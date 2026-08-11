# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 176: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 197: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 219: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 241: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 263: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 297: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 438: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 459: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormGpe.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4248 linhas total):

*-- Linhas 82 a 100:
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .PageCount  = 2
85:             .Top        = -29
86:             .Left       = 0
87:             .Width      = THIS.Width
88:             .Height     = THIS.Height + 29
89:             .Tabs       = .F.
90:             .Visible    = .T.
91: 
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(255, 255, 255)
95:             .Page2.Caption   = "Dados"
96:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page2.BackColor = RGB(255, 255, 255)
98:         ENDWITH
99:     ENDPROC
100: 

*-- Linhas 111 a 147:
111:         *-- Container cabecalho cinza superior
112:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH loc_oPagina.cnt_4c_Cabecalho
114:             .Top         = 2
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackColor   = RGB(100, 100, 100)
119:             .BorderWidth = 0
120:             .Visible     = .T.
121: 
122:             .AddObject("lbl_4c_Sombra", "Label")
123:             WITH .lbl_4c_Sombra
124:                 .Caption   = THIS.Caption
125:                 .Top       = 15
126:                 .Left      = 10
127:                 .Width     = THIS.Width
128:                 .Height    = 40
129:                 .FontName  = "Tahoma"
130:                 .FontSize  = 16
131:                 .FontBold  = .T.
132:                 .ForeColor = RGB(0, 0, 0)
133:                 .BackStyle = 0
134:                 .AutoSize  = .F.
135:                 .Visible   = .T.
136:             ENDWITH
137: 
138:             .AddObject("lbl_4c_Titulo", "Label")
139:             WITH .lbl_4c_Titulo
140:                 .Caption   = THIS.Caption
141:                 .Top       = 18
142:                 .Left      = 10
143:                 .Width     = THIS.Width
144:                 .Height    = 46
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 16
147:                 .FontBold  = .T.

*-- Linhas 155 a 269:
155:         *-- Container botoes CRUD (direito, fundo escuro)
156:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
157:         WITH loc_oPagina.cnt_4c_Botoes
158:             .Top         = 29
159:             .Left        = 542
160:             .Width       = 390
161:             .Height      = 85
162:             .BackStyle   = 1
163:             .BackColor   = RGB(53, 53, 53)
164:             .BorderWidth = 0
165:             .Visible     = .T.
166: 
167:             .AddObject("cmd_4c_Incluir", "CommandButton")
168:             WITH .cmd_4c_Incluir
169:                 .Caption         = "Incluir"
170:                 .Top             = 5
171:                 .Left            =  542
172:                 .Width           = 75
173:                 .Height          = 75
174:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
175:                 .PicturePosition = 13
176:                 .FontName        = "Comic Sans MS"
177:                 .FontSize        = 8
178:                 .FontBold        = .T.
179:                 .FontItalic      = .T.
180:                 .ForeColor       = RGB(90, 90, 90)
181:                 .BackColor       = RGB(255, 255, 255)
182:                 .SpecialEffect   = 0
183:                 .MousePointer    = 15
184:                 .WordWrap        = .T.
185:                 .Visible         = .T.
186:             ENDWITH
187: 
188:             .AddObject("cmd_4c_Visualizar", "CommandButton")
189:             WITH .cmd_4c_Visualizar
190:                 .Caption         = "Visualizar"
191:                 .Top             = 5
192:                 .Left            =  542
193:                 .Width           = 75
194:                 .Height          = 75
195:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
196:                 .PicturePosition = 13
197:                 .FontName        = "Comic Sans MS"
198:                 .FontSize        = 8
199:                 .FontBold        = .T.
200:                 .FontItalic      = .T.
201:                 .ForeColor       = RGB(90, 90, 90)
202:                 .BackColor       = RGB(255, 255, 255)
203:                 .Themes          = .F.
204:                 .SpecialEffect   = 0
205:                 .MousePointer    = 15
206:                 .WordWrap        = .T.
207:                 .Visible         = .T.
208:             ENDWITH
209: 
210:             .AddObject("cmd_4c_Alterar", "CommandButton")
211:             WITH .cmd_4c_Alterar
212:                 .Caption         = "Alterar"
213:                 .Top             = 5
214:                 .Left            =  542
215:                 .Width           = 75
216:                 .Height          = 75
217:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
218:                 .PicturePosition = 13
219:                 .FontName        = "Comic Sans MS"
220:                 .FontSize        = 8
221:                 .FontBold        = .T.
222:                 .FontItalic      = .T.
223:                 .ForeColor       = RGB(90, 90, 90)
224:                 .BackColor       = RGB(255, 255, 255)
225:                 .Themes          = .F.
226:                 .SpecialEffect   = 0
227:                 .MousePointer    = 15
228:                 .WordWrap        = .T.
229:                 .Visible         = .T.
230:             ENDWITH
231: 
232:             .AddObject("cmd_4c_Excluir", "CommandButton")
233:             WITH .cmd_4c_Excluir
234:                 .Caption         = "Excluir"
235:                 .Top             = 5
236:                 .Left            =  542
237:                 .Width           = 75
238:                 .Height          = 75
239:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
240:                 .PicturePosition = 13
241:                 .FontName        = "Comic Sans MS"
242:                 .FontSize        = 8
243:                 .FontBold        = .T.
244:                 .FontItalic      = .T.
245:                 .ForeColor       = RGB(90, 90, 90)
246:                 .BackColor       = RGB(255, 255, 255)
247:                 .Themes          = .F.
248:                 .SpecialEffect   = 0
249:                 .MousePointer    = 15
250:                 .WordWrap        = .T.
251:                 .Visible         = .T.
252:             ENDWITH
253: 
254:             .AddObject("cmd_4c_Buscar", "CommandButton")
255:             WITH .cmd_4c_Buscar
256:                 .Caption         = "Buscar"
257:                 .Top             = 5
258:                 .Left            =  542
259:                 .Width           = 75
260:                 .Height          = 75
261:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
262:                 .PicturePosition = 13
263:                 .FontName        = "Comic Sans MS"
264:                 .FontSize        = 8
265:                 .FontBold        = .T.
266:                 .FontItalic      = .T.
267:                 .ForeColor       = RGB(90, 90, 90)
268:                 .BackColor       = RGB(255, 255, 255)
269:                 .Themes          = .F.

*-- Linhas 277 a 303:
277:         *-- Container saida (Encerrar) - padrao canonico
278:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
279:         WITH loc_oPagina.cnt_4c_Saida
280:             .Top         = 29
281:             .Left        = 917
282:             .Width       = 90
283:             .Height      = 85
284:             .BackStyle   = 0
285:             .BorderWidth = 0
286:             .Visible     = .T.
287: 
288:             .AddObject("cmd_4c_Encerrar", "CommandButton")
289:             WITH .cmd_4c_Encerrar
290:                 .Caption         = "Encerrar"
291:                 .Top             = 5
292:                 .Left            = 917
293:                 .Width           = 90
294:                 .Height          = 75
295:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
296:                 .PicturePosition = 13
297:                 .FontName        = "Comic Sans MS"
298:                 .FontSize        = 8
299:                 .FontBold        = .T.
300:                 .FontItalic      = .T.
301:                 .ForeColor       = RGB(90, 90, 90)
302:                 .BackColor       = RGB(255, 255, 255)
303:                 .SpecialEffect   = 0

*-- Linhas 309 a 352:
309: 
310:         *-- Botoes auxiliares do legado: MontaLista, ImpXML, ExpXML
311:         *-- top=85 no legado + compensacao +29 = 114 na nova arquitetura
312:         loc_oPagina.AddObject("cmd_4c_MontaLista", "CommandButton")
313:         WITH loc_oPagina.cmd_4c_MontaLista
314:             .Caption         = ""
315:             .ToolTipText     = "Monta Lista"
316:             .Top             = 114
317:             .Left            = 587
318:             .Width           = 45
319:             .Height          = 45
320:             .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
321:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
322:             .PicturePosition = 4
323:             .Themes          = .T.
324:             .Visible         = .T.
325:         ENDWITH
326: 
327:         loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
328:         WITH loc_oPagina.cmd_4c_BtnImpXML
329:             .Caption         = ""
330:             .ToolTipText     = "Importar XML"
331:             .Top             = 114
332:             .Left            = 632
333:             .Width           = 45
334:             .Height          = 45
335:             .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
336:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
337:             .PicturePosition = 4
338:             .Themes          = .T.
339:             .Visible         = .T.
340:         ENDWITH
341: 
342:         loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
343:         WITH loc_oPagina.cmd_4c_BtnExpXML
344:             .Caption         = ""
345:             .ToolTipText     = "Exportar XML"
346:             .Top             = 114
347:             .Left            = 677
348:             .Width           = 45
349:             .Height          = 45
350:             .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
351:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
352:             .PicturePosition = 4

*-- Linhas 361 a 370:
361:         loc_oPagina.grd_4c_Lista.RecordSource = ""
362: 
363:         WITH loc_oPagina.grd_4c_Lista
364:             .Top                = 162
365:             .Left               = 26
366:             .Width              = 880
367:             .Height             = 433
368:             .FontName           = "Verdana"
369:             .FontSize           = 8
370:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 383 a 410:
383: 
384:             .Column1.Width           = 750
385:             .Column1.Resizable       = .T.
386:             .Column1.Header1.Caption = "Grupo Operacional"
387: 
388:             .Column2.Width           = 100
389:             .Column2.Resizable       = .T.
390:             .Column2.Alignment       = 1
391:             .Column2.Header1.Caption = "N" + CHR(186)
392:         ENDWITH
393: 
394:         THIS.TornarControlesVisiveis(loc_oPagina)
395: 
396:         *-- BINDEVENTs dos botoes da Page1
397:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
398:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
399:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
400:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
401:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
402:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
403:         BINDEVENT(loc_oPagina.cmd_4c_MontaLista,               "Click", THIS, "BtnMontaListaClick")
404:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML,                "Click", THIS, "BtnImpXMLClick")
405:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML,                "Click", THIS, "BtnExpXMLClick")
406:     ENDPROC
407: 
408:     *--------------------------------------------------------------------------
409:     * ConfigurarPaginaDados - Configura Page2 (Dados do registro)
410:     *--------------------------------------------------------------------------

*-- Linhas 418 a 465:
418:         *-- Container botoes Confirmar/Cancelar (topo direito)
419:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
420:         WITH loc_oPagina.cnt_4c_BotoesAcao
421:             .Top         = 33
422:             .Left        = 842
423:             .Width       = 160
424:             .Height      = 85
425:             .BackStyle   = 0
426:             .BorderWidth = 0
427:             .Visible     = .T.
428: 
429:             .AddObject("cmd_4c_Confirmar", "CommandButton")
430:             WITH .cmd_4c_Confirmar
431:                 .Caption         = "Confirmar"
432:                 .Top             = 5
433:                 .Left            = 5
434:                 .Width           = 75
435:                 .Height          = 75
436:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
437:                 .PicturePosition = 13
438:                 .FontName        = "Comic Sans MS"
439:                 .FontSize        = 8
440:                 .FontBold        = .T.
441:                 .FontItalic      = .T.
442:                 .ForeColor       = RGB(90, 90, 90)
443:                 .BackColor       = RGB(255, 255, 255)
444:                 .SpecialEffect   = 0
445:                 .MousePointer    = 15
446:                 .WordWrap        = .T.
447:                 .Visible         = .T.
448:             ENDWITH
449: 
450:             .AddObject("cmd_4c_Cancelar", "CommandButton")
451:             WITH .cmd_4c_Cancelar
452:                 .Caption         = "Encerrar"
453:                 .Top             = 5
454:                 .Left            = 80
455:                 .Width           = 75
456:                 .Height          = 75
457:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
458:                 .PicturePosition = 13
459:                 .FontName        = "Comic Sans MS"
460:                 .FontSize        = 8
461:                 .FontBold        = .T.
462:                 .FontItalic      = .T.
463:                 .ForeColor       = RGB(90, 90, 90)
464:                 .BackColor       = RGB(255, 255, 255)
465:                 .Themes          = .F.

*-- Linhas 471 a 522:
471:         ENDWITH
472: 
473:         *-- Label + TextBox: Grupo Operacional (dgopes) - Top=98+29=127
474:         loc_oPagina.AddObject("lbl_4c_LblGrupo", "Label")
475:         WITH loc_oPagina.lbl_4c_LblGrupo
476:             .Caption   = "Grupo Operacional : "
477:             .Top       = 130
478:             .Left      = 69
479:             .Width     = 115
480:             .Height    = 15
481:             .FontBold  = .T.
482:             .BackStyle = 0
483:             .AutoSize  = .F.
484:             .Visible   = .T.
485:         ENDWITH
486: 
487:         loc_oPagina.AddObject("txt_4c_Dgope", "TextBox")
488:         WITH loc_oPagina.txt_4c_Dgope
489:             .Top         = 127
490:             .Left        = 184
491:             .Width       = 150
492:             .Height      = 23
493:             .MaxLength   = 20
494:             .Format      = "K!"
495:             .FontName    = "Tahoma"
496:             .FontSize    = 8
497:             .Visible     = .T.
498:         ENDWITH
499: 
500:         *-- Label + TextBox: N° Grupo Operacional (ngopes) - readonly
501:         loc_oPagina.AddObject("lbl_4c_LblNumero", "Label")
502:         WITH loc_oPagina.lbl_4c_LblNumero
503:             .Caption   = "N" + CHR(176) + " Grupo Operacional : "
504:             .Top       = 130
505:             .Left      = 370
506:             .Width     = 131
507:             .Height    = 15
508:             .FontBold  = .T.
509:             .BackStyle = 0
510:             .AutoSize  = .F.
511:             .Visible   = .T.
512:         ENDWITH
513: 
514:         loc_oPagina.AddObject("txt_4c_Ngope", "TextBox")
515:         WITH loc_oPagina.txt_4c_Ngope
516:             .Top         = 127
517:             .Left        = 503
518:             .Width       = 52
519:             .Height      = 23
520:             .InputMask   = "999999"
521:             .ReadOnly    = .T.
522:             .FontName    = "Tahoma"

*-- Linhas 530 a 566:
530:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
531:         WITH loc_oPagina.pgf_4c_Dados
532:             .PageCount  = 2
533:             .Top        = 156
534:             .Left       = 0
535:             .Width      = THIS.Width
536:             .Height     = 448
537:             .Tabs       = .T.
538:             .Visible    = .T.
539: 
540:             .Page1.Caption   = "Configura" + CHR(231) + CHR(245) + "es"
541:             .Page1.FontName  = "Tahoma"
542:             .Page1.FontSize  = 8
543:             .Page1.BackColor = RGB(255, 255, 255)
544:             .Page1.ForeColor = RGB(90, 90, 90)
545: 
546:             .Page2.Caption   = "Complementos"
547:             .Page2.FontName  = "Tahoma"
548:             .Page2.FontSize  = 8
549:             .Page2.BackColor = RGB(255, 255, 255)
550:             .Page2.ForeColor = RGB(90, 90, 90)
551:         ENDWITH
552: 
553:         THIS.ConfigurarPgConfig(loc_oPagina.pgf_4c_Dados.Page1)
554:         THIS.ConfigurarPgCompls(loc_oPagina.pgf_4c_Dados.Page2)
555: 
556:         THIS.TornarControlesVisiveis(loc_oPagina)
557: 
558:         *-- BINDEVENTs dos botoes da Page2
559:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
560:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
561:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.cmd_4c_Icone,    "Click", THIS, "BtnIconeClick")
562: 
563:         *-- BINDEVENTs para lookup dos campos de texto (Enter/Tab/F4 abre picker)
564:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Subncrs, ;
565:             "KeyPress", THIS, "TxtSubncrsKeyPress")
566:         BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Locals, ;

*-- Linhas 585 a 599:
585:         *-- COLUNA ESQUERDA: OptionGroups e labels (Left=167, Width=247)
586: 
587:         *-- Numeracao da Operacao (numopers)
588:         par_oPg.AddObject("lbl_4c_NumOper", "Label")
589:         WITH par_oPg.lbl_4c_NumOper
590:             .FontName  = "Tahoma"
591:             .FontSize  = 8
592:             .Caption   = "Numera" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o :"
593:             .Top       = 13
594:             .Left      = 36
595:             .Width     = 128
596:             .Height    = 15
597:             .ForeColor = RGB(90, 90, 90)
598:             .BackStyle = 0
599:             .AutoSize  = .F.

*-- Linhas 607 a 653:
607:             .BackStyle   = 0
608:             .BorderStyle = 0
609:             .Height      = 21
610:             .Left        = 167
611:             .Top         = 8
612:             .Width       = 247
613:             .Value       = 1
614:             .Visible     = .T.
615:             .Buttons(1).Caption   = "No. Controle"
616:             .Buttons(1).FontSize  = 8
617:             .Buttons(1).BackStyle = 0
618:             .Buttons(1).Left      = 3
619:             .Buttons(1).Top       = 3
620:             .Buttons(1).Width     = 79
621:             .Buttons(1).AutoSize  = .T.
622:             .Buttons(1).ForeColor = RGB(90, 90, 90)
623:             .Buttons(2).Caption   = "Autom" + CHR(225) + "tica"
624:             .Buttons(2).FontSize  = 8
625:             .Buttons(2).BackStyle = 0
626:             .Buttons(2).Left      = 82
627:             .Buttons(2).Top       = 3
628:             .Buttons(2).Width     = 72
629:             .Buttons(2).AutoSize  = .T.
630:             .Buttons(2).ForeColor = RGB(90, 90, 90)
631:             .Buttons(3).Caption   = "Oper + No.Ctrl"
632:             .Buttons(3).FontSize  = 8
633:             .Buttons(3).BackStyle = 0
634:             .Buttons(3).Left      = 159
635:             .Buttons(3).Top       = 3
636:             .Buttons(3).Width     = 90
637:             .Buttons(3).AutoSize  = .T.
638:             .Buttons(3).ForeColor = RGB(90, 90, 90)
639:         ENDWITH
640: 
641:         *-- Tipo do No de Controle (ncontroles)
642:         par_oPg.AddObject("lbl_4c_Controle", "Label")
643:         WITH par_oPg.lbl_4c_Controle
644:             .FontName  = "Tahoma"
645:             .FontSize  = 8
646:             .Caption   = "Tipo do N" + CHR(176) + " de Controle :"
647:             .Top       = 33
648:             .Left      = 46
649:             .Width     = 118
650:             .Height    = 15
651:             .ForeColor = RGB(90, 90, 90)
652:             .BackStyle = 0
653:             .AutoSize  = .F.

