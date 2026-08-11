# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Lista define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Lista.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFAPF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (806 linhas total):

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

*-- Linhas 123 a 334:
123:         CATCH TO loc_oErro
124:             MsgErro(loc_oErro.Message + CHR(13) + ;
125:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
126:                 "Procedure: " + loc_oErro.Procedure, ;
127:                 "Erro ConfigurarPageFrame")
128:         ENDTRY
129:     ENDPROC
130: 
131:     *==========================================================================
132:     * ConfigurarPaginaLista - Constroi os controles principais do form OPERACIONAL
133:     * Para forms OPERACIONAIS, este metodo unifica a configuracao dos elementos
134:     * da area de conteudo (botoes de acao e campos de entrada)
135:     *==========================================================================
136:     PROTECTED PROCEDURE ConfigurarPaginaLista()
137:         LOCAL loc_oErro
138: 
139:         TRY
140:             THIS.ConfigurarBotoesAcao()
141:             THIS.ConfigurarBotoesCRUD()
142:             THIS.ConfigurarGrade()
143:             THIS.ConfigurarPaginaDados()
144:         CATCH TO loc_oErro
145:             MsgErro(loc_oErro.Message + CHR(13) + ;
146:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
147:                 "Procedure: " + loc_oErro.Procedure, ;
148:                 "Erro ConfigurarPaginaLista")
149:         ENDTRY
150:     ENDPROC
151: 
152:     *==========================================================================
153:     * ConfigurarBotoesAcao - Cria o container canonico de saida (Encerrar)
154:     * Padrao canonico: cnt_4c_Saida.Left=917 (adaptado para Width=718: Left=638)
155:     * cmd_4c_Encerrar: Left=5, Top=5, Width=75, Height=75, Caption="Encerrar"
156:     *==========================================================================
157:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
158:         LOCAL loc_oErro
159: 
160:         TRY
161:             THIS.AddObject("cnt_4c_Saida", "Container")
162:             WITH THIS.cnt_4c_Saida
163:                 .Top         = 5
164:                 .Left        = 917
165:                 .Width       = 90
166:                 .Height      = 85
167:                 .BackStyle   = 0
168:                 .BorderWidth = 0
169: 
170:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
171:                 WITH .cmd_4c_Encerrar
172:                     .Top             = 5
173:                     .Left            = 917
174:                     .Width           = 90
175:                     .Height          = 75
176:                     .Caption         = "Encerrar"
177:                     .FontBold        = .T.
178:                     .FontItalic      = .T.
179:                     .FontName        = "Comic Sans MS"
180:                     .FontSize        = 8
181:                     .WordWrap        = .T.
182:                     .ForeColor       = RGB(90, 90, 90)
183:                     .BackColor       = RGB(255, 255, 255)
184:                     .SpecialEffect   = 0
185:                     .MousePointer    = 15
186:                     .PicturePosition = 13
187:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
188:                 ENDWITH
189:             ENDWITH
190: 
191:         CATCH TO loc_oErro
192:             MsgErro(loc_oErro.Message + CHR(13) + ;
193:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
194:                 "Procedure: " + loc_oErro.Procedure, ;
195:                 "Erro ConfigurarBotoesAcao")
196:         ENDTRY
197:     ENDPROC
198: 
199:     *==========================================================================
200:     * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz do form
201:     * cnt_4c_Sombra ja tem Visible=.T. definido em ConfigurarPageFrame
202:     *==========================================================================
203:     PROTECTED PROCEDURE TornarControlesVisiveis()
204:         LOCAL loc_oErro
205: 
206:         TRY
207:             THIS.TornarVisivelRecursivo(THIS)
208: 
209:         CATCH TO loc_oErro
210:             MsgErro(loc_oErro.Message + CHR(13) + ;
211:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
212:                 "Procedure: " + loc_oErro.Procedure, ;
213:                 "Erro TornarControlesVisiveis")
214:         ENDTRY
215:     ENDPROC
216: 
217:     *==========================================================================
218:     * TornarVisivelRecursivo - Percorre container recursivamente tornando visiveis
219:     *==========================================================================
220:     PROTECTED PROCEDURE TornarVisivelRecursivo(par_oContainer)
221:         LOCAL loc_i, loc_oCtrl
222:         FOR loc_i = 1 TO par_oContainer.ControlCount
223:             loc_oCtrl = par_oContainer.Controls(loc_i)
224:             IF VARTYPE(loc_oCtrl) = "O"
225:                 *-- Pular painel de dados: deve comecar oculto; recursar filhos apenas
226:                 IF UPPER(loc_oCtrl.Name) = "CNT_4C_PAINELDADOS"
227:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
228:                        loc_oCtrl.ControlCount > 0
229:                         THIS.TornarVisivelRecursivo(loc_oCtrl)
230:                     ENDIF
231:                     LOOP
232:                 ENDIF
233:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
234:                     loc_oCtrl.Visible = .T.
235:                 ENDIF
236:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
237:                    loc_oCtrl.ControlCount > 0
238:                     THIS.TornarVisivelRecursivo(loc_oCtrl)
239:                 ENDIF
240:             ENDIF
241:         ENDFOR
242:     ENDPROC
243: 
244:     *==========================================================================
245:     * ConfigurarBINDEVENTs - Vincula o evento do botao Encerrar
246:     * Eventos dos campos de entrada serao vinculados nas fases de conteudo
247:     *==========================================================================
248:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
249:         LOCAL loc_oErro
250: 
251:         TRY
252:             BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
253:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
254:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
255:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
256:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
257:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
258:             BINDEVENT(THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar, ;
259:                       "Click", THIS, "BtnConfirmarClick")
260:             BINDEVENT(THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Cancelar, ;
261:                       "Click", THIS, "BtnCancelarClick")
262: 
263:         CATCH TO loc_oErro
264:             MsgErro(loc_oErro.Message + CHR(13) + ;
265:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
266:                 "Procedure: " + loc_oErro.Procedure, ;
267:                 "Erro ConfigurarBINDEVENTs")
268:         ENDTRY
269:     ENDPROC
270: 
271:     *==========================================================================
272:     * BtnEncerrarClick - Encerra o formulario
273:     *==========================================================================
274:     PROCEDURE BtnEncerrarClick()
275:         THIS.Release()
276:     ENDPROC
277: 
278:     *==========================================================================
279:     PROCEDURE Destroy()
280:     *==========================================================================
281:         IF USED("cursor_4c_Dados")
282:             USE IN cursor_4c_Dados
283:         ENDIF
284:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
285:             THIS.this_oBusinessObject = .NULL.
286:         ENDIF
287:         DODEFAULT()
288:     ENDPROC
289: 
290:     *==========================================================================
291:     * ConfigurarBotoesCRUD - Cria container com os 5 botoes de operacao CRUD
292:     * Posicionado no cabecalho, a esquerda do cnt_4c_Saida
293:     *==========================================================================
294:     PROTECTED PROCEDURE ConfigurarBotoesCRUD()
295:         LOCAL loc_oErro
296: 
297:         TRY
298:             THIS.AddObject("cnt_4c_Botoes", "Container")
299:             WITH THIS.cnt_4c_Botoes
300:                 .Top         = 5
301:                 .Left        = THIS.Width - 85 - 390 - 5
302:                 .Width       = 390
303:                 .Height      = 85
304:                 .BackStyle   = 0
305:                 .BorderWidth = 0
306:                 .AddObject("cmd_4c_Incluir",    "CommandButton")
307:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
308:                 .AddObject("cmd_4c_Alterar",    "CommandButton")
309:                 .AddObject("cmd_4c_Excluir",    "CommandButton")
310:                 .AddObject("cmd_4c_Buscar",     "CommandButton")
311:                 .Visible     = .T.
312:             ENDWITH
313: 
314:             WITH THIS.cnt_4c_Botoes.cmd_4c_Incluir
315:                 .Top             = 5
316:                 .Left            = 5
317:                 .Width           = 75
318:                 .Height          = 75
319:                 .Caption         = "Incluir"
320:                 .FontBold        = .T.
321:                 .FontItalic      = .T.
322:                 .FontName        = "Comic Sans MS"
323:                 .FontSize        = 8
324:                 .WordWrap        = .T.
325:                 .ForeColor       = RGB(90, 90, 90)
326:                 .BackColor       = RGB(255, 255, 255)
327:                 .SpecialEffect   = 0
328:                 .Themes          = .F.
329:                 .MousePointer    = 15
330:                 .PicturePosition = 13
331:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
332:             ENDWITH
333: 
334:             WITH THIS.cnt_4c_Botoes.cmd_4c_Visualizar

