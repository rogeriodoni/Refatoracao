# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCIC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (700 linhas total):

*-- Linhas 9 a 176:
9: *   CODE -> arquitetura em camadas (FormBase / SIGPRCICBO)
10: *
11: * CHAMADA:
12: *   loForm = CREATEOBJECT("FormSIGPRCIC", loFormPai, lcIdChave)
13: *   loForm.Show()
14: *   par_loForm1    = form pai (objeto) - DataSession compartilhada
15: *   par_lcIdChave1 = pkChaves do programa a ter icone alterado
16: *==============================================================================
17: 
18: DEFINE CLASS FormSIGPRCIC AS FormBase
19: 
20:     *-- Propriedades visuais (popup modal pequeno, identico ao legado)
21:     Height      = 496
22:     Width       = 469
23:     BorderStyle = 2
24:     AutoCenter  = .T.
25:     ShowTips    = .T.
26:     TitleBar    = 0
27:     ShowWindow = 1
28:     ControlBox  = .F.
29:     Closable    = .F.
30:     MaxButton   = .F.
31:     MinButton   = .F.
32:     KeyPreview  = .T.
33:     DataSession  = 1
34:     WindowType   = 1
35:     ClipControls = .F.
36: 
37:     *-- Propriedades customizadas herdadas do legado (RESERVED3)
38:     *-- pkChaves do programa cujo icone sera alterado
39:     pcIdChaves = ""
40:     *-- Referencia ao form pai (compartilhamento de DataSession)
41:     poForm1    = .NULL.
42: 
43:     *==========================================================================
44:     PROCEDURE Init
45:     *==========================================================================
46:         LPARAMETERS par_loForm1, par_lcIdChave1
47: 
48:         *-- Armazenar parametros ANTES de DODEFAULT() para que InicializarForm
49:         *-- tenha acesso ao form pai e a chave do programa
50:         IF VARTYPE(par_loForm1) = "O"
51:             THIS.poForm1 = par_loForm1
52:             *-- Compartilhar datasession com form pai: cursores crProg1/crProg2/crSigSyIco1
53:             *-- so existem na datasession do pai (critico para grid e REPLACE funcionarem)
54:             THIS.DataSessionId = par_loForm1.DataSessionId
55:         ELSE
56:             THIS.poForm1 = THIS
57:         ENDIF
58: 
59:         IF VARTYPE(par_lcIdChave1) = "C"
60:             THIS.pcIdChaves = ALLTRIM(par_lcIdChave1)
61:         ENDIF
62: 
63:         RETURN DODEFAULT()
64:     ENDPROC
65: 
66:     *==========================================================================
67:     PROTECTED PROCEDURE InicializarForm
68:     *==========================================================================
69:         LOCAL loc_lSucesso
70:         loc_lSucesso = .F.
71: 
72:         TRY
73:             *-- Caption com acentos via CHR() (literal acentuado proibido em .prg)
74:             THIS.Caption = "Escolha de " + CHR(205) + "cones"
75: 
76:             *-- Criar Business Object
77:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCICBO")
78:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
79:                 MsgErro("Falha ao criar SIGPRCICBO", "Erro")
80:                 loc_lSucesso = .F.
81:             ENDIF
82: 
83:             *-- Carregar descricao do programa a partir de crProg2
84:             IF !EMPTY(THIS.pcIdChaves)
85:                 THIS.this_oBusinessObject.CarregarPorChave(THIS.pcIdChaves)
86:             ENDIF
87: 
88:             *-- Guard para validacao UI sem conexao SQL
89:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
90:                 loc_lSucesso = .T.
91:             ENDIF
92: 
93:             *-- Configurar picture de fundo do form
94:             THIS.ConfigurarPageFrame()
95: 
96:             *-- Configurar cabecalho cinza (cntSombra do legado)
97:             THIS.ConfigurarCabecalho()
98:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
99:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
100: 
101:             *-- Configurar controles principais: grid de icones, preview, label, textbox
102:             THIS.ConfigurarPaginaLista()
103: 
104:             *-- Vincular eventos adicionais do grid (BeforeRowColChange)
105:             THIS.ConfigurarPaginaDados()
106: 
107:             *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
108:             THIS.TornarControlesVisiveis()
109: 
110:             *-- Carregar dados: vincular grid ao cursor e posicionar no icone atual
111:             THIS.CarregarDados()
112: 
113:             loc_lSucesso = .T.
114:         CATCH TO loc_oErro
115:             MsgErro("Erro ao inicializar FormSIGPRCIC: " + loc_oErro.Message + ;
116:                     " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
117:                     " Proc=" + loc_oErro.Procedure, "Erro")
118:         ENDTRY
119: 
120:         RETURN loc_lSucesso
121:     ENDPROC
122: 
123:     *==========================================================================
124:     PROTECTED PROCEDURE ConfigurarPageFrame
125:     *==========================================================================
126:         LOCAL loc_cImgFundo
127:         *-- Form OPERACIONAL flat (sem PageFrame) - configura picture de fundo
128:         loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
129:         IF FILE(loc_cImgFundo)
130:             THIS.Picture = loc_cImgFundo
131:         ENDIF
132:         *-- Manter dimensoes originais do popup (469x496) - NAO reescalonar para 1000x600
133:     ENDPROC
134: 
135:     *==========================================================================
136:     PROTECTED PROCEDURE ConfigurarCabecalho
137:     *==========================================================================
138:         LOCAL loc_nW
139:         loc_nW = THIS.Width
140: 
141:         *-- Container cabecalho cinza (cntSombra do legado)
142:         *-- Posicao: Top=0, Left=0, largura total do form, Height=80
143:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
144:         WITH THIS.cnt_4c_Cabecalho
145:             .Top         = 0
146:             .Left        = 0
147:             .Width       = loc_nW
148:             .Height      = 80
149:             .BackStyle   = 1
150:             .BackColor   = RGB(100, 100, 100)
151:             .BorderWidth = 0
152: 
153:             *-- Label sombra (deslocada 1px para efeito de profundidade, texto escuro)
154:             .AddObject("lbl_4c_Sombra", "Label")
155:             WITH .lbl_4c_Sombra
156:                 .AutoSize  = .F.
157:                 .Width     = loc_nW
158:                 .Height    = 40
159:                 .Top       = 18
160:                 .Left      = 10
161:                 .Caption   = ""
162:                 .FontName  = "Tahoma"
163:                 .FontSize  = 18
164:                 .FontBold  = .T.
165:                 .BackStyle = 0
166:                 .ForeColor = RGB(0, 0, 0)
167:                 .WordWrap  = .T.
168:                 .Alignment = 0
169:             ENDWITH
170: 
171:             *-- Label titulo (branco sobre cinza)
172:             .AddObject("lbl_4c_Titulo", "Label")
173:             WITH .lbl_4c_Titulo
174:                 .AutoSize  = .F.
175:                 .Width     = loc_nW
176:                 .Height    = 46

