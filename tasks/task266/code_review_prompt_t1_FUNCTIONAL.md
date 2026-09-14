# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCIC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (697 linhas total):

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

*-- Linhas 189 a 266:
189:     ENDPROC
190: 
191:     *==========================================================================
192:     PROTECTED PROCEDURE TornarControlesVisiveis
193:     *==========================================================================
194:         LPARAMETERS par_oContainer
195:         LOCAL loc_oContainer, loc_i, loc_oControl
196: 
197:         IF VARTYPE(par_oContainer) = "O"
198:             loc_oContainer = par_oContainer
199:         ELSE
200:             loc_oContainer = THIS
201:         ENDIF
202: 
203:         FOR loc_i = 1 TO loc_oContainer.ControlCount
204:             loc_oControl = loc_oContainer.Controls(loc_i)
205:             IF VARTYPE(loc_oControl) = "O"
206:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
207:                     loc_oControl.Visible = .T.
208:                 ENDIF
209:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
210:                     THIS.TornarControlesVisiveis(loc_oControl)
211:                 ENDIF
212:             ENDIF
213:         ENDFOR
214:     ENDPROC
215: 
216:     *==========================================================================
217:     PROCEDURE KeyPress
218:     *==========================================================================
219:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
220:         IF par_nKeyCode = 27
221:             THIS.Release()
222:         ENDIF
223:     ENDPROC
224: 
225:     *==========================================================================
226:     PROTECTED PROCEDURE ConfigurarPaginaLista
227:     *==========================================================================
228:         LOCAL loc_oGrd
229: 
230:         *-- Grid de icones (Grid1 do legado)
231:         THIS.AddObject("grd_4c_Dados", "Grid")
232:         WITH THIS.grd_4c_Dados
233:             .Top               = 131
234:             .Left              = 10
235:             .Width             = 242
236:             .Height            = 345
237:             .ColumnCount       = 1
238:             .AllowHeaderSizing = .F.
239:             .AllowRowSizing    = .F.
240:             .DeleteMark        = .F.
241:             .RecordMark        = .F.
242:             .ReadOnly          = .T.
243:             .ScrollBars        = 2
244:             .GridLineColor     = RGB(238, 238, 238)
245:             .HeaderHeight      = 15
246:             .RowHeight         = 15
247:             .LinkMaster        = ""
248:             .RelationalExpr    = ""
249: 
250:             .FontName = "Courier New"
251:             .SetAll("FontName",   "Tahoma",      "Header")
252:             .SetAll("FontName",   "Courier New", "TextBox")
253:             .FontSize = 9
254:             .SetAll("FontSize",    8,             "Header")
255:             .SetAll("FontSize",    9,             "TextBox")
256:             .SetAll("Format",     "K",            "Column")
257:             .SetAll("Format",     "K",            "TextBox")
258:             .SetAll("Movable",    .F.,            "Column")
259:             .SetAll("ReadOnly",   .T.,            "Column")
260:             .SetAll("ReadOnly",   .T.,            "TextBox")
261:             .SetAll("Resizable",  .F.,            "Column")
262:             .Column1.Resizable = .T.
263:             .SetAll("Alignment",   3,             "Column")
264:             .SetAll("Alignment",   3,             "TextBox")
265:             .SetAll("Alignment",   2,             "Header")
266:             .SetAll("BorderStyle", 0,             "TextBox")

