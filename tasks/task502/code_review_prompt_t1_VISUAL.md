# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (10)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 170: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 194: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 218: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 242: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 266: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 301: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 323: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 467: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 490: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrl.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1926 linhas total):

*-- Linhas 75 a 90:
75:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
76:         THIS.pgf_4c_Paginas.PageCount = 2
77:         WITH THIS.pgf_4c_Paginas
78:             .Top     = -29
79:             .Left    = 0
80:             .Width   = THIS.Width
81:             .Height  = THIS.Height + 29
82:             .Tabs    = .F.
83:             .Visible = .T.
84:             .Page1.Caption = "Lista"
85:             .Page2.Caption = "Dados"
86:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
87:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
88:         ENDWITH
89: 
90:         THIS.ConfigurarPaginaLista()

*-- Linhas 104 a 345:
104:         *-- Cabecalho escuro: Top=1+29=30
105:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
106:         WITH loc_oPagina.cnt_4c_Cabecalho
107:             .Top         = 30
108:             .Left        = 0
109:             .Width       = THIS.Width
110:             .Height      = 80
111:             .BackColor   = RGB(100, 100, 100)
112:             .BorderWidth = 0
113:             .Visible     = .T.
114:         ENDWITH
115: 
116:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
117:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
118:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
119:             .Top       = 15
120:             .Left      = 10
121:             .Width     = 769
122:             .Height    = 40
123:             .FontName  = "Tahoma"
124:             .FontSize  = 16
125:             .FontBold  = .T.
126:             .ForeColor = RGB(0, 0, 0)
127:             .BackStyle = 0
128:             .Visible   = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
133:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
134:             .Top       = 18
135:             .Left      = 10
136:             .Width     = 769
137:             .Height    = 46
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(255, 255, 255)
142:             .BackStyle = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         *-- Container botoes CRUD: Top=0+29=29 (original Grupo_op.Top=-1 -> 28, canonical ~29)
147:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
148:         WITH loc_oPagina.cnt_4c_Botoes
149:             .Top         = 29
150:             .Left        = 542
151:             .Width       = 390
152:             .Height      = 85
153:             .BackStyle = 0
154:             .BorderWidth = 0
155:             .Visible     = .T.
156:         ENDWITH
157: 
158:         *-- Incluir
159:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
160:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
161:             .Caption         = "Incluir"
162:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
163:             .PicturePosition = 13
164:             .Top             = 5
165:             .Left            = 5
166:             .Width           = 75
167:             .Height          = 75
168:             .BackColor       = RGB(255, 255, 255)
169:             .ForeColor       = RGB(90, 90, 90)
170:             .FontName        = "Comic Sans MS"
171:             .FontSize        = 8
172:             .FontBold        = .T.
173:             .FontItalic      = .T.
174:             .Themes          = .F.
175:             .SpecialEffect   = 0
176:             .MousePointer    = 15
177:             .WordWrap        = .T.
178:             .AutoSize        = .F.
179:         ENDWITH
180:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
181: 
182:         *-- Visualizar
183:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
184:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
185:             .Caption         = "Visualizar"
186:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
187:             .PicturePosition = 13
188:             .Top             = 5
189:             .Left            = 80
190:             .Width           = 75
191:             .Height          = 75
192:             .BackColor       = RGB(255, 255, 255)
193:             .ForeColor       = RGB(90, 90, 90)
194:             .FontName        = "Comic Sans MS"
195:             .FontSize        = 8
196:             .FontBold        = .T.
197:             .FontItalic      = .T.
198:             .Themes          = .F.
199:             .SpecialEffect   = 0
200:             .MousePointer    = 15
201:             .WordWrap        = .T.
202:             .AutoSize        = .F.
203:         ENDWITH
204:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
205: 
206:         *-- Alterar
207:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
208:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
209:             .Caption         = "Alterar"
210:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
211:             .PicturePosition = 13
212:             .Top             = 5
213:             .Left            = 155
214:             .Width           = 75
215:             .Height          = 75
216:             .BackColor       = RGB(255, 255, 255)
217:             .ForeColor       = RGB(90, 90, 90)
218:             .FontName        = "Comic Sans MS"
219:             .FontSize        = 8
220:             .FontBold        = .T.
221:             .FontItalic      = .T.
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .MousePointer    = 15
225:             .WordWrap        = .T.
226:             .AutoSize        = .F.
227:         ENDWITH
228:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
229: 
230:         *-- Excluir
231:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
232:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
233:             .Caption         = "Excluir"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 230
238:             .Width           = 75
239:             .Height          = 75
240:             .BackColor       = RGB(255, 255, 255)
241:             .ForeColor       = RGB(90, 90, 90)
242:             .FontName        = "Comic Sans MS"
243:             .FontSize        = 8
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .Themes          = .F.
247:             .SpecialEffect   = 0
248:             .MousePointer    = 15
249:             .WordWrap        = .T.
250:             .AutoSize        = .F.
251:         ENDWITH
252:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
253: 
254:         *-- Buscar
255:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
256:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
257:             .Caption         = "Buscar"
258:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
259:             .PicturePosition = 13
260:             .Top             = 5
261:             .Left            = 305
262:             .Width           = 75
263:             .Height          = 75
264:             .BackColor       = RGB(255, 255, 255)
265:             .ForeColor       = RGB(90, 90, 90)
266:             .FontName        = "Comic Sans MS"
267:             .FontSize        = 8
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .Themes          = .F.
271:             .SpecialEffect   = 0
272:             .MousePointer    = 15
273:             .WordWrap        = .T.
274:             .AutoSize        = .F.
275:         ENDWITH
276:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
277: 
278:         *-- Container Encerrar (canonico - prevalece sobre PILAR 1)
279:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
280:         WITH loc_oPagina.cnt_4c_Saida
281:             .Top         = 29
282:             .Left        = 917
283:             .Width       = 90
284:             .Height      = 85
285:             .BackStyle   = 0
286:             .BorderWidth = 0
287:             .Visible     = .T.
288:         ENDWITH
289: 
290:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
291:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
292:             .Caption         = "Encerrar"
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
294:             .PicturePosition = 13
295:             .Top             = 5
296:             .Left            = 5
297:             .Width           = 75
298:             .Height          = 75
299:             .BackColor       = RGB(255, 255, 255)
300:             .ForeColor       = RGB(90, 90, 90)
301:             .FontName        = "Comic Sans MS"
302:             .FontSize        = 8
303:             .FontBold        = .T.
304:             .FontItalic      = .T.
305:             .Themes          = .F.
306:             .SpecialEffect   = 0
307:             .MousePointer    = 15
308:             .WordWrap        = .T.
309:             .AutoSize        = .F.
310:         ENDWITH
311:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
312: 
313:         *-- Botao Etiquetas (cmdEtiquetas original: Top=-1+29=28, Left=464)
314:         loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
315:         WITH loc_oPagina.cmd_4c_Etiquetas
316:             .Caption         = "Etiquetas"
317:             .Top             = 28
318:             .Left            = 464
319:             .Width           = 75
320:             .Height          = 75
321:             .BackColor       = RGB(255, 255, 255)
322:             .ForeColor       = RGB(90, 90, 90)
323:             .FontName        = "Comic Sans MS"
324:             .FontSize        = 8
325:             .FontBold        = .T.
326:             .FontItalic      = .T.
327:             .Themes          = .F.
328:             .SpecialEffect   = 0
329:             .MousePointer    = 15
330:             .WordWrap        = .T.
331:             .AutoSize        = .F.
332:         ENDWITH
333:         BINDEVENT(loc_oPagina.cmd_4c_Etiquetas, "Click", THIS, "BtnEtiquetasClick")
334: 
335:         *-- Grid lista (Grade original: codigos 100px, descricaos 290px)
336:         *-- Top=88+29=117, Left=26, Width=890, Height=498
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         WITH loc_oPagina.grd_4c_Lista
339:             .Top                = 117
340:             .Left               = 26
341:             .Width              = 890
342:             .Height             = 498
343:             .FontName           = "Verdana"
344:             .FontSize           = 8
345:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 362 a 383:
362:         WITH loc_oPagina.grd_4c_Lista.Column1
363:             .Width               = 100
364:             .Alignment           = 0
365:             .Header1.Caption     = "C" + CHR(243) + "digo"
366:         ENDWITH
367: 
368:         WITH loc_oPagina.grd_4c_Lista.Column2
369:             .Width               = 290
370:             .Alignment           = 0
371:             .Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
372:         ENDWITH
373: 
374:         *-- Painel etiquetas: inicia OCULTO (ativado via BtnEtiquetasClick)
375:         loc_oPagina.AddObject("cnt_4c_Etiquetas", "Container")
376:         WITH loc_oPagina.cnt_4c_Etiquetas
377:             .Top           = 202
378:             .Left          = 289
379:             .Width         = 420
380:             .Height        = 259
381:             .BorderWidth   = 2
382:             .SpecialEffect = 0
383:             .BackColor     = RGB(255, 255, 255)