*-- Linhas 184 a 269:
184:                 .ForeColor = RGB(255, 255, 255)
185:                 .WordWrap  = .T.
186:                 .Alignment = 0
187:             ENDWITH
188:         ENDWITH
189:         THIS.cnt_4c_Cabecalho.Visible = .T.
190:     ENDPROC
191: 
192:     *==========================================================================
193:     PROTECTED PROCEDURE TornarControlesVisiveis
194:     *==========================================================================
195:         LPARAMETERS par_oContainer
196:         LOCAL loc_oContainer, loc_i, loc_oControl
197: 
198:         IF VARTYPE(par_oContainer) = "O"
199:             loc_oContainer = par_oContainer
200:         ELSE
201:             loc_oContainer = THIS
202:         ENDIF
203: 
204:         FOR loc_i = 1 TO loc_oContainer.ControlCount
205:             loc_oControl = loc_oContainer.Controls(loc_i)
206:             IF VARTYPE(loc_oControl) = "O"
207:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
208:                     THIS.TornarControlesVisiveis(loc_oControl)
209:                 ENDIF
210:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
211:                     IF !INLIST(LOWER(loc_oControl.Name), "cnt_4c_cabecalho", "img_4c_icone")
212:                         loc_oControl.Visible = .T.
213:                     ENDIF
214:                 ENDIF
215:             ENDIF
216:         ENDFOR
217:     ENDPROC
218: 
219:     *==========================================================================
220:     PROCEDURE KeyPress
221:     *==========================================================================
222:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
223:         IF par_nKeyCode = 27
224:             THIS.Release()
225:         ENDIF
226:     ENDPROC
227: 
228:     *==========================================================================
229:     PROTECTED PROCEDURE ConfigurarPaginaLista
230:     *==========================================================================
231:         LOCAL loc_oGrd
232: 
233:         *-- Grid de icones (Grid1 do legado)
234:         THIS.AddObject("grd_4c_Dados", "Grid")
235:         THIS.grd_4c_Dados.ColumnCount = 1
236:         WITH THIS.grd_4c_Dados
237:             .Top               = 131
238:             .Left              = 10
239:             .Width             = 242
240:             .Height            = 345
241:             .AllowHeaderSizing = .F.
242:             .AllowRowSizing    = .F.
243:             .DeleteMark        = .F.
244:             .RecordMark        = .F.
245:             .ReadOnly          = .T.
246:             .ScrollBars        = 2
247:             .GridLineColor     = RGB(238, 238, 238)
248:             .HeaderHeight      = 15
249:             .RowHeight         = 15
250:             .LinkMaster        = ""
251:             .RelationalExpr    = ""
252: 
253:             .FontName = "Courier New"
254:             .SetAll("FontName",   "Tahoma",      "Header")
255:             .SetAll("FontName",   "Courier New", "TextBox")
256:             .FontSize = 9
257:             .SetAll("FontSize",    8,             "Header")
258:             .SetAll("FontSize",    9,             "TextBox")
259:             .SetAll("Format",     "K",            "Column")
260:             .SetAll("Format",     "K",            "TextBox")
261:             .SetAll("Movable",    .F.,            "Column")
262:             .SetAll("ReadOnly",   .T.,            "Column")
263:             .SetAll("ReadOnly",   .T.,            "TextBox")
264:             .SetAll("Resizable",  .F.,            "Column")
265:             .Column1.Resizable = .T.
266:             .SetAll("Alignment",   3,             "Column")
267:             .SetAll("Alignment",   3,             "TextBox")
268:             .SetAll("Alignment",   2,             "Header")
269:             .SetAll("BorderStyle", 0,             "TextBox")

