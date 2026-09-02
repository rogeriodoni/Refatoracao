# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 155: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 180: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 205: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 255: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 292: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 372: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 397: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormScl.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1164 linhas total):

*-- Linhas 33 a 41:
33:         loc_lSucesso = .F.
34: 
35:         TRY
36:             THIS.Caption = "Situa" + CHR(231) + CHR(227) + "o de Contas"
37: 
38:             THIS.this_oBusinessObject = CREATEOBJECT("SclBO")
39:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
40:                 MsgErro("Erro ao criar SclBO.", "Inicializa" + CHR(231) + CHR(227) + "o")
41:             ELSE

*-- Linhas 64 a 81:
64:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
65:         WITH THIS.pgf_4c_Paginas
66:             .PageCount = 2
67:             .Top       = -29
68:             .Left      = 0
69:             .Width     = THIS.Width
70:             .Height    = THIS.Height + 29
71:             .Tabs      = .F.
72:             .TabStop   = .F.
73:             .Visible   = .T.
74:             .Page1.Caption = "Lista"
75:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
76:             .Page2.Caption = "Dados"
77:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
78:         ENDWITH
79:     ENDPROC
80: 
81:     *--------------------------------------------------------------------------

*-- Linhas 89 a 125:
89:         *-- Cabecalho (cntSombra no legado)
90:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
91:         WITH loc_oPagina.cnt_4c_Cabecalho
92:             .Top         = 31
93:             .Left        = 0
94:             .Width       = THIS.Width
95:             .Height      = 80
96:             .BackColor   = RGB(100, 100, 100)
97:             .BorderWidth = 0
98:             .Visible     = .T.
99:         ENDWITH
100: 
101:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
102:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
103:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o de Contas"
104:             .Top       = 15
105:             .Left      = 10
106:             .Width     = 769
107:             .Height    = 40
108:             .FontName  = "Tahoma"
109:             .FontSize  = 16
110:             .FontBold  = .T.
111:             .ForeColor = RGB(0, 0, 0)
112:             .BackStyle = 0
113:             .Visible   = .T.
114:         ENDWITH
115: 
116:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
117:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
118:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o de Contas"
119:             .Top       = 18
120:             .Left      = 10
121:             .Width     = 769
122:             .Height    = 46
123:             .FontName  = "Tahoma"
124:             .FontSize  = 16
125:             .FontBold  = .T.