*-- Linhas 402 a 438:
402:         *-- Cabecalho escuro (mesmo estilo da Page1): Top=1+29=30
403:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
404:         WITH loc_oPagina.cnt_4c_Cabecalho
405:             .Top         = 30
406:             .Left        = 0
407:             .Width       = THIS.Width
408:             .Height      = 80
409:             .BackColor   = RGB(100, 100, 100)
410:             .BorderWidth = 0
411:             .Visible     = .T.
412:         ENDWITH
413: 
414:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
415:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
416:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
417:             .Top       = 15
418:             .Left      = 10
419:             .Width     = 769
420:             .Height    = 40
421:             .FontName  = "Tahoma"
422:             .FontSize  = 16
423:             .FontBold  = .T.
424:             .ForeColor = RGB(0, 0, 0)
425:             .BackStyle = 0
426:             .Visible   = .T.
427:         ENDWITH
428: 
429:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
430:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
431:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
432:             .Top       = 18
433:             .Left      = 10
434:             .Width     = 769
435:             .Height    = 46
436:             .FontName  = "Tahoma"
437:             .FontSize  = 16
438:             .FontBold  = .T.

*-- Linhas 444 a 512:
444:         *-- Container botoes Salvar/Cancelar: Top=9+29=38, Left=819
445:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
446:         WITH loc_oPagina.cnt_4c_BotoesAcao
447:             .Top         = 38
448:             .Left        = 819
449:             .Width       = 160
450:             .Height      = 85
451:             .BackStyle = 1
452:             .BackColor = RGB(255, 255, 255)
453:             .Visible     = .T.
454:         ENDWITH
455: 
456:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
457:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
458:             .Caption         = "Confirmar"
459:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
460:             .PicturePosition = 13
461:             .Top             = 5
462:             .Left            = 5
463:             .Width           = 75
464:             .Height          = 75
465:             .BackColor       = RGB(255, 255, 255)
466:             .ForeColor       = RGB(90, 90, 90)
467:             .FontName        = "Comic Sans MS"
468:             .FontSize        = 8
469:             .FontBold        = .T.
470:             .FontItalic      = .T.
471:             .Themes          = .F.
472:             .SpecialEffect   = 0
473:             .MousePointer    = 15
474:             .WordWrap        = .T.
475:             .AutoSize        = .F.
476:         ENDWITH
477:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
478: 
479:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
480:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
481:             .Caption         = "Encerrar"
482:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
483:             .PicturePosition = 13
484:             .Top             = 5
485:             .Left            = 80
486:             .Width           = 75
487:             .Height          = 75
488:             .BackColor       = RGB(255, 255, 255)
489:             .ForeColor       = RGB(90, 90, 90)
490:             .FontName        = "Comic Sans MS"
491:             .FontSize        = 8
492:             .FontBold        = .T.
493:             .FontItalic      = .T.
494:             .Themes          = .F.
495:             .SpecialEffect   = 0
496:             .MousePointer    = 15
497:             .WordWrap        = .T.
498:             .AutoSize        = .F.
499:         ENDWITH
500:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
501: 
502:         *-- Label "Codigo :" (Say8): Top=155+29=184, Left=319, Width=42
503:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
504:         WITH loc_oPagina.lbl_4c_Codigo
505:             .Caption   = "C" + CHR(243) + "digo :"
506:             .Top       = 184
507:             .Left      = 319
508:             .Width     = 42
509:             .Height    = 17
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .FontBold  = .F.