*-- Linhas 417 a 738:
417:         CATCH TO loc_oErro
418:             MsgErro(loc_oErro.Message + CHR(13) + ;
419:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
420:                 "Procedure: " + loc_oErro.Procedure, ;
421:                 "Erro ConfigurarBotoesCRUD")
422:         ENDTRY
423:     ENDPROC
424: 
425:     *==========================================================================
426:     * ConfigurarGrade - Cria o grid de exibicao de registros com cursor vazio
427:     *==========================================================================
428:     PROTECTED PROCEDURE ConfigurarGrade()
429:         LOCAL loc_oErro
430: 
431:         TRY
432:             SET NULL ON
433:             CREATE CURSOR cursor_4c_Dados (Codigo C(20) NULL, Descricao C(60) NULL)
434:             SET NULL OFF
435: 
436:             THIS.AddObject("grd_4c_Lista", "Grid")
437:             WITH THIS.grd_4c_Lista
438:                 .Top                = 95
439:                 .Left               = 5
440:                 .Width              = THIS.Width - 10
441:                 .Height             = THIS.Height - 100
442:                 .FontName           = "Verdana"
443:                 .FontSize           = 8
444:                 .ForeColor          = RGB(90, 90, 90)
445:                 .BackColor          = RGB(255, 255, 255)
446:                 .GridLineColor      = RGB(238, 238, 238)
447:                 .HighlightBackColor = RGB(255, 255, 255)
448:                 .HighlightForeColor = RGB(15, 41, 104)
449:                 .HighlightStyle     = 2
450:                 .DeleteMark         = .F.
451:                 .RecordMark         = .F.
452:                 .ScrollBars         = 2
453:                 .RowHeight          = 16
454:                 .ColumnCount        = 2
455:                 .RecordSource       = "cursor_4c_Dados"
456:                 .Column1.ControlSource    = "cursor_4c_Dados.Codigo"
457:                 .Column1.Width            = 150
458:                 .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
459:                 .Column2.ControlSource    = "cursor_4c_Dados.Descricao"
460:                 .Column2.Width            = THIS.Width - 10 - 150 - 5
461:                 .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
462:             ENDWITH
463: 
464:         CATCH TO loc_oErro
465:             MsgErro(loc_oErro.Message + CHR(13) + ;
466:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
467:                 "Procedure: " + loc_oErro.Procedure, ;
468:                 "Erro ConfigurarGrade")
469:         ENDTRY
470:     ENDPROC
471: 
472:     *==========================================================================
473:     * CarregarLista - Carrega/recarrega dados no grid principal
474:     * Form operacional sem tabela propria - cursor permanece vazio por padrao
475:     *==========================================================================
476:     PROCEDURE CarregarLista()
477:         LOCAL loc_oErro
478: 
479:         TRY
480:             IF USED("cursor_4c_Dados")
481:                 SELECT cursor_4c_Dados
482:                 ZAP
483:             ELSE
484:                 SET NULL ON
485:                 CREATE CURSOR cursor_4c_Dados (Codigo C(20) NULL, Descricao C(60) NULL)
486:                 SET NULL OFF
487:             ENDIF
488: 
489:             IF VARTYPE(THIS.grd_4c_Lista) = "O"
490:                 THIS.grd_4c_Lista.ColumnCount                 = 2
491:                 THIS.grd_4c_Lista.RecordSource                = "cursor_4c_Dados"
492:                 THIS.grd_4c_Lista.Column1.ControlSource       = "cursor_4c_Dados.Codigo"
493:                 THIS.grd_4c_Lista.Column2.ControlSource       = "cursor_4c_Dados.Descricao"
494:                 THIS.grd_4c_Lista.Column1.Header1.Caption     = "C" + CHR(243) + "digo"
495:                 THIS.grd_4c_Lista.Column2.Header1.Caption     = ;
496:                     "Descri" + CHR(231) + CHR(227) + "o"
497:             ENDIF
498: 
499:             THIS.AlternarPagina(1)
500: 
501:         CATCH TO loc_oErro
502:             MsgErro(loc_oErro.Message + CHR(13) + ;
503:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
504:                 "Procedure: " + loc_oErro.Procedure, ;
505:                 "Erro CarregarLista")
506:         ENDTRY
507:     ENDPROC
508: 
509:     *==========================================================================
510:     * AlternarPagina - Alterna entre modo Lista (1) e modo Dados (2)
511:     * Ajusta estado dos botoes CRUD conforme modo corrente
512:     *==========================================================================
513:     PROCEDURE AlternarPagina(par_nPagina)
514:         LOCAL loc_lTemRegistro
515: 
516:         IF VARTYPE(THIS.cnt_4c_Botoes) != "O"
517:             RETURN
518:         ENDIF
519: 
520:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
521: 
522:         IF par_nPagina = 1
523:             *-- Modo Lista: exibe grid, oculta painel de dados
524:             IF VARTYPE(THIS.grd_4c_Lista) = "O"
525:                 THIS.grd_4c_Lista.Visible = .T.
526:             ENDIF
527:             IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
528:                 THIS.cnt_4c_PainelDados.Visible = .F.
529:             ENDIF
530:             THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
531:             THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
532:             THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
533:             THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
534:             THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
535:         ELSE
536:             *-- Modo Dados: oculta grid, exibe painel de dados
537:             IF VARTYPE(THIS.grd_4c_Lista) = "O"
538:                 THIS.grd_4c_Lista.Visible = .F.
539:             ENDIF
540:             IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
541:                 THIS.cnt_4c_PainelDados.Visible = .T.
542:             ENDIF
543:             THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .F.
544:             THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .F.
545:             THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .F.
546:             THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .F.
547:             THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .F.
548:         ENDIF
549:     ENDPROC
550: 
551:     *==========================================================================
552:     * BtnIncluirClick - Inicia inclusao de novo registro
553:     *==========================================================================
554:     PROCEDURE BtnIncluirClick()
555:         THIS.this_oBusinessObject.NovoRegistro()
556:         THIS.BOParaForm()
557:         THIS.HabilitarCampos(.T.)
558:         THIS.AlternarPagina(2)
559:     ENDPROC
560: 
561:     *==========================================================================
562:     * BtnVisualizarClick - Exibe registro selecionado para visualizacao
563:     *==========================================================================
564:     PROCEDURE BtnVisualizarClick()
565:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
566:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
567:             RETURN
568:         ENDIF
569:         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
570:         THIS.BOParaForm()
571:         THIS.HabilitarCampos(.F.)
572:         THIS.AlternarPagina(2)
573:     ENDPROC
574: 
575:     *==========================================================================
576:     * BtnAlterarClick - Inicia alteracao do registro selecionado
577:     *==========================================================================
578:     PROCEDURE BtnAlterarClick()
579:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
580:             MsgAviso("Selecione um registro para alterar.", "Alterar")
581:             RETURN
582:         ENDIF
583:         THIS.this_oBusinessObject.EditarRegistro()
584:         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
585:         THIS.BOParaForm()
586:         THIS.HabilitarCampos(.T.)
587:         THIS.AlternarPagina(2)
588:     ENDPROC
589: 
590:     *==========================================================================
591:     * BtnExcluirClick - Exclui o registro selecionado
592:     *==========================================================================
593:     PROCEDURE BtnExcluirClick()
594:         LOCAL loc_lResultado
595: 
596:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
597:             MsgAviso("Selecione um registro para excluir.", "Excluir")
598:             RETURN
599:         ENDIF
600: 
601:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
602:                 "Excluir")
603:             RETURN
604:         ENDIF
605: 
606:         loc_lResultado = THIS.this_oBusinessObject.Excluir()
607: 
608:         IF loc_lResultado
609:             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
610:             THIS.CarregarLista()
611:         ELSE
612:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
613:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Excluir")
614:             ELSE
615:                 MsgErro("Erro ao excluir o registro.", "Excluir")
616:             ENDIF
617:         ENDIF
618:     ENDPROC
619: 
620:     *==========================================================================
621:     * BtnBuscarClick - Recarrega a lista de registros
622:     *==========================================================================
623:     PROCEDURE BtnBuscarClick()
624:         THIS.CarregarLista()
625:     ENDPROC
626: 
627:     *==========================================================================
628:     * BtnConfirmarClick - Salva o registro em edicao/inclusao
629:     *==========================================================================
630:     PROCEDURE BtnConfirmarClick()
631:         LOCAL loc_lResultado
632: 
633:         THIS.FormParaBO()
634:         loc_lResultado = THIS.this_oBusinessObject.Salvar()
635: 
636:         IF loc_lResultado
637:             MsgInfo("Registro salvo com sucesso.", "Confirmar")
638:             THIS.CarregarLista()
639:         ELSE
640:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
641:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Confirmar")
642:             ELSE
643:                 MsgErro("Erro ao salvar o registro.", "Confirmar")
644:             ENDIF
645:         ENDIF
646:     ENDPROC
647: 
648:     *==========================================================================
649:     * BtnSalvarClick - Alias para BtnConfirmarClick (compatibilidade)
650:     *==========================================================================
651:     PROCEDURE BtnSalvarClick()
652:         THIS.BtnConfirmarClick()
653:     ENDPROC
654: 
655:     *==========================================================================
656:     * BtnCancelarClick - Cancela edicao e volta para a lista
657:     *==========================================================================
658:     PROCEDURE BtnCancelarClick()
659:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
660:            THIS.this_oBusinessObject.this_lEmEdicao
661:             THIS.this_oBusinessObject.Cancelar()
662:         ENDIF
663:         THIS.CarregarLista()
664:     ENDPROC
665: 
666:     *==========================================================================
667:     * FormParaBO - Transfere valores dos campos para o Business Object
668:     * Form sem campos - nenhum mapeamento necessario
669:     *==========================================================================
670:     PROCEDURE FormParaBO()
671:         RETURN .T.
672:     ENDPROC
673: 
674:     *==========================================================================
675:     * BOParaForm - Transfere valores do Business Object para os campos
676:     * Form sem campos - nenhum mapeamento necessario
677:     *==========================================================================
678:     PROCEDURE BOParaForm()
679:         RETURN .T.
680:     ENDPROC
681: 
682:     *==========================================================================
683:     * HabilitarCampos - Habilita ou desabilita campos de entrada
684:     * par_lHabilitar: .T. = editavel, .F. = somente leitura (modo visualizar)
685:     * Form sem campos - controla apenas botao Confirmar
686:     *==========================================================================
687:     PROCEDURE HabilitarCampos(par_lHabilitar)
688:         IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
689:             THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar.Enabled = ;
690:                 par_lHabilitar
691:         ENDIF
692:     ENDPROC
693: 
694:     *==========================================================================
695:     * ConfigurarPaginaDados - Cria o painel de dados (Page2 do form OPERACIONAL)
696:     * Form sem campos proprios: apenas container com botoes Confirmar/Cancelar
697:     *==========================================================================
698:     PROTECTED PROCEDURE ConfigurarPaginaDados()
699:         LOCAL loc_oErro
700: 
701:         TRY
702:             THIS.AddObject("cnt_4c_PainelDados", "Container")
703:             WITH THIS.cnt_4c_PainelDados
704:                 .Top         = 95
705:                 .Left        = 0
706:                 .Width       = THIS.Width
707:                 .Height      = THIS.Height - 95
708:                 .BackStyle   = 1
709:                 .BackColor   = RGB(255, 255, 255)
710:                 .BorderWidth = 0
711: 
712:                 .AddObject("cnt_4c_BotoesDados", "Container")
713:                 .Visible     = .T.
714:             ENDWITH
715: 
716:             WITH THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados
717:                 .Top         = THIS.Height - 185
718:                 .Left        = THIS.Width - 170
719:                 .Width       = 165
720:                 .Height      = 85
721:                 .BackStyle   = 0
722:                 .BorderWidth = 0
723: 
724:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
725:                 .AddObject("cmd_4c_Cancelar",  "CommandButton")
726:                 .Visible     = .T.
727:             ENDWITH
728: 
729:             WITH THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar
730:                 .Top             = 5
731:                 .Left            = 5
732:                 .Width           = 75
733:                 .Height          = 75
734:                 .Caption         = "Confirmar"
735:                 .FontBold        = .T.
736:                 .FontItalic      = .T.
737:                 .FontName        = "Comic Sans MS"
738:                 .FontSize        = 8

