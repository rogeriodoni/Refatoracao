# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 181: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 201: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 221: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefc2.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (860 linhas total):

*-- Linhas 92 a 130:
92:     PROTECTED PROCEDURE ConfigurarCabecalho()
93:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
94:         WITH THIS.cnt_4c_Cabecalho
95:             .Top         = 0
96:             .Left        = 0
97:             .Width       = THIS.Width
98:             .Height      = 80
99:             .BackStyle   = 1
100:             .BackColor   = RGB(100, 100, 100)
101:             .BorderWidth = 0
102:             .Visible     = .T.
103: 
104:             .AddObject("lbl_4c_Sombra", "Label")
105:             WITH .lbl_4c_Sombra
106:                 .Top       = 15
107:                 .Left      = 11
108:                 .Width     = THIS.Width
109:                 .Height    = 40
110:                 .Caption   = "Fechamento de Caixa"
111:                 .FontName  = "Tahoma"
112:                 .FontSize  = 16
113:                 .FontBold  = .T.
114:                 .ForeColor = RGB(0, 0, 0)
115:                 .BackStyle = 0
116:                 .Visible   = .T.
117:             ENDWITH
118: 
119:             .AddObject("lbl_4c_Titulo", "Label")
120:             WITH .lbl_4c_Titulo
121:                 .Top       = 18
122:                 .Left      = 10
123:                 .Width     = THIS.Width
124:                 .Height    = 46
125:                 .Caption   = "Fechamento de Caixa"
126:                 .FontName  = "Tahoma"
127:                 .FontSize  = 16
128:                 .FontBold  = .T.
129:                 .ForeColor = RGB(255, 255, 255)
130:                 .BackStyle = 0

*-- Linhas 142 a 167:
142:     PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
143:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
144:         WITH THIS.cmg_4c_Botoes
145:             .Top           = 0
146:             .Left          = 529
147:             .Width         = 273
148:             .Height        = 80
149:             .ButtonCount   = 4
150:             .BackStyle     = 0
151:             .BorderStyle   = 0
152:             .BorderColor   = RGB(136, 189, 188)
153:             .SpecialEffect = 1
154:             .Themes        = .F.
155:             .Visible       = .T.
156: 
157:             WITH .Buttons(1)
158:                 .Top             = 5
159:                 .Left            = 5
160:                 .Width           = 65
161:                 .Height          = 70
162:                 .Caption         = "Visualizar"
163:                 .FontBold        = .T.
164:                 .FontItalic      = .T.
165:                 .BackColor       = RGB(255, 255, 255)
166:                 .ForeColor       = RGB(90, 90, 90)
167:                 .PicturePosition = 13

*-- Linhas 173 a 187:
173:             ENDWITH
174: 
175:             WITH .Buttons(2)
176:                 .Top             = 5
177:                 .Left            = 71
178:                 .Width           = 65
179:                 .Height          = 70
180:                 .Caption         = "Imprimir"
181:                 .FontName        = "Comic Sans MS"
182:                 .FontBold        = .T.
183:                 .FontItalic      = .T.
184:                 .FontSize        = 8
185:                 .BackColor       = RGB(255, 255, 255)
186:                 .ForeColor       = RGB(90, 90, 90)
187:                 .PicturePosition = 13

*-- Linhas 193 a 207:
193:             ENDWITH
194: 
195:             WITH .Buttons(3)
196:                 .Top             = 5
197:                 .Left            = 137
198:                 .Width           = 65
199:                 .Height          = 70
200:                 .Caption         = "Excel"
201:                 .FontName        = "Comic Sans MS"
202:                 .FontBold        = .T.
203:                 .FontItalic      = .T.
204:                 .FontSize        = 8
205:                 .BackColor       = RGB(255, 255, 255)
206:                 .ForeColor       = RGB(90, 90, 90)
207:                 .PicturePosition = 13

*-- Linhas 213 a 227:
213:             ENDWITH
214: 
215:             WITH .Buttons(4)
216:                 .Top             = 5
217:                 .Left            = 203
218:                 .Width           = 65
219:                 .Height          = 70
220:                 .Caption         = "Sair"
221:                 .FontName        = "Comic Sans MS"
222:                 .FontBold        = .T.
223:                 .FontItalic      = .T.
224:                 .FontSize        = 8
225:                 .BackColor       = RGB(255, 255, 255)
226:                 .ForeColor       = RGB(90, 90, 90)
227:                 .PicturePosition = 13