*-- Linhas 520 a 529:
520:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
521:         WITH loc_oPagina.txt_4c_Codigos
522:             .Value         = ""
523:             .Top           = 181
524:             .Left          = 366
525:             .Width         = 80
526:             .Height        = 23
527:             .MaxLength     = 10
528:             .FontName      = "Tahoma"
529:             .FontSize      = 8

*-- Linhas 536 a 567:
536:             .Visible       = .T.
537:         ENDWITH
538: 
539:         *-- CheckBox "Imprime Etiqueta" (chkEtiqueta): Top=155+29=184, Left=455
540:         loc_oPagina.AddObject("chk_4c_Etiqueta", "CheckBox")
541:         WITH loc_oPagina.chk_4c_Etiqueta
542:             .Caption   = "Imprime Etiqueta"
543:             .Value     = 0
544:             .Top       = 184
545:             .Left      = 455
546:             .Width     = 120
547:             .Height    = 17
548:             .FontName  = "Tahoma"
549:             .FontSize  = 8
550:             .ForeColor = RGB(90, 90, 90)
551:             .BackStyle = 0
552:             .Themes    = .F.
553:             .Enabled   = .F.
554:             .Visible   = .T.
555:         ENDWITH
556: 
557:         *-- Label "Localização :" (Say1): Top=182+29=211, Left=298, Width=63
558:         loc_oPagina.AddObject("lbl_4c_Localizacao", "Label")
559:         WITH loc_oPagina.lbl_4c_Localizacao
560:             .Caption   = "Localiza" + CHR(231) + CHR(227) + "o :"
561:             .Top       = 211
562:             .Left      = 298
563:             .Width     = 63
564:             .Height    = 17
565:             .FontName  = "Tahoma"
566:             .FontSize  = 8
567:             .FontBold  = .F.

*-- Linhas 575 a 584:
575:         loc_oPagina.AddObject("txt_4c_Descricaos", "TextBox")
576:         WITH loc_oPagina.txt_4c_Descricaos
577:             .Value         = ""
578:             .Top           = 207
579:             .Left          = 366
580:             .Width         = 150
581:             .Height        = 23
582:             .MaxLength     = 20
583:             .Format        = "!"
584:             .FontName      = "Tahoma"