*-- Linhas 278 a 324:
278:             .Column1.Header1.ForeColor  = RGB(90, 90, 90)
279:         ENDWITH
280: 
281:         BINDEVENT(THIS.grd_4c_Dados,               "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
282:         BINDEVENT(THIS.grd_4c_Dados,               "Scrolled",          THIS, "GrdDadosScrolled")
283:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "DblClick",  THIS, "GrdText1DblClick")
284:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdText1KeyPress")
285: 
286:         *-- Moldura decorativa para area de preview (Shape1 do legado)
287:         THIS.AddObject("shp_4c_Shape1", "Shape")
288:         WITH THIS.shp_4c_Shape1
289:             .Top         = 184
290:             .Left        = 276
291:             .Width       = 169
292:             .Height      = 169
293:             .BackStyle   = 0
294:             .BorderStyle = 0
295:             .BorderColor = RGB(136, 189, 188)
296:         ENDWITH
297: 
298:         *-- Imagem de preview do icone selecionado (Icone do legado)
299:         THIS.AddObject("img_4c_Icone", "Image")
300:         WITH THIS.img_4c_Icone
301:             .Stretch = 1
302:             .Height  = 156
303:             .Left    = 282
304:             .Top     = 200
305:             .Width   = 156
306:             .Visible = .F.
307:         ENDWITH
308: 
309:         *-- Label "Programa" (Say2 do legado)
310:         THIS.AddObject("lbl_4c_Programa", "Label")
311:         WITH THIS.lbl_4c_Programa
312:             .Caption   = "Programa"
313:             .Left      = 12
314:             .Top       = 86
315:             .AutoSize  = .T.
316:             .BackStyle = 0
317:             .ForeColor = RGB(90, 90, 90)
318:             .FontName  = "Tahoma"
319:             .FontSize  = 8
320:         ENDWITH
321: 
322:         *-- TextBox descricao do programa (Text1 do legado - somente leitura)
323:         THIS.AddObject("txt_4c_Descricao", "TextBox")
324:         WITH THIS.txt_4c_Descricao