*-- Linhas 255 a 276:
255: 
256:         loc_oPgf.PageCount = 2
257: 
258:         loc_oPgf.Top    = 85
259:         loc_oPgf.Left   = -1
260:         loc_oPgf.Width  = THIS.Width + 2
261:         loc_oPgf.Height = THIS.Height - 85
262:         loc_oPgf.Tabs   = .F.
263: 
264:         loc_oPgf.Page1.Caption   = "Filtros"
265:         loc_oPgf.Page1.FontName  = "Tahoma"
266:         loc_oPgf.Page1.FontSize  = 8
267:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
268:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
269:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
270: 
271:         loc_oPgf.Page2.Caption   = "Dados"
272:         loc_oPgf.Page2.FontName  = "Tahoma"
273:         loc_oPgf.Page2.FontSize  = 8
274:         loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
275:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
276:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

*-- Linhas 291 a 436:
291:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
292: 
293:         *-- Label "Empresa :"
294:         loc_oPg1.AddObject("lbl_4c_LblEmpresa", "Label")
295:         WITH loc_oPg1.lbl_4c_LblEmpresa
296:             .Top       = 38
297:             .Left      = 214
298:             .AutoSize  = .T.
299:             .Caption   = "Empresa :"
300:             .FontName  = "Tahoma"
301:             .FontSize  = 8
302:             .ForeColor = RGB(90, 90, 90)
303:             .BackStyle = 0
304:             .Visible   = .T.
305:         ENDWITH
306: 
307:         *-- TextBox Codigo Empresa
308:         loc_oPg1.AddObject("txt_4c_CdEmpresa", "TextBox")
309:         WITH loc_oPg1.txt_4c_CdEmpresa
310:             .Top      = 35
311:             .Left     = 267
312:             .Width    = 31
313:             .Height   = 23
314:             .Value    = ""
315:             .FontName = "Tahoma"
316:             .FontSize = 8
317:             .Visible  = .T.
318:         ENDWITH
319: 
320:         *-- TextBox Razao Social Empresa (editavel - busca por nome, como original get_ds_empresa)
321:         loc_oPg1.AddObject("txt_4c_NomEmpresa", "TextBox")
322:         WITH loc_oPg1.txt_4c_NomEmpresa
323:             .Top       = 35
324:             .Left      = 300
325:             .Width     = 289
326:             .Height    = 23
327:             .Value     = ""
328:             .FontName  = "Tahoma"
329:             .FontSize  = 8
330:             .MaxLength = 40
331:             .Visible   = .T.
332:         ENDWITH
333: 
334:         *-- Label "Periodo :"
335:         loc_oPg1.AddObject("lbl_4c_LblPeriodo", "Label")
336:         WITH loc_oPg1.lbl_4c_LblPeriodo
337:             .Top       = 63
338:             .Left      = 219
339:             .AutoSize  = .T.
340:             .Caption   = "Per" + CHR(237) + "odo :"
341:             .FontName  = "Tahoma"
342:             .FontSize  = 8
343:             .ForeColor = RGB(90, 90, 90)
344:             .BackStyle = 0
345:             .Visible   = .T.
346:         ENDWITH
347: 
348:         *-- TextBox Data Inicial
349:         loc_oPg1.AddObject("txt_4c_DtInicial", "TextBox")
350:         WITH loc_oPg1.txt_4c_DtInicial
351:             .Top      = 60
352:             .Left     = 267
353:             .Width    = 80
354:             .Height   = 23
355:             .Value    = {}
356:             .FontName = "Tahoma"
357:             .FontSize = 8
358:             .Visible  = .T.
359:         ENDWITH
360: 
361:         *-- Label separador "a" entre datas
362:         loc_oPg1.AddObject("lbl_4c_LblSep", "Label")
363:         WITH loc_oPg1.lbl_4c_LblSep
364:             .Top       = 63
365:             .Left      = 351
366:             .AutoSize  = .T.
367:             .Caption   = "a"
368:             .FontName  = "Tahoma"
369:             .FontSize  = 8
370:             .ForeColor = RGB(90, 90, 90)
371:             .BackStyle = 0
372:             .Visible   = .T.
373:         ENDWITH
374: 
375:         *-- TextBox Data Final
376:         loc_oPg1.AddObject("txt_4c_DtFinal", "TextBox")
377:         WITH loc_oPg1.txt_4c_DtFinal
378:             .Top      = 60
379:             .Left     = 364
380:             .Width    = 80
381:             .Height   = 23
382:             .Value    = {}
383:             .FontName = "Tahoma"
384:             .FontSize = 8
385:             .Visible  = .T.
386:         ENDWITH
387: 
388:         *-- Label "Tipo :"
389:         loc_oPg1.AddObject("lbl_4c_LblTipo", "Label")
390:         WITH loc_oPg1.lbl_4c_LblTipo
391:             .Top       = 94
392:             .Left      = 235
393:             .AutoSize  = .T.
394:             .Caption   = "Tipo :"
395:             .FontName  = "Tahoma"
396:             .FontSize  = 8
397:             .ForeColor = RGB(90, 90, 90)
398:             .BackStyle = 0
399:             .Visible   = .T.
400:         ENDWITH
401: 
402:         *-- OptionGroup Tipo de Relatorio
403:         loc_oPg1.AddObject("opt_4c_TpRel", "OptionGroup")
404:         loc_oOpt = loc_oPg1.opt_4c_TpRel
405:         WITH loc_oOpt
406:             .Top         = 89
407:             .Left        = 256
408:             .Width       = 155
409:             .Height      = 47
410:             .ButtonCount = 2
411:             .BackStyle   = 0
412:             .BorderStyle = 0
413:             .Value       = 1
414:             .Visible     = .T.
415: 
416:             WITH .Buttons(1)
417:                 .Caption   = "Vis" + CHR(227) + "o Detalhada"
418:                 .Left      = 0
419:                 .Top       = 0
420:                 .Width     = 150
421:                 .Height    = 21
422:                 .FontName  = "Tahoma"
423:                 .FontSize  = 8
424:                 .ForeColor = RGB(90, 90, 90)
425:                 .Visible   = .T.
426:             ENDWITH
427: 
428:             WITH .Buttons(2)
429:                 .Caption   = "Mapa de Fechamento"
430:                 .Left      = 0
431:                 .Top       = 23
432:                 .Width     = 150
433:                 .Height    = 21
434:                 .FontName  = "Tahoma"
435:                 .FontSize  = 8
436:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 455 a 527:
455:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
456: 
457:             *-- Label titulo da secao de configuracao
458:             loc_oPg2.AddObject("lbl_4c_TituloConfig", "Label")
459:             WITH loc_oPg2.lbl_4c_TituloConfig
460:                 .Top       = 15
461:                 .Left      = 214
462:                 .Width     = 350
463:                 .Height    = 18
464:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o de Fechamento (SigCdPam)"
465:                 .FontName  = "Tahoma"
466:                 .FontSize  = 8
467:                 .FontBold  = .T.
468:                 .ForeColor = RGB(90, 90, 90)
469:                 .BackStyle = 0
470:                 .Visible   = .T.
471:             ENDWITH
472: 
473:             *-- Label "Opera" + CHR(231) + CHR(227) + "o :"
474:             loc_oPg2.AddObject("lbl_4c_LblOperacao", "Label")
475:             WITH loc_oPg2.lbl_4c_LblOperacao
476:                 .Top       = 45
477:                 .Left      = 214
478:                 .Width     = 80
479:                 .Height    = 18
480:                 .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
481:                 .FontName  = "Tahoma"
482:                 .FontSize  = 8
483:                 .ForeColor = RGB(90, 90, 90)
484:                 .BackStyle = 0
485:                 .Visible   = .T.
486:             ENDWITH
487: 
488:             *-- TextBox Descricao da Operacao (preenchida via LimparCampos)
489:             loc_oPg2.AddObject("txt_4c_DesOperacao", "TextBox")
490:             WITH loc_oPg2.txt_4c_DesOperacao
491:                 .Top       = 42
492:                 .Left      = 300
493:                 .Width     = 250
494:                 .Height    = 23
495:                 .Value     = ""
496:                 .FontName  = "Tahoma"
497:                 .FontSize  = 8
498:                 .ReadOnly  = .T.
499:                 .BackColor = RGB(240, 240, 240)
500:                 .Visible   = .T.
501:             ENDWITH
502: 
503:             *-- Label "Conserto :"
504:             loc_oPg2.AddObject("lbl_4c_LblConserto", "Label")
505:             WITH loc_oPg2.lbl_4c_LblConserto
506:                 .Top       = 75
507:                 .Left      = 214
508:                 .Width     = 80
509:                 .Height    = 18
510:                 .Caption   = "Conserto :"
511:                 .FontName  = "Tahoma"
512:                 .FontSize  = 8
513:                 .ForeColor = RGB(90, 90, 90)
514:                 .BackStyle = 0
515:                 .Visible   = .T.
516:             ENDWITH
517: 
518:             *-- TextBox Descricao do Conserto (preenchida via LimparCampos)
519:             loc_oPg2.AddObject("txt_4c_DesConserto", "TextBox")
520:             WITH loc_oPg2.txt_4c_DesConserto
521:                 .Top       = 72
522:                 .Left      = 300
523:                 .Width     = 250
524:                 .Height    = 23
525:                 .Value     = ""
526:                 .FontName  = "Tahoma"
527:                 .FontSize  = 8