*-- Linhas 593 a 667:
593:         ENDWITH
594: 
595:         *-- Campos sem uso do legado (mapeados para fidelidade, iniciam ocultos)
596:         loc_oPagina.AddObject("lbl_4c_SemUso2", "Label")
597:         WITH loc_oPagina.lbl_4c_SemUso2
598:             .Caption  = "sem uso :"
599:             .Top      = 527
600:             .Left     = 315
601:             .Width    = 59
602:             .Height   = 17
603:             .FontName = "Verdana"
604:             .FontSize = 8
605:             .ForeColor = RGB(255, 0, 0)
606:             .BackStyle = 0
607:             .Visible  = .F.
608:         ENDWITH
609: 
610:         loc_oPagina.AddObject("txt_4c_Divisaos", "TextBox")
611:         WITH loc_oPagina.txt_4c_Divisaos
612:             .Value         = 0
613:             .Top           = 546
614:             .Left          = 377
615:             .Width         = 24
616:             .Height        = 23
617:             .MaxLength     = 2
618:             .InputMask     = "99"
619:             .FontName      = "Courier New"
620:             .FontSize      = 8
621:             .ForeColor     = RGB(36, 84, 155)
622:             .SpecialEffect = 1
623:             .Themes        = .F.
624:             .Visible       = .F.
625:         ENDWITH
626: 
627:         loc_oPagina.AddObject("lbl_4c_SemUso3", "Label")
628:         WITH loc_oPagina.lbl_4c_SemUso3
629:             .Caption  = "sem uso :"
630:             .Top      = 550
631:             .Left     = 315
632:             .Width    = 59
633:             .Height   = 15
634:             .FontName = "Verdana"
635:             .FontSize = 8
636:             .ForeColor = RGB(255, 0, 0)
637:             .BackStyle = 0
638:             .Visible  = .F.
639:         ENDWITH
640: 
641:         loc_oPagina.AddObject("txt_4c_Bloqueios", "TextBox")
642:         WITH loc_oPagina.txt_4c_Bloqueios
643:             .Value         = 0
644:             .Top           = 570
645:             .Left          = 377
646:             .Width         = 24
647:             .Height        = 23
648:             .MaxLength     = 2
649:             .InputMask     = "99"
650:             .FontName      = "Courier New"
651:             .FontSize      = 8
652:             .ForeColor     = RGB(36, 84, 155)
653:             .SpecialEffect = 1
654:             .Themes        = .F.
655:             .Visible       = .F.
656:         ENDWITH
657: 
658:         loc_oPagina.AddObject("lbl_4c_SemUso22", "Label")
659:         WITH loc_oPagina.lbl_4c_SemUso22
660:             .Caption  = "sem uso :"
661:             .Top      = 573
662:             .Left     = 315
663:             .Width    = 59
664:             .Height   = 15
665:             .FontName = "Verdana"
666:             .FontSize = 8
667:             .ForeColor = RGB(255, 0, 0)

*-- Linhas 674 a 714:
674:         WITH loc_oPagina.opt_4c_Tipos
675:             .BackStyle   = 0
676:             .BorderStyle = 0
677:             .Top         = 522
678:             .Left        = 377
679:             .Width       = 262
680:             .Height      = 27
681:             .Value       = 1
682:             .Visible     = .F.
683:         ENDWITH
684:         WITH loc_oPagina.opt_4c_Tipos.Buttons(1)
685:             .Caption  = "Produto"
686:             .Left     = 5
687:             .Top      = 5
688:             .Width    = 63
689:             .AutoSize = .T.
690:             .FontName = "Verdana"
691:             .FontSize = 8
692:             .ForeColor = RGB(36, 84, 155)
693:             .BackStyle = 0
694:         ENDWITH
695:         WITH loc_oPagina.opt_4c_Tipos.Buttons(2)
696:             .Caption  = "Agendamento"
697:             .Left     = 81
698:             .Top      = 5
699:             .Width    = 98
700:             .AutoSize = .T.
701:             .FontName = "Verdana"
702:             .FontSize = 8
703:             .ForeColor = RGB(36, 84, 155)
704:             .BackStyle = 0
705:         ENDWITH
706:         WITH loc_oPagina.opt_4c_Tipos.Buttons(3)
707:             .Caption  = "Dep" + CHR(243) + "sito"
708:             .Left     = 183
709:             .Top      = 7
710:             .Width    = 69
711:             .AutoSize = .T.
712:             .FontName = "Verdana"
713:             .FontSize = 8
714:             .ForeColor = RGB(36, 84, 155)

*-- Linhas 740 a 749:
740:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.descricaos"
741:                     loc_oGrid.Column1.Width          = 100
742:                     loc_oGrid.Column2.Width          = 290
743:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
744:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
745: 
746:                     THIS.FormatarGridLista(loc_oGrid)
747:                     loc_lResultado = .T.
748:                 ELSE
749:                     loc_lResultado = .F.

*-- Linhas 833 a 842:
833:             LOCAL loc_oPagina
834:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
835:             IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
836:                 IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
837:                     loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
838:                 ENDIF
839:             ENDIF
840:         ELSE
841:             MsgErro("Erro ao carregar registro.", "Visualizar")
842:         ENDIF

*-- Linhas 950 a 959:
950:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.descricaos"
951:                     loc_oGrid.Column1.Width          = 100
952:                     loc_oGrid.Column2.Width          = 290
953:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
954:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
955:                     THIS.FormatarGridLista(loc_oGrid)
956: 
957:                     IF RECCOUNT("cursor_4c_Dados") = 0
958:                         MsgAviso("Nenhum registro encontrado para '" + ALLTRIM(loc_cBusca) + "'.", "Buscar")
959:                     ENDIF

*-- Linhas 1133 a 1145:
1133:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1134: 
1135:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1136:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1137:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
1138:             ENDIF
1139:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1140:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1141:             ENDIF
1142:         ENDIF
1143:     ENDPROC
1144: 
1145:     *--------------------------------------------------------------------------