*-- Linhas 273 a 321:
273:             .Column1.Header1.FontSize   = 8
274:             .Column1.Header1.Alignment  = 2
275:             .Column1.Header1.ForeColor  = RGB(90, 90, 90)
276:         ENDWITH
277: 
278:         BINDEVENT(THIS.grd_4c_Dados,               "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
279:         BINDEVENT(THIS.grd_4c_Dados,               "Scrolled",          THIS, "GrdDadosScrolled")
280:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "DblClick",  THIS, "GrdText1DblClick")
281:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdText1KeyPress")
282: 
283:         *-- Moldura decorativa para area de preview (Shape1 do legado)
284:         THIS.AddObject("shp_4c_Shape1", "Shape")
285:         WITH THIS.shp_4c_Shape1
286:             .Top         = 184
287:             .Left        = 276
288:             .Width       = 169
289:             .Height      = 169
290:             .BackStyle   = 0
291:             .BorderStyle = 0
292:             .BorderColor = RGB(136, 189, 188)
293:         ENDWITH
294: 
295:         *-- Imagem de preview do icone selecionado (Icone do legado)
296:         THIS.AddObject("img_4c_Icone", "Image")
297:         WITH THIS.img_4c_Icone
298:             .Stretch = 1
299:             .Height  = 156
300:             .Left    = 282
301:             .Top     = 200
302:             .Width   = 156
303:             .Visible = .F.
304:         ENDWITH
305: 
306:         *-- Label "Programa" (Say2 do legado)
307:         THIS.AddObject("lbl_4c_Programa", "Label")
308:         WITH THIS.lbl_4c_Programa
309:             .Caption   = "Programa"
310:             .Left      = 12
311:             .Top       = 86
312:             .AutoSize  = .T.
313:             .BackStyle = 0
314:             .ForeColor = RGB(90, 90, 90)
315:             .FontName  = "Tahoma"
316:             .FontSize  = 8
317:         ENDWITH
318: 
319:         *-- TextBox descricao do programa (Text1 do legado - somente leitura)
320:         THIS.AddObject("txt_4c_Descricao", "TextBox")
321:         WITH THIS.txt_4c_Descricao