*-- Linhas 337 a 700:
337:     ENDPROC
338: 
339:     *==========================================================================
340:     PROTECTED PROCEDURE ConfigurarPaginaDados
341:     *==========================================================================
342:         *-- Fase 5: completa configuracao do painel de preview (area direita)
343:         *-- e vincula BeforeRowColChange para manter preview sincronizado
344:         *-- enquanto o usuario navega ANTES da linha mudar (comportamento do legado)
345: 
346:         *-- BeforeRowColChange: atualiza preview ao iniciar movimento de linha
347:         *-- O legado tinha AfterRowColChange E BeforeRowColChange (identicos)
348:         BINDEVENT(THIS.grd_4c_Dados, "BeforeRowColChange", THIS, "GrdDadosBeforeRowColChange")
349: 
350:         *-- Garantir estado inicial correto do preview de icone
351:         WITH THIS.img_4c_Icone
352:             .Visible  = .F.
353:             .Picture  = ""
354:             .Stretch  = 1
355:         ENDWITH
356: 
357:         *-- Garantir estado inicial correto da moldura decorativa
358:         WITH THIS.shp_4c_Shape1
359:             .BackStyle   = 0
360:             .BorderStyle = 0
361:             .BorderColor = RGB(136, 189, 188)
362:         ENDWITH
363:     ENDPROC
364: 
365:     *==========================================================================
366:     PROTECTED PROCEDURE CarregarDados
367:     *==========================================================================
368:         LOCAL loc_cArqIcone
369:         loc_cArqIcone = ""
370: 
371:         *-- Preencher descricao do programa no TextBox
372:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
373:             THIS.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cPrograma
374:             loc_cArqIcone = PADR(LOWER(ALLTRIM(THIS.this_oBusinessObject.this_cArqIconeAtual)), 64)
375:         ENDIF
376: 
377:         *-- Fallback: se barrapict vazio, usar JustFname(pkChaves) como nome do icone
378:         *-- (replica logica do Init original do SCX legado)
379:         IF EMPTY(ALLTRIM(loc_cArqIcone)) AND !EMPTY(THIS.pcIdChaves)
380:             loc_cArqIcone = PADR(LOWER(ALLTRIM(JUSTFNAME(THIS.pcIdChaves))), 64)
381:         ENDIF
382: 
383:         *-- Configurar grid com cursor crSigSyIco1 da datasession compartilhada
384:         IF USED("crSigSyIco1")
385:             SET ORDER TO "carqicones" IN crSigSyIco1
386: 
387:             IF !EMPTY(loc_cArqIcone)
388:                 IF !SEEK(loc_cArqIcone, "crSigSyIco1", "carqicones")
389:                     GO TOP IN crSigSyIco1
390:                 ENDIF
391:             ELSE
392:                 GO TOP IN crSigSyIco1
393:             ENDIF
394: 
395:             THIS.grd_4c_Dados.RecordSource = "crSigSyIco1"
396:             WITH THIS.grd_4c_Dados
397:                 .Column1.ControlSource = "crSigSyIco1.carqicones"
398:                 .Refresh()
399:             ENDWITH
400: 
401:             THIS.AtualizarPreviewIcone()
402:         ENDIF
403:     ENDPROC
404: 
405:     *==========================================================================
406:     PROTECTED PROCEDURE AtualizarPreviewIcone
407:     *==========================================================================
408:         LOCAL loc_cArqIcone
409:         loc_cArqIcone = ""
410: 
411:         IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
412:             loc_cArqIcone = ALLTRIM(crSigSyIco1.ctmpicones)
413:         ENDIF
414: 
415:         IF !EMPTY(loc_cArqIcone) AND FILE(loc_cArqIcone)
416:             THIS.img_4c_Icone.Picture = loc_cArqIcone
417:             THIS.img_4c_Icone.Visible = .T.
418:         ELSE
419:             THIS.img_4c_Icone.Visible = .F.
420:         ENDIF
421:     ENDPROC
422: 
423:     *==========================================================================
424:     PROCEDURE AlternarPagina
425:     *==========================================================================
426:         LPARAMETERS par_nPagina
427:         *-- Form flat sem PageFrame - alternancia de paginas nao se aplica
428:     ENDPROC
429: 
430:     *-- -----------------------------------------------------------------------
431:     *-- Handlers de eventos do Grid (PUBLIC - obrigatorio para BINDEVENT)
432:     *-- -----------------------------------------------------------------------
433: 
434:     *==========================================================================
435:     PROCEDURE GrdDadosAfterRowColChange
436:     *==========================================================================
437:         LPARAMETERS par_nColIndex
438:         THIS.AtualizarPreviewIcone()
439:     ENDPROC
440: 
441:     *==========================================================================
442:     PROCEDURE GrdDadosScrolled
443:     *==========================================================================
444:         LPARAMETERS par_nDirection
445:         THIS.AtualizarPreviewIcone()
446:     ENDPROC
447: 
448:     *==========================================================================
449:     PROCEDURE GrdDadosBeforeRowColChange
450:     *==========================================================================
451:         LPARAMETERS par_nColIndex
452:         THIS.AtualizarPreviewIcone()
453:     ENDPROC
454: 
455:     *==========================================================================
456:     PROCEDURE GrdText1DblClick
457:     *==========================================================================
458:         THIS.SelecionarIconeAtual()
459:     ENDPROC
460: 
461:     *==========================================================================
462:     PROCEDURE GrdText1KeyPress
463:     *==========================================================================
464:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
465:         IF par_nKeyCode = 13
466:             THIS.SelecionarIconeAtual()
467:         ENDIF
468:     ENDPROC
469: 
470:     *==========================================================================
471:     PROTECTED PROCEDURE SelecionarIconeAtual
472:     *==========================================================================
473:         LOCAL loc_cArqIcone
474:         loc_cArqIcone = ""
475: 
476:         IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
477:             loc_cArqIcone = ALLTRIM(crSigSyIco1.carqicones)
478:         ENDIF
479: 
480:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
481:             THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone)
482:         ENDIF
483: 
484:         THIS.Release()
485:     ENDPROC
486: 
487:     *-- -----------------------------------------------------------------------
488:     *-- Eventos principais dos botoes (mapeados para acoes do seletor de icones)
489:     *-- Popup modal SEM botoes CRUD no legado; metodos existem para satisfazer
490:     *-- contrato da arquitetura e permitir integracao/testes automatizados.
491:     *-- Cada acao replica logica real do formulario:
492:     *--   Incluir/Alterar -> confirma icone selecionado (equivalente ao DblClick)
493:     *--   Visualizar      -> forca refresh do preview do icone corrente
494:     *--   Excluir         -> limpa vinculo de icone (equivalente a "< nenhum >")
495:     *-- -----------------------------------------------------------------------
496: 
497:     *==========================================================================
498:     PROCEDURE BtnIncluirClick
499:     *==========================================================================
500:         *-- Confirma icone corrente do grid e fecha o picker (equivalente ao
501:         *-- DblClick sobre o icone selecionado). Sem selecao valida, apenas
502:         *-- posiciona no primeiro registro do cursor de icones.
503:         IF USED("crSigSyIco1")
504:             IF EOF("crSigSyIco1") OR BOF("crSigSyIco1")
505:                 GO TOP IN crSigSyIco1
506:                 THIS.grd_4c_Dados.Refresh()
507:                 THIS.AtualizarPreviewIcone()
508:                 RETURN
509:             ENDIF
510:             THIS.SelecionarIconeAtual()
511:         ENDIF
512:     ENDPROC
513: 
514:     *==========================================================================
515:     PROCEDURE BtnAlterarClick
516:     *==========================================================================
517:         *-- Alterar tem semantica identica a Incluir neste picker: substitui o
518:         *-- icone atual do programa pelo icone posicionado no grid.
519:         IF USED("crSigSyIco1")
520:             IF EOF("crSigSyIco1") OR BOF("crSigSyIco1")
521:                 GO TOP IN crSigSyIco1
522:                 THIS.grd_4c_Dados.Refresh()
523:                 THIS.AtualizarPreviewIcone()
524:                 RETURN
525:             ENDIF
526:             THIS.SelecionarIconeAtual()
527:         ENDIF
528:     ENDPROC
529: 
530:     *==========================================================================
531:     PROCEDURE BtnVisualizarClick
532:     *==========================================================================
533:         *-- Forca refresh do preview do icone posicionado (mesma logica do
534:         *-- AfterRowColChange). Util quando o grid re-renderiza mas o preview
535:         *-- fica dessincronizado (ex: apos scroll rapido).
536:         IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
537:             THIS.grd_4c_Dados.Refresh()
538:             THIS.AtualizarPreviewIcone()
539:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
540:                 THIS.grd_4c_Dados.SetFocus()
541:             ENDIF
542:         ENDIF
543:     ENDPROC
544: 
545:     *==========================================================================
546:     PROCEDURE BtnExcluirClick
547:     *==========================================================================
548:         *-- Limpa o vinculo de icone do programa (equivalente a selecionar
549:         *-- "< nenhum >" no grid do legado). O BO grava string vazia em
550:         *-- barrapict e mantem barraforms, fechando o picker em seguida.
551:         LOCAL loc_lConfirma
552:         loc_lConfirma = MsgConfirma("Remover o " + CHR(237) + "cone atual do programa?", ;
553:                                     "Confirma" + CHR(231) + CHR(227) + "o")
554:         IF !loc_lConfirma
555:             RETURN
556:         ENDIF
557: 
558:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
559:             THIS.this_oBusinessObject.SelecionarIcone("")
560:         ENDIF
561: 
562:         THIS.Release()
563:     ENDPROC
564: 
565:     *==========================================================================
566:     PROCEDURE BtnBuscarClick
567:     *==========================================================================
568:         *-- Reposiciona o grid no icone atualmente vinculado ao programa.
569:         *-- Util quando o usuario navega e quer voltar ao icone original.
570:         LOCAL loc_cArqIcone
571:         loc_cArqIcone = ""
572: 
573:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
574:             loc_cArqIcone = PADR(LOWER(ALLTRIM(THIS.this_oBusinessObject.this_cArqIconeAtual)), 64)
575:         ENDIF
576: 
577:         IF USED("crSigSyIco1")
578:             IF !EMPTY(ALLTRIM(loc_cArqIcone))
579:                 IF !SEEK(loc_cArqIcone, "crSigSyIco1", "carqicones")
580:                     GO TOP IN crSigSyIco1
581:                 ENDIF
582:             ELSE
583:                 GO TOP IN crSigSyIco1
584:             ENDIF
585:             THIS.grd_4c_Dados.Refresh()
586:             THIS.AtualizarPreviewIcone()
587:         ENDIF
588:     ENDPROC
589: 
590:     *==========================================================================
591:     PROCEDURE BtnEncerrarClick
592:     *==========================================================================
593:         *-- Fecha o picker sem selecionar icone (equivalente a ESC/Cancelar).
594:         THIS.Release()
595:     ENDPROC
596: 
597:     *==========================================================================
598:     PROCEDURE BtnSalvarClick
599:     *==========================================================================
600:         *-- Confirma o icone posicionado no grid e persiste a selecao.
601:         *-- Equivalente ao DblClick/Enter sobre a linha do grid.
602:         IF USED("crSigSyIco1")
603:             IF EOF("crSigSyIco1") OR BOF("crSigSyIco1")
604:                 GO TOP IN crSigSyIco1
605:                 THIS.grd_4c_Dados.Refresh()
606:                 THIS.AtualizarPreviewIcone()
607:                 RETURN
608:             ENDIF
609:             THIS.SelecionarIconeAtual()
610:         ENDIF
611:     ENDPROC
612: 
613:     *==========================================================================
614:     PROCEDURE BtnCancelarClick
615:     *==========================================================================
616:         *-- Fecha o picker sem confirmar selecao de icone.
617:         THIS.Release()
618:     ENDPROC
619: 
620:     *==========================================================================
621:     PROCEDURE FormParaBO
622:     *==========================================================================
623:         *-- Sincroniza o icone posicionado no grid com as propriedades do BO.
624:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
625:             RETURN
626:         ENDIF
627: 
628:         LOCAL loc_cArqIcone
629:         loc_cArqIcone = ""
630: 
631:         IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
632:             loc_cArqIcone = LOWER(ALLTRIM(crSigSyIco1.carqicones))
633:             IF loc_cArqIcone == "< nenhum >"
634:                 loc_cArqIcone = ""
635:             ENDIF
636:         ENDIF
637: 
638:         THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
639:         THIS.this_oBusinessObject.this_cIdChaves = THIS.pcIdChaves
640:     ENDPROC
641: 
642:     *==========================================================================
643:     PROCEDURE BOParaForm
644:     *==========================================================================
645:         *-- Atualiza o TextBox de descricao do programa a partir do BO.
646:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
647:             RETURN
648:         ENDIF
649: 
650:         IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
651:             THIS.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cPrograma
652:         ENDIF
653:     ENDPROC
654: 
655:     *==========================================================================
656:     PROTECTED PROCEDURE HabilitarCampos
657:     *==========================================================================
658:         LPARAMETERS par_lHabilitar
659:         *-- Form picker modal: txt_4c_Descricao e sempre ReadOnly (identico ao legado).
660:         *-- Nao ha campos editaveis para alternar por modo.
661:     ENDPROC
662: 
663:     *==========================================================================
664:     PROTECTED PROCEDURE LimparCampos
665:     *==========================================================================
666:         *-- Reseta o TextBox de descricao e oculta o preview do icone.
667:         IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
668:             THIS.txt_4c_Descricao.Value = ""
669:         ENDIF
670:         IF PEMSTATUS(THIS, "img_4c_Icone", 5)
671:             THIS.img_4c_Icone.Visible = .F.
672:             THIS.img_4c_Icone.Picture = ""
673:         ENDIF
674:     ENDPROC
675: 
676:     *==========================================================================
677:     PROCEDURE CarregarLista
678:     *==========================================================================
679:         *-- Carrega (ou recarrega) a lista de icones no grid.
680:         THIS.CarregarDados()
681:     ENDPROC
682: 
683:     *==========================================================================
684:     PROTECTED PROCEDURE AjustarBotoesPorModo
685:     *==========================================================================
686:         LPARAMETERS par_cModo
687:         *-- Form picker flat sem modos CRUD (sem CommandGroups para ajustar).
688:     ENDPROC
689: 
690:     *==========================================================================
691:     PROCEDURE Destroy
692:     *==========================================================================
693:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
694:             THIS.this_oBusinessObject = .NULL.
695:         ENDIF
696:         THIS.poForm1 = .NULL.
697:         DODEFAULT()
698:     ENDPROC
699: 
700: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCICBO.prg):
*=============================================================================*
* SIGPRCICBO.prg - Business Object para Escolha de Icones de Programas
*=============================================================================*
* Herda de: BusinessBase
* Form associado: FormSIGPRCIC.prg (forms\operacionais\)
* Descricao: Gerencia selecao de icones para programas/menus.
*            Opera sobre cursores em memoria (crProg1/crProg2/crSigSyIco1)
*            compartilhados via DataSession do form pai.
*            Nao possui tabela SQL Server propria.
*=============================================================================*