*-- Linhas 1162 a 1170:
1162:                 ENDIF
1163: 
1164:                 *-- Pular campos sem uso (devem permanecer ocultos)
1165:                 IF INLIST(loc_cNome, "LBL_4C_SEMUSO2", "LBL_4C_SEMUSO3", "LBL_4C_SEMUSO22", ;
1166:                                      "TXT_4C_DIVISAOS", "TXT_4C_BLOQUEIOS", "OPT_4C_TIPOS")
1167:                     LOOP
1168:                 ENDIF
1169: 
1170:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)

*-- Linhas 1202 a 1267:
1202:         LOCAL loc_oErro
1203:         TRY
1204:             *-- Titulo
1205:             par_oCnt.AddObject("lbl_4c_TituloEtq", "Label")
1206:             WITH par_oCnt.lbl_4c_TituloEtq
1207:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
1208:                 .FontBold  = .T.
1209:                 .FontName  = "Tahoma"
1210:                 .FontSize  = 12
1211:                 .BackStyle = 0
1212:                 .ForeColor = RGB(90, 90, 90)
1213:                 .Height    = 21
1214:                 .Left      = 113
1215:                 .Top       = 5
1216:                 .Width     = 194
1217:                 .Visible   = .T.
1218:             ENDWITH
1219: 
1220:             *-- Label Codigo
1221:             par_oCnt.AddObject("lbl_4c_CodigoEtq", "Label")
1222:             WITH par_oCnt.lbl_4c_CodigoEtq
1223:                 .Caption   = "C" + CHR(243) + "digo :"
1224:                 .FontName  = "Tahoma"
1225:                 .FontSize  = 8
1226:                 .BackStyle = 0
1227:                 .ForeColor = RGB(90, 90, 90)
1228:                 .Height    = 15
1229:                 .Left      = 7
1230:                 .Top       = 36
1231:                 .Width     = 42
1232:                 .Visible   = .T.
1233:             ENDWITH
1234: 
1235:             *-- TextBox Codigo (getCodigos: MaxLength=3, codigo da localizacao)
1236:             par_oCnt.AddObject("txt_4c_CodigosEtq", "TextBox")
1237:             WITH par_oCnt.txt_4c_CodigosEtq
1238:                 .Value         = ""
1239:                 .FontName      = "Tahoma"
1240:                 .FontSize      = 8
1241:                 .ForeColor     = RGB(90, 90, 90)
1242:                 .Height        = 23
1243:                 .Left          = 58
1244:                 .MaxLength     = 3
1245:                 .SpecialEffect = 1
1246:                 .Top           = 33
1247:                 .Width         = 31
1248:                 .Visible       = .T.
1249:             ENDWITH
1250:             BINDEVENT(par_oCnt.txt_4c_CodigosEtq, "KeyPress", THIS, "CodigosEtqLostFocus")
1251: 
1252:             *-- Label Quantidade
1253:             par_oCnt.AddObject("lbl_4c_QuantEtq", "Label")
1254:             WITH par_oCnt.lbl_4c_QuantEtq
1255:                 .Caption   = "Quantidade :"
1256:                 .FontName  = "Tahoma"
1257:                 .FontSize  = 8
1258:                 .BackStyle = 0
1259:                 .ForeColor = RGB(90, 90, 90)
1260:                 .Height    = 15
1261:                 .Left      = 99
1262:                 .Top       = 37
1263:                 .Width     = 65
1264:                 .Visible   = .T.
1265:             ENDWITH
1266: 
1267:             *-- TextBox Quantidade (getQtde: numero de copias)