*-- Linhas 334 a 697:
334:     ENDPROC
335: 
336:     *==========================================================================
337:     PROTECTED PROCEDURE ConfigurarPaginaDados
338:     *==========================================================================
339:         *-- Fase 5: completa configuracao do painel de preview (area direita)
340:         *-- e vincula BeforeRowColChange para manter preview sincronizado
341:         *-- enquanto o usuario navega ANTES da linha mudar (comportamento do legado)
342: 
343:         *-- BeforeRowColChange: atualiza preview ao iniciar movimento de linha
344:         *-- O legado tinha AfterRowColChange E BeforeRowColChange (identicos)
345:         BINDEVENT(THIS.grd_4c_Dados, "BeforeRowColChange", THIS, "GrdDadosBeforeRowColChange")
346: 
347:         *-- Garantir estado inicial correto do preview de icone
348:         WITH THIS.img_4c_Icone
349:             .Visible  = .F.
350:             .Picture  = ""
351:             .Stretch  = 1
352:         ENDWITH
353: 
354:         *-- Garantir estado inicial correto da moldura decorativa
355:         WITH THIS.shp_4c_Shape1
356:             .BackStyle   = 0
357:             .BorderStyle = 0
358:             .BorderColor = RGB(136, 189, 188)
359:         ENDWITH
360:     ENDPROC
361: 
362:     *==========================================================================
363:     PROTECTED PROCEDURE CarregarDados
364:     *==========================================================================
365:         LOCAL loc_cArqIcone
366:         loc_cArqIcone = ""
367: 
368:         *-- Preencher descricao do programa no TextBox
369:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
370:             THIS.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cPrograma
371:             loc_cArqIcone = PADR(LOWER(ALLTRIM(THIS.this_oBusinessObject.this_cArqIconeAtual)), 64)
372:         ENDIF
373: 
374:         *-- Fallback: se barrapict vazio, usar JustFname(pkChaves) como nome do icone
375:         *-- (replica logica do Init original do SCX legado)
376:         IF EMPTY(ALLTRIM(loc_cArqIcone)) AND !EMPTY(THIS.pcIdChaves)
377:             loc_cArqIcone = PADR(LOWER(ALLTRIM(JUSTFNAME(THIS.pcIdChaves))), 64)
378:         ENDIF
379: 
380:         *-- Configurar grid com cursor crSigSyIco1 da datasession compartilhada
381:         IF USED("crSigSyIco1")
382:             SET ORDER TO "carqicones" IN crSigSyIco1
383: 
384:             IF !EMPTY(loc_cArqIcone)
385:                 IF !SEEK(loc_cArqIcone, "crSigSyIco1", "carqicones")
386:                     GO TOP IN crSigSyIco1
387:                 ENDIF
388:             ELSE
389:                 GO TOP IN crSigSyIco1
390:             ENDIF
391: 
392:             WITH THIS.grd_4c_Dados
393:                 .RecordSource          = "crSigSyIco1"
394:                 .Column1.ControlSource = "crSigSyIco1.carqicones"
395:                 .Refresh()
396:             ENDWITH
397: 
398:             THIS.AtualizarPreviewIcone()
399:         ENDIF
400:     ENDPROC
401: 
402:     *==========================================================================
403:     PROTECTED PROCEDURE AtualizarPreviewIcone
404:     *==========================================================================
405:         LOCAL loc_cArqIcone
406:         loc_cArqIcone = ""
407: 
408:         IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
409:             loc_cArqIcone = ALLTRIM(crSigSyIco1.ctmpicones)
410:         ENDIF
411: 
412:         IF !EMPTY(loc_cArqIcone) AND FILE(loc_cArqIcone)
413:             THIS.img_4c_Icone.Picture = loc_cArqIcone
414:             THIS.img_4c_Icone.Visible = .T.
415:         ELSE
416:             THIS.img_4c_Icone.Visible = .F.
417:         ENDIF
418:     ENDPROC
419: 
420:     *==========================================================================
421:     PROCEDURE AlternarPagina
422:     *==========================================================================
423:         LPARAMETERS par_nPagina
424:         *-- Form flat sem PageFrame - alternancia de paginas nao se aplica
425:     ENDPROC
426: 
427:     *-- -----------------------------------------------------------------------
428:     *-- Handlers de eventos do Grid (PUBLIC - obrigatorio para BINDEVENT)
429:     *-- -----------------------------------------------------------------------
430: 
431:     *==========================================================================
432:     PROCEDURE GrdDadosAfterRowColChange
433:     *==========================================================================
434:         LPARAMETERS par_nColIndex
435:         THIS.AtualizarPreviewIcone()
436:     ENDPROC
437: 
438:     *==========================================================================
439:     PROCEDURE GrdDadosScrolled
440:     *==========================================================================
441:         LPARAMETERS par_nDirection
442:         THIS.AtualizarPreviewIcone()
443:     ENDPROC
444: 
445:     *==========================================================================
446:     PROCEDURE GrdDadosBeforeRowColChange
447:     *==========================================================================
448:         LPARAMETERS par_nColIndex
449:         THIS.AtualizarPreviewIcone()
450:     ENDPROC
451: 
452:     *==========================================================================
453:     PROCEDURE GrdText1DblClick
454:     *==========================================================================
455:         THIS.SelecionarIconeAtual()
456:     ENDPROC
457: 
458:     *==========================================================================
459:     PROCEDURE GrdText1KeyPress
460:     *==========================================================================
461:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
462:         IF par_nKeyCode = 13
463:             THIS.SelecionarIconeAtual()
464:         ENDIF
465:     ENDPROC
466: 
467:     *==========================================================================
468:     PROTECTED PROCEDURE SelecionarIconeAtual
469:     *==========================================================================
470:         LOCAL loc_cArqIcone
471:         loc_cArqIcone = ""
472: 
473:         IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
474:             loc_cArqIcone = ALLTRIM(crSigSyIco1.carqicones)
475:         ENDIF
476: 
477:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
478:             THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone)
479:         ENDIF
480: 
481:         THIS.Release()
482:     ENDPROC
483: 
484:     *-- -----------------------------------------------------------------------
485:     *-- Eventos principais dos botoes (mapeados para acoes do seletor de icones)
486:     *-- Popup modal SEM botoes CRUD no legado; metodos existem para satisfazer
487:     *-- contrato da arquitetura e permitir integracao/testes automatizados.
488:     *-- Cada acao replica logica real do formulario:
489:     *--   Incluir/Alterar -> confirma icone selecionado (equivalente ao DblClick)
490:     *--   Visualizar      -> forca refresh do preview do icone corrente
491:     *--   Excluir         -> limpa vinculo de icone (equivalente a "< nenhum >")
492:     *-- -----------------------------------------------------------------------
493: 
494:     *==========================================================================
495:     PROCEDURE BtnIncluirClick
496:     *==========================================================================
497:         *-- Confirma icone corrente do grid e fecha o picker (equivalente ao
498:         *-- DblClick sobre o icone selecionado). Sem selecao valida, apenas
499:         *-- posiciona no primeiro registro do cursor de icones.
500:         IF USED("crSigSyIco1")
501:             IF EOF("crSigSyIco1") OR BOF("crSigSyIco1")
502:                 GO TOP IN crSigSyIco1
503:                 THIS.grd_4c_Dados.Refresh()
504:                 THIS.AtualizarPreviewIcone()
505:                 RETURN
506:             ENDIF
507:             THIS.SelecionarIconeAtual()
508:         ENDIF
509:     ENDPROC
510: 
511:     *==========================================================================
512:     PROCEDURE BtnAlterarClick
513:     *==========================================================================
514:         *-- Alterar tem semantica identica a Incluir neste picker: substitui o
515:         *-- icone atual do programa pelo icone posicionado no grid.
516:         IF USED("crSigSyIco1")
517:             IF EOF("crSigSyIco1") OR BOF("crSigSyIco1")
518:                 GO TOP IN crSigSyIco1
519:                 THIS.grd_4c_Dados.Refresh()
520:                 THIS.AtualizarPreviewIcone()
521:                 RETURN
522:             ENDIF
523:             THIS.SelecionarIconeAtual()
524:         ENDIF
525:     ENDPROC
526: 
527:     *==========================================================================
528:     PROCEDURE BtnVisualizarClick
529:     *==========================================================================
530:         *-- Forca refresh do preview do icone posicionado (mesma logica do
531:         *-- AfterRowColChange). Util quando o grid re-renderiza mas o preview
532:         *-- fica dessincronizado (ex: apos scroll rapido).
533:         IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
534:             THIS.grd_4c_Dados.Refresh()
535:             THIS.AtualizarPreviewIcone()
536:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
537:                 THIS.grd_4c_Dados.SetFocus()
538:             ENDIF
539:         ENDIF
540:     ENDPROC
541: 
542:     *==========================================================================
543:     PROCEDURE BtnExcluirClick
544:     *==========================================================================
545:         *-- Limpa o vinculo de icone do programa (equivalente a selecionar
546:         *-- "< nenhum >" no grid do legado). O BO grava string vazia em
547:         *-- barrapict e mantem barraforms, fechando o picker em seguida.
548:         LOCAL loc_lConfirma
549:         loc_lConfirma = MsgConfirma("Remover o " + CHR(237) + "cone atual do programa?", ;
550:                                     "Confirma" + CHR(231) + CHR(227) + "o")
551:         IF !loc_lConfirma
552:             RETURN
553:         ENDIF
554: 
555:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
556:             THIS.this_oBusinessObject.SelecionarIcone("")
557:         ENDIF
558: 
559:         THIS.Release()
560:     ENDPROC
561: 
562:     *==========================================================================
563:     PROCEDURE BtnBuscarClick
564:     *==========================================================================
565:         *-- Reposiciona o grid no icone atualmente vinculado ao programa.
566:         *-- Util quando o usuario navega e quer voltar ao icone original.
567:         LOCAL loc_cArqIcone
568:         loc_cArqIcone = ""
569: 
570:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
571:             loc_cArqIcone = PADR(LOWER(ALLTRIM(THIS.this_oBusinessObject.this_cArqIconeAtual)), 64)
572:         ENDIF
573: 
574:         IF USED("crSigSyIco1")
575:             IF !EMPTY(ALLTRIM(loc_cArqIcone))
576:                 IF !SEEK(loc_cArqIcone, "crSigSyIco1", "carqicones")
577:                     GO TOP IN crSigSyIco1
578:                 ENDIF
579:             ELSE
580:                 GO TOP IN crSigSyIco1
581:             ENDIF
582:             THIS.grd_4c_Dados.Refresh()
583:             THIS.AtualizarPreviewIcone()
584:         ENDIF
585:     ENDPROC
586: 
587:     *==========================================================================
588:     PROCEDURE BtnEncerrarClick
589:     *==========================================================================
590:         *-- Fecha o picker sem selecionar icone (equivalente a ESC/Cancelar).
591:         THIS.Release()
592:     ENDPROC
593: 
594:     *==========================================================================
595:     PROCEDURE BtnSalvarClick
596:     *==========================================================================
597:         *-- Confirma o icone posicionado no grid e persiste a selecao.
598:         *-- Equivalente ao DblClick/Enter sobre a linha do grid.
599:         IF USED("crSigSyIco1")
600:             IF EOF("crSigSyIco1") OR BOF("crSigSyIco1")
601:                 GO TOP IN crSigSyIco1
602:                 THIS.grd_4c_Dados.Refresh()
603:                 THIS.AtualizarPreviewIcone()
604:                 RETURN
605:             ENDIF
606:             THIS.SelecionarIconeAtual()
607:         ENDIF
608:     ENDPROC
609: 
610:     *==========================================================================
611:     PROCEDURE BtnCancelarClick
612:     *==========================================================================
613:         *-- Fecha o picker sem confirmar selecao de icone.
614:         THIS.Release()
615:     ENDPROC
616: 
617:     *==========================================================================
618:     PROCEDURE FormParaBO
619:     *==========================================================================
620:         *-- Sincroniza o icone posicionado no grid com as propriedades do BO.
621:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
622:             RETURN
623:         ENDIF
624: 
625:         LOCAL loc_cArqIcone
626:         loc_cArqIcone = ""
627: 
628:         IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
629:             loc_cArqIcone = LOWER(ALLTRIM(crSigSyIco1.carqicones))
630:             IF loc_cArqIcone == "< nenhum >"
631:                 loc_cArqIcone = ""
632:             ENDIF
633:         ENDIF
634: 
635:         THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
636:         THIS.this_oBusinessObject.this_cIdChaves = THIS.pcIdChaves
637:     ENDPROC
638: 
639:     *==========================================================================
640:     PROCEDURE BOParaForm
641:     *==========================================================================
642:         *-- Atualiza o TextBox de descricao do programa a partir do BO.
643:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
644:             RETURN
645:         ENDIF
646: 
647:         IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
648:             THIS.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cPrograma
649:         ENDIF
650:     ENDPROC
651: 
652:     *==========================================================================
653:     PROTECTED PROCEDURE HabilitarCampos
654:     *==========================================================================
655:         LPARAMETERS par_lHabilitar
656:         *-- Form picker modal: txt_4c_Descricao e sempre ReadOnly (identico ao legado).
657:         *-- Nao ha campos editaveis para alternar por modo.
658:     ENDPROC
659: 
660:     *==========================================================================
661:     PROTECTED PROCEDURE LimparCampos
662:     *==========================================================================
663:         *-- Reseta o TextBox de descricao e oculta o preview do icone.
664:         IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
665:             THIS.txt_4c_Descricao.Value = ""
666:         ENDIF
667:         IF PEMSTATUS(THIS, "img_4c_Icone", 5)
668:             THIS.img_4c_Icone.Visible = .F.
669:             THIS.img_4c_Icone.Picture = ""
670:         ENDIF
671:     ENDPROC
672: 
673:     *==========================================================================
674:     PROCEDURE CarregarLista
675:     *==========================================================================
676:         *-- Carrega (ou recarrega) a lista de icones no grid.
677:         THIS.CarregarDados()
678:     ENDPROC
679: 
680:     *==========================================================================
681:     PROTECTED PROCEDURE AjustarBotoesPorModo
682:     *==========================================================================
683:         LPARAMETERS par_cModo
684:         *-- Form picker flat sem modos CRUD (sem CommandGroups para ajustar).
685:     ENDPROC
686: 
687:     *==========================================================================
688:     PROCEDURE Destroy
689:     *==========================================================================
690:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
691:             THIS.this_oBusinessObject = .NULL.
692:         ENDIF
693:         THIS.poForm1 = .NULL.
694:         DODEFAULT()
695:     ENDPROC
696: 
697: ENDDEFINE


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