*-- Linhas 661 a 710:
661:             .BackStyle   = 0
662:             .BorderStyle = 0
663:             .Height      = 22
664:             .Left        = 167
665:             .Top         = 29
666:             .Width       = 247
667:             .Value       = 1
668:             .Visible     = .T.
669:             .Buttons(1).Caption      = "Empresa"
670:             .Buttons(1).ToolTipText  = "Tipo Espelho ( EEENNNNNN )"
671:             .Buttons(1).FontSize     = 8
672:             .Buttons(1).BackStyle    = 0
673:             .Buttons(1).Left         = 3
674:             .Buttons(1).Top          = 3
675:             .Buttons(1).Width        = 59
676:             .Buttons(1).AutoSize     = .T.
677:             .Buttons(1).ForeColor    = RGB(90, 90, 90)
678:             .Buttons(2).Caption      = "Opera" + CHR(231) + CHR(227) + "o"
679:             .Buttons(2).ToolTipText  = "Tipo Boleto ( OONNNNNN )"
680:             .Buttons(2).FontSize     = 8
681:             .Buttons(2).BackStyle    = 0
682:             .Buttons(2).Left         = 82
683:             .Buttons(2).Top          = 3
684:             .Buttons(2).Width        = 65
685:             .Buttons(2).AutoSize     = .T.
686:             .Buttons(2).ForeColor    = RGB(90, 90, 90)
687:             .Buttons(3).Caption      = "Manual"
688:             .Buttons(3).ToolTipText  = "Tipo Manual ( NNNNNN )"
689:             .Buttons(3).FontSize     = 8
690:             .Buttons(3).BackStyle    = 0
691:             .Buttons(3).Left         = 159
692:             .Buttons(3).Top          = 3
693:             .Buttons(3).Width        = 61
694:             .Buttons(3).AutoSize     = .T.
695:             .Buttons(3).ForeColor    = RGB(90, 90, 90)
696:         ENDWITH
697: 
698:         *-- Fonte da Numeracao (fontnums)
699:         par_oPg.AddObject("lbl_4c_FonNum", "Label")
700:         WITH par_oPg.lbl_4c_FonNum
701:             .FontName  = "Tahoma"
702:             .FontSize  = 8
703:             .Caption   = "Fonte da Numera" + CHR(231) + CHR(227) + "o :"
704:             .Top       = 55
705:             .Left      = 55
706:             .Width     = 109
707:             .Height    = 15
708:             .ForeColor = RGB(90, 90, 90)
709:             .BackStyle = 0
710:             .AutoSize  = .F.

*-- Linhas 718 a 756:
718:             .BackStyle   = 0
719:             .BorderStyle = 0
720:             .Height      = 21
721:             .Left        = 167
722:             .Top         = 51
723:             .Width       = 247
724:             .Value       = 2
725:             .Visible     = .T.
726:             .Buttons(1).Caption   = "Grupo"
727:             .Buttons(1).FontSize  = 8
728:             .Buttons(1).BackStyle = 0
729:             .Buttons(1).Left      = 3
730:             .Buttons(1).Top       = 3
731:             .Buttons(1).Width     = 47
732:             .Buttons(1).AutoSize  = .T.
733:             .Buttons(1).ForeColor = RGB(90, 90, 90)
734:             .Buttons(2).Caption   = "Opera" + CHR(231) + CHR(227) + "o"
735:             .Buttons(2).FontSize  = 8
736:             .Buttons(2).BackStyle = 0
737:             .Buttons(2).Left      = 82
738:             .Buttons(2).Top       = 3
739:             .Buttons(2).Width     = 65
740:             .Buttons(2).AutoSize  = .T.
741:             .Buttons(2).ForeColor = RGB(90, 90, 90)
742:         ENDWITH
743: 
744:         *-- Situacao das Operacoes (utilizas)
745:         par_oPg.AddObject("lbl_4c_Utilizas", "Label")
746:         WITH par_oPg.lbl_4c_Utilizas
747:             .FontName  = "Tahoma"
748:             .FontSize  = 8
749:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es:"
750:             .Top       = 75
751:             .Left      = 42
752:             .Width     = 122
753:             .Height    = 15
754:             .ForeColor = RGB(90, 90, 90)
755:             .BackStyle = 0
756:             .AutoSize  = .F.

*-- Linhas 764 a 810:
764:             .BackStyle   = 0
765:             .BorderStyle = 0
766:             .Height      = 22
767:             .Left        = 167
768:             .Top         = 72
769:             .Width       = 247
770:             .Value       = 1
771:             .Visible     = .T.
772:             .Buttons(1).Caption   = "Todas"
773:             .Buttons(1).FontSize  = 8
774:             .Buttons(1).BackStyle = 0
775:             .Buttons(1).Left      = 3
776:             .Buttons(1).Top       = 3
777:             .Buttons(1).Width     = 47
778:             .Buttons(1).AutoSize  = .T.
779:             .Buttons(1).ForeColor = RGB(90, 90, 90)
780:             .Buttons(2).Caption   = "Utilizadas"
781:             .Buttons(2).FontSize  = 8
782:             .Buttons(2).BackStyle = 0
783:             .Buttons(2).Left      = 82
784:             .Buttons(2).Top       = 3
785:             .Buttons(2).Width     = 63
786:             .Buttons(2).AutoSize  = .T.
787:             .Buttons(2).ForeColor = RGB(90, 90, 90)
788:             .Buttons(3).Caption   = "N" + CHR(227) + "o Utilizadas"
789:             .Buttons(3).FontSize  = 8
790:             .Buttons(3).BackStyle = 0
791:             .Buttons(3).Left      = 159
792:             .Buttons(3).Top       = 3
793:             .Buttons(3).Width     = 73
794:             .Buttons(3).AutoSize  = .T.
795:             .Buttons(3).ForeColor = RGB(90, 90, 90)
796:         ENDWITH
797: 
798:         *-- Situacao dos Subniveis (subniveis)
799:         par_oPg.AddObject("lbl_4c_Subniveis", "Label")
800:         WITH par_oPg.lbl_4c_Subniveis
801:             .FontName  = "Tahoma"
802:             .FontSize  = 8
803:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o dos Subn" + CHR(237) + "veis :"
804:             .Top       = 97
805:             .Left      = 46
806:             .Width     = 118
807:             .Height    = 15
808:             .ForeColor = RGB(90, 90, 90)
809:             .BackStyle = 0
810:             .AutoSize  = .F.

*-- Linhas 818 a 864:
818:             .BackStyle   = 0
819:             .BorderStyle = 0
820:             .Height      = 22
821:             .Left        = 167
822:             .Top         = 94
823:             .Width       = 247
824:             .Value       = 1
825:             .Visible     = .T.
826:             .Buttons(1).Caption   = "Todos"
827:             .Buttons(1).FontSize  = 8
828:             .Buttons(1).BackStyle = 0
829:             .Buttons(1).Left      = 3
830:             .Buttons(1).Top       = 3
831:             .Buttons(1).Width     = 47
832:             .Buttons(1).AutoSize  = .T.
833:             .Buttons(1).ForeColor = RGB(90, 90, 90)
834:             .Buttons(2).Caption   = "Pendentes"
835:             .Buttons(2).FontSize  = 8
836:             .Buttons(2).BackStyle = 0
837:             .Buttons(2).Left      = 82
838:             .Buttons(2).Top       = 3
839:             .Buttons(2).Width     = 69
840:             .Buttons(2).AutoSize  = .T.
841:             .Buttons(2).ForeColor = RGB(90, 90, 90)
842:             .Buttons(3).Caption   = "Baixados"
843:             .Buttons(3).FontSize  = 8
844:             .Buttons(3).BackStyle = 0
845:             .Buttons(3).Left      = 159
846:             .Buttons(3).Top       = 3
847:             .Buttons(3).Width     = 61
848:             .Buttons(3).AutoSize  = .T.
849:             .Buttons(3).ForeColor = RGB(90, 90, 90)
850:         ENDWITH
851: 
852:         *-- Ordem de Producao (prods)
853:         par_oPg.AddObject("lbl_4c_Prods", "Label")
854:         WITH par_oPg.lbl_4c_Prods
855:             .FontName  = "Tahoma"
856:             .FontSize  = 8
857:             .Caption   = "Ordem de Produ" + CHR(231) + CHR(227) + "o :"
858:             .Top       = 119
859:             .Left      = 60
860:             .Width     = 104
861:             .Height    = 15
862:             .ForeColor = RGB(90, 90, 90)
863:             .BackStyle = 0
864:             .AutoSize  = .F.

*-- Linhas 872 a 918:
872:             .BackStyle   = 0
873:             .BorderStyle = 0
874:             .Height      = 22
875:             .Left        = 167
876:             .Top         = 116
877:             .Width       = 247
878:             .Value       = 1
879:             .Visible     = .T.
880:             .Buttons(1).Caption   = "Todas"
881:             .Buttons(1).FontSize  = 8
882:             .Buttons(1).BackStyle = 0
883:             .Buttons(1).Left      = 3
884:             .Buttons(1).Top       = 3
885:             .Buttons(1).Width     = 47
886:             .Buttons(1).AutoSize  = .T.
887:             .Buttons(1).ForeColor = RGB(90, 90, 90)
888:             .Buttons(2).Caption   = "Com OP"
889:             .Buttons(2).FontSize  = 8
890:             .Buttons(2).BackStyle = 0
891:             .Buttons(2).Left      = 82
892:             .Buttons(2).Top       = 3
893:             .Buttons(2).Width     = 56
894:             .Buttons(2).AutoSize  = .T.
895:             .Buttons(2).ForeColor = RGB(90, 90, 90)
896:             .Buttons(3).Caption   = "Sem OP"
897:             .Buttons(3).FontSize  = 8
898:             .Buttons(3).BackStyle = 0
899:             .Buttons(3).Left      = 159
900:             .Buttons(3).Top       = 3
901:             .Buttons(3).Width     = 55
902:             .Buttons(3).AutoSize  = .T.
903:             .Buttons(3).ForeColor = RGB(90, 90, 90)
904:         ENDWITH
905: 
906:         *-- Desagendar Utilizados (desutils)
907:         par_oPg.AddObject("lbl_4c_Desutils", "Label")
908:         WITH par_oPg.lbl_4c_Desutils
909:             .FontName  = "Tahoma"
910:             .FontSize  = 8
911:             .Caption   = "Desagendar Utilizados:"
912:             .Top       = 141
913:             .Left      = 52
914:             .Width     = 112
915:             .Height    = 15
916:             .ForeColor = RGB(90, 90, 90)
917:             .BackStyle = 0
918:             .AutoSize  = .F.

*-- Linhas 926 a 962:
926:             .BackStyle   = 0
927:             .BorderStyle = 0
928:             .Height      = 22
929:             .Left        = 167
930:             .Top         = 138
931:             .Width       = 247
932:             .Value       = 2
933:             .Visible     = .T.
934:             .Buttons(1).Caption   = "Sim"
935:             .Buttons(1).FontSize  = 8
936:             .Buttons(1).BackStyle = 0
937:             .Buttons(1).Left      = 3
938:             .Buttons(1).Top       = 3
939:             .Buttons(1).Width     = 34
940:             .Buttons(1).AutoSize  = .T.
941:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
942:             .Buttons(2).FontSize  = 8
943:             .Buttons(2).BackStyle = 0
944:             .Buttons(2).Left      = 82
945:             .Buttons(2).Top       = 3
946:             .Buttons(2).Width     = 37
947:             .Buttons(2).AutoSize  = .T.
948:         ENDWITH
949: 
950:         *-- Exibir botao F8 - AGENDA (iniagenda)
951:         par_oPg.AddObject("lbl_4c_Iniagenda", "Label")
952:         WITH par_oPg.lbl_4c_Iniagenda
953:             .FontName  = "Tahoma"
954:             .FontSize  = 8
955:             .Caption   = "Exibir bot" + CHR(227) + "o F8 - AGENDA:"
956:             .Top       = 163
957:             .Left      = 35
958:             .Width     = 129
959:             .Height    = 15
960:             .ForeColor = RGB(90, 90, 90)
961:             .BackStyle = 0
962:             .AutoSize  = .F.

*-- Linhas 970 a 1006:
970:             .BackStyle   = 0
971:             .BorderStyle = 0
972:             .Height      = 22
973:             .Left        = 167
974:             .Top         = 160
975:             .Width       = 247
976:             .Value       = 2
977:             .Visible     = .T.
978:             .Buttons(1).Caption   = "Sim"
979:             .Buttons(1).FontSize  = 8
980:             .Buttons(1).BackStyle = 0
981:             .Buttons(1).Left      = 3
982:             .Buttons(1).Top       = 3
983:             .Buttons(1).Width     = 34
984:             .Buttons(1).AutoSize  = .T.
985:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
986:             .Buttons(2).FontSize  = 8
987:             .Buttons(2).BackStyle = 0
988:             .Buttons(2).Left      = 82
989:             .Buttons(2).Top       = 3
990:             .Buttons(2).Width     = 37
991:             .Buttons(2).AutoSize  = .T.
992:         ENDWITH
993: 
994:         *-- Ignorar Grupo Operacional (qualquer)
995:         par_oPg.AddObject("lbl_4c_Qualquer", "Label")
996:         WITH par_oPg.lbl_4c_Qualquer
997:             .FontName  = "Tahoma"
998:             .FontSize  = 8
999:             .Caption   = "Ignorar Grupo Operacional :"
1000:             .Top       = 185
1001:             .Left      = 27
1002:             .Width     = 137
1003:             .Height    = 15
1004:             .ForeColor = RGB(90, 90, 90)
1005:             .BackStyle = 0
1006:             .AutoSize  = .F.

*-- Linhas 1014 a 1050:
1014:             .BackStyle   = 0
1015:             .BorderStyle = 0
1016:             .Height      = 22
1017:             .Left        = 167
1018:             .Top         = 182
1019:             .Width       = 247
1020:             .Value       = 2
1021:             .Visible     = .T.
1022:             .Buttons(1).Caption   = "Sim"
1023:             .Buttons(1).FontSize  = 8
1024:             .Buttons(1).BackStyle = 0
1025:             .Buttons(1).Left      = 3
1026:             .Buttons(1).Top       = 3
1027:             .Buttons(1).Width     = 34
1028:             .Buttons(1).AutoSize  = .T.
1029:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1030:             .Buttons(2).FontSize  = 8
1031:             .Buttons(2).BackStyle = 0
1032:             .Buttons(2).Left      = 82
1033:             .Buttons(2).Top       = 3
1034:             .Buttons(2).Width     = 37
1035:             .Buttons(2).AutoSize  = .T.
1036:         ENDWITH
1037: 
1038:         *-- Apenas Consulta (consulta)
1039:         par_oPg.AddObject("lbl_4c_Consulta", "Label")
1040:         WITH par_oPg.lbl_4c_Consulta
1041:             .FontName  = "Tahoma"
1042:             .FontSize  = 8
1043:             .Caption   = "Apenas Consulta :"
1044:             .Top       = 207
1045:             .Left      = 74
1046:             .Width     = 90
1047:             .Height    = 15
1048:             .ForeColor = RGB(90, 90, 90)
1049:             .BackStyle = 0
1050:             .AutoSize  = .F.

*-- Linhas 1058 a 1094:
1058:             .BackStyle   = 0
1059:             .BorderStyle = 0
1060:             .Height      = 22
1061:             .Left        = 167
1062:             .Top         = 204
1063:             .Width       = 247
1064:             .Value       = 2
1065:             .Visible     = .T.
1066:             .Buttons(1).Caption   = "Sim"
1067:             .Buttons(1).FontSize  = 8
1068:             .Buttons(1).BackStyle = 0
1069:             .Buttons(1).Left      = 3
1070:             .Buttons(1).Top       = 3
1071:             .Buttons(1).Width     = 34
1072:             .Buttons(1).AutoSize  = .T.
1073:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1074:             .Buttons(2).FontSize  = 8
1075:             .Buttons(2).BackStyle = 0
1076:             .Buttons(2).Left      = 82
1077:             .Buttons(2).Top       = 3
1078:             .Buttons(2).Width     = 37
1079:             .Buttons(2).AutoSize  = .T.
1080:         ENDWITH
1081: 
1082:         *-- Produtos Com Montagem (montagem)
1083:         par_oPg.AddObject("lbl_4c_Montagem", "Label")
1084:         WITH par_oPg.lbl_4c_Montagem
1085:             .FontName  = "Tahoma"
1086:             .FontSize  = 8
1087:             .Caption   = "Produtos Com Montagem :"
1088:             .Top       = 229
1089:             .Left      = 35
1090:             .Width     = 129
1091:             .Height    = 15
1092:             .ForeColor = RGB(90, 90, 90)
1093:             .BackStyle = 0
1094:             .AutoSize  = .F.