*-- Linhas 1273 a 1380:
1273:                 .ForeColor     = RGB(90, 90, 90)
1274:                 .Height        = 23
1275:                 .InputMask     = "999"
1276:                 .Left          = 173
1277:                 .MaxLength     = 3
1278:                 .SpecialEffect = 1
1279:                 .Top           = 34
1280:                 .Width         = 31
1281:                 .Visible       = .T.
1282:             ENDWITH
1283: 
1284:             *-- Label Tipo
1285:             par_oCnt.AddObject("lbl_4c_TipoEtq", "Label")
1286:             WITH par_oCnt.lbl_4c_TipoEtq
1287:                 .Caption   = "Tipo :"
1288:                 .FontName  = "Tahoma"
1289:                 .FontSize  = 8
1290:                 .BackStyle = 0
1291:                 .ForeColor = RGB(90, 90, 90)
1292:                 .Height    = 15
1293:                 .Left      = 23
1294:                 .Top       = 65
1295:                 .Width     = 31
1296:                 .Visible   = .T.
1297:             ENDWITH
1298: 
1299:             *-- OptionGroup Tipo (optTipo: Pequena=1, Grande=2)
1300:             par_oCnt.AddObject("opt_4c_TipoEtq", "OptionGroup")
1301:             par_oCnt.opt_4c_TipoEtq.ButtonCount = 2
1302:             WITH par_oCnt.opt_4c_TipoEtq
1303:                 .BackStyle   = 0
1304:                 .BorderStyle = 0
1305:                 .Height      = 25
1306:                 .Left        = 52
1307:                 .Top         = 61
1308:                 .Value       = 1
1309:                 .Width       = 141
1310:                 .Visible     = .T.
1311:             ENDWITH
1312:             WITH par_oCnt.opt_4c_TipoEtq.Buttons(1)
1313:                 .AutoSize  = .T.
1314:                 .BackStyle = 0
1315:                 .Caption   = "Pequena"
1316:                 .FontName  = "Tahoma"
1317:                 .FontSize  = 8
1318:                 .ForeColor = RGB(90, 90, 90)
1319:                 .Height    = 15
1320:                 .Left      = 5
1321:                 .Themes    = .F.
1322:                 .Top       = 5
1323:                 .Width     = 60
1324:             ENDWITH
1325:             WITH par_oCnt.opt_4c_TipoEtq.Buttons(2)
1326:                 .AutoSize  = .T.
1327:                 .BackStyle = 0
1328:                 .Caption   = "Grande"
1329:                 .FontName  = "Tahoma"
1330:                 .FontSize  = 8
1331:                 .ForeColor = RGB(90, 90, 90)
1332:                 .Height    = 15
1333:                 .Left      = 78
1334:                 .Themes    = .F.
1335:                 .Top       = 5
1336:                 .Width     = 53
1337:             ENDWITH
1338: 
1339:             *-- OptionGroup Impressora (optImpressora: populado dinamicamente em ImprimirEtiquetas)
1340:             par_oCnt.AddObject("opt_4c_Impressora", "OptionGroup")
1341:             par_oCnt.opt_4c_Impressora.ButtonCount = 1
1342:             WITH par_oCnt.opt_4c_Impressora
1343:                 .AutoSize    = .F.
1344:                 .BackStyle   = 0
1345:                 .BorderStyle = 0
1346:                 .Height      = 156
1347:                 .Left        = 12
1348:                 .Top         = 94
1349:                 .Value       = 1
1350:                 .Width       = 200
1351:                 .Visible     = .T.
1352:             ENDWITH
1353:             WITH par_oCnt.opt_4c_Impressora.Buttons(1)
1354:                 .AutoSize  = .F.
1355:                 .BackStyle = 0
1356:                 .Caption   = " \<1. Gen" + CHR(233) + "rico/Somente Texto"
1357:                 .FontName  = "Tahoma"
1358:                 .FontSize  = 8
1359:                 .ForeColor = RGB(90, 90, 90)
1360:                 .Height    = 17
1361:                 .Left      = 4
1362:                 .Top       = 10
1363:                 .Width     = 186
1364:             ENDWITH
1365: 
1366:             *-- Label Densidade
1367:             par_oCnt.AddObject("lbl_4c_DensidadeEtq", "Label")
1368:             WITH par_oCnt.lbl_4c_DensidadeEtq
1369:                 .Caption   = "Densidade"
1370:                 .FontName  = "Tahoma"
1371:                 .FontSize  = 7
1372:                 .BackStyle = 0
1373:                 .ForeColor = RGB(90, 90, 90)
1374:                 .Left      = 234
1375:                 .Top       = 37
1376:                 .Width     = 45
1377:                 .Visible   = .T.
1378:             ENDWITH
1379: 
1380:             *-- Spinner Densidade (spnDensidade: range 0-20, default 20)

*-- Linhas 1386 a 1413:
1386:                 .Height            = 26
1387:                 .KeyboardHighValue = 20
1388:                 .KeyboardLowValue  = 0
1389:                 .Left              = 234
1390:                 .SpecialEffect     = 1
1391:                 .SpinnerHighValue  = 20
1392:                 .SpinnerLowValue   = 0
1393:                 .Top               = 53
1394:                 .Value             = 20
1395:                 .Width             = 55
1396:                 .Visible           = .T.
1397:             ENDWITH
1398: 
1399:             *-- Label Horizontal
1400:             par_oCnt.AddObject("lbl_4c_HorizontalEtq", "Label")
1401:             WITH par_oCnt.lbl_4c_HorizontalEtq
1402:                 .Caption   = "Horizontal"
1403:                 .FontName  = "Tahoma"
1404:                 .FontSize  = 7
1405:                 .BackStyle = 0
1406:                 .ForeColor = RGB(90, 90, 90)
1407:                 .Left      = 292
1408:                 .Top       = 37
1409:                 .Width     = 43
1410:                 .Visible   = .T.
1411:             ENDWITH
1412: 
1413:             *-- Spinner Horizontal (spnHorizontal: range 0-20, default 0)

*-- Linhas 1419 a 1447:
1419:                 .Height            = 26
1420:                 .KeyboardHighValue = 20
1421:                 .KeyboardLowValue  = 0
1422:                 .Left              = 292
1423:                 .SpecialEffect     = 1
1424:                 .SpinnerHighValue  = 20
1425:                 .SpinnerLowValue   = 0
1426:                 .Top               = 53
1427:                 .Value             = 0
1428:                 .Width             = 55
1429:                 .Visible           = .T.
1430:             ENDWITH
1431: 
1432:             *-- Label Vertical
1433:             par_oCnt.AddObject("lbl_4c_VerticalEtq", "Label")
1434:             WITH par_oCnt.lbl_4c_VerticalEtq
1435:                 .Caption   = "Vertical"
1436:                 .FontName  = "Tahoma"
1437:                 .FontSize  = 7
1438:                 .BackStyle = 0
1439:                 .ForeColor = RGB(90, 90, 90)
1440:                 .Height    = 13
1441:                 .Left      = 350
1442:                 .Top       = 37
1443:                 .Width     = 33
1444:                 .Visible   = .T.
1445:             ENDWITH
1446: 
1447:             *-- Spinner Vertical (spnVertical: range 0-20, default carregado de SigCdPam.AjVerts)

