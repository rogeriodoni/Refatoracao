# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 183: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 208: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 258: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 283: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 322: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 423: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 448: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSER.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (944 linhas total):

*-- Linhas 49 a 57:
49: 
50:         TRY
51:             *-- Caption com acento correto (CHR nao permitido em DEFINE CLASS)
52:             THIS.Caption = "Cadastro de Servi" + CHR(231) + "os dos Produtos"
53: 
54:             THIS.this_oBusinessObject = CREATEOBJECT("SERBO")
55: 
56:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
57:                 MsgErro("Erro ao criar SERBO", "FormSER")

*-- Linhas 83 a 100:
83:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
84: 
85:         WITH THIS.pgf_4c_Paginas
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .PageCount = 2
91:             .Tabs      = .F.
92:             .Visible   = .T.
93:             .Page1.Caption = "Lista"
94:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page2.Caption = "Dados"
96:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:         ENDWITH
98:     ENDPROC
99: 
100:     *==========================================================================

*-- Linhas 113 a 149:
113:         *----------------------------------------------------------------------
114:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
115:         WITH loc_oPagina.cnt_4c_Cabecalho
116:             .Top         = 31
117:             .Left        = 0
118:             .Width       = THIS.Width
119:             .Height      = 80
120:             .BackColor   = RGB(100, 100, 100)
121:             .BorderWidth = 0
122:             .Visible     = .T.
123:         ENDWITH
124: 
125:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
126:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
127:             .Caption   = "Cadastro de Servi" + CHR(231) + "os dos Produtos"
128:             .Top       = 15
129:             .Left      = 10
130:             .Width     = 769
131:             .Height    = 40
132:             .FontName  = "Tahoma"
133:             .FontSize  = 16
134:             .FontBold  = .T.
135:             .ForeColor = RGB(0, 0, 0)
136:             .BackStyle = 0
137:             .Visible   = .T.
138:         ENDWITH
139: 
140:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
141:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
142:             .Caption   = "Cadastro de Servi" + CHR(231) + "os dos Produtos"
143:             .Top       = 18
144:             .Left      = 10
145:             .Width     = 769
146:             .Height    = 46
147:             .FontName  = "Tahoma"
148:             .FontSize  = 16
149:             .FontBold  = .T.