*-- Linhas 769 a 806:
769:         CATCH TO loc_oErro
770:             MsgErro(loc_oErro.Message + CHR(13) + ;
771:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
772:                 "Procedure: " + loc_oErro.Procedure, ;
773:                 "Erro ConfigurarPaginaDados")
774:         ENDTRY
775:     ENDPROC
776: 
777:     *==========================================================================
778:     * LimparCampos - Limpa campos de entrada e redefine estado do cursor
779:     * Form sem campos proprios: zera cursor de dados e ajusta botoes
780:     *==========================================================================
781:     PROCEDURE LimparCampos()
782:         IF USED("cursor_4c_Dados")
783:             SELECT cursor_4c_Dados
784:             ZAP
785:         ENDIF
786:         THIS.AjustarBotoesPorModo()
787:     ENDPROC
788: 
789:     *==========================================================================
790:     * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme dados
791:     * Habilitado/Desabilitado conforme existencia de registros no cursor
792:     *==========================================================================
793:     PROCEDURE AjustarBotoesPorModo()
794:         LOCAL loc_lTemRegistro
795:         IF VARTYPE(THIS.cnt_4c_Botoes) != "O"
796:             RETURN
797:         ENDIF
798:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
799:         THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
800:         THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
801:         THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
802:         THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
803:         THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
804:     ENDPROC
805: 
806: ENDDEFINE


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