*-- Linhas 1453 a 1510:
1453:                 .Height            = 26
1454:                 .KeyboardHighValue = 20
1455:                 .KeyboardLowValue  = 0
1456:                 .Left              = 350
1457:                 .SpecialEffect     = 1
1458:                 .SpinnerHighValue  = 20
1459:                 .SpinnerLowValue   = 0
1460:                 .Top               = 53
1461:                 .Value             = 0
1462:                 .Width             = 55
1463:                 .Visible           = .T.
1464:             ENDWITH
1465: 
1466:             *-- Botao OK (CmdOk: confirma impressao)
1467:             par_oCnt.AddObject("cmd_4c_OkEtq", "CommandButton")
1468:             WITH par_oCnt.cmd_4c_OkEtq
1469:                 .Caption       = "OK"
1470:                 .BackColor     = RGB(255, 255, 255)
1471:                 .ForeColor     = RGB(90, 90, 90)
1472:                 .FontName      = "Tahoma"
1473:                 .FontSize      = 8
1474:                 .Height        = 45
1475:                 .Left          = 321
1476:                 .MousePointer  = 15
1477:                 .SpecialEffect = 0
1478:                 .Themes        = .F.
1479:                 .ToolTipText   = "Confirmar"
1480:                 .Top           = 206
1481:                 .Width         = 45
1482:                 .Visible       = .T.
1483:             ENDWITH
1484:             BINDEVENT(par_oCnt.cmd_4c_OkEtq, "Click", THIS, "CmdOkEtqClick")
1485: 
1486:             *-- Botao Cancelar (CmdCancel: fecha painel sem imprimir)
1487:             par_oCnt.AddObject("cmd_4c_CancelEtq", "CommandButton")
1488:             WITH par_oCnt.cmd_4c_CancelEtq
1489:                 .Caption       = "Sair"
1490:                 .BackColor     = RGB(255, 255, 255)
1491:                 .Cancel        = .T.
1492:                 .ForeColor     = RGB(90, 90, 90)
1493:                 .FontName      = "Tahoma"
1494:                 .FontSize      = 8
1495:                 .Height        = 45
1496:                 .Left          = 367
1497:                 .MousePointer  = 15
1498:                 .SpecialEffect = 0
1499:                 .Themes        = .F.
1500:                 .ToolTipText   = "[ESC] Sair"
1501:                 .Top           = 206
1502:                 .Width         = 45
1503:                 .Visible       = .T.
1504:             ENDWITH
1505:             BINDEVENT(par_oCnt.cmd_4c_CancelEtq, "Click", THIS, "CmdCancelEtqClick")
1506: 
1507:         CATCH TO loc_oErro
1508:             MsgErro(loc_oErro.Message, "Erro ao configurar painel de etiquetas")
1509:         ENDTRY
1510:     ENDPROC

*-- Linhas 1588 a 1610:
1588:                     loc_cI = ALLTRIM(STR(loc_nI))
1589:                     WITH loc_oCnt.opt_4c_Impressora.Buttons(loc_nI)
1590:                         .AutoSize = .F.
1591:                         .Caption  = " \<" + loc_cI + ". " + laImpOk(loc_nI)
1592:                         .FontSize = 8
1593:                         .Tag      = UPPER(laImpOk(loc_nI))
1594:                         .Top      = loc_nTop
1595:                         .Width    = 180
1596:                     ENDWITH
1597:                     loc_nTop    = loc_nTop + 20
1598:                     loc_nHeight = loc_nHeight + 20
1599:                 ENDFOR
1600:             ELSE
1601:                 loc_oCnt.opt_4c_Impressora.ButtonCount = 1
1602:                 loc_nOk = ASCAN(laPrinters, "GEN" + CHR(233) + "RICO/SOMENTE TEXTO")
1603:                 WITH loc_oCnt.opt_4c_Impressora.Buttons(1)
1604:                     .AutoSize = .F.
1605:                     .Caption  = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
1606:                     .BackStyle = 0
1607:                     .Enabled  = (loc_nOk > 0)
1608:                     .FontSize = 8
1609:                     .Tag      = "GEN" + CHR(233) + "RICO/SOMENTE TEXTO"
1610:                     .Width    = 180

*-- Linhas 1625 a 1633:
1625:             loc_oPagina.grd_4c_Lista.Enabled      = .F.
1626:             loc_oPagina.cnt_4c_Botoes.Enabled     = .F.
1627:             loc_oPagina.cnt_4c_Saida.Enabled      = .F.
1628:             loc_oPagina.cmd_4c_Etiquetas.Enabled  = .F.
1629: 
1630:             loc_oCnt.txt_4c_QtdeEtq.Value    = 1
1631:             loc_oCnt.txt_4c_CodigosEtq.Value = ""
1632: 
1633:             THIS.Refresh()