*-- Linhas 159 a 349:
159:         *----------------------------------------------------------------------
160:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
161:         WITH loc_oPagina.cnt_4c_Botoes
162:             .Top         = 29
163:             .Left        = 542
164:             .Width       = 390
165:             .Height      = 85
166:             .BackStyle = 0
167:             .BorderWidth = 0
168:             .Visible     = .T.
169:         ENDWITH
170: 
171:         *-- Incluir (Inserir no legado)
172:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
173:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
174:             .Caption         = "Incluir"
175:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
176:             .PicturePosition = 13
177:             .Top             = 5
178:             .Left            = 5
179:             .Width           = 75
180:             .Height          = 75
181:             .BackColor       = RGB(255, 255, 255)
182:             .ForeColor       = RGB(90, 90, 90)
183:             .FontName        = "Comic Sans MS"
184:             .FontSize        = 8
185:             .FontBold        = .T.
186:             .FontItalic      = .T.
187:             .Themes          = .F.
188:             .SpecialEffect   = 0
189:             .MousePointer    = 15
190:             .WordWrap        = .T.
191:             .AutoSize        = .F.
192:             .Visible         = .T.
193:         ENDWITH
194:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
195: 
196:         *-- Visualizar (Consultar no legado)
197:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
198:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
199:             .Caption         = "Visualizar"
200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
201:             .PicturePosition = 13
202:             .Top             = 5
203:             .Left            = 80
204:             .Width           = 75
205:             .Height          = 75
206:             .BackColor       = RGB(255, 255, 255)
207:             .ForeColor       = RGB(90, 90, 90)
208:             .FontName        = "Comic Sans MS"
209:             .FontSize        = 8
210:             .FontBold        = .T.
211:             .FontItalic      = .T.
212:             .Themes          = .F.
213:             .SpecialEffect   = 0
214:             .MousePointer    = 15
215:             .WordWrap        = .T.
216:             .AutoSize        = .F.
217:             .Visible         = .T.
218:         ENDWITH
219:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
220: 
221:         *-- Alterar
222:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .BackColor       = RGB(255, 255, 255)
232:             .ForeColor       = RGB(90, 90, 90)
233:             .FontName        = "Comic Sans MS"
234:             .FontSize        = 8
235:             .FontBold        = .T.
236:             .FontItalic      = .T.
237:             .Themes          = .F.
238:             .SpecialEffect   = 0
239:             .MousePointer    = 15
240:             .WordWrap        = .T.
241:             .AutoSize        = .F.
242:             .Visible         = .T.
243:         ENDWITH
244:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
245: 
246:         *-- Excluir
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
249:             .Caption         = "Excluir"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
251:             .PicturePosition = 13
252:             .Top             = 5
253:             .Left            = 230
254:             .Width           = 75
255:             .Height          = 75
256:             .BackColor       = RGB(255, 255, 255)
257:             .ForeColor       = RGB(90, 90, 90)
258:             .FontName        = "Comic Sans MS"
259:             .FontSize        = 8
260:             .FontBold        = .T.
261:             .FontItalic      = .T.
262:             .Themes          = .F.
263:             .SpecialEffect   = 0
264:             .MousePointer    = 15
265:             .WordWrap        = .T.
266:             .AutoSize        = .F.
267:             .Visible         = .T.
268:         ENDWITH
269:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
270: 
271:         *-- Buscar (Procurar no legado)
272:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
273:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
274:             .Caption         = "Buscar"
275:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
276:             .PicturePosition = 13
277:             .Top             = 5
278:             .Left            = 305
279:             .Width           = 75
280:             .Height          = 75
281:             .BackColor       = RGB(255, 255, 255)
282:             .ForeColor       = RGB(90, 90, 90)
283:             .FontName        = "Comic Sans MS"
284:             .FontSize        = 8
285:             .FontBold        = .T.
286:             .FontItalic      = .T.
287:             .Themes          = .F.
288:             .SpecialEffect   = 0
289:             .MousePointer    = 15
290:             .WordWrap        = .T.
291:             .AutoSize        = .F.
292:             .Visible         = .T.
293:         ENDWITH
294:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
295: 
296:         *----------------------------------------------------------------------
297:         * Container Saida (Grupo_Saida no legado) - PADRAO CANONICO (CLAUDE.md #10)
298:         * Original: Left=919, Top=-1 -> canonico PREVALECE: Left=917, Top=29
299:         *----------------------------------------------------------------------
300:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
301:         WITH loc_oPagina.cnt_4c_Saida
302:             .Top         = 29
303:             .Left        = 917
304:             .Width       = 90
305:             .Height      = 85
306:             .BackStyle   = 0
307:             .BorderWidth = 0
308:             .Visible     = .T.
309:         ENDWITH
310: 
311:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313:             .Caption         = "Encerrar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .BackColor       = RGB(255, 255, 255)
321:             .ForeColor       = RGB(90, 90, 90)
322:             .FontName        = "Comic Sans MS"
323:             .FontSize        = 8
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .Themes          = .F.
327:             .SpecialEffect   = 0
328:             .MousePointer    = 15
329:             .WordWrap        = .T.
330:             .AutoSize        = .F.
331:             .Visible         = .T.
332:         ENDWITH
333:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335:         *----------------------------------------------------------------------
336:         * Grid de lista (Grade no legado)
337:         * Original: Top=121, Left=12, Width=940, Height=470 -> Top=150 (+29)
338:         * ColumnCount=2 para mostrar apenas Cods e Descs (cIdChaves fica no cursor)
339:         *----------------------------------------------------------------------
340:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
341: 
342:         loc_oGrid = loc_oPagina.grd_4c_Lista
343:         loc_oGrid.Top         = 150
344:         loc_oGrid.Left        = 12
345:         loc_oGrid.Width       = 940
346:         loc_oGrid.Height      = 470
347:         loc_oGrid.ColumnCount = 2
348:         loc_oGrid.RecordSource = ""
349: 

*-- Linhas 370 a 386:
370:             .FontName  = "Tahoma"
371:             .FontSize  = 8
372:         ENDWITH
373:         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
374: 
375:         WITH loc_oGrid.Column2
376:             .Width     = 200
377:             .Alignment = 0
378:             .FontName  = "Tahoma"
379:             .FontSize  = 8
380:         ENDWITH
381:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
382: 
383:         THIS.TornarControlesVisiveis(loc_oPagina)
384:     ENDPROC
385: 
386:     *==========================================================================

*-- Linhas 399 a 474:
399:         *----------------------------------------------------------------------
400:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
401:         WITH loc_oPagina.cnt_4c_BotoesAcao
402:             .Top         = 40
403:             .Left        = 817
404:             .Width       = 160
405:             .Height      = 85
406:             .BackStyle   = 0
407:             .BorderWidth = 0
408:             .Visible     = .T.
409:         ENDWITH
410: 
411:         *-- Confirmar (Salva no legado)
412:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
413:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
414:             .Caption         = "Confirmar"
415:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
416:             .PicturePosition = 13
417:             .Top             = 5
418:             .Left            = 5
419:             .Width           = 75
420:             .Height          = 75
421:             .BackColor       = RGB(255, 255, 255)
422:             .ForeColor       = RGB(90, 90, 90)
423:             .FontName        = "Comic Sans MS"
424:             .FontSize        = 8
425:             .FontBold        = .T.
426:             .FontItalic      = .T.
427:             .Themes          = .F.
428:             .SpecialEffect   = 0
429:             .MousePointer    = 15
430:             .WordWrap        = .T.
431:             .AutoSize        = .F.
432:             .Visible         = .T.
433:         ENDWITH
434:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
435: 
436:         *-- Cancelar
437:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
438:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
439:             .Caption         = "Encerrar"
440:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
441:             .PicturePosition = 13
442:             .Top             = 5
443:             .Left            = 80
444:             .Width           = 75
445:             .Height          = 75
446:             .BackColor       = RGB(255, 255, 255)
447:             .ForeColor       = RGB(90, 90, 90)
448:             .FontName        = "Comic Sans MS"
449:             .FontSize        = 8
450:             .FontBold        = .T.
451:             .FontItalic      = .T.
452:             .Themes          = .F.
453:             .SpecialEffect   = 0
454:             .MousePointer    = 15
455:             .WordWrap        = .T.
456:             .AutoSize        = .F.
457:             .Visible         = .T.
458:         ENDWITH
459:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
460: 
461:         *----------------------------------------------------------------------
462:         * Label Codigo (Say1 no legado)
463:         * Original: Top=141, Left=358 -> Top=170 (+29)
464:         *----------------------------------------------------------------------
465:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
466:         WITH loc_oPagina.lbl_4c_Codigo
467:             .Caption   = "C" + CHR(243) + "digo :"
468:             .Top       = 170
469:             .Left      = 358
470:             .Width     = 46
471:             .Height    = 17
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .FontBold  = .F.

*-- Linhas 482 a 494:
482:         * Label Descricao (Say2 no legado)
483:         * Original: Top=167, Left=345 -> Top=196 (+29)
484:         *----------------------------------------------------------------------
485:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
486:         WITH loc_oPagina.lbl_4c_Descricao
487:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
488:             .Top       = 196
489:             .Left      = 345
490:             .Width     = 59
491:             .Height    = 17
492:             .FontName  = "Tahoma"
493:             .FontSize  = 8
494:             .FontBold  = .F.

*-- Linhas 502 a 514:
502:         * Label QtDias (Say3 no legado)
503:         * Original: Top=194, Left=305 -> Top=223 (+29)
504:         *----------------------------------------------------------------------
505:         loc_oPagina.AddObject("lbl_4c_QtDias", "Label")
506:         WITH loc_oPagina.lbl_4c_QtDias
507:             .Caption   = "Dias para entrega :"
508:             .Top       = 223
509:             .Left      = 305
510:             .Width     = 99
511:             .Height    = 17
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .FontBold  = .F.

*-- Linhas 527 a 536:
527:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
528:         WITH loc_oPagina.txt_4c_Codigo
529:             .Value         = ""
530:             .Top           = 166
531:             .Left          = 405
532:             .Width         = 41
533:             .Height        = 24
534:             .MaxLength     = 3
535:             .Format        = "!"
536:             .SpecialEffect = 1

*-- Linhas 549 a 558:
549:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
550:         WITH loc_oPagina.txt_4c_Descricao
551:             .Value         = ""
552:             .Top           = 192
553:             .Left          = 405
554:             .Width         = 282
555:             .Height        = 24
556:             .MaxLength     = 30
557:             .Format        = "!"
558:             .SpecialEffect = 1

*-- Linhas 571 a 580:
571:         loc_oPagina.AddObject("txt_4c_QtDias", "TextBox")
572:         WITH loc_oPagina.txt_4c_QtDias
573:             .Value         = 0
574:             .Top           = 219
575:             .Left          = 405
576:             .Width         = 41
577:             .Height        = 24
578:             .MaxLength     = 3
579:             .InputMask     = "999"
580:             .SpecialEffect = 1

*-- Linhas 611 a 620:
611:                     *-- Width e Headers APOS ControlSource (Problem #32)
612:                     loc_oGrid.Column1.Width = 80
613:                     loc_oGrid.Column2.Width = 200
614:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
615:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
616:                     THIS.FormatarGridLista(loc_oGrid)
617:                     loc_lResultado = .T.
618:                 ENDIF
619:             ENDIF
620:         CATCH TO loc_oErro

*-- Linhas 696 a 720:
696: 
697:         *-- Confirmar: habilitado em edicao OU em EXCLUIR (nao usar = 6, retorna LOGICAL)
698:         loc_lConfirmar = par_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
699:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lConfirmar
700:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
701:     ENDPROC
702: 
703:     *==========================================================================
704:     * AjustarBotoesPorModo - Estado dos botoes conforme this_cModoAtual
705:     *==========================================================================
706:     PROTECTED PROCEDURE AjustarBotoesPorModo()
707:         LOCAL loc_oPg2
708:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
709: 
710:         IF THIS.this_cModoAtual = "VISUALIZAR"
711:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
712:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
713:         ELSE
714:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
715:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
716:         ENDIF
717:     ENDPROC
718: 
719:     *==========================================================================
720:     * ValidarCampos - Valida campos obrigatorios antes de salvar

*-- Linhas 759 a 767:
759: 
760:     *==========================================================================
761:     * BtnVisualizarClick - Click no botao Visualizar
762:     * Modo: VISUALIZAR, foco em cmd_4c_Confirmar (Grupo_Salva.Salva.SetFocus)
763:     *==========================================================================
764:     PROCEDURE BtnVisualizarClick()
765:         LOCAL loc_cChave
766: 
767:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")

*-- Linhas 778 a 786:
778:             THIS.HabilitarCampos(.F.)
779:             THIS.AjustarBotoesPorModo()
780:             THIS.pgf_4c_Paginas.ActivePage = 2
781:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
782:         ELSE
783:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
784:         ENDIF
785:     ENDPROC
786: 


### BO (C:\4c\projeto\app\classes\SERBO.prg):
*==============================================================================
* SERBO.prg - Business Object para Servicos dos Produtos
* Tabela: SigPrSer
* Herda de: BusinessBase
* Fase 1/8: Propriedades e Init
*==============================================================================

DEFINE CLASS SERBO AS BusinessBase

    *-- Propriedades de dados (espelham colunas de SigPrSer)
    this_cIdChaves  = ""  && cidchaves char(20) - chave primaria UUID gerada por fUniqueIds
    this_cCodigo    = ""  && cods char(3) - codigo do servico (chave de negocio)
    this_cDescricao = ""  && descs char(30) - descricao do servico
    this_nQtDias    = 0   && qtdias numeric(3,0) - dias para entrega

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrSer"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega servicos no cursor_4c_Dados com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cIdChaves, a.Cods, a.Descs, a.qtDias" + ;
                       " FROM SigPrSer a"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                           " WHERE a.Cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar servi" + CHR(231) + CHR(245) + "os:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega servico pelo codigo de negocio (Cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cIdChaves, a.Cods, a.Descs, a.qtDias" + ;
                       " FROM SigPrSer a" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
            THIS.this_cCodigo    = TratarNulo(Cods,      "C")
            THIS.this_cDescricao = TratarNulo(Descs,     "C")
            THIS.this_nQtDias    = TratarNulo(qtDias,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigPrSer
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se codigo ja existe
            IF USED("cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Cods FROM SigPrSer WHERE Cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo)), ;
                "cursor_4c_Verifica")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Verifica") > 0
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Gerar UUID para a chave primaria
                THIS.this_cIdChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO SigPrSer (cIdChaves, Cods, Descs, qtDias)" + ;
                           " VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nQtDias) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Verifica")
            USE IN cursor_4c_Verifica
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigPrSer (codigo Cods nao e alterado apos insert)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrSer SET" + ;
                       " Descs = "  + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                       " qtDias = " + FormatarNumeroSQL(THIS.this_nQtDias) + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigPrSer
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrSer" + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