*-- Linhas 1102 a 1148:
1102:             .BackStyle   = 0
1103:             .BorderStyle = 0
1104:             .Height      = 22
1105:             .Left        = 167
1106:             .Top         = 226
1107:             .Width       = 247
1108:             .Value       = 2
1109:             .Visible     = .T.
1110:             .Buttons(1).Caption   = "Sim"
1111:             .Buttons(1).FontSize  = 8
1112:             .Buttons(1).BackStyle = 0
1113:             .Buttons(1).Left      = 3
1114:             .Buttons(1).Top       = 3
1115:             .Buttons(1).Width     = 34
1116:             .Buttons(1).AutoSize  = .T.
1117:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1118:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1119:             .Buttons(2).FontSize  = 8
1120:             .Buttons(2).BackStyle = 0
1121:             .Buttons(2).Left      = 82
1122:             .Buttons(2).Top       = 3
1123:             .Buttons(2).Width     = 37
1124:             .Buttons(2).AutoSize  = .T.
1125:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1126:             .Buttons(3).Caption   = "Ambos"
1127:             .Buttons(3).FontSize  = 8
1128:             .Buttons(3).BackStyle = 0
1129:             .Buttons(3).Left      = 159
1130:             .Buttons(3).Top       = 3
1131:             .Buttons(3).Width     = 61
1132:             .Buttons(3).AutoSize  = .T.
1133:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1134:         ENDWITH
1135: 
1136:         *-- Checar Mercadorias (chkmercs)
1137:         par_oPg.AddObject("lbl_4c_Chkmercs", "Label")
1138:         WITH par_oPg.lbl_4c_Chkmercs
1139:             .FontName  = "Tahoma"
1140:             .FontSize  = 8
1141:             .Caption   = "Checar Mercadorias :"
1142:             .Top       = 251
1143:             .Left      = 60
1144:             .Width     = 104
1145:             .Height    = 15
1146:             .ForeColor = RGB(90, 90, 90)
1147:             .BackStyle = 0
1148:             .AutoSize  = .F.

*-- Linhas 1156 a 1192:
1156:             .BackStyle   = 0
1157:             .BorderStyle = 0
1158:             .Height      = 22
1159:             .Left        = 167
1160:             .Top         = 248
1161:             .Width       = 247
1162:             .Value       = 2
1163:             .Visible     = .T.
1164:             .Buttons(1).Caption   = "Sim"
1165:             .Buttons(1).FontSize  = 8
1166:             .Buttons(1).BackStyle = 0
1167:             .Buttons(1).Left      = 3
1168:             .Buttons(1).Top       = 3
1169:             .Buttons(1).Width     = 34
1170:             .Buttons(1).AutoSize  = .T.
1171:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1172:             .Buttons(2).FontSize  = 8
1173:             .Buttons(2).BackStyle = 0
1174:             .Buttons(2).Left      = 82
1175:             .Buttons(2).Top       = 3
1176:             .Buttons(2).Width     = 37
1177:             .Buttons(2).AutoSize  = .T.
1178:         ENDWITH
1179: 
1180:         *-- Operacoes Utilizadas (oputiliza)
1181:         par_oPg.AddObject("lbl_4c_Oputiliza", "Label")
1182:         WITH par_oPg.lbl_4c_Oputiliza
1183:             .FontName  = "Tahoma"
1184:             .FontSize  = 8
1185:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es Utilizadas :"
1186:             .Top       = 273
1187:             .Left      = 55
1188:             .Width     = 109
1189:             .Height    = 15
1190:             .ForeColor = RGB(90, 90, 90)
1191:             .BackStyle = 0
1192:             .AutoSize  = .F.

*-- Linhas 1200 a 1246:
1200:             .BackStyle   = 0
1201:             .BorderStyle = 0
1202:             .Height      = 22
1203:             .Left        = 167
1204:             .Top         = 270
1205:             .Width       = 247
1206:             .Value       = 1
1207:             .Visible     = .T.
1208:             .Buttons(1).Caption   = "Sim"
1209:             .Buttons(1).FontSize  = 8
1210:             .Buttons(1).BackStyle = 0
1211:             .Buttons(1).Left      = 3
1212:             .Buttons(1).Top       = 3
1213:             .Buttons(1).Width     = 34
1214:             .Buttons(1).AutoSize  = .T.
1215:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1216:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1217:             .Buttons(2).FontSize  = 8
1218:             .Buttons(2).BackStyle = 0
1219:             .Buttons(2).Left      = 82
1220:             .Buttons(2).Top       = 3
1221:             .Buttons(2).Width     = 37
1222:             .Buttons(2).AutoSize  = .T.
1223:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1224:             .Buttons(3).Caption   = "Ambas"
1225:             .Buttons(3).FontSize  = 8
1226:             .Buttons(3).BackStyle = 0
1227:             .Buttons(3).Left      = 159
1228:             .Buttons(3).Top       = 3
1229:             .Buttons(3).Width     = 61
1230:             .Buttons(3).AutoSize  = .T.
1231:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1232:         ENDWITH
1233: 
1234:         *-- Operacoes Pagas (filpagas)
1235:         par_oPg.AddObject("lbl_4c_Filpagas", "Label")
1236:         WITH par_oPg.lbl_4c_Filpagas
1237:             .FontName  = "Tahoma"
1238:             .FontSize  = 8
1239:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es Pagas :"
1240:             .Top       = 295
1241:             .Left      = 71
1242:             .Width     = 93
1243:             .Height    = 15
1244:             .ForeColor = RGB(90, 90, 90)
1245:             .BackStyle = 0
1246:             .AutoSize  = .F.

*-- Linhas 1254 a 1300:
1254:             .BackStyle   = 0
1255:             .BorderStyle = 0
1256:             .Height      = 22
1257:             .Left        = 167
1258:             .Top         = 292
1259:             .Width       = 247
1260:             .Value       = 1
1261:             .Visible     = .T.
1262:             .Buttons(1).Caption   = "Sim"
1263:             .Buttons(1).FontSize  = 8
1264:             .Buttons(1).BackStyle = 0
1265:             .Buttons(1).Left      = 3
1266:             .Buttons(1).Top       = 3
1267:             .Buttons(1).Width     = 34
1268:             .Buttons(1).AutoSize  = .T.
1269:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1270:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1271:             .Buttons(2).FontSize  = 8
1272:             .Buttons(2).BackStyle = 0
1273:             .Buttons(2).Left      = 82
1274:             .Buttons(2).Top       = 3
1275:             .Buttons(2).Width     = 37
1276:             .Buttons(2).AutoSize  = .T.
1277:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1278:             .Buttons(3).Caption   = "Ambas"
1279:             .Buttons(3).FontSize  = 8
1280:             .Buttons(3).BackStyle = 0
1281:             .Buttons(3).Left      = 159
1282:             .Buttons(3).Top       = 3
1283:             .Buttons(3).Width     = 61
1284:             .Buttons(3).AutoSize  = .T.
1285:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1286:         ENDWITH
1287: 
1288:         *-- Operacoes Baixadas (filbaixas)
1289:         par_oPg.AddObject("lbl_4c_Filbaixas", "Label")
1290:         WITH par_oPg.lbl_4c_Filbaixas
1291:             .FontName  = "Tahoma"
1292:             .FontSize  = 8
1293:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es Baixadas :"
1294:             .Top       = 317
1295:             .Left      = 57
1296:             .Width     = 107
1297:             .Height    = 15
1298:             .ForeColor = RGB(90, 90, 90)
1299:             .BackStyle = 0
1300:             .AutoSize  = .F.

*-- Linhas 1308 a 1366:
1308:             .BackStyle   = 0
1309:             .BorderStyle = 0
1310:             .Height      = 22
1311:             .Left        = 167
1312:             .Top         = 314
1313:             .Width       = 247
1314:             .Value       = 1
1315:             .Visible     = .T.
1316:             .Buttons(1).Caption   = "Sim"
1317:             .Buttons(1).FontSize  = 8
1318:             .Buttons(1).BackStyle = 0
1319:             .Buttons(1).Left      = 3
1320:             .Buttons(1).Top       = 3
1321:             .Buttons(1).Width     = 34
1322:             .Buttons(1).AutoSize  = .T.
1323:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1324:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1325:             .Buttons(2).FontSize  = 8
1326:             .Buttons(2).BackStyle = 0
1327:             .Buttons(2).Left      = 82
1328:             .Buttons(2).Top       = 3
1329:             .Buttons(2).Width     = 37
1330:             .Buttons(2).AutoSize  = .T.
1331:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1332:             .Buttons(3).Caption   = "Ambas"
1333:             .Buttons(3).FontSize  = 8
1334:             .Buttons(3).BackStyle = 0
1335:             .Buttons(3).Left      = 159
1336:             .Buttons(3).Top       = 3
1337:             .Buttons(3).Width     = 61
1338:             .Buttons(3).AutoSize  = .T.
1339:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1340:         ENDWITH
1341: 
1342:         *-- Limite Diario (limdia)
1343:         par_oPg.AddObject("lbl_4c_Limdia", "Label")
1344:         WITH par_oPg.lbl_4c_Limdia
1345:             .FontName  = "Tahoma"
1346:             .FontSize  = 8
1347:             .Caption   = "Limite di" + CHR(225) + "rio :"
1348:             .Top       = 341
1349:             .Left      = 99
1350:             .Width     = 65
1351:             .Height    = 15
1352:             .ForeColor = RGB(90, 90, 90)
1353:             .BackStyle = 0
1354:             .AutoSize  = .F.
1355:             .Visible   = .T.
1356:         ENDWITH
1357: 
1358:         par_oPg.AddObject("txt_4c_Limdia", "TextBox")
1359:         WITH par_oPg.txt_4c_Limdia
1360:             .Top       = 338
1361:             .Left      = 168
1362:             .Width     = 52
1363:             .Height    = 23
1364:             .MaxLength = 6
1365:             .FontName  = "Tahoma"
1366:             .FontSize  = 8

*-- Linhas 1375 a 1456:
1375:             .BackStyle   = 0
1376:             .BorderStyle = 0
1377:             .Height      = 112
1378:             .Left        = 424
1379:             .Top         = 8
1380:             .Width       = 301
1381:             .Value       = 2
1382:             .Visible     = .T.
1383:             .Buttons(1).Caption   = "Sim"
1384:             .Buttons(1).FontSize  = 8
1385:             .Buttons(1).BackStyle = 0
1386:             .Buttons(1).Left      = 4
1387:             .Buttons(1).Top       = 6
1388:             .Buttons(1).Width     = 34
1389:             .Buttons(1).AutoSize  = .T.
1390:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1391:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1392:             .Buttons(2).FontSize  = 8
1393:             .Buttons(2).BackStyle = 0
1394:             .Buttons(2).Left      = 151
1395:             .Buttons(2).Top       = 6
1396:             .Buttons(2).Width     = 37
1397:             .Buttons(2).AutoSize  = .T.
1398:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1399:             .Buttons(3).Caption   = "Agendamento Pago"
1400:             .Buttons(3).FontSize  = 8
1401:             .Buttons(3).BackStyle = 0
1402:             .Buttons(3).Left      = 4
1403:             .Buttons(3).Top       = 27
1404:             .Buttons(3).Width     = 112
1405:             .Buttons(3).AutoSize  = .T.
1406:             .Buttons(3).ForeColor = RGB(90, 90, 90)
1407:             .Buttons(4).Caption   = "Agendamento N" + CHR(227) + "o Pago"
1408:             .Buttons(4).FontSize  = 8
1409:             .Buttons(4).BackStyle = 0
1410:             .Buttons(4).Left      = 151
1411:             .Buttons(4).Top       = 27
1412:             .Buttons(4).Width     = 134
1413:             .Buttons(4).AutoSize  = .T.
1414:             .Buttons(4).ForeColor = RGB(90, 90, 90)
1415:             .Buttons(5).Caption   = "Subniveis N" + CHR(227) + "o Utilizados"
1416:             .Buttons(5).FontSize  = 8
1417:             .Buttons(5).BackStyle = 0
1418:             .Buttons(5).Left      = 4
1419:             .Buttons(5).Top       = 48
1420:             .Buttons(5).Width     = 133
1421:             .Buttons(5).AutoSize  = .T.
1422:             .Buttons(5).ForeColor = RGB(90, 90, 90)
1423:             .Buttons(6).Caption   = "Certificado de Cr" + CHR(233) + "dito"
1424:             .Buttons(6).FontSize  = 8
1425:             .Buttons(6).BackStyle = 0
1426:             .Buttons(6).Left      = 151
1427:             .Buttons(6).Top       = 48
1428:             .Buttons(6).Width     = 123
1429:             .Buttons(6).AutoSize  = .T.
1430:             .Buttons(6).ForeColor = RGB(90, 90, 90)
1431:             .Buttons(7).Caption   = "Subniveis Pagos"
1432:             .Buttons(7).FontSize  = 8
1433:             .Buttons(7).BackStyle = 0
1434:             .Buttons(7).Left      = 4
1435:             .Buttons(7).Top       = 69
1436:             .Buttons(7).Width     = 95
1437:             .Buttons(7).AutoSize  = .T.
1438:             .Buttons(7).ForeColor = RGB(90, 90, 90)
1439:             .Buttons(8).Caption   = "N" + CHR(227) + "o Pagos"
1440:             .Buttons(8).FontSize  = 8
1441:             .Buttons(8).BackStyle = 0
1442:             .Buttons(8).Left      = 151
1443:             .Buttons(8).Top       = 69
1444:             .Buttons(8).Width     = 69
1445:             .Buttons(8).AutoSize  = .T.
1446:             .Buttons(8).ForeColor = RGB(90, 90, 90)
1447:             .Buttons(9).Caption   = "Agendamento Geral"
1448:             .Buttons(9).FontSize  = 8
1449:             .Buttons(9).BackStyle = 0
1450:             .Buttons(9).Left      = 4
1451:             .Buttons(9).Top       = 90
1452:             .Buttons(9).Width     = 113
1453:             .Buttons(9).AutoSize  = .T.
1454:             .Buttons(9).ForeColor = RGB(90, 90, 90)
1455:         ENDWITH
1456: 

*-- Linhas 1463 a 1475:
1463:         WITH par_oPg.grd_4c_GradeOpe
1464:             .HeaderHeight = 17
1465:             .Height       = 171
1466:             .Left         = 424
1467:             .RecordMark   = .F.
1468:             .DeleteMark   = .F.
1469:             .RowHeight    = 17
1470:             .Top          = 121
1471:             .Width        = 301
1472:             .ReadOnly     = .F.
1473:             .ScrollBars   = 2
1474:             .Visible      = .T.
1475: 

*-- Linhas 1491 a 1504:
1491:             .Column1.Header1.FontName  = "Verdana"
1492:             .Column1.Header1.FontSize  = 8
1493:             .Column1.Header1.Alignment = 2
1494:             .Column1.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"
1495: 
1496:             .Column2.Header1.FontName  = "Verdana"
1497:             .Column2.Header1.FontSize  = 8
1498:             .Column2.Header1.Alignment = 2
1499:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
1500:         ENDWITH
1501:     ENDPROC
1502: 
1503:     *--------------------------------------------------------------------------
1504:     * ConfigurarPgCompls - Configura aba Complementos (pgf_4c_Dados.Page2)

*-- Linhas 1510 a 1592:
1510: 
1511:         par_oPg.AddObject("shp_4c_Shape2", "Shape")
1512:         WITH par_oPg.shp_4c_Shape2
1513:             .Top           = 10
1514:             .Left          = 515
1515:             .Height        = 61
1516:             .Width         = 215
1517:             .BackStyle     = 0
1518:             .SpecialEffect = 0
1519:             .Visible       = .T.
1520:         ENDWITH
1521: 
1522:         par_oPg.AddObject("shp_4c_Shape6", "Shape")
1523:         WITH par_oPg.shp_4c_Shape6
1524:             .Top           = 73
1525:             .Left          = 515
1526:             .Height        = 56
1527:             .Width         = 215
1528:             .BackStyle     = 0
1529:             .SpecialEffect = 0
1530:             .Visible       = .T.
1531:         ENDWITH
1532: 
1533:         par_oPg.AddObject("shp_4c_Shape1", "Shape")
1534:         WITH par_oPg.shp_4c_Shape1
1535:             .Top           = 246
1536:             .Left          = 275
1537:             .Height        = 79
1538:             .Width         = 264
1539:             .BackStyle     = 0
1540:             .SpecialEffect = 0
1541:             .Visible       = .T.
1542:         ENDWITH
1543: 
1544:         par_oPg.AddObject("shp_4c_Shape3", "Shape")
1545:         WITH par_oPg.shp_4c_Shape3
1546:             .Top           = 246
1547:             .Left          = 5
1548:             .Height        = 124
1549:             .Width         = 264
1550:             .BackStyle     = 0
1551:             .SpecialEffect = 0
1552:             .Visible       = .T.
1553:         ENDWITH
1554: 
1555:         par_oPg.AddObject("shp_4c_Shape4", "Shape")
1556:         WITH par_oPg.shp_4c_Shape4
1557:             .Top           = 331
1558:             .Left          = 275
1559:             .Height        = 39
1560:             .Width         = 264
1561:             .BackStyle     = 0
1562:             .SpecialEffect = 0
1563:             .Visible       = .T.
1564:         ENDWITH
1565: 
1566:         *-- Icone diamante - tooltip consulta generica de produtos (Image1)
1567:         par_oPg.AddObject("img_4c_Image1", "Image")
1568:         WITH par_oPg.img_4c_Image1
1569:             .Picture     = gc_4c_CaminhoIcones + "a_diamd1.bmp"
1570:             .Top         = 263
1571:             .Left        = 244
1572:             .Height      = 20
1573:             .Width       = 20
1574:             .ToolTipText = "Esta Configura" + CHR(231) + CHR(227) + "o " + CHR(233) + " Utilizada Na Consulta Gen" + CHR(233) + "rica de Produtos"
1575:             .Visible     = .T.
1576:         ENDWITH
1577: 
1578:         *-- COLUNA ESQUERDA: OptionGroups Sim/Nao (Left=173, Width=86, H=20)
1579: 
1580:         *-- Utilizar Data Atual (dtatuals)
1581:         par_oPg.AddObject("lbl_4c_DtAtuals", "Label")
1582:         WITH par_oPg.lbl_4c_DtAtuals
1583:             .FontName  = "Tahoma"
1584:             .FontSize  = 8
1585:             .Caption   = "Utilizar Data Atual :"
1586:             .Top       = 6
1587:             .Left      = 79
1588:             .Width     = 95
1589:             .Height    = 15
1590:             .ForeColor = RGB(90, 90, 90)
1591:             .BackStyle = 0
1592:             .AutoSize  = .F.