*-- Linhas 1908 a 1916:
1908:         loc_oPagina.grd_4c_Lista.Enabled      = .T.
1909:         loc_oPagina.cnt_4c_Botoes.Enabled     = .T.
1910:         loc_oPagina.cnt_4c_Saida.Enabled      = .T.
1911:         loc_oPagina.cmd_4c_Etiquetas.Enabled  = .T.
1912:         THIS.Refresh()
1913:         loc_oPagina.grd_4c_Lista.SetFocus()
1914:     ENDPROC
1915: 
1916:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\PrlBO.prg):
*==============================================================================
* PrlBO.prg - Business Object para Cadastro de Localizacao
* Tabela: SigPrLcl
* Herdado de: BusinessBase
*==============================================================================

DEFINE CLASS PrlBO AS BusinessBase

    *-- Propriedades da tabela SigPrLcl
    this_cCodigos    = ""   && codigos char(10) PK
    this_cDescricaos = ""   && descricaos char(20)
    this_nTipos      = 0    && tipos numeric(1,0): 1=Produto 2=Agendamento 3=Deposito
    this_nEtiquetas  = 0    && etiquetas numeric(1,0): 0=Nao 1=Sim
    this_nBloqueios  = 0    && bloqueios numeric(2,0)
    this_nDivisaos   = 0    && divisaos numeric(2,0)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrLcl"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os registros (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, etiquetas" + ;
                       " FROM SigPrLcl" + ;
                       " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo PK (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, tipos, etiquetas, bloqueios, divisaos" + ;
                       " FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = TratarNulo(codigos,    "C")
            THIS.this_cDescricaos = TratarNulo(descricaos, "C")
            THIS.this_nTipos      = TratarNulo(tipos,      "N")
            THIS.this_nEtiquetas  = TratarNulo(etiquetas,  "N")
            THIS.this_nBloqueios  = TratarNulo(bloqueios,  "N")
            THIS.this_nDivisaos   = TratarNulo(divisaos,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrLcl" + ;
                       " (codigos, descricaos, tipos, etiquetas, bloqueios, divisaos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)         + ", " + ;
                       EscaparSQL(THIS.this_cDescricaos)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEtiquetas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBloqueios) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDivisaos)  + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrLcl SET" + ;
                       " descricaos = " + EscaparSQL(THIS.this_cDescricaos)      + "," + ;
                       " tipos      = " + FormatarNumeroSQL(THIS.this_nTipos)     + "," + ;
                       " etiquetas  = " + FormatarNumeroSQL(THIS.this_nEtiquetas) + "," + ;
                       " bloqueios  = " + FormatarNumeroSQL(THIS.this_nBloqueios) + "," + ;
                       " divisaos   = " + FormatarNumeroSQL(THIS.this_nDivisaos)  + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida regras de negocio antes de salvar (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        *-- Localizacao invalida (descricao vazia)
        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Localiza" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        *-- Para etiqueta, codigo deve ter no maximo 3 caracteres
        IF loc_lResultado AND THIS.this_nEtiquetas = 1 AND LEN(ALLTRIM(THIS.this_cCodigos)) > 3
            MsgAviso("Para Impress" + CHR(227) + "o de Etiquetas o C" + CHR(243) + "digo Deve Ter no M" + CHR(225) + "ximo 3 Caracteres!!!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarEtiquetas - Retorna localizacoes com etiqueta habilitada (PUBLIC por padrao)
    * Usado pelo painel de impressao de etiquetas (cntEtiquetas)
    *--------------------------------------------------------------------------
    FUNCTION BuscarEtiquetas(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT codigos, descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE etiquetas = 1" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE codigos = " + EscaparSQL(PADR(par_cCodigo, 6))
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Etiquetas")
                TABLEREVERT(.T., "cursor_4c_Etiquetas")
                USE IN cursor_4c_Etiquetas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiquetas")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar etiquetas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar etiquetas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoExiste - Verifica se codigo ja cadastrado (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoExiste(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT codigos FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkCod")
                TABLEREVERT(.T., "cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarCodigo - Gera proximo codigo unico para SigPrLcl (PUBLIC por padrao)
    * Equivalente a Padl(fGerUniqueKey([SigPrLcl]), 10, [0]) do legado
    *--------------------------------------------------------------------------
    FUNCTION GerarCodigo()
        LOCAL loc_cNovoCodigo, loc_cSQL, loc_nResult
        loc_cNovoCodigo = ""

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CASE WHEN ISNUMERIC(LTRIM(RTRIM(codigos))) = 1" + ;
                       " THEN CAST(LTRIM(RTRIM(codigos)) AS INT) ELSE 0 END), 0) + 1 AS proximo" + ;
                       " FROM SigPrLcl"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_GerarCod")
                TABLEREVERT(.T., "cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_cNovoCodigo = PADL(ALLTRIM(STR(cursor_4c_GerarCod.proximo)), 10, "0")
            ENDIF

            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        ENDTRY

        RETURN loc_cNovoCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Etiquetas")
            USE IN cursor_4c_Etiquetas
        ENDIF
        IF USED("cursor_4c_ChkCod")
            USE IN cursor_4c_ChkCod
        ENDIF
        IF USED("cursor_4c_GerarCod")
            USE IN cursor_4c_GerarCod
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