DEFINE CLASS SIGPRCICBO AS BusinessBase

    *-- Chave do programa cujo icone sera alterado (pkChaves de crProg1/crProg2)
    this_cIdChaves      = ""

    *-- Nome/descricao do programa (crProg2.descricaos)
    this_cPrograma      = ""

    *-- Icone atual do programa ao abrir (crProg2.barrapict)
    this_cArqIconeAtual = ""

    *-- Icone selecionado pelo usuario (carqicones da linha corrente do grid)
    this_cArqIcone      = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO sem tabela SQL propria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor crProg2
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPrograma      = TratarNulo(descricaos, "C")
            THIS.this_cArqIconeAtual = TratarNulo(barrapict,  "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorChave - Localiza programa por pkChaves em crProg2 e carrega propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorChave(par_cIdChaves)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cIdChaves = ALLTRIM(par_cIdChaves)

        TRY
            IF USED("crProg2") AND SEEK(THIS.this_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                THIS.this_cPrograma      = TratarNulo(descricaos, "C")
                THIS.this_cArqIconeAtual = TratarNulo(barrapict,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarIcone - Aplica icone escolhido nos cursores crProg1 e crProg2
    *   via VFP REPLACE (esta BO nao usa SQLEXEC - opera em cursores em memoria)
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarIcone(par_cArqIcone)
        LOCAL loc_lSucesso, loc_cArqIcone

        loc_lSucesso  = .F.
        loc_cArqIcone = LOWER(ALLTRIM(par_cArqIcone))

        IF loc_cArqIcone == "< nenhum >"
            loc_cArqIcone = ""
        ENDIF

        THIS.this_cArqIcone = loc_cArqIcone

        TRY
            IF USED("crProg1") AND SEEK(THIS.this_cIdChaves, "crProg1", "pkChaves")
                SELECT crProg1
                REPLACE barrapict WITH loc_cArqIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg1.programas) ;
                        IN ("crProg1")
            ENDIF

            IF USED("crProg2") AND SEEK(THIS.this_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                REPLACE barrapict WITH loc_cArqIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg2.programas) ;
                        IN ("crProg2")
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel: esta BO opera sobre cursores VFP, nao SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Delega para SelecionarIcone com o icone ja carregado em this_cArqIcone
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.SelecionarIcone(THIS.this_cArqIcone)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do programa (pkChaves)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

ENDDEFINE