*-- Linhas 1600 a 1636:
1600:             .BackStyle   = 0
1601:             .BorderStyle = 0
1602:             .Height      = 20
1603:             .Left        = 173
1604:             .Top         = 2
1605:             .Width       = 86
1606:             .Value       = 1
1607:             .Visible     = .T.
1608:             .Buttons(1).Caption   = "Sim"
1609:             .Buttons(1).FontSize  = 8
1610:             .Buttons(1).BackStyle = 0
1611:             .Buttons(1).Left      = 5
1612:             .Buttons(1).Top       = 3
1613:             .Buttons(1).Width     = 34
1614:             .Buttons(1).AutoSize  = .T.
1615:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1616:             .Buttons(2).FontSize  = 8
1617:             .Buttons(2).BackStyle = 0
1618:             .Buttons(2).Left      = 45
1619:             .Buttons(2).Top       = 3
1620:             .Buttons(2).Width     = 37
1621:             .Buttons(2).AutoSize  = .T.
1622:         ENDWITH
1623: 
1624:         *-- Bloqueia Alt. Data (blqadts)
1625:         par_oPg.AddObject("lbl_4c_BlqAdts", "Label")
1626:         WITH par_oPg.lbl_4c_BlqAdts
1627:             .FontName  = "Tahoma"
1628:             .FontSize  = 8
1629:             .Caption   = "Bloqueia Alt. Data :"
1630:             .Top       = 25
1631:             .Left      = 79
1632:             .Width     = 95
1633:             .Height    = 15
1634:             .ForeColor = RGB(90, 90, 90)
1635:             .BackStyle = 0
1636:             .AutoSize  = .F.

*-- Linhas 1644 a 1680:
1644:             .BackStyle   = 0
1645:             .BorderStyle = 0
1646:             .Height      = 20
1647:             .Left        = 173
1648:             .Top         = 21
1649:             .Width       = 86
1650:             .Value       = 2
1651:             .Visible     = .T.
1652:             .Buttons(1).Caption   = "Sim"
1653:             .Buttons(1).FontSize  = 8
1654:             .Buttons(1).BackStyle = 0
1655:             .Buttons(1).Left      = 5
1656:             .Buttons(1).Top       = 3
1657:             .Buttons(1).Width     = 34
1658:             .Buttons(1).AutoSize  = .T.
1659:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1660:             .Buttons(2).FontSize  = 8
1661:             .Buttons(2).BackStyle = 0
1662:             .Buttons(2).Left      = 45
1663:             .Buttons(2).Top       = 3
1664:             .Buttons(2).Width     = 37
1665:             .Buttons(2).AutoSize  = .T.
1666:         ENDWITH
1667: 
1668:         *-- Inibir Botao Ocorrencia (inibocors)
1669:         par_oPg.AddObject("lbl_4c_InibOcors", "Label")
1670:         WITH par_oPg.lbl_4c_InibOcors
1671:             .FontName  = "Tahoma"
1672:             .FontSize  = 8
1673:             .Caption   = "Inibir Bot" + CHR(227) + "o Ocorr" + CHR(234) + "ncia :"
1674:             .Top       = 44
1675:             .Left      = 55
1676:             .Width     = 119
1677:             .Height    = 15
1678:             .ForeColor = RGB(90, 90, 90)
1679:             .BackStyle = 0
1680:             .AutoSize  = .F.

*-- Linhas 1688 a 1724:
1688:             .BackStyle   = 0
1689:             .BorderStyle = 0
1690:             .Height      = 20
1691:             .Left        = 173
1692:             .Top         = 40
1693:             .Width       = 86
1694:             .Value       = 2
1695:             .Visible     = .T.
1696:             .Buttons(1).Caption   = "Sim"
1697:             .Buttons(1).FontSize  = 8
1698:             .Buttons(1).BackStyle = 0
1699:             .Buttons(1).Left      = 5
1700:             .Buttons(1).Top       = 3
1701:             .Buttons(1).Width     = 34
1702:             .Buttons(1).AutoSize  = .T.
1703:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1704:             .Buttons(2).FontSize  = 8
1705:             .Buttons(2).BackStyle = 0
1706:             .Buttons(2).Left      = 45
1707:             .Buttons(2).Top       = 3
1708:             .Buttons(2).Width     = 37
1709:             .Buttons(2).AutoSize  = .T.
1710:         ENDWITH
1711: 
1712:         *-- Inibir Botao Fechamento (inibfecs)
1713:         par_oPg.AddObject("lbl_4c_InibFecs", "Label")
1714:         WITH par_oPg.lbl_4c_InibFecs
1715:             .FontName  = "Tahoma"
1716:             .FontSize  = 8
1717:             .Caption   = "Inibir Bot" + CHR(227) + "o Fechamento :"
1718:             .Top       = 63
1719:             .Left      = 48
1720:             .Width     = 126
1721:             .Height    = 15
1722:             .ForeColor = RGB(90, 90, 90)
1723:             .BackStyle = 0
1724:             .AutoSize  = .F.

*-- Linhas 1732 a 1768:
1732:             .BackStyle   = 0
1733:             .BorderStyle = 0
1734:             .Height      = 20
1735:             .Left        = 173
1736:             .Top         = 59
1737:             .Width       = 86
1738:             .Value       = 2
1739:             .Visible     = .T.
1740:             .Buttons(1).Caption   = "Sim"
1741:             .Buttons(1).FontSize  = 8
1742:             .Buttons(1).BackStyle = 0
1743:             .Buttons(1).Left      = 5
1744:             .Buttons(1).Top       = 3
1745:             .Buttons(1).Width     = 34
1746:             .Buttons(1).AutoSize  = .T.
1747:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1748:             .Buttons(2).FontSize  = 8
1749:             .Buttons(2).BackStyle = 0
1750:             .Buttons(2).Left      = 45
1751:             .Buttons(2).Top       = 3
1752:             .Buttons(2).Width     = 37
1753:             .Buttons(2).AutoSize  = .T.
1754:         ENDWITH
1755: 
1756:         *-- Permitir Alteracao (alterar)
1757:         par_oPg.AddObject("lbl_4c_Alterar", "Label")
1758:         WITH par_oPg.lbl_4c_Alterar
1759:             .FontName  = "Tahoma"
1760:             .FontSize  = 8
1761:             .Caption   = "Permitir Altera" + CHR(231) + CHR(227) + "o :"
1762:             .Top       = 82
1763:             .Left      = 80
1764:             .Width     = 94
1765:             .Height    = 15
1766:             .ForeColor = RGB(90, 90, 90)
1767:             .BackStyle = 0
1768:             .AutoSize  = .F.

*-- Linhas 1776 a 1812:
1776:             .BackStyle   = 0
1777:             .BorderStyle = 0
1778:             .Height      = 20
1779:             .Left        = 173
1780:             .Top         = 78
1781:             .Width       = 86
1782:             .Value       = 2
1783:             .Visible     = .T.
1784:             .Buttons(1).Caption   = "Sim"
1785:             .Buttons(1).FontSize  = 8
1786:             .Buttons(1).BackStyle = 0
1787:             .Buttons(1).Left      = 5
1788:             .Buttons(1).Top       = 3
1789:             .Buttons(1).Width     = 34
1790:             .Buttons(1).AutoSize  = .T.
1791:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1792:             .Buttons(2).FontSize  = 8
1793:             .Buttons(2).BackStyle = 0
1794:             .Buttons(2).Left      = 45
1795:             .Buttons(2).Top       = 3
1796:             .Buttons(2).Width     = 37
1797:             .Buttons(2).AutoSize  = .T.
1798:         ENDWITH
1799: 
1800:         *-- Utiliza Periodo Configuracao (periodos)
1801:         par_oPg.AddObject("lbl_4c_Periodos", "Label")
1802:         WITH par_oPg.lbl_4c_Periodos
1803:             .FontName  = "Tahoma"
1804:             .FontSize  = 8
1805:             .Caption   = "Utiliza Per" + CHR(237) + "odo Configura" + CHR(231) + CHR(227) + "o :"
1806:             .Top       = 101
1807:             .Left      = 31
1808:             .Width     = 143
1809:             .Height    = 15
1810:             .ForeColor = RGB(90, 90, 90)
1811:             .BackStyle = 0
1812:             .AutoSize  = .F.

*-- Linhas 1820 a 1856:
1820:             .BackStyle   = 0
1821:             .BorderStyle = 0
1822:             .Height      = 20
1823:             .Left        = 173
1824:             .Top         = 97
1825:             .Width       = 86
1826:             .Value       = 2
1827:             .Visible     = .T.
1828:             .Buttons(1).Caption   = "Sim"
1829:             .Buttons(1).FontSize  = 8
1830:             .Buttons(1).BackStyle = 0
1831:             .Buttons(1).Left      = 5
1832:             .Buttons(1).Top       = 3
1833:             .Buttons(1).Width     = 34
1834:             .Buttons(1).AutoSize  = .T.
1835:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1836:             .Buttons(2).FontSize  = 8
1837:             .Buttons(2).BackStyle = 0
1838:             .Buttons(2).Left      = 45
1839:             .Buttons(2).Top       = 3
1840:             .Buttons(2).Width     = 37
1841:             .Buttons(2).AutoSize  = .T.
1842:         ENDWITH
1843: 
1844:         *-- Utiliza Periodo Entrega (entregas)
1845:         par_oPg.AddObject("lbl_4c_Entregas", "Label")
1846:         WITH par_oPg.lbl_4c_Entregas
1847:             .FontName  = "Tahoma"
1848:             .FontSize  = 8
1849:             .Caption   = "Utiliza Per" + CHR(237) + "odo Entrega :"
1850:             .Top       = 121
1851:             .Left      = 57
1852:             .Width     = 117
1853:             .Height    = 15
1854:             .ForeColor = RGB(90, 90, 90)
1855:             .BackStyle = 0
1856:             .AutoSize  = .F.

*-- Linhas 1864 a 1900:
1864:             .BackStyle   = 0
1865:             .BorderStyle = 0
1866:             .Height      = 20
1867:             .Left        = 173
1868:             .Top         = 117
1869:             .Width       = 86
1870:             .Value       = 2
1871:             .Visible     = .T.
1872:             .Buttons(1).Caption   = "Sim"
1873:             .Buttons(1).FontSize  = 8
1874:             .Buttons(1).BackStyle = 0
1875:             .Buttons(1).Left      = 5
1876:             .Buttons(1).Top       = 3
1877:             .Buttons(1).Width     = 34
1878:             .Buttons(1).AutoSize  = .T.
1879:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1880:             .Buttons(2).FontSize  = 8
1881:             .Buttons(2).BackStyle = 0
1882:             .Buttons(2).Left      = 45
1883:             .Buttons(2).Top       = 3
1884:             .Buttons(2).Width     = 37
1885:             .Buttons(2).AutoSize  = .T.
1886:         ENDWITH
1887: 
1888:         *-- Utiliza Periodo Operacao (operacoes)
1889:         par_oPg.AddObject("lbl_4c_Operacoes", "Label")
1890:         WITH par_oPg.lbl_4c_Operacoes
1891:             .FontName  = "Tahoma"
1892:             .FontSize  = 8
1893:             .Caption   = "Utiliza Per" + CHR(237) + "odo Opera" + CHR(231) + CHR(227) + "o :"
1894:             .Top       = 140
1895:             .Left      = 48
1896:             .Width     = 126
1897:             .Height    = 15
1898:             .ForeColor = RGB(90, 90, 90)
1899:             .BackStyle = 0
1900:             .AutoSize  = .F.

*-- Linhas 1908 a 1944:
1908:             .BackStyle   = 0
1909:             .BorderStyle = 0
1910:             .Height      = 20
1911:             .Left        = 173
1912:             .Top         = 136
1913:             .Width       = 86
1914:             .Value       = 2
1915:             .Visible     = .T.
1916:             .Buttons(1).Caption   = "Sim"
1917:             .Buttons(1).FontSize  = 8
1918:             .Buttons(1).BackStyle = 0
1919:             .Buttons(1).Left      = 5
1920:             .Buttons(1).Top       = 3
1921:             .Buttons(1).Width     = 34
1922:             .Buttons(1).AutoSize  = .T.
1923:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1924:             .Buttons(2).FontSize  = 8
1925:             .Buttons(2).BackStyle = 0
1926:             .Buttons(2).Left      = 45
1927:             .Buttons(2).Top       = 3
1928:             .Buttons(2).Width     = 37
1929:             .Buttons(2).AutoSize  = .T.
1930:         ENDWITH
1931: 
1932:         *-- Senha por Responsavel (vends)
1933:         par_oPg.AddObject("lbl_4c_Vends", "Label")
1934:         WITH par_oPg.lbl_4c_Vends
1935:             .FontName  = "Tahoma"
1936:             .FontSize  = 8
1937:             .Caption   = "Senha por Respons" + CHR(225) + "vel :"
1938:             .Top       = 159
1939:             .Left      = 52
1940:             .Width     = 122
1941:             .Height    = 15
1942:             .ForeColor = RGB(90, 90, 90)
1943:             .BackStyle = 0
1944:             .AutoSize  = .F.

*-- Linhas 1952 a 1988:
1952:             .BackStyle   = 0
1953:             .BorderStyle = 0
1954:             .Height      = 20
1955:             .Left        = 173
1956:             .Top         = 155
1957:             .Width       = 86
1958:             .Value       = 2
1959:             .Visible     = .T.
1960:             .Buttons(1).Caption   = "Sim"
1961:             .Buttons(1).FontSize  = 8
1962:             .Buttons(1).BackStyle = 0
1963:             .Buttons(1).Left      = 5
1964:             .Buttons(1).Top       = 3
1965:             .Buttons(1).Width     = 34
1966:             .Buttons(1).AutoSize  = .T.
1967:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1968:             .Buttons(2).FontSize  = 8
1969:             .Buttons(2).BackStyle = 0
1970:             .Buttons(2).Left      = 45
1971:             .Buttons(2).Top       = 3
1972:             .Buttons(2).Width     = 37
1973:             .Buttons(2).AutoSize  = .T.
1974:         ENDWITH
1975: 
1976:         *-- Checar SAC (sacs)
1977:         par_oPg.AddObject("lbl_4c_Sacs", "Label")
1978:         WITH par_oPg.lbl_4c_Sacs
1979:             .FontName  = "Tahoma"
1980:             .FontSize  = 8
1981:             .Caption   = "Checar SAC :"
1982:             .Top       = 178
1983:             .Left      = 108
1984:             .Width     = 66
1985:             .Height    = 15
1986:             .ForeColor = RGB(90, 90, 90)
1987:             .BackStyle = 0
1988:             .AutoSize  = .F.

*-- Linhas 1996 a 2032:
1996:             .BackStyle   = 0
1997:             .BorderStyle = 0
1998:             .Height      = 20
1999:             .Left        = 173
2000:             .Top         = 174
2001:             .Width       = 86
2002:             .Value       = 2
2003:             .Visible     = .T.
2004:             .Buttons(1).Caption   = "Sim"
2005:             .Buttons(1).FontSize  = 8
2006:             .Buttons(1).BackStyle = 0
2007:             .Buttons(1).Left      = 5
2008:             .Buttons(1).Top       = 3
2009:             .Buttons(1).Width     = 34
2010:             .Buttons(1).AutoSize  = .T.
2011:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2012:             .Buttons(2).FontSize  = 8
2013:             .Buttons(2).BackStyle = 0
2014:             .Buttons(2).Left      = 45
2015:             .Buttons(2).Top       = 3
2016:             .Buttons(2).Width     = 37
2017:             .Buttons(2).AutoSize  = .T.
2018:         ENDWITH
2019: 
2020:         *-- Utiliza Empresa (empresas)
2021:         par_oPg.AddObject("lbl_4c_Empresas", "Label")
2022:         WITH par_oPg.lbl_4c_Empresas
2023:             .FontName  = "Tahoma"
2024:             .FontSize  = 8
2025:             .Caption   = "Utiliza Empresa :"
2026:             .Top       = 198
2027:             .Left      = 93
2028:             .Width     = 81
2029:             .Height    = 15
2030:             .ForeColor = RGB(90, 90, 90)
2031:             .BackStyle = 0
2032:             .AutoSize  = .F.

*-- Linhas 2040 a 2076:
2040:             .BackStyle   = 0
2041:             .BorderStyle = 0
2042:             .Height      = 20
2043:             .Left        = 173
2044:             .Top         = 193
2045:             .Width       = 86
2046:             .Value       = 2
2047:             .Visible     = .T.
2048:             .Buttons(1).Caption   = "Sim"
2049:             .Buttons(1).FontSize  = 8
2050:             .Buttons(1).BackStyle = 0
2051:             .Buttons(1).Left      = 5
2052:             .Buttons(1).Top       = 3
2053:             .Buttons(1).Width     = 34
2054:             .Buttons(1).AutoSize  = .T.
2055:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2056:             .Buttons(2).FontSize  = 8
2057:             .Buttons(2).BackStyle = 0
2058:             .Buttons(2).Left      = 45
2059:             .Buttons(2).Top       = 3
2060:             .Buttons(2).Width     = 37
2061:             .Buttons(2).AutoSize  = .T.
2062:         ENDWITH
2063: 
2064:         *-- Controlar Acesso por Usuario (ctacusus)
2065:         par_oPg.AddObject("lbl_4c_Ctacusus", "Label")
2066:         WITH par_oPg.lbl_4c_Ctacusus
2067:             .FontName  = "Tahoma"
2068:             .FontSize  = 8
2069:             .Caption   = "Controlar Acesso por Usu" + CHR(225) + "rio :"
2070:             .Top       = 217
2071:             .Left      = 25
2072:             .Width     = 149
2073:             .Height    = 15
2074:             .ForeColor = RGB(90, 90, 90)
2075:             .BackStyle = 0
2076:             .AutoSize  = .F.