*-- Linhas 131 a 317:
131:         *-- Container botoes CRUD (Grupo_op no legado, Left=544 original -> canonico Left=542)
132:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
133:         WITH loc_oPagina.cnt_4c_Botoes
134:             .Top         = 29
135:             .Left        = 542
136:             .Width       = 385
137:             .Height      = 85
138:             .BackStyle = 0
139:             .BorderWidth = 0
140:             .Visible     = .T.
141:         ENDWITH
142: 
143:         *-- Botao Incluir
144:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
145:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
146:             .Caption         = "Incluir"
147:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
148:             .PicturePosition = 13
149:             .Top             = 5
150:             .Left            = 5
151:             .Width           = 75
152:             .Height          = 75
153:             .BackColor       = RGB(255, 255, 255)
154:             .ForeColor       = RGB(90, 90, 90)
155:             .FontName        = "Comic Sans MS"
156:             .FontSize        = 8
157:             .FontBold        = .T.
158:             .FontItalic      = .T.
159:             .Themes          = .F.
160:             .SpecialEffect   = 0
161:             .MousePointer    = 15
162:             .WordWrap        = .T.
163:             .AutoSize        = .F.
164:             .Visible         = .T.
165:         ENDWITH
166:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
167: 
168:         *-- Botao Visualizar
169:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
170:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
171:             .Caption         = "Visualizar"
172:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
173:             .PicturePosition = 13
174:             .Top             = 5
175:             .Left            = 80
176:             .Width           = 75
177:             .Height          = 75
178:             .BackColor       = RGB(255, 255, 255)
179:             .ForeColor       = RGB(90, 90, 90)
180:             .FontName        = "Comic Sans MS"
181:             .FontSize        = 8
182:             .FontBold        = .T.
183:             .FontItalic      = .T.
184:             .Themes          = .F.
185:             .SpecialEffect   = 0
186:             .MousePointer    = 15
187:             .WordWrap        = .T.
188:             .AutoSize        = .F.
189:             .Visible         = .T.
190:         ENDWITH
191:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
192: 
193:         *-- Botao Alterar
194:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
195:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
196:             .Caption         = "Alterar"
197:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
198:             .PicturePosition = 13
199:             .Top             = 5
200:             .Left            = 155
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
216:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
217: 
218:         *-- Botao Excluir
219:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
220:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
221:             .Caption         = "Excluir"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
223:             .PicturePosition = 13
224:             .Top             = 5
225:             .Left            = 230
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
241:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
242: 
243:         *-- Botao Buscar
244:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
245:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
246:             .Caption         = "Buscar"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 305
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
266:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
267: 
268:         *-- Container saida canonico (CLAUDE.md regra #10 - prevalece sobre legado)
269:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
270:         WITH loc_oPagina.cnt_4c_Saida
271:             .Top         = 29
272:             .Left        = 917
273:             .Width       = 90
274:             .Height      = 85
275:             .BackStyle   = 0
276:             .BorderWidth = 0
277:             .Visible     = .T.
278:         ENDWITH
279: 
280:         *-- Botao Encerrar (canonico)
281:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
282:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
283:             .Caption         = "Encerrar"
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
285:             .PicturePosition = 13
286:             .Top             = 5
287:             .Left            = 5
288:             .Width           = 75
289:             .Height          = 75
290:             .BackColor       = RGB(255, 255, 255)
291:             .ForeColor       = RGB(90, 90, 90)
292:             .FontName        = "Comic Sans MS"
293:             .FontSize        = 8
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .MousePointer    = 15
299:             .WordWrap        = .T.
300:             .AutoSize        = .F.
301:             .Visible         = .T.
302:         ENDWITH
303:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
304: 
305:         *-- Grid de listagem (Grade no legado: top=98, left=29, width=941, height=487)
306:         *-- Top compensado: 98 + 29 = 127 (PageFrame.Top = -29)
307:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
308:         *-- ColumnCount FORA de WITH para colunas serem criadas imediatamente (Problema 36)
309:         loc_oPagina.grd_4c_Lista.ColumnCount = 4
310:         WITH loc_oPagina.grd_4c_Lista
311:             .Top                = 127
312:             .Left               = 29
313:             .Width              = 941
314:             .Height             = 487
315:             .FontName           = "Verdana"
316:             .FontSize           = 8
317:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 349 a 823:
349:         *-- Top compensado: -3+29=26
350:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
351:         WITH loc_oPagina.cnt_4c_Salva
352:             .Top         = 26
353:             .Left        = 843
354:             .Width       = 160
355:             .Height      = 85
356:             .BackStyle   = 0
357:             .Visible     = .T.
358:         ENDWITH
359: 
360:         *-- Botao Confirmar (Salvar)
361:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
362:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
363:             .Caption         = "Confirmar"
364:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
365:             .PicturePosition = 13
366:             .Top             = 5
367:             .Left            = 5
368:             .Width           = 75
369:             .Height          = 75
370:             .BackColor       = RGB(255, 255, 255)
371:             .ForeColor       = RGB(90, 90, 90)
372:             .FontName        = "Comic Sans MS"
373:             .FontSize        = 8
374:             .FontBold        = .T.
375:             .FontItalic      = .T.
376:             .Themes          = .F.
377:             .SpecialEffect   = 0
378:             .MousePointer    = 15
379:             .WordWrap        = .T.
380:             .AutoSize        = .F.
381:             .Visible         = .T.
382:         ENDWITH
383:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
384: 
385:         *-- Botao Cancelar
386:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
387:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
388:             .Caption         = "Encerrar"
389:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
390:             .PicturePosition = 13
391:             .Top             = 5
392:             .Left            = 80
393:             .Width           = 75
394:             .Height          = 75
395:             .BackColor       = RGB(255, 255, 255)
396:             .ForeColor       = RGB(90, 90, 90)
397:             .FontName        = "Comic Sans MS"
398:             .FontSize        = 8
399:             .FontBold        = .T.
400:             .FontItalic      = .T.
401:             .Themes          = .F.
402:             .SpecialEffect   = 0
403:             .MousePointer    = 15
404:             .WordWrap        = .T.
405:             .AutoSize        = .F.
406:             .Visible         = .T.
407:         ENDWITH
408:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
409: 
410:         *-- Codigo (Get_Codigo: legado top=151, left=251, w=31 -> top compensado=180)
411:         loc_oPagina.AddObject("lbl_4c_Codigo_label", "Label")
412:         WITH loc_oPagina.lbl_4c_Codigo_label
413:             .Caption   = "C" + CHR(243) + "digo :"
414:             .Top       = 184
415:             .Left      = 207
416:             .Width     = 45
417:             .Height    = 17
418:             .FontName  = "Tahoma"
419:             .FontSize  = 8
420:             .ForeColor = RGB(90, 90, 90)
421:             .BackStyle = 0
422:             .Visible   = .T.
423:         ENDWITH
424: 
425:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
426:         WITH loc_oPagina.txt_4c_Codigo
427:             .Value     = ""
428:             .Top       = 180
429:             .Left      = 251
430:             .Width     = 31
431:             .Height    = 23
432:             .MaxLength = 3
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .Visible   = .T.
436:         ENDWITH
437: 
438:         *-- Movimentacao (op_com: legado top=155, left=631, w=116 -> top compensado=184)
439:         loc_oPagina.AddObject("lbl_4c_Movimentacao_label", "Label")
440:         WITH loc_oPagina.lbl_4c_Movimentacao_label
441:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
442:             .Top       = 189
443:             .Left      = 555
444:             .Width     = 78
445:             .Height    = 15
446:             .FontName  = "Tahoma"
447:             .FontSize  = 8
448:             .ForeColor = RGB(90, 90, 90)
449:             .BackStyle = 0
450:             .Visible   = .T.
451:         ENDWITH
452: 
453:         loc_oPagina.AddObject("opt_4c_Movimentacao", "OptionGroup")
454:         WITH loc_oPagina.opt_4c_Movimentacao
455:             .ButtonCount = 2
456:             .Top         = 184
457:             .Left        = 631
458:             .Width       = 116
459:             .Height      = 25
460:             .BackStyle   = 0
461:             .BorderStyle = 0
462:             .Value       = 1
463:             .Visible     = .T.
464:         ENDWITH
465:         WITH loc_oPagina.opt_4c_Movimentacao.Buttons(1)
466:             .Caption   = "Sim"
467:             .BackStyle = 0
468:             .Left      = 5
469:             .Top       = 5
470:             .Width     = 40
471:             .AutoSize  = .T.
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .ForeColor = RGB(90, 90, 90)
475:         ENDWITH
476:         WITH loc_oPagina.opt_4c_Movimentacao.Buttons(2)
477:             .Caption   = "N" + CHR(227) + "o"
478:             .BackStyle = 0
479:             .Left      = 48
480:             .Top       = 5
481:             .Width     = 40
482:             .AutoSize  = .T.
483:             .FontName  = "Tahoma"
484:             .FontSize  = 8
485:             .ForeColor = RGB(90, 90, 90)
486:         ENDWITH
487: 
488:         *-- Descricao (Get_Descr: legado top=176, left=251, w=220 -> top compensado=205)
489:         loc_oPagina.AddObject("lbl_4c_Descr_label", "Label")
490:         WITH loc_oPagina.lbl_4c_Descr_label
491:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
492:             .Top       = 209
493:             .Left      = 194
494:             .Width     = 55
495:             .Height    = 17
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .ForeColor = RGB(90, 90, 90)
499:             .BackStyle = 0
500:             .Visible   = .T.
501:         ENDWITH
502: 
503:         loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
504:         WITH loc_oPagina.txt_4c_Descr
505:             .Value     = ""
506:             .Top       = 205
507:             .Left      = 251
508:             .Width     = 220
509:             .Height    = 23
510:             .MaxLength = 30
511:             .FontName  = "Tahoma"
512:             .FontSize  = 8
513:             .Visible   = .T.
514:         ENDWITH
515: 
516:         *-- Bloquear Movimentacao (op_blqMov: legado top=180, left=631, w=276, 3 btns -> top=209)
517:         loc_oPagina.AddObject("lbl_4c_BlqMov_label", "Label")
518:         WITH loc_oPagina.lbl_4c_BlqMov_label
519:             .Caption   = "Bloquear Movimenta" + CHR(231) + CHR(227) + "o :"
520:             .Top       = 214
521:             .Left      = 510
522:             .Width     = 123
523:             .Height    = 15
524:             .FontName  = "Tahoma"
525:             .FontSize  = 8
526:             .ForeColor = RGB(90, 90, 90)
527:             .BackStyle = 0
528:             .Visible   = .T.
529:         ENDWITH
530: 
531:         loc_oPagina.AddObject("opt_4c_BlqMov", "OptionGroup")
532:         WITH loc_oPagina.opt_4c_BlqMov
533:             .ButtonCount = 3
534:             .Top         = 209
535:             .Left        = 631
536:             .Width       = 276
537:             .Height      = 25
538:             .BackStyle   = 0
539:             .BorderStyle = 0
540:             .Value       = 1
541:             .Visible     = .T.
542:         ENDWITH
543:         WITH loc_oPagina.opt_4c_BlqMov.Buttons(1)
544:             .Caption   = "Sim"
545:             .BackStyle = 0
546:             .Left      = 5
547:             .Top       = 5
548:             .Width     = 40
549:             .AutoSize  = .T.
550:             .FontName  = "Tahoma"
551:             .FontSize  = 8
552:             .ForeColor = RGB(90, 90, 90)
553:         ENDWITH
554:         WITH loc_oPagina.opt_4c_BlqMov.Buttons(2)
555:             .Caption   = "N" + CHR(227) + "o"
556:             .BackStyle = 0
557:             .Left      = 48
558:             .Top       = 5
559:             .Width     = 40
560:             .AutoSize  = .T.
561:             .FontName  = "Tahoma"
562:             .FontSize  = 8
563:             .ForeColor = RGB(90, 90, 90)
564:         ENDWITH
565:         WITH loc_oPagina.opt_4c_BlqMov.Buttons(3)
566:             .Caption   = "Verifica Cond. Pagto."
567:             .BackStyle = 0
568:             .Left      = 90
569:             .Top       = 5
570:             .Width     = 170
571:             .AutoSize  = .T.
572:             .FontName  = "Tahoma"
573:             .FontSize  = 8
574:             .ForeColor = RGB(90, 90, 90)
575:         ENDWITH
576: 
577:         *-- Descricao Para Movimentacoes (get_Descr2: legado top=201, left=251, w=220 -> top=230)
578:         loc_oPagina.AddObject("lbl_4c_Descr2_label", "Label")
579:         WITH loc_oPagina.lbl_4c_Descr2_label
580:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Para Movimenta" + ;
581:                          CHR(231) + CHR(245) + "es :"
582:             .Top       = 234
583:             .Left      = 92
584:             .Width     = 155
585:             .Height    = 17
586:             .FontName  = "Tahoma"
587:             .FontSize  = 8
588:             .ForeColor = RGB(90, 90, 90)
589:             .BackStyle = 0
590:             .Visible   = .T.
591:         ENDWITH
592: 
593:         loc_oPagina.AddObject("txt_4c_Descr2", "TextBox")
594:         WITH loc_oPagina.txt_4c_Descr2
595:             .Value     = ""
596:             .Top       = 230
597:             .Left      = 251
598:             .Width     = 220
599:             .Height    = 23
600:             .MaxLength = 30
601:             .FontName  = "Tahoma"
602:             .FontSize  = 8
603:             .Visible   = .T.
604:         ENDWITH
605: 
606:         *-- Bloquear Desconto (fwoption1: legado top=205, left=631, w=116 -> top compensado=234)
607:         loc_oPagina.AddObject("lbl_4c_BlqDesconto_label", "Label")
608:         WITH loc_oPagina.lbl_4c_BlqDesconto_label
609:             .Caption   = "Bloquear Desconto :"
610:             .Top       = 239
611:             .Left      = 534
612:             .Width     = 99
613:             .Height    = 15
614:             .FontName  = "Tahoma"
615:             .FontSize  = 8
616:             .ForeColor = RGB(90, 90, 90)
617:             .BackStyle = 0
618:             .Visible   = .T.
619:         ENDWITH
620: 
621:         loc_oPagina.AddObject("opt_4c_BlqDesconto", "OptionGroup")
622:         WITH loc_oPagina.opt_4c_BlqDesconto
623:             .ButtonCount = 2
624:             .Top         = 234
625:             .Left        = 631
626:             .Width       = 116
627:             .Height      = 25
628:             .BackStyle   = 0
629:             .BorderStyle = 0
630:             .Value       = 1
631:             .Visible     = .T.
632:         ENDWITH
633:         WITH loc_oPagina.opt_4c_BlqDesconto.Buttons(1)
634:             .Caption   = "Sim"
635:             .BackStyle = 0
636:             .Left      = 5
637:             .Top       = 5
638:             .Width     = 40
639:             .AutoSize  = .T.
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8
642:             .ForeColor = RGB(90, 90, 90)
643:         ENDWITH
644:         WITH loc_oPagina.opt_4c_BlqDesconto.Buttons(2)
645:             .Caption   = "N" + CHR(227) + "o"
646:             .BackStyle = 0
647:             .Left      = 48
648:             .Top       = 5
649:             .Width     = 40
650:             .AutoSize  = .T.
651:             .FontName  = "Tahoma"
652:             .FontSize  = 8
653:             .ForeColor = RGB(90, 90, 90)
654:         ENDWITH
655: 
656:         *-- Mala Direta (getMalad: legado top=226, left=251, w=19 -> top compensado=255)
657:         loc_oPagina.AddObject("lbl_4c_Say3", "Label")
658:         WITH loc_oPagina.lbl_4c_Say3
659:             .Caption   = "Mala Direta :"
660:             .Top       = 259
661:             .Left      = 186
662:             .Width     = 70
663:             .Height    = 17
664:             .FontName  = "Tahoma"
665:             .FontSize  = 8
666:             .ForeColor = RGB(90, 90, 90)
667:             .BackStyle = 0
668:             .Visible   = .T.
669:         ENDWITH
670: 
671:         loc_oPagina.AddObject("txt_4c_Malad", "TextBox")
672:         WITH loc_oPagina.txt_4c_Malad
673:             .Value         = ""
674:             .Top           = 255
675:             .Left          = 251
676:             .Width         = 19
677:             .Height        = 23
678:             .MaxLength     = 1
679:             .Format        = "M"
680:             .InputMask     = "S,N, "
681:             .FontName      = "Tahoma"
682:             .FontSize      = 8
683:             .SpecialEffect = 1
684:             .Visible       = .T.
685:         ENDWITH
686: 
687:         *-- Prioridade (fwget1: legado top=252, left=251, w=31 -> top compensado=281)
688:         loc_oPagina.AddObject("lbl_4c_Say4", "Label")
689:         WITH loc_oPagina.lbl_4c_Say4
690:             .Caption   = "Prioridade :"
691:             .Top       = 286
692:             .Left      = 192
693:             .Width     = 60
694:             .Height    = 17
695:             .FontName  = "Tahoma"
696:             .FontSize  = 8
697:             .ForeColor = RGB(90, 90, 90)
698:             .BackStyle = 0
699:             .Visible   = .T.
700:         ENDWITH
701: 
702:         loc_oPagina.AddObject("txt_4c_Priors", "TextBox")
703:         WITH loc_oPagina.txt_4c_Priors
704:             .Value         = 0
705:             .Top           = 281
706:             .Left          = 251
707:             .Width         = 31
708:             .Height        = 23
709:             .MaxLength     = 3
710:             .InputMask     = "999"
711:             .FontName      = "Tahoma"
712:             .FontSize      = 8
713:             .SpecialEffect = 1
714:             .Visible       = .T.
715:         ENDWITH
716: 
717:         *-- Tipo (optAutos: legado top=229, left=631, w=151 -> top compensado=258)
718:         loc_oPagina.AddObject("lbl_4c_Say5", "Label")
719:         WITH loc_oPagina.lbl_4c_Say5
720:             .Caption   = "Tipo :"
721:             .Top       = 263
722:             .Left      = 604
723:             .Width     = 29
724:             .Height    = 15
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .ForeColor = RGB(90, 90, 90)
728:             .BackStyle = 0
729:             .Visible   = .T.
730:         ENDWITH
731: 
732:         loc_oPagina.AddObject("opt_4c_Autos", "OptionGroup")
733:         WITH loc_oPagina.opt_4c_Autos
734:             .ButtonCount = 2
735:             .Top         = 258
736:             .Left        = 631
737:             .Width       = 151
738:             .Height      = 25
739:             .BackStyle   = 0
740:             .BorderStyle = 0
741:             .Value       = 1
742:             .Visible     = .T.
743:         ENDWITH
744:         WITH loc_oPagina.opt_4c_Autos.Buttons(1)
745:             .Caption   = "Normal"
746:             .BackStyle = 0
747:             .Left      = 5
748:             .Top       = 5
749:             .AutoSize  = .T.
750:             .FontName  = "Tahoma"
751:             .FontSize  = 8
752:             .ForeColor = RGB(90, 90, 90)
753:         ENDWITH
754:         WITH loc_oPagina.opt_4c_Autos.Buttons(2)
755:             .Caption   = "Autom" + CHR(225) + "tica"
756:             .BackStyle = 0
757:             .Left      = 74
758:             .Top       = 5
759:             .AutoSize  = .T.
760:             .FontName  = "Tahoma"
761:             .FontSize  = 8
762:             .ForeColor = RGB(90, 90, 90)
763:         ENDWITH
764: 
765:         *-- Exibe dados da Ultima Compra (Fwoption2: legado top=251, left=632, w=116 -> top=280)
766:         loc_oPagina.AddObject("lbl_4c_Say7", "Label")
767:         WITH loc_oPagina.lbl_4c_Say7
768:             .Caption   = "Exibe dados da Ultima Compra :"
769:             .Top       = 286
770:             .Left      = 479
771:             .Width     = 154
772:             .Height    = 15
773:             .FontName  = "Tahoma"
774:             .FontSize  = 8
775:             .ForeColor = RGB(90, 90, 90)
776:             .BackStyle = 0
777:             .Visible   = .T.
778:         ENDWITH
779: 
780:         loc_oPagina.AddObject("opt_4c_UltCompra", "OptionGroup")
781:         WITH loc_oPagina.opt_4c_UltCompra
782:             .ButtonCount = 2
783:             .Top         = 280
784:             .Left        = 632
785:             .Width       = 116
786:             .Height      = 25
787:             .BackStyle   = 0
788:             .BorderStyle = 0
789:             .Value       = 1
790:             .Visible     = .T.
791:         ENDWITH
792:         WITH loc_oPagina.opt_4c_UltCompra.Buttons(1)
793:             .Caption   = "Sim"
794:             .BackStyle = 0
795:             .Left      = 5
796:             .Top       = 5
797:             .AutoSize  = .T.
798:             .FontName  = "Tahoma"
799:             .FontSize  = 8
800:             .ForeColor = RGB(90, 90, 90)
801:         ENDWITH
802:         WITH loc_oPagina.opt_4c_UltCompra.Buttons(2)
803:             .Caption   = "N" + CHR(227) + "o"
804:             .BackStyle = 0
805:             .Left      = 74
806:             .Top       = 5
807:             .AutoSize  = .T.
808:             .FontName  = "Tahoma"
809:             .FontSize  = 8
810:             .ForeColor = RGB(90, 90, 90)
811:         ENDWITH
812: 
813:         *-- Label informativa [999] Situacao Liberada (Label1: legado top=256, left=286 -> top=285)
814:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
815:         WITH loc_oPagina.lbl_4c_Label1
816:             .Caption   = "[999] Situa" + CHR(231) + CHR(227) + "o Liberada"
817:             .Top       = 285
818:             .Left      = 286
819:             .Width     = 116
820:             .Height    = 15
821:             .AutoSize  = .T.
822:             .FontName  = "Tahoma"
823:             .FontSize  = 8

*-- Linhas 855 a 866:
855:                 loc_oGrid.Column3.Width = 240
856:                 loc_oGrid.Column4.Width = 70
857:                 *-- Headers APOS RecordSource (Problema 32 - reset de captions)
858:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
859:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
860:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o 2"
861:                 loc_oGrid.Column4.Header1.Caption = "Mala Direta"
862:                 THIS.FormatarGridLista(loc_oGrid)
863:                 THIS.AjustarBotoesPorModo()
864:                 loc_lResultado = .T.
865:             ENDIF
866:         CATCH TO loException

*-- Linhas 919 a 927:
919:             THIS.BOParaForm()
920:             THIS.HabilitarCampos(.F.)
921:             THIS.AlternarPagina(2)
922:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
923:         ELSE
924:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
925:         ENDIF
926:     ENDPROC
927: 

*-- Linhas 960 a 968:
960:             THIS.BOParaForm()
961:             THIS.HabilitarCampos(.F.)
962:             THIS.AlternarPagina(2)
963:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
964:         ELSE
965:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Excluir")
966:         ENDIF
967:     ENDPROC
968: 

*-- Linhas 1129 a 1150:
1129:         loc_oPg2.opt_4c_UltCompra.Enabled      = par_lHabilitar
1130: 
1131:         *-- Confirmar: habilitado em INCLUIR/ALTERAR e tambem em EXCLUIR (para confirmar exclusao)
1132:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar OR ;
1133:             (THIS.this_cModoAtual = "EXCLUIR")
1134:     ENDPROC
1135: 
1136:     *--------------------------------------------------------------------------
1137:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1138:         LOCAL loc_oPg1, loc_lTemRegistro
1139:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1140:         loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
1141:                            RECCOUNT("cursor_4c_Dados") > 0 AND ;
1142:                            !EOF("cursor_4c_Dados")
1143:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1144:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1145:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1146:     ENDPROC
1147: 
1148:     *--------------------------------------------------------------------------
1149:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1150:         WITH par_oGrid


### BO (C:\4c\projeto\app\classes\SclBO.prg):
*==============================================================================
* SclBO.prg - Business Object para Situacao de Contas
* Tabela: SigCdCst | PK: codigos
*==============================================================================

DEFINE CLASS SclBO AS BusinessBase

    *-- Propriedades - SigCdCst
    this_cCodigos  = ""    && codigos  char(3)
    this_cDescrs   = ""    && descrs   char(30)
    this_cDescr2s  = ""    && descr2s  char(30) - Descricao Para Movimentacoes
    this_cMalads   = ""    && cmalads  char(1)  - Mala Direta (S/N)
    this_nDispMovs = 0     && dispmovs numeric(1,0) - Movimentacao (0=Sim 1=Nao)
    this_nPriors   = 0     && priors   numeric(3,0) - Prioridade
    this_nAutos    = 0     && autos    numeric(1,0) - Tipo (0=Normal 1=Automatica)
    this_nBlqMovs  = 0     && blqmovs  numeric(1,0) - Bloquear Movimentacao (0=Sim 1=Nao 2=VerificaCondPagto)
    this_nBlqDescs = 0     && blqdescs numeric(1,0) - Bloquear Desconto (0=Sim 1=Nao)
    this_nUltCompra = 0    && ultcompra numeric(6,3) - Exibe dados Ultima Compra (0=Sim 1=Nao)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCst"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos   = TratarNulo(codigos,   "C")
            THIS.this_cDescrs    = TratarNulo(descrs,    "C")
            THIS.this_cDescr2s   = TratarNulo(descr2s,   "C")
            THIS.this_cMalads    = TratarNulo(cmalads,   "C")
            THIS.this_nDispMovs  = TratarNulo(dispmovs,  "N")
            THIS.this_nPriors    = TratarNulo(priors,    "N")
            THIS.this_nAutos     = TratarNulo(autos,     "N")
            THIS.this_nBlqMovs   = TratarNulo(blqmovs,   "N")
            THIS.this_nBlqDescs  = TratarNulo(blqdescs,  "N")
            THIS.this_nUltCompra = TratarNulo(ultcompra, "N")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT codigos, descrs, descr2s, cmalads," + ;
                       " dispmovs, priors, autos, blqmovs, blqdescs, ultcompra" + ;
                       " FROM SigCdCst"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT codigos, descrs, descr2s, cmalads," + ;
                       " dispmovs, priors, autos, blqmovs, blqdescs, ultcompra" + ;
                       " FROM SigCdCst WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Validar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !INLIST(UPPER(ALLTRIM(THIS.this_cMalads)), "S", "N")
            MsgAviso("Especifica" + CHR(231) + CHR(227) + "o da Mala Direta Inv" + CHR(225) + "lida, Apenas [S]im ou [N]" + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdCst" + ;
                       " (codigos, descrs, descr2s, cmalads," + ;
                       " dispmovs, priors, autos, blqmovs, blqdescs, ultcompra)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)             + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)              + ", " + ;
                       EscaparSQL(THIS.this_cDescr2s)             + ", " + ;
                       EscaparSQL(UPPER(THIS.this_cMalads))       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDispMovs)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPriors)        + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutos)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqMovs)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqDescs)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUltCompra)     + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCst SET" + ;
                       " descrs   = " + EscaparSQL(THIS.this_cDescrs)              + ", " + ;
                       " descr2s  = " + EscaparSQL(THIS.this_cDescr2s)             + ", " + ;
                       " cmalads  = " + EscaparSQL(UPPER(THIS.this_cMalads))       + ", " + ;
                       " dispmovs = " + FormatarNumeroSQL(THIS.this_nDispMovs)      + ", " + ;
                       " priors   = " + FormatarNumeroSQL(THIS.this_nPriors)        + ", " + ;
                       " autos    = " + FormatarNumeroSQL(THIS.this_nAutos)         + ", " + ;
                       " blqmovs  = " + FormatarNumeroSQL(THIS.this_nBlqMovs)       + ", " + ;
                       " blqdescs = " + FormatarNumeroSQL(THIS.this_nBlqDescs)      + ", " + ;
                       " ultcompra= " + FormatarNumeroSQL(THIS.this_nUltCompra)     + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCst WHERE codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir Situa" + CHR(231) + CHR(227) + "o de Contas:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