*-- Linhas 2084 a 2119:
2084:             .BackStyle   = 0
2085:             .BorderStyle = 0
2086:             .Height      = 20
2087:             .Left        = 173
2088:             .Top         = 214
2089:             .Width       = 86
2090:             .Value       = 2
2091:             .Visible     = .T.
2092:             .Buttons(1).Caption   = "Sim"
2093:             .Buttons(1).FontSize  = 8
2094:             .Buttons(1).BackStyle = 0
2095:             .Buttons(1).Left      = 4
2096:             .Buttons(1).Top       = 2
2097:             .Buttons(1).AutoSize  = .T.
2098:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2099:             .Buttons(2).FontSize  = 8
2100:             .Buttons(2).BackStyle = 0
2101:             .Buttons(2).Left      = 43
2102:             .Buttons(2).Top       = 2
2103:             .Buttons(2).AutoSize  = .T.
2104:         ENDWITH
2105: 
2106:         *-- SECAO "Padrao de Configuracao" - header Bold
2107:         par_oPg.AddObject("lbl_4c_PadrConf", "Label")
2108:         WITH par_oPg.lbl_4c_PadrConf
2109:             .FontName  = "Tahoma"
2110:             .FontSize  = 8
2111:             .FontBold  = .T.
2112:             .Caption   = " Padr" + CHR(227) + "o de Configura" + CHR(231) + CHR(227) + "o "
2113:             .Top       = 247
2114:             .Left      = 7
2115:             .Width     = 142
2116:             .Height    = 15
2117:             .ForeColor = RGB(90, 90, 90)
2118:             .BackStyle = 0
2119:             .AutoSize  = .F.

*-- Linhas 2128 a 2409:
2128:             .BackStyle   = 0
2129:             .BorderStyle = 0
2130:             .Height      = 22
2131:             .Left        = 3
2132:             .Top         = 261
2133:             .Width       = 216
2134:             .Value       = 1
2135:             .Visible     = .T.
2136:             .Buttons(1).Caption   = "Todas"
2137:             .Buttons(1).FontSize  = 8
2138:             .Buttons(1).BackStyle = 0
2139:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2140:             .Buttons(1).Left      = 5
2141:             .Buttons(1).Top       = 3
2142:             .Buttons(1).Width     = 47
2143:             .Buttons(1).AutoSize  = .T.
2144:             .Buttons(2).Caption   = "Pendentes"
2145:             .Buttons(2).FontSize  = 8
2146:             .Buttons(2).BackStyle = 0
2147:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2148:             .Buttons(2).Left      = 57
2149:             .Buttons(2).Top       = 3
2150:             .Buttons(2).Width     = 69
2151:             .Buttons(2).AutoSize  = .T.
2152:             .Buttons(3).Caption   = "Baixadas"
2153:             .Buttons(3).FontSize  = 8
2154:             .Buttons(3).BackStyle = 0
2155:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2156:             .Buttons(3).Left      = 140
2157:             .Buttons(3).Top       = 3
2158:             .Buttons(3).Width     = 61
2159:             .Buttons(3).AutoSize  = .T.
2160:         ENDWITH
2161: 
2162:         par_oPg.AddObject("opt_4c_Opagends", "OptionGroup")
2163:         WITH par_oPg.opt_4c_Opagends
2164:             .ButtonCount = 3
2165:             .AutoSize    = .F.
2166:             .BackStyle   = 0
2167:             .BorderStyle = 0
2168:             .Height      = 22
2169:             .Left        = 3
2170:             .Top         = 278
2171:             .Width       = 216
2172:             .Value       = 1
2173:             .Visible     = .T.
2174:             .Buttons(1).Caption   = "Todas"
2175:             .Buttons(1).FontSize  = 8
2176:             .Buttons(1).BackStyle = 0
2177:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2178:             .Buttons(1).Left      = 5
2179:             .Buttons(1).Top       = 3
2180:             .Buttons(1).Width     = 47
2181:             .Buttons(1).AutoSize  = .T.
2182:             .Buttons(2).Caption   = "N" + CHR(227) + "o Agendadas"
2183:             .Buttons(2).FontSize  = 8
2184:             .Buttons(2).BackStyle = 0
2185:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2186:             .Buttons(2).Left      = 57
2187:             .Buttons(2).Top       = 3
2188:             .Buttons(2).Width     = 82
2189:             .Buttons(2).AutoSize  = .T.
2190:             .Buttons(3).Caption   = "Agendadas"
2191:             .Buttons(3).FontSize  = 8
2192:             .Buttons(3).BackStyle = 0
2193:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2194:             .Buttons(3).Left      = 140
2195:             .Buttons(3).Top       = 3
2196:             .Buttons(3).Width     = 72
2197:             .Buttons(3).AutoSize  = .T.
2198:         ENDWITH
2199: 
2200:         par_oPg.AddObject("opt_4c_Oppagas", "OptionGroup")
2201:         WITH par_oPg.opt_4c_Oppagas
2202:             .ButtonCount = 3
2203:             .AutoSize    = .F.
2204:             .BackStyle   = 0
2205:             .BorderStyle = 0
2206:             .Height      = 22
2207:             .Left        = 3
2208:             .Top         = 296
2209:             .Width       = 216
2210:             .Value       = 1
2211:             .Visible     = .T.
2212:             .Buttons(1).Caption   = "Todas"
2213:             .Buttons(1).FontSize  = 8
2214:             .Buttons(1).BackStyle = 0
2215:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2216:             .Buttons(1).Left      = 5
2217:             .Buttons(1).Top       = 3
2218:             .Buttons(1).Width     = 47
2219:             .Buttons(1).AutoSize  = .T.
2220:             .Buttons(2).Caption   = "N" + CHR(227) + "o Pagas"
2221:             .Buttons(2).FontSize  = 8
2222:             .Buttons(2).BackStyle = 0
2223:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2224:             .Buttons(2).Left      = 57
2225:             .Buttons(2).Top       = 3
2226:             .Buttons(2).Width     = 57
2227:             .Buttons(2).AutoSize  = .T.
2228:             .Buttons(3).Caption   = "Pagas"
2229:             .Buttons(3).FontSize  = 8
2230:             .Buttons(3).BackStyle = 0
2231:             .Buttons(3).ForeColor = RGB(90, 90, 90)
2232:             .Buttons(3).Left      = 140
2233:             .Buttons(3).Top       = 3
2234:             .Buttons(3).Width     = 47
2235:             .Buttons(3).AutoSize  = .T.
2236:         ENDWITH
2237: 
2238:         *-- CheckBoxes para travar ordenacao (Fixa*)
2239:         par_oPg.AddObject("chk_4c_Fixaps", "CheckBox")
2240:         WITH par_oPg.chk_4c_Fixaps
2241:             .Top           = 261
2242:             .Left          = 221
2243:             .Height        = 20
2244:             .Width         = 20
2245:             .Caption       = ""
2246:             .Alignment     = 0
2247:             .SpecialEffect = 0
2248:             .Style         = 1
2249:             .Visible       = .T.
2250:         ENDWITH
2251: 
2252:         par_oPg.AddObject("chk_4c_Fixaas", "CheckBox")
2253:         WITH par_oPg.chk_4c_Fixaas
2254:             .Top           = 279
2255:             .Left          = 221
2256:             .Height        = 20
2257:             .Width         = 20
2258:             .Caption       = ""
2259:             .Alignment     = 0
2260:             .SpecialEffect = 0
2261:             .Style         = 1
2262:             .Visible       = .T.
2263:         ENDWITH
2264: 
2265:         par_oPg.AddObject("chk_4c_Fixags", "CheckBox")
2266:         WITH par_oPg.chk_4c_Fixags
2267:             .Top           = 297
2268:             .Left          = 221
2269:             .Height        = 20
2270:             .Width         = 20
2271:             .Caption       = ""
2272:             .Alignment     = 0
2273:             .SpecialEffect = 0
2274:             .Style         = 1
2275:             .Visible       = .T.
2276:         ENDWITH
2277: 
2278:         par_oPg.AddObject("chk_4c_Fixals", "CheckBox")
2279:         WITH par_oPg.chk_4c_Fixals
2280:             .Top           = 317
2281:             .Left          = 221
2282:             .Height        = 20
2283:             .Width         = 20
2284:             .Caption       = ""
2285:             .Alignment     = 0
2286:             .SpecialEffect = 0
2287:             .Style         = 1
2288:             .Visible       = .T.
2289:         ENDWITH
2290: 
2291:         par_oPg.AddObject("chk_4c_Fixass", "CheckBox")
2292:         WITH par_oPg.chk_4c_Fixass
2293:             .Top           = 339
2294:             .Left          = 221
2295:             .Height        = 20
2296:             .Width         = 20
2297:             .Caption       = ""
2298:             .Alignment     = 0
2299:             .SpecialEffect = 0
2300:             .Style         = 1
2301:             .Visible       = .T.
2302:         ENDWITH
2303: 
2304:         *-- Localizacao Padrao (locals - lookup SigPrLcl)
2305:         par_oPg.AddObject("lbl_4c_Local", "Label")
2306:         WITH par_oPg.lbl_4c_Local
2307:             .FontSize  = 8
2308:             .Caption   = "Localiza" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :"
2309:             .Top       = 320
2310:             .Left      = 16
2311:             .Width     = 100
2312:             .Height    = 15
2313:             .BackStyle = 0
2314:             .AutoSize  = .F.
2315:             .Visible   = .T.
2316:         ENDWITH
2317: 
2318:         par_oPg.AddObject("txt_4c_Locals", "TextBox")
2319:         WITH par_oPg.txt_4c_Locals
2320:             .Top       = 317
2321:             .Left      = 139
2322:             .Width     = 80
2323:             .Height    = 22
2324:             .MaxLength = 10
2325:             .FontName  = "Tahoma"
2326:             .FontSize  = 8
2327:             .Visible   = .T.
2328:         ENDWITH
2329: 
2330:         *-- Segmento Padrao (codsegs - lookup SigCdSct)
2331:         par_oPg.AddObject("lbl_4c_Seg", "Label")
2332:         WITH par_oPg.lbl_4c_Seg
2333:             .FontSize  = 8
2334:             .Caption   = "Segmento Padr" + CHR(227) + "o :"
2335:             .Top       = 342
2336:             .Left      = 23
2337:             .Width     = 94
2338:             .Height    = 15
2339:             .BackStyle = 0
2340:             .AutoSize  = .F.
2341:             .Visible   = .T.
2342:         ENDWITH
2343: 
2344:         par_oPg.AddObject("txt_4c_Codsegs", "TextBox")
2345:         WITH par_oPg.txt_4c_Codsegs
2346:             .Top       = 339
2347:             .Left      = 139
2348:             .Width     = 80
2349:             .Height    = 22
2350:             .MaxLength = 10
2351:             .FontName  = "Tahoma"
2352:             .FontSize  = 8
2353:             .Visible   = .T.
2354:         ENDWITH
2355: 
2356:         *-- SECAO "Ordem da Grade" (header Bold)
2357:         par_oPg.AddObject("lbl_4c_OrdGrade", "Label")
2358:         WITH par_oPg.lbl_4c_OrdGrade
2359:             .FontName  = "Tahoma"
2360:             .FontSize  = 8
2361:             .FontBold  = .T.
2362:             .Caption   = " Ordem da Grade "
2363:             .Top       = 246
2364:             .Left      = 274
2365:             .Width     = 100
2366:             .Height    = 15
2367:             .ForeColor = RGB(90, 90, 90)
2368:             .BackStyle = 0
2369:             .AutoSize  = .F.
2370:             .Visible   = .T.
2371:         ENDWITH
2372: 
2373:         par_oPg.AddObject("lbl_4c_Todas", "Label")
2374:         WITH par_oPg.lbl_4c_Todas
2375:             .FontSize  = 8
2376:             .Caption   = "Todas :"
2377:             .Top       = 261
2378:             .Left      = 315
2379:             .Width     = 38
2380:             .Height    = 15
2381:             .BackStyle = 0
2382:             .AutoSize  = .F.
2383:             .Visible   = .T.
2384:         ENDWITH
2385: 
2386:         par_oPg.AddObject("lbl_4c_NAgen", "Label")
2387:         WITH par_oPg.lbl_4c_NAgen
2388:             .FontSize  = 8
2389:             .Caption   = "N" + CHR(227) + "o Agendadas :"
2390:             .Top       = 282
2391:             .Left      = 279
2392:             .Width     = 73
2393:             .Height    = 15
2394:             .BackStyle = 0
2395:             .AutoSize  = .F.
2396:             .Visible   = .T.
2397:         ENDWITH
2398: 
2399:         par_oPg.AddObject("lbl_4c_Agen", "Label")
2400:         WITH par_oPg.lbl_4c_Agen
2401:             .FontSize  = 8
2402:             .Caption   = "Agendadas :"
2403:             .Top       = 303
2404:             .Left      = 289
2405:             .Width     = 63
2406:             .Height    = 15
2407:             .BackStyle = 0
2408:             .AutoSize  = .F.
2409:             .Visible   = .T.

*-- Linhas 2416 a 2469:
2416:             .RowSourceType = 1
2417:             .RowSource     = "Opera" + CHR(231) + CHR(227) + "o,Data Opera" + CHR(231) + CHR(227) + "o,Documento,Data Entrega,Data Agenda/Auditoria,Conta"
2418:             .Height        = 21
2419:             .Left          = 353
2420:             .Style         = 2
2421:             .ToolTipText   = "Ordem de Apresenta" + CHR(231) + CHR(227) + "o Quando Selecionado o Flag Todas"
2422:             .Top           = 258
2423:             .Width         = 182
2424:             .Visible       = .T.
2425:         ENDWITH
2426: 
2427:         par_oPg.AddObject("cmb_4c_Ordemns", "ComboBox")
2428:         WITH par_oPg.cmb_4c_Ordemns
2429:             .FontName      = "Courier New"
2430:             .RowSourceType = 1
2431:             .RowSource     = "Opera" + CHR(231) + CHR(227) + "o,Data Opera" + CHR(231) + CHR(227) + "o,Documento,Data Entrega,Data Agenda/Auditoria,Conta"
2432:             .Height        = 21
2433:             .Left          = 353
2434:             .Style         = 2
2435:             .ToolTipText   = "Ordem de Apresenta" + CHR(231) + CHR(227) + "o Quando Selecionado o Flag N" + CHR(227) + "o Agendadas"
2436:             .Top           = 279
2437:             .Width         = 182
2438:             .Visible       = .T.
2439:         ENDWITH
2440: 
2441:         par_oPg.AddObject("cmb_4c_Ordemas", "ComboBox")
2442:         WITH par_oPg.cmb_4c_Ordemas
2443:             .FontName      = "Courier New"
2444:             .RowSourceType = 1
2445:             .RowSource     = "Opera" + CHR(231) + CHR(227) + "o,Data Opera" + CHR(231) + CHR(227) + "o,Documento,Data Entrega,Data Agenda/Auditoria,Conta"
2446:             .Height        = 21
2447:             .Left          = 353
2448:             .Style         = 2
2449:             .ToolTipText   = "Ordem de Apresenta" + CHR(231) + CHR(227) + "o Quando Selecionado o Flag Agendadas"
2450:             .Top           = 300
2451:             .Width         = 182
2452:             .Visible       = .T.
2453:         ENDWITH
2454: 
2455:         *-- COLUNA DIREITA: OptionGroups Sim/Nao (Left=431, Width=86)
2456: 
2457:         *-- Analisar C.Pagto Fx.Cx (anacps)
2458:         par_oPg.AddObject("lbl_4c_Anacps", "Label")
2459:         WITH par_oPg.lbl_4c_Anacps
2460:             .FontName  = "Tahoma"
2461:             .FontSize  = 8
2462:             .Caption   = "Analisar C.Pagto Fx. Cx :"
2463:             .Top       = 7
2464:             .Left      = 310
2465:             .Width     = 124
2466:             .Height    = 15
2467:             .ForeColor = RGB(90, 90, 90)
2468:             .BackStyle = 0
2469:             .AutoSize  = .F.

*-- Linhas 2477 a 2513:
2477:             .BackStyle   = 0
2478:             .BorderStyle = 0
2479:             .Height      = 20
2480:             .Left        = 431
2481:             .Top         = 3
2482:             .Width       = 86
2483:             .Value       = 2
2484:             .Visible     = .T.
2485:             .Buttons(1).Caption   = "Sim"
2486:             .Buttons(1).FontSize  = 8
2487:             .Buttons(1).BackStyle = 0
2488:             .Buttons(1).Left      = 5
2489:             .Buttons(1).Top       = 3
2490:             .Buttons(1).Width     = 34
2491:             .Buttons(1).AutoSize  = .T.
2492:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2493:             .Buttons(2).FontSize  = 8
2494:             .Buttons(2).BackStyle = 0
2495:             .Buttons(2).Left      = 45
2496:             .Buttons(2).Top       = 3
2497:             .Buttons(2).Width     = 37
2498:             .Buttons(2).AutoSize  = .T.
2499:         ENDWITH
2500: 
2501:         *-- Gera Controle de Volumes / ChkReserva (chkreserva)
2502:         par_oPg.AddObject("lbl_4c_Chkreserva", "Label")
2503:         WITH par_oPg.lbl_4c_Chkreserva
2504:             .FontName  = "Tahoma"
2505:             .FontSize  = 8
2506:             .Caption   = "Gera Controle de Volumes :"
2507:             .Top       = 26
2508:             .Left      = 301
2509:             .Width     = 133
2510:             .Height    = 15
2511:             .ForeColor = RGB(90, 90, 90)
2512:             .BackStyle = 0
2513:             .AutoSize  = .F.

*-- Linhas 2521 a 2557:
2521:             .BackStyle   = 0
2522:             .BorderStyle = 0
2523:             .Height      = 20
2524:             .Left        = 431
2525:             .Top         = 22
2526:             .Width       = 86
2527:             .Value       = 2
2528:             .Visible     = .T.
2529:             .Buttons(1).Caption   = "Sim"
2530:             .Buttons(1).FontSize  = 8
2531:             .Buttons(1).BackStyle = 0
2532:             .Buttons(1).Left      = 5
2533:             .Buttons(1).Top       = 3
2534:             .Buttons(1).Width     = 34
2535:             .Buttons(1).AutoSize  = .T.
2536:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2537:             .Buttons(2).FontSize  = 8
2538:             .Buttons(2).BackStyle = 0
2539:             .Buttons(2).Left      = 45
2540:             .Buttons(2).Top       = 3
2541:             .Buttons(2).Width     = 37
2542:             .Buttons(2).AutoSize  = .T.
2543:         ENDWITH
2544: 
2545:         *-- Utiliza Responsavel (resps)
2546:         par_oPg.AddObject("lbl_4c_Resps", "Label")
2547:         WITH par_oPg.lbl_4c_Resps
2548:             .FontName  = "Tahoma"
2549:             .FontSize  = 8
2550:             .Caption   = "Utiliza Respons" + CHR(225) + "vel :"
2551:             .Top       = 45
2552:             .Left      = 333
2553:             .Width     = 101
2554:             .Height    = 15
2555:             .ForeColor = RGB(90, 90, 90)
2556:             .BackStyle = 0
2557:             .AutoSize  = .F.

*-- Linhas 2565 a 2601:
2565:             .BackStyle   = 0
2566:             .BorderStyle = 0
2567:             .Height      = 20
2568:             .Left        = 431
2569:             .Top         = 41
2570:             .Width       = 86
2571:             .Value       = 2
2572:             .Visible     = .T.
2573:             .Buttons(1).Caption   = "Sim"
2574:             .Buttons(1).FontSize  = 8
2575:             .Buttons(1).BackStyle = 0
2576:             .Buttons(1).Left      = 5
2577:             .Buttons(1).Top       = 3
2578:             .Buttons(1).Width     = 34
2579:             .Buttons(1).AutoSize  = .T.
2580:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2581:             .Buttons(2).FontSize  = 8
2582:             .Buttons(2).BackStyle = 0
2583:             .Buttons(2).Left      = 45
2584:             .Buttons(2).Top       = 3
2585:             .Buttons(2).Width     = 37
2586:             .Buttons(2).AutoSize  = .T.
2587:         ENDWITH
2588: 
2589:         *-- Estoque Disponivel (estdisps)
2590:         par_oPg.AddObject("lbl_4c_Estdisps", "Label")
2591:         WITH par_oPg.lbl_4c_Estdisps
2592:             .FontName  = "Tahoma"
2593:             .FontSize  = 8
2594:             .Caption   = "Estoque Dispon" + CHR(237) + "vel :"
2595:             .Top       = 64
2596:             .Left      = 335
2597:             .Width     = 99
2598:             .Height    = 15
2599:             .ForeColor = RGB(90, 90, 90)
2600:             .BackStyle = 0
2601:             .AutoSize  = .F.

*-- Linhas 2609 a 2645:
2609:             .BackStyle   = 0
2610:             .BorderStyle = 0
2611:             .Height      = 20
2612:             .Left        = 431
2613:             .Top         = 60
2614:             .Width       = 86
2615:             .Value       = 2
2616:             .Visible     = .T.
2617:             .Buttons(1).Caption   = "Sim"
2618:             .Buttons(1).FontSize  = 8
2619:             .Buttons(1).BackStyle = 0
2620:             .Buttons(1).Left      = 5
2621:             .Buttons(1).Top       = 3
2622:             .Buttons(1).Width     = 34
2623:             .Buttons(1).AutoSize  = .T.
2624:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2625:             .Buttons(2).FontSize  = 8
2626:             .Buttons(2).BackStyle = 0
2627:             .Buttons(2).Left      = 45
2628:             .Buttons(2).Top       = 3
2629:             .Buttons(2).Width     = 37
2630:             .Buttons(2).AutoSize  = .T.
2631:         ENDWITH
2632: 
2633:         *-- Quantidade de Volumes (volumes)
2634:         par_oPg.AddObject("lbl_4c_Volumes", "Label")
2635:         WITH par_oPg.lbl_4c_Volumes
2636:             .FontName  = "Tahoma"
2637:             .FontSize  = 8
2638:             .Caption   = "Quantidade de Volumes :"
2639:             .Top       = 83
2640:             .Left      = 312
2641:             .Width     = 122
2642:             .Height    = 15
2643:             .ForeColor = RGB(90, 90, 90)
2644:             .BackStyle = 0
2645:             .AutoSize  = .F.

*-- Linhas 2653 a 2689:
2653:             .BackStyle   = 0
2654:             .BorderStyle = 0
2655:             .Height      = 20
2656:             .Left        = 431
2657:             .Top         = 79
2658:             .Width       = 86
2659:             .Value       = 2
2660:             .Visible     = .T.
2661:             .Buttons(1).Caption   = "Sim"
2662:             .Buttons(1).FontSize  = 8
2663:             .Buttons(1).BackStyle = 0
2664:             .Buttons(1).Left      = 5
2665:             .Buttons(1).Top       = 3
2666:             .Buttons(1).Width     = 34
2667:             .Buttons(1).AutoSize  = .T.
2668:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2669:             .Buttons(2).FontSize  = 8
2670:             .Buttons(2).BackStyle = 0
2671:             .Buttons(2).Left      = 45
2672:             .Buttons(2).Top       = 3
2673:             .Buttons(2).Width     = 37
2674:             .Buttons(2).AutoSize  = .T.
2675:         ENDWITH
2676: 
2677:         *-- Checa Acesso Muda Empresa (acmemps)
2678:         par_oPg.AddObject("lbl_4c_Acmemps", "Label")
2679:         WITH par_oPg.lbl_4c_Acmemps
2680:             .FontName  = "Tahoma"
2681:             .FontSize  = 8
2682:             .Caption   = "Checa Acesso Muda Empresa :"
2683:             .Top       = 103
2684:             .Left      = 285
2685:             .Width     = 149
2686:             .Height    = 15
2687:             .ForeColor = RGB(90, 90, 90)
2688:             .BackStyle = 0
2689:             .AutoSize  = .F.

*-- Linhas 2697 a 2733:
2697:             .BackStyle   = 0
2698:             .BorderStyle = 0
2699:             .Height      = 20
2700:             .Left        = 431
2701:             .Top         = 99
2702:             .Width       = 86
2703:             .Value       = 2
2704:             .Visible     = .T.
2705:             .Buttons(1).Caption   = "Sim"
2706:             .Buttons(1).FontSize  = 8
2707:             .Buttons(1).BackStyle = 0
2708:             .Buttons(1).Left      = 5
2709:             .Buttons(1).Top       = 3
2710:             .Buttons(1).Width     = 34
2711:             .Buttons(1).AutoSize  = .T.
2712:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2713:             .Buttons(2).FontSize  = 8
2714:             .Buttons(2).BackStyle = 0
2715:             .Buttons(2).Left      = 45
2716:             .Buttons(2).Top       = 3
2717:             .Buttons(2).Width     = 37
2718:             .Buttons(2).AutoSize  = .T.
2719:         ENDWITH
2720: 
2721:         *-- Solicita Senha Responsavel (senresps)
2722:         par_oPg.AddObject("lbl_4c_Senresps", "Label")
2723:         WITH par_oPg.lbl_4c_Senresps
2724:             .FontName  = "Tahoma"
2725:             .FontSize  = 8
2726:             .Caption   = "Solicita Senha Respons" + CHR(225) + "vel :"
2727:             .Top       = 122
2728:             .Left      = 295
2729:             .Width     = 139
2730:             .Height    = 15
2731:             .ForeColor = RGB(90, 90, 90)
2732:             .BackStyle = 0
2733:             .AutoSize  = .F.

*-- Linhas 2741 a 2777:
2741:             .BackStyle   = 0
2742:             .BorderStyle = 0
2743:             .Height      = 20
2744:             .Left        = 431
2745:             .Top         = 118
2746:             .Width       = 86
2747:             .Value       = 1
2748:             .Visible     = .T.
2749:             .Buttons(1).Caption   = "Sim"
2750:             .Buttons(1).FontSize  = 8
2751:             .Buttons(1).BackStyle = 0
2752:             .Buttons(1).Left      = 5
2753:             .Buttons(1).Top       = 3
2754:             .Buttons(1).Width     = 34
2755:             .Buttons(1).AutoSize  = .T.
2756:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2757:             .Buttons(2).FontSize  = 8
2758:             .Buttons(2).BackStyle = 0
2759:             .Buttons(2).Left      = 45
2760:             .Buttons(2).Top       = 3
2761:             .Buttons(2).Width     = 37
2762:             .Buttons(2).AutoSize  = .T.
2763:         ENDWITH
2764: 
2765:         *-- Checar Data de Entrega (chdtentrs)
2766:         par_oPg.AddObject("lbl_4c_Chdtentrs", "Label")
2767:         WITH par_oPg.lbl_4c_Chdtentrs
2768:             .FontName  = "Tahoma"
2769:             .FontSize  = 8
2770:             .Caption   = "Checar Data de Entrega :"
2771:             .Top       = 141
2772:             .Left      = 309
2773:             .Width     = 125
2774:             .Height    = 15
2775:             .ForeColor = RGB(90, 90, 90)
2776:             .BackStyle = 0
2777:             .AutoSize  = .F.

*-- Linhas 2785 a 2821:
2785:             .BackStyle   = 0
2786:             .BorderStyle = 0
2787:             .Height      = 20
2788:             .Left        = 431
2789:             .Top         = 137
2790:             .Width       = 86
2791:             .Value       = 1
2792:             .Visible     = .T.
2793:             .Buttons(1).Caption   = "Sim"
2794:             .Buttons(1).FontSize  = 8
2795:             .Buttons(1).BackStyle = 0
2796:             .Buttons(1).Left      = 5
2797:             .Buttons(1).Top       = 3
2798:             .Buttons(1).Width     = 34
2799:             .Buttons(1).AutoSize  = .T.
2800:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2801:             .Buttons(2).FontSize  = 8
2802:             .Buttons(2).BackStyle = 0
2803:             .Buttons(2).Left      = 45
2804:             .Buttons(2).Top       = 3
2805:             .Buttons(2).Width     = 37
2806:             .Buttons(2).AutoSize  = .T.
2807:         ENDWITH
2808: 
2809:         *-- Imprime Documentos (multiimps)
2810:         par_oPg.AddObject("lbl_4c_Multiimps", "Label")
2811:         WITH par_oPg.lbl_4c_Multiimps
2812:             .FontName  = "Tahoma"
2813:             .FontSize  = 8
2814:             .Caption   = "Imprime Documentos :"
2815:             .Top       = 160
2816:             .Left      = 325
2817:             .Width     = 109
2818:             .Height    = 15
2819:             .ForeColor = RGB(90, 90, 90)
2820:             .BackStyle = 0
2821:             .AutoSize  = .F.

*-- Linhas 2829 a 2865:
2829:             .BackStyle   = 0
2830:             .BorderStyle = 0
2831:             .Height      = 20
2832:             .Left        = 431
2833:             .Top         = 156
2834:             .Width       = 86
2835:             .Value       = 1
2836:             .Visible     = .T.
2837:             .Buttons(1).Caption   = "Sim"
2838:             .Buttons(1).FontSize  = 8
2839:             .Buttons(1).BackStyle = 0
2840:             .Buttons(1).Left      = 5
2841:             .Buttons(1).Top       = 3
2842:             .Buttons(1).Width     = 34
2843:             .Buttons(1).AutoSize  = .T.
2844:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2845:             .Buttons(2).FontSize  = 8
2846:             .Buttons(2).BackStyle = 0
2847:             .Buttons(2).Left      = 45
2848:             .Buttons(2).Top       = 3
2849:             .Buttons(2).Width     = 37
2850:             .Buttons(2).AutoSize  = .T.
2851:         ENDWITH
2852: 
2853:         *-- Utiliza Conta (contas)
2854:         par_oPg.AddObject("lbl_4c_Contas", "Label")
2855:         WITH par_oPg.lbl_4c_Contas
2856:             .FontName  = "Tahoma"
2857:             .FontSize  = 8
2858:             .Caption   = "Utiliza Conta :"
2859:             .Top       = 179
2860:             .Left      = 365
2861:             .Width     = 69
2862:             .Height    = 15
2863:             .ForeColor = RGB(90, 90, 90)
2864:             .BackStyle = 0
2865:             .AutoSize  = .F.

*-- Linhas 2873 a 2925:
2873:             .BackStyle   = 0
2874:             .BorderStyle = 0
2875:             .Height      = 20
2876:             .Left        = 431
2877:             .Top         = 175
2878:             .Width       = 86
2879:             .Value       = 2
2880:             .Visible     = .T.
2881:             .Buttons(1).Caption   = "Sim"
2882:             .Buttons(1).FontSize  = 8
2883:             .Buttons(1).BackStyle = 0
2884:             .Buttons(1).Left      = 5
2885:             .Buttons(1).Top       = 3
2886:             .Buttons(1).Width     = 34
2887:             .Buttons(1).AutoSize  = .T.
2888:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2889:             .Buttons(2).FontSize  = 8
2890:             .Buttons(2).BackStyle = 0
2891:             .Buttons(2).Left      = 45
2892:             .Buttons(2).Top       = 3
2893:             .Buttons(2).Width     = 37
2894:             .Buttons(2).AutoSize  = .T.
2895:         ENDWITH
2896: 
2897:         *-- SECAO "Credito / Bonus" (header Bold, Left=524)
2898:         par_oPg.AddObject("lbl_4c_CrBonus", "Label")
2899:         WITH par_oPg.lbl_4c_CrBonus
2900:             .FontName  = "Tahoma"
2901:             .FontSize  = 8
2902:             .FontBold  = .T.
2903:             .Caption   = "Cr" + CHR(233) + "dito / B" + CHR(244) + "nus"
2904:             .Top       = 10
2905:             .Left      = 524
2906:             .Width     = 89
2907:             .Height    = 15
2908:             .ForeColor = RGB(90, 90, 90)
2909:             .BackStyle = 0
2910:             .AutoSize  = .F.
2911:             .Visible   = .T.
2912:         ENDWITH
2913: 
2914:         par_oPg.AddObject("lbl_4c_Gerar", "Label")
2915:         WITH par_oPg.lbl_4c_Gerar
2916:             .FontName  = "Tahoma"
2917:             .FontSize  = 8
2918:             .Caption   = "Gerar :"
2919:             .Top       = 27
2920:             .Left      = 543
2921:             .Width     = 36
2922:             .Height    = 15
2923:             .ForeColor = RGB(90, 90, 90)
2924:             .BackStyle = 0
2925:             .AutoSize  = .F.

*-- Linhas 2934 a 3014:
2934:             .BackStyle   = 0
2935:             .BorderStyle = 0
2936:             .Height      = 20
2937:             .Left        = 572
2938:             .Top         = 22
2939:             .Width       = 86
2940:             .Value       = 2
2941:             .Visible     = .T.
2942:             .Buttons(1).Caption   = "Sim"
2943:             .Buttons(1).FontSize  = 8
2944:             .Buttons(1).BackStyle = 0
2945:             .Buttons(1).Left      = 5
2946:             .Buttons(1).Top       = 3
2947:             .Buttons(1).Width     = 34
2948:             .Buttons(1).AutoSize  = .T.
2949:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2950:             .Buttons(2).FontSize  = 8
2951:             .Buttons(2).BackStyle = 0
2952:             .Buttons(2).Left      = 45
2953:             .Buttons(2).Top       = 3
2954:             .Buttons(2).Width     = 37
2955:             .Buttons(2).AutoSize  = .T.
2956:         ENDWITH
2957: 
2958:         par_oPg.AddObject("lbl_4c_Subnivel", "Label")
2959:         WITH par_oPg.lbl_4c_Subnivel
2960:             .FontName  = "Tahoma"
2961:             .FontSize  = 8
2962:             .Caption   = "Subn" + CHR(237) + "vel :"
2963:             .Top       = 47
2964:             .Left      = 530
2965:             .Width     = 49
2966:             .Height    = 15
2967:             .ForeColor = RGB(90, 90, 90)
2968:             .BackStyle = 0
2969:             .AutoSize  = .F.
2970:             .Visible   = .T.
2971:         ENDWITH
2972: 
2973:         *-- Subnivel Padrao (subncrs - lookup SigCdOpe)
2974:         par_oPg.AddObject("txt_4c_Subncrs", "TextBox")
2975:         WITH par_oPg.txt_4c_Subncrs
2976:             .Top       = 45
2977:             .Left      = 576
2978:             .Width     = 150
2979:             .Height    = 21
2980:             .MaxLength = 20
2981:             .FontName  = "Tahoma"
2982:             .FontSize  = 8
2983:             .Visible   = .T.
2984:         ENDWITH
2985: 
2986:         *-- SECAO "Bloqueio" (header Bold, Left=524)
2987:         par_oPg.AddObject("lbl_4c_Bloqueio", "Label")
2988:         WITH par_oPg.lbl_4c_Bloqueio
2989:             .FontName  = "Tahoma"
2990:             .FontSize  = 8
2991:             .FontBold  = .T.
2992:             .Caption   = "Bloqueio"
2993:             .Top       = 73
2994:             .Left      = 524
2995:             .Width     = 50
2996:             .Height    = 15
2997:             .ForeColor = RGB(90, 90, 90)
2998:             .BackStyle = 0
2999:             .AutoSize  = .F.
3000:             .Visible   = .T.
3001:         ENDWITH
3002: 
3003:         par_oPg.AddObject("lbl_4c_Por", "Label")
3004:         WITH par_oPg.lbl_4c_Por
3005:             .FontName  = "Tahoma"
3006:             .FontSize  = 8
3007:             .Caption   = "por :"
3008:             .Top       = 93
3009:             .Left      = 554
3010:             .Width     = 25
3011:             .Height    = 15
3012:             .ForeColor = RGB(90, 90, 90)
3013:             .BackStyle = 0
3014:             .AutoSize  = .F.

*-- Linhas 3023 a 3105:
3023:             .BackStyle   = 0
3024:             .BorderStyle = 0
3025:             .Height      = 48
3026:             .Left        = 585
3027:             .Top         = 77
3028:             .Width       = 244
3029:             .Value       = 1
3030:             .Visible     = .T.
3031:             .Buttons(1).Caption   = "Per" + CHR(237) + "odo"
3032:             .Buttons(1).FontSize  = 8
3033:             .Buttons(1).BackStyle = 0
3034:             .Buttons(1).Left      = 3
3035:             .Buttons(1).Top       = 1
3036:             .Buttons(1).Width     = 54
3037:             .Buttons(1).AutoSize  = .T.
3038:             .Buttons(2).Caption   = "Limite M" + CHR(237) + "nimo"
3039:             .Buttons(2).FontSize  = 8
3040:             .Buttons(2).BackStyle = 0
3041:             .Buttons(2).Left      = 3
3042:             .Buttons(2).Top       = 15
3043:             .Buttons(2).Width     = 80
3044:             .Buttons(2).AutoSize  = .T.
3045:             .Buttons(3).Caption   = "N" + CHR(227) + "o Bloqueia"
3046:             .Buttons(3).FontSize  = 8
3047:             .Buttons(3).BackStyle = 0
3048:             .Buttons(3).Left      = 3
3049:             .Buttons(3).Top       = 29
3050:             .Buttons(3).Width     = 81
3051:             .Buttons(3).AutoSize  = .T.
3052:         ENDWITH
3053: 
3054:         *-- SECAO "Icone Para Barra de Acesso" (header Bold)
3055:         par_oPg.AddObject("lbl_4c_IcoBarra", "Label")
3056:         WITH par_oPg.lbl_4c_IcoBarra
3057:             .FontName  = "Tahoma"
3058:             .FontSize  = 8
3059:             .FontBold  = .T.
3060:             .Caption   = " " + CHR(205) + "cone Para Barra de Acesso "
3061:             .Top       = 331
3062:             .Left      = 278
3063:             .Width     = 163
3064:             .Height    = 15
3065:             .ForeColor = RGB(90, 90, 90)
3066:             .BackStyle = 0
3067:             .AutoSize  = .F.
3068:             .Visible   = .T.
3069:         ENDWITH
3070: 
3071:         *-- Arquivo de icone (carqicones)
3072:         par_oPg.AddObject("txt_4c_Carqicones", "TextBox")
3073:         WITH par_oPg.txt_4c_Carqicones
3074:             .Top       = 345
3075:             .Left      = 278
3076:             .Width     = 204
3077:             .Height    = 21
3078:             .MaxLength = 64
3079:             .FontName  = "Tahoma"
3080:             .FontSize  = 8
3081:             .Visible   = .T.
3082:         ENDWITH
3083: 
3084:         *-- Botao para abrir file picker de icone
3085:         par_oPg.AddObject("cmd_4c_Icone", "CommandButton")
3086:         WITH par_oPg.cmd_4c_Icone
3087:             .Caption  = "..."
3088:             .Top      = 344
3089:             .Left     = 482
3090:             .Height   = 22
3091:             .Width    = 22
3092:             .FontBold = .T.
3093:             .Visible  = .T.
3094:         ENDWITH
3095: 
3096:         *-- Imagem do icone selecionado
3097:         par_oPg.AddObject("img_4c_Icone", "Image")
3098:         WITH par_oPg.img_4c_Icone
3099:             .Top     = 334
3100:             .Left    = 504
3101:             .Height  = 32
3102:             .Width   = 32
3103:             .Visible = .T.
3104:         ENDWITH
3105:     ENDPROC

*-- Linhas 3124 a 3133:
3124:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ngopes"
3125: 
3126:                     *-- Reconfigurar headers APOS RecordSource (VFP9 reseta headers)
3127:                     loc_oGrid.Column1.Header1.Caption = "Grupo Operacional"
3128:                     loc_oGrid.Column2.Header1.Caption = "N" + CHR(186)
3129:                     loc_oGrid.Column2.Alignment       = 1
3130: 
3131:                     THIS.FormatarGridLista(loc_oGrid)
3132:                     loc_lResultado = .T.
3133:                 ENDIF

*-- Linhas 3231 a 3239:
3231:                 .this_nGeracrs    = loc_oPgC.opt_4c_Geracrs.Value
3232:                 .this_nTpbloqueio = loc_oPgC.opt_4c_Tpbloqueio.Value
3233: 
3234:                 *-- pgCompls: CheckBoxes (0/1 numeric)
3235:                 .this_nFixaps  = loc_oPgC.chk_4c_Fixaps.Value
3236:                 .this_nFixaas  = loc_oPgC.chk_4c_Fixaas.Value
3237:                 .this_nFixags  = loc_oPgC.chk_4c_Fixags.Value
3238:                 .this_nFixals  = loc_oPgC.chk_4c_Fixals.Value
3239:                 .this_nFixass  = loc_oPgC.chk_4c_Fixass.Value

*-- Linhas 3329 a 3337:
3329:             loc_oPgC.opt_4c_Geracrs.Value    = IIF(loc_oBO.this_nGeracrs    >= 1, loc_oBO.this_nGeracrs,    1)
3330:             loc_oPgC.opt_4c_Tpbloqueio.Value = IIF(loc_oBO.this_nTpbloqueio >= 1, loc_oBO.this_nTpbloqueio, 1)
3331: 
3332:             *-- pgCompls: CheckBoxes (0/1)
3333:             loc_oPgC.chk_4c_Fixaps.Value = loc_oBO.this_nFixaps
3334:             loc_oPgC.chk_4c_Fixaas.Value = loc_oBO.this_nFixaas
3335:             loc_oPgC.chk_4c_Fixags.Value = loc_oBO.this_nFixags
3336:             loc_oPgC.chk_4c_Fixals.Value = loc_oBO.this_nFixals
3337:             loc_oPgC.chk_4c_Fixass.Value = loc_oBO.this_nFixass

*-- Linhas 3362 a 3372:
3362:                 loc_oPg1.grd_4c_GradeOpe.RecordSource          = "cursor_4c_Operacoes"
3363:                 loc_oPg1.grd_4c_GradeOpe.Column1.ControlSource = "cursor_4c_Operacoes.dopers"
3364:                 loc_oPg1.grd_4c_GradeOpe.Column2.ControlSource = "cursor_4c_Operacoes.confops"
3365:                 loc_oPg1.grd_4c_GradeOpe.Column1.Header1.Caption = ;
3366:                     "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"
3367:                 loc_oPg1.grd_4c_GradeOpe.Column2.Header1.Caption = ;
3368:                     "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
3369:                 loc_oPg1.grd_4c_GradeOpe.Refresh()
3370:             ENDIF
3371: 
3372:             loc_lResultado = .T.

*-- Linhas 3444 a 3452:
3444:             loc_oPgC.opt_4c_Geracrs.Enabled    = par_lHabilitar
3445:             loc_oPgC.opt_4c_Tpbloqueio.Enabled = par_lHabilitar
3446: 
3447:             *-- pgCompls: CheckBoxes
3448:             loc_oPgC.chk_4c_Fixaps.Enabled = par_lHabilitar
3449:             loc_oPgC.chk_4c_Fixaas.Enabled = par_lHabilitar
3450:             loc_oPgC.chk_4c_Fixags.Enabled = par_lHabilitar
3451:             loc_oPgC.chk_4c_Fixals.Enabled = par_lHabilitar
3452:             loc_oPgC.chk_4c_Fixass.Enabled = par_lHabilitar

*-- Linhas 3461 a 3469:
3461:             loc_oPgC.txt_4c_Locals.ReadOnly      = loc_lSoLeitura
3462:             loc_oPgC.txt_4c_Codsegs.ReadOnly     = loc_lSoLeitura
3463:             loc_oPgC.txt_4c_Carqicones.ReadOnly  = loc_lSoLeitura
3464:             loc_oPgC.cmd_4c_Icone.Enabled        = par_lHabilitar
3465: 
3466:         CATCH TO loc_oErro
3467:             MsgErro(loc_oErro.Message + CHR(13) + ;
3468:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3469:                 "Procedure: " + loc_oErro.Procedure, "Erro HabilitarCampos")

*-- Linhas 3515 a 3525:
3515:             loc_oPg1.grd_4c_GradeOpe.RecordSource          = "cursor_4c_Operacoes"
3516:             loc_oPg1.grd_4c_GradeOpe.Column1.ControlSource = "cursor_4c_Operacoes.dopers"
3517:             loc_oPg1.grd_4c_GradeOpe.Column2.ControlSource = "cursor_4c_Operacoes.confops"
3518:             loc_oPg1.grd_4c_GradeOpe.Column1.Header1.Caption = ;
3519:                 "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"
3520:             loc_oPg1.grd_4c_GradeOpe.Column2.Header1.Caption = ;
3521:                 "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
3522:             loc_oPg1.grd_4c_GradeOpe.Refresh()
3523: 
3524:             *-- pgCompls: OptionGroups → todos Value=1
3525:             loc_oPgC.opt_4c_Dtatuals.Value   = 1

*-- Linhas 3550 a 3558:
3550:             loc_oPgC.opt_4c_Geracrs.Value    = 1
3551:             loc_oPgC.opt_4c_Tpbloqueio.Value = 1
3552: 
3553:             *-- pgCompls: CheckBoxes
3554:             loc_oPgC.chk_4c_Fixaps.Value = 0
3555:             loc_oPgC.chk_4c_Fixaas.Value = 0
3556:             loc_oPgC.chk_4c_Fixags.Value = 0
3557:             loc_oPgC.chk_4c_Fixals.Value = 0
3558:             loc_oPgC.chk_4c_Fixass.Value = 0

*-- Linhas 3589 a 3601:
3589:                                RECCOUNT("cursor_4c_Dados") > 0
3590: 
3591:             IF VARTYPE(loc_oBotoes) = "O"
3592:                 loc_oBotoes.cmd_4c_Incluir.Enabled    = .T.
3593:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
3594:                 loc_oBotoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
3595:                 loc_oBotoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
3596:                 loc_oBotoes.cmd_4c_Buscar.Enabled     = .T.
3597:             ENDIF
3598:         CATCH TO loc_oErro
3599:             MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
3600:         ENDTRY
3601:     ENDPROC


### BO (C:\4c\projeto\app\classes\GpeBO.prg):
* GpeBO.prg - Business Object para Cadastro de Grupos Operacionais
* Tabela principal: SigCdGpe | PK: dgopes
* Tabela filha: SigCdGpo (grid operacoes: dopers + confops)

DEFINE CLASS GpeBO AS BusinessBase

    *-- SigCdGpe: Identificacao
    this_cDgopes            = ""   && dgopes char(20) - PK Grupo Operacional
    this_nNgopes            = 0    && ngopes numeric(6,0) - Nro interno (fGerUniqueKey)

    *-- SigCdGpe: Numeracao e Controle
    this_nNumopers          = 0    && numopers numeric(1,0) - Numeracao da Operacao
    this_nNcontroles        = 0    && ncontroles numeric(1,0) - Tipo do Nro de Controle
    this_nFontnums          = 0    && fontnums numeric(1,0) - Fonte da Numeracao
    this_nLimdia            = 0    && limdia numeric(6,0) - Limite diario

    *-- SigCdGpe: Auditoria e Acesso
    this_nAudits            = 0    && audits numeric(1,0) - Auditoria (9 opcoes)
    this_nBlqadts           = 0    && blqadts numeric(1,0) - Bloqueia Alt. Data
    this_nInibfecs          = 0    && inibfecs numeric(1,0) - Inibir Botao Fechamento
    this_nInibocors         = 0    && inibocors numeric(1,0) - Inibir Botao Ocorrencia
    this_nAlterar           = 0    && alterar numeric(1,0) - Permitir Alteracao
    this_nConsulta          = 0    && consulta numeric(1,0) - Apenas Consulta
    this_nCtacusus          = 0    && ctacusus numeric(1,0) - Controlar Acesso por Usuario
    this_nSenresps          = 0    && senresps numeric(1,0) - Senha por Responsavel
    this_nAcmemps           = 0    && acmemps numeric(1,0) - Checar Acesso Muda Empresa
    this_nAnacps            = 0    && anacps numeric(1,0) - Analisar C.Pagto Fx.Cx

    *-- SigCdGpe: Situacoes (tristate)
    this_nSubniveis         = 0    && subniveis numeric(1,0) - Situacao dos Subniveis
    this_nUtilizas          = 0    && utilizas numeric(1,0) - Situacao das Operacoes
    this_nFilpagas          = 0    && filpagas numeric(1,0) - Filtro Operacoes Pagas
    this_nFilbaixas         = 0    && filbaixas numeric(1,0) - Filtro Operacoes Baixadas
    this_nOputiliza         = 0    && oputiliza numeric(1,0) - Operacoes Utilizadas
    this_nMontagem          = 0    && montagem numeric(1,0) - Produtos Com Montagem
    this_nQualquer          = 0    && qualquer numeric(1,0) - Ignorar Grupo Operacional
    this_nChkmercs          = 0    && chkmercs numeric(1,0) - Checar Mercadorias
    this_nProds             = 0    && prods numeric(1,0) - Ordem de Producao
    this_nDesutils          = 0    && desutils numeric(1,0) - Desagendar Utilizados
    this_nIniagenda         = 0    && iniagenda numeric(1,0) - Exibir botao F8 - AGENDA

    *-- SigCdGpe: Operacoes em filtro (ordem grade)
    this_nOpagends          = 0    && opagends numeric(1,0) - Operacoes Agendadas (filtro lista)
    this_nOppagas           = 0    && oppagas numeric(1,0) - Operacoes Pagas (filtro lista)
    this_nOppends           = 0    && oppends numeric(1,0) - Operacoes Todas/Agend./Nao-Agend.
    this_nOrdemas           = 0    && ordemas numeric(1,0) - Ordem das Agendadas (combobox)
    this_nOrdemns           = 0    && ordemns numeric(1,0) - Ordem das Nao-Agendadas (combobox)
    this_nOrdems            = 0    && ordems numeric(1,0) - Ordem de Todas (combobox)

    *-- SigCdGpe: Fixar ordenacao
    this_nFixaps            = 0    && fixaps numeric(1,0) - Fixa Pagas (checkbox)
    this_nFixaas            = 0    && fixaas numeric(1,0) - Fixa Agendadas (checkbox)
    this_nFixals            = 0    && fixals numeric(1,0) - Fixa Livres (checkbox Check1)
    this_nFixags            = 0    && fixags numeric(1,0) - Fixa Geral (checkbox)
    this_nFixass            = 0    && fixass numeric(1,0) - Fixa Sessao (checkbox Check2)

    *-- SigCdGpe: Utilizar recursos
    this_nResps             = 0    && resps numeric(1,0) - Utiliza Responsavel
    this_nContas            = 0    && contas numeric(1,0) - Utiliza Conta
    this_nEmpresas          = 0    && empresas numeric(1,0) - Utiliza Empresa
    this_nVends             = 0    && vends numeric(1,0) - Senha por Responsavel (Vendas)
    this_nSacs              = 0    && sacs numeric(1,0) - Checar SAC
    this_nVolumes           = 0    && volumes numeric(1,0) - Quantidade de Volumes
    this_nPeriodos          = 0    && periodos numeric(1,0) - Utiliza Periodo Configuracao
    this_nEntregas          = 0    && entregas numeric(1,0) - Utiliza Periodo Entrega
    this_nOperacoes         = 0    && operacoes numeric(1,0) - Utiliza Periodo Operacao
    this_nEstdisps          = 0    && estdisps numeric(1,0) - Estoque Disponivel
    this_nDtatuals          = 0    && dtatuals numeric(1,0) - Utilizar Data Atual
    this_nGeracrs           = 0    && geracrs numeric(1,0) - Gera Controle de Subniveis
    this_nChkreserva        = 0    && chkreserva numeric(1,0) - Credito/Bonus (optReserva)
    this_nMultiimps         = 0    && multiimps numeric(1,0) - Imprime Documentos
    this_nRoadshows         = 0    && roadshows numeric(1,0)
    this_nTpbloqueio        = 0    && tpbloqueio numeric(1,0) - Tipo de Bloqueio
    this_nChdtentrs         = 0    && chdtentrs numeric(1,0) - Checar Data de Entrega

    *-- SigCdGpe: Campos texto
    this_cSubncrs           = ""   && subncrs char(20) - Subnivel (lookup SigCdOpe)
    this_cLocals            = ""   && locals char(10) - Localizacao Padrao
    this_cCodsegs           = ""   && codsegs char(10) - Segmento Padrao (lookup SigCdSct)
    this_cCarqicones        = ""   && carqicones char(64) - Arquivo de icone
    this_cDopes             = ""   && dopes char(20) - Operacao Padrao (lookup SigCdOpe)
    this_cTproads           = ""   && tproads char(15)

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGpe"
        THIS.this_cCampoChave = "dgopes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDgopes
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista SigCdGpe em cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dgopes, ngopes FROM SigCdGpe"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY dgopes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos operacionais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega SigCdGpe pelo codigo do grupo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cDgopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dgopes, ngopes, numopers, ncontroles, fontnums, limdia," + ;
                " audits, blqadts, inibfecs, inibocors, alterar, consulta, ctacusus," + ;
                " senresps, acmemps, anacps, subniveis, utilizas, filpagas, filbaixas," + ;
                " oputiliza, montagem, qualquer, chkmercs, prods, desutils, iniagenda," + ;
                " opagends, oppagas, oppends, ordemas, ordemns, ordems," + ;
                " fixaps, fixaas, fixals, fixags, fixass," + ;
                " resps, contas, empresas, vends, sacs, volumes, periodos, entregas," + ;
                " operacoes, estdisps, dtatuals, geracrs, chkreserva, multiimps," + ;
                " roadshows, tpbloqueio, chdtentrs," + ;
                " subncrs, locals, codsegs, carqicones, dopes, tproads" + ;
                " FROM SigCdGpe WHERE dgopes = " + EscaparSQL(par_cDgopes)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar grupo operacional:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    * OBRIGATORIO: SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDgopes       = TratarNulo(dgopes, "C")
            THIS.this_nNgopes       = TratarNulo(ngopes, "N")
            THIS.this_nNumopers     = TratarNulo(numopers, "N")
            THIS.this_nNcontroles   = TratarNulo(ncontroles, "N")
            THIS.this_nFontnums     = TratarNulo(fontnums, "N")
            THIS.this_nLimdia       = TratarNulo(limdia, "N")
            THIS.this_nAudits       = TratarNulo(audits, "N")
            THIS.this_nBlqadts      = TratarNulo(blqadts, "N")
            THIS.this_nInibfecs     = TratarNulo(inibfecs, "N")
            THIS.this_nInibocors    = TratarNulo(inibocors, "N")
            THIS.this_nAlterar      = TratarNulo(alterar, "N")
            THIS.this_nConsulta     = TratarNulo(consulta, "N")
            THIS.this_nCtacusus     = TratarNulo(ctacusus, "N")
            THIS.this_nSenresps     = TratarNulo(senresps, "N")
            THIS.this_nAcmemps      = TratarNulo(acmemps, "N")
            THIS.this_nAnacps       = TratarNulo(anacps, "N")
            THIS.this_nSubniveis    = TratarNulo(subniveis, "N")
            THIS.this_nUtilizas     = TratarNulo(utilizas, "N")
            THIS.this_nFilpagas     = TratarNulo(filpagas, "N")
            THIS.this_nFilbaixas    = TratarNulo(filbaixas, "N")
            THIS.this_nOputiliza    = TratarNulo(oputiliza, "N")
            THIS.this_nMontagem     = TratarNulo(montagem, "N")
            THIS.this_nQualquer     = TratarNulo(qualquer, "N")
            THIS.this_nChkmercs     = TratarNulo(chkmercs, "N")
            THIS.this_nProds        = TratarNulo(prods, "N")
            THIS.this_nDesutils     = TratarNulo(desutils, "N")
            THIS.this_nIniagenda    = TratarNulo(iniagenda, "N")
            THIS.this_nOpagends     = TratarNulo(opagends, "N")
            THIS.this_nOppagas      = TratarNulo(oppagas, "N")
            THIS.this_nOppends      = TratarNulo(oppends, "N")
            THIS.this_nOrdemas      = TratarNulo(ordemas, "N")
            THIS.this_nOrdemns      = TratarNulo(ordemns, "N")
            THIS.this_nOrdems       = TratarNulo(ordems, "N")
            THIS.this_nFixaps       = TratarNulo(fixaps, "N")
            THIS.this_nFixaas       = TratarNulo(fixaas, "N")
            THIS.this_nFixals       = TratarNulo(fixals, "N")
            THIS.this_nFixags       = TratarNulo(fixags, "N")
            THIS.this_nFixass       = TratarNulo(fixass, "N")
            THIS.this_nResps        = TratarNulo(resps, "N")
            THIS.this_nContas       = TratarNulo(contas, "N")
            THIS.this_nEmpresas     = TratarNulo(empresas, "N")
            THIS.this_nVends        = TratarNulo(vends, "N")
            THIS.this_nSacs         = TratarNulo(sacs, "N")
            THIS.this_nVolumes      = TratarNulo(volumes, "N")
            THIS.this_nPeriodos     = TratarNulo(periodos, "N")
            THIS.this_nEntregas     = TratarNulo(entregas, "N")
            THIS.this_nOperacoes    = TratarNulo(operacoes, "N")
            THIS.this_nEstdisps     = TratarNulo(estdisps, "N")
            THIS.this_nDtatuals     = TratarNulo(dtatuals, "N")
            THIS.this_nGeracrs      = TratarNulo(geracrs, "N")
            THIS.this_nChkreserva   = TratarNulo(chkreserva, "N")
            THIS.this_nMultiimps    = TratarNulo(multiimps, "N")
            THIS.this_nRoadshows    = TratarNulo(roadshows, "N")
            THIS.this_nTpbloqueio   = TratarNulo(tpbloqueio, "N")
            THIS.this_nChdtentrs    = TratarNulo(chdtentrs, "N")
            THIS.this_cSubncrs      = TratarNulo(subncrs, "C")
            THIS.this_cLocals       = TratarNulo(locals, "C")
            THIS.this_cCodsegs      = TratarNulo(codsegs, "C")
            THIS.this_cCarqicones   = TratarNulo(carqicones, "C")
            THIS.this_cDopes        = TratarNulo(dopes, "C")
            THIS.this_cTproads      = TratarNulo(tproads, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdGpe
    * ngopes gerado via fGerUniqueKey("SigCdGpe")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_nNgopes = fGerUniqueKey("SigCdGpe")

            loc_cSQL = "INSERT INTO SigCdGpe (" + ;
                "dgopes, ngopes, numopers, ncontroles, fontnums, limdia," + ;
                " audits, blqadts, inibfecs, inibocors, alterar, consulta, ctacusus," + ;
                " senresps, acmemps, anacps, subniveis, utilizas, filpagas, filbaixas," + ;
                " oputiliza, montagem, qualquer, chkmercs, prods, desutils, iniagenda," + ;
                " opagends, oppagas, oppends, ordemas, ordemns, ordems," + ;
                " fixaps, fixaas, fixals, fixags, fixass," + ;
                " resps, contas, empresas, vends, sacs, volumes, periodos, entregas," + ;
                " operacoes, estdisps, dtatuals, geracrs, chkreserva, multiimps," + ;
                " roadshows, tpbloqueio, chdtentrs," + ;
                " subncrs, locals, codsegs, carqicones, dopes, tproads" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cDgopes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNgopes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumopers) + "," + ;
                FormatarNumeroSQL(THIS.this_nNcontroles) + "," + ;
                FormatarNumeroSQL(THIS.this_nFontnums) + "," + ;
                FormatarNumeroSQL(THIS.this_nLimdia) + "," + ;
                FormatarNumeroSQL(THIS.this_nAudits) + "," + ;
                FormatarNumeroSQL(THIS.this_nBlqadts) + "," + ;
                FormatarNumeroSQL(THIS.this_nInibfecs) + "," + ;
                FormatarNumeroSQL(THIS.this_nInibocors) + "," + ;
                FormatarNumeroSQL(THIS.this_nAlterar) + "," + ;
                FormatarNumeroSQL(THIS.this_nConsulta) + "," + ;
                FormatarNumeroSQL(THIS.this_nCtacusus) + "," + ;
                FormatarNumeroSQL(THIS.this_nSenresps) + "," + ;
                FormatarNumeroSQL(THIS.this_nAcmemps) + "," + ;
                FormatarNumeroSQL(THIS.this_nAnacps) + "," + ;
                FormatarNumeroSQL(THIS.this_nSubniveis) + "," + ;
                FormatarNumeroSQL(THIS.this_nUtilizas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFilpagas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFilbaixas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOputiliza) + "," + ;
                FormatarNumeroSQL(THIS.this_nMontagem) + "," + ;
                FormatarNumeroSQL(THIS.this_nQualquer) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkmercs) + "," + ;
                FormatarNumeroSQL(THIS.this_nProds) + "," + ;
                FormatarNumeroSQL(THIS.this_nDesutils) + "," + ;
                FormatarNumeroSQL(THIS.this_nIniagenda) + "," + ;
                FormatarNumeroSQL(THIS.this_nOpagends) + "," + ;
                FormatarNumeroSQL(THIS.this_nOppagas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOppends) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdemas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdemns) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdems) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixaps) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixaas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixals) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixags) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixass) + "," + ;
                FormatarNumeroSQL(THIS.this_nResps) + "," + ;
                FormatarNumeroSQL(THIS.this_nContas) + "," + ;
                FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                FormatarNumeroSQL(THIS.this_nSacs) + "," + ;
                FormatarNumeroSQL(THIS.this_nVolumes) + "," + ;
                FormatarNumeroSQL(THIS.this_nPeriodos) + "," + ;
                FormatarNumeroSQL(THIS.this_nEntregas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOperacoes) + "," + ;
                FormatarNumeroSQL(THIS.this_nEstdisps) + "," + ;
                FormatarNumeroSQL(THIS.this_nDtatuals) + "," + ;
                FormatarNumeroSQL(THIS.this_nGeracrs) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkreserva) + "," + ;
                FormatarNumeroSQL(THIS.this_nMultiimps) + "," + ;
                FormatarNumeroSQL(THIS.this_nRoadshows) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpbloqueio) + "," + ;
                FormatarNumeroSQL(THIS.this_nChdtentrs) + "," + ;
                EscaparSQL(THIS.this_cSubncrs) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cCodsegs) + "," + ;
                EscaparSQL(THIS.this_cCarqicones) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cTproads) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir grupo operacional:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdGpe (nao atualiza dgopes/ngopes - sao PK/chave)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGpe SET" + ;
                " numopers = " + FormatarNumeroSQL(THIS.this_nNumopers) + ;
                ", ncontroles = " + FormatarNumeroSQL(THIS.this_nNcontroles) + ;
                ", fontnums = " + FormatarNumeroSQL(THIS.this_nFontnums) + ;
                ", limdia = " + FormatarNumeroSQL(THIS.this_nLimdia) + ;
                ", audits = " + FormatarNumeroSQL(THIS.this_nAudits) + ;
                ", blqadts = " + FormatarNumeroSQL(THIS.this_nBlqadts) + ;
                ", inibfecs = " + FormatarNumeroSQL(THIS.this_nInibfecs) + ;
                ", inibocors = " + FormatarNumeroSQL(THIS.this_nInibocors) + ;
                ", alterar = " + FormatarNumeroSQL(THIS.this_nAlterar) + ;
                ", consulta = " + FormatarNumeroSQL(THIS.this_nConsulta) + ;
                ", ctacusus = " + FormatarNumeroSQL(THIS.this_nCtacusus) + ;
                ", senresps = " + FormatarNumeroSQL(THIS.this_nSenresps) + ;
                ", acmemps = " + FormatarNumeroSQL(THIS.this_nAcmemps) + ;
                ", anacps = " + FormatarNumeroSQL(THIS.this_nAnacps) + ;
                ", subniveis = " + FormatarNumeroSQL(THIS.this_nSubniveis) + ;
                ", utilizas = " + FormatarNumeroSQL(THIS.this_nUtilizas) + ;
                ", filpagas = " + FormatarNumeroSQL(THIS.this_nFilpagas) + ;
                ", filbaixas = " + FormatarNumeroSQL(THIS.this_nFilbaixas) + ;
                ", oputiliza = " + FormatarNumeroSQL(THIS.this_nOputiliza) + ;
                ", montagem = " + FormatarNumeroSQL(THIS.this_nMontagem) + ;
                ", qualquer = " + FormatarNumeroSQL(THIS.this_nQualquer) + ;
                ", chkmercs = " + FormatarNumeroSQL(THIS.this_nChkmercs) + ;
                ", prods = " + FormatarNumeroSQL(THIS.this_nProds) + ;
                ", desutils = " + FormatarNumeroSQL(THIS.this_nDesutils) + ;
                ", iniagenda = " + FormatarNumeroSQL(THIS.this_nIniagenda) + ;
                ", opagends = " + FormatarNumeroSQL(THIS.this_nOpagends) + ;
                ", oppagas = " + FormatarNumeroSQL(THIS.this_nOppagas) + ;
                ", oppends = " + FormatarNumeroSQL(THIS.this_nOppends) + ;
                ", ordemas = " + FormatarNumeroSQL(THIS.this_nOrdemas) + ;
                ", ordemns = " + FormatarNumeroSQL(THIS.this_nOrdemns) + ;
                ", ordems = " + FormatarNumeroSQL(THIS.this_nOrdems) + ;
                ", fixaps = " + FormatarNumeroSQL(THIS.this_nFixaps) + ;
                ", fixaas = " + FormatarNumeroSQL(THIS.this_nFixaas) + ;
                ", fixals = " + FormatarNumeroSQL(THIS.this_nFixals) + ;
                ", fixags = " + FormatarNumeroSQL(THIS.this_nFixags) + ;
                ", fixass = " + FormatarNumeroSQL(THIS.this_nFixass) + ;
                ", resps = " + FormatarNumeroSQL(THIS.this_nResps) + ;
                ", contas = " + FormatarNumeroSQL(THIS.this_nContas) + ;
                ", empresas = " + FormatarNumeroSQL(THIS.this_nEmpresas) + ;
                ", vends = " + FormatarNumeroSQL(THIS.this_nVends) + ;
                ", sacs = " + FormatarNumeroSQL(THIS.this_nSacs) + ;
                ", volumes = " + FormatarNumeroSQL(THIS.this_nVolumes) + ;
                ", periodos = " + FormatarNumeroSQL(THIS.this_nPeriodos) + ;
                ", entregas = " + FormatarNumeroSQL(THIS.this_nEntregas) + ;
                ", operacoes = " + FormatarNumeroSQL(THIS.this_nOperacoes) + ;
                ", estdisps = " + FormatarNumeroSQL(THIS.this_nEstdisps) + ;
                ", dtatuals = " + FormatarNumeroSQL(THIS.this_nDtatuals) + ;
                ", geracrs = " + FormatarNumeroSQL(THIS.this_nGeracrs) + ;
                ", chkreserva = " + FormatarNumeroSQL(THIS.this_nChkreserva) + ;
                ", multiimps = " + FormatarNumeroSQL(THIS.this_nMultiimps) + ;
                ", roadshows = " + FormatarNumeroSQL(THIS.this_nRoadshows) + ;
                ", tpbloqueio = " + FormatarNumeroSQL(THIS.this_nTpbloqueio) + ;
                ", chdtentrs = " + FormatarNumeroSQL(THIS.this_nChdtentrs) + ;
                ", subncrs = " + EscaparSQL(THIS.this_cSubncrs) + ;
                ", locals = " + EscaparSQL(THIS.this_cLocals) + ;
                ", codsegs = " + EscaparSQL(THIS.this_cCodsegs) + ;
                ", carqicones = " + EscaparSQL(THIS.this_cCarqicones) + ;
                ", dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                ", tproads = " + EscaparSQL(THIS.this_cTproads) + ;
                " WHERE dgopes = " + EscaparSQL(THIS.this_cDgopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo operacional:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdGpe e registros filhos SigCdGpo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Excluir operacoes filhas em SigCdGpo
            loc_cSQL = "DELETE FROM SigCdGpo WHERE dgopes = " + ;
                EscaparSQL(THIS.this_cDgopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es do grupo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir registro principal
                loc_cSQL = "DELETE FROM SigCdGpe WHERE dgopes = " + ;
                    EscaparSQL(THIS.this_cDgopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir grupo operacional:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega SigCdGpo (grid de operacoes) em cursor_4c_Operacoes
    * SigCdGpo: dgopes(FK), dopers(op. possivel), confops(op. conferencia), cidchaves(PK)
    *--------------------------------------------------------------------------
    FUNCTION BuscarOperacoes(par_cDgopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dopers, confops, cidchaves FROM SigCdGpo" + ;
                " WHERE dgopes = " + EscaparSQL(par_cDgopes) + ;
                " ORDER BY cidchaves"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Operacoes")
                TABLEREVERT(.T., "cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarOperacoes - Persiste grid de operacoes (SigCdGpo) do grupo
    * par_cDgopes: codigo do grupo
    * par_cCursorOps: nome do cursor com linhas editadas (campos: dopers, confops)
    * Estrategia: DELETE todas + INSERT das linhas nao vazias
    *--------------------------------------------------------------------------
    FUNCTION SalvarOperacoes(par_cDgopes, par_cCursorOps)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nLinha, loc_cChave
        LOCAL loc_cDopers, loc_cConfops
        loc_lResultado = .F.

        TRY
            *-- Excluir todas as operacoes do grupo
            loc_cSQL = "DELETE FROM SigCdGpo WHERE dgopes = " + EscaparSQL(par_cDgopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar opera" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
                IF USED(par_cCursorOps) AND RECCOUNT(par_cCursorOps) > 0
                    SELECT (par_cCursorOps)
                    GO TOP
                    loc_nLinha = 0
                    DO WHILE !EOF() AND loc_lResultado
                        loc_cDopers  = ALLTRIM(dopers)
                        loc_cConfops = ALLTRIM(confops)
                        IF !EMPTY(loc_cDopers)
                            loc_nLinha = loc_nLinha + 1
                            loc_cChave = LEFT(ALLTRIM(par_cDgopes) + ;
                                STR(loc_nLinha, 6), 20)
                            loc_cSQL = "INSERT INTO SigCdGpo" + ;
                                " (dgopes, dopers, confops, cidchaves) VALUES (" + ;
                                EscaparSQL(par_cDgopes) + "," + ;
                                EscaparSQL(loc_cDopers) + "," + ;
                                EscaparSQL(loc_cConfops) + "," + ;
                                EscaparSQL(loc_cChave) + ")"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + ;
                                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lResultado = .F.
                            ENDIF
                        ENDIF
                        SKIP
                    ENDDO
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

