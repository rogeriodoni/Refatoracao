# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 180: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 203: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 226: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 249: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 272: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 308: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 387: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 410: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formgpr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1986 linhas total):

*-- Linhas 47 a 56:
47:                 THIS.ConfigurarPaginaLista()
48:                 THIS.ConfigurarPaginaDados()
49: 
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52: 
53:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
54:                     IF !THIS.CarregarLista()
55:                         *-- Falha ao carregar nao impede abertura do formulario
56:                     ENDIF

*-- Linhas 74 a 150:
74: 
75:     *--------------------------------------------------------------------------
76:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
77:     * PageFrame.Top = -29 (canonico) para esconder abas
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81:         WITH THIS.pgf_4c_Paginas
82:             .Top       = -29
83:             .Left      = 0
84:             .Width     = 1003
85:             .Height    = 629
86:             .PageCount = 2
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98:     ENDPROC
99: 
100:     *--------------------------------------------------------------------------
101:     * ConfigurarPaginaLista - Page1: cabecalho, container botoes e saida
102:     * Todos os Top compensados +29 (PageFrame.Top=-29)
103:     * Original: cntSombra.Top=1, Grupo_op.Top=0, Grupo_Saida.Left=918
104:     *--------------------------------------------------------------------------
105:     PROTECTED PROCEDURE ConfigurarPaginaLista()
106:         LOCAL loc_oPagina
107:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
108: 
109:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
110:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111: 
112:         *-- Container cabecalho escuro (cntSombra: Top=1+29=30, Width=1008 do original)
113:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
114:         WITH loc_oPagina.cnt_4c_Cabecalho
115:             .Top         = 30
116:             .Left        = 0
117:             .Width       = 1008
118:             .Height      = 80
119:             .BackColor   = RGB(100, 100, 100)
120:             .BackStyle   = 1
121:             .BorderWidth = 0
122:             .Visible     = .T.
123:         ENDWITH
124: 
125:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
126:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
127:             .Caption   = "Cadastro de Grande Grupo"
128:             .Top       = 15
129:             .Left      = 10
130:             .Width     = THIS.Width
131:             .Height    = 40
132:             .AutoSize  = .F.
133:             .FontName  = "Tahoma"
134:             .FontSize  = 16
135:             .FontBold  = .T.
136:             .BackStyle = 0
137:             .ForeColor = RGB(0, 0, 0)
138:             .Visible   = .T.
139:         ENDWITH
140: 
141:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
143:             .Caption   = "Cadastro de Grande Grupo"
144:             .Top       = 18
145:             .Left      = 10
146:             .Width     = THIS.Width
147:             .Height    = 46
148:             .AutoSize  = .F.
149:             .FontName  = "Tahoma"
150:             .FontSize  = 16

*-- Linhas 157 a 329:
157:         *-- Container botoes CRUD (Grupo_op: Left=512, Top=0+29=29, Width=414, Height=85)
158:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
159:         WITH loc_oPagina.cnt_4c_Botoes
160:             .Top         = 29
161:             .Left        =  542
162:             .Width       = 414
163:             .Height      = 85
164:             .BackStyle   = 0
165:             .BorderWidth = 0
166:             .Visible     = .T.
167:         ENDWITH
168: 
169:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
170:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
171:             .Caption         = "Incluir"
172:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
173:             .PicturePosition = 13
174:             .Top             = 5
175:             .Left            = 5
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
188:             .Visible         = .T.
189:         ENDWITH
190:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
191: 
192:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
193:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
194:             .Caption         = "Visualizar"
195:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
196:             .PicturePosition = 13
197:             .Top             = 5
198:             .Left            = 80
199:             .Width           = 75
200:             .Height          = 75
201:             .BackColor       = RGB(255, 255, 255)
202:             .ForeColor       = RGB(90, 90, 90)
203:             .FontName        = "Comic Sans MS"
204:             .FontSize        = 8
205:             .FontBold        = .T.
206:             .FontItalic      = .T.
207:             .Themes          = .F.
208:             .SpecialEffect   = 0
209:             .MousePointer    = 15
210:             .WordWrap        = .T.
211:             .Visible         = .T.
212:         ENDWITH
213:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
214: 
215:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
216:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
217:             .Caption         = "Alterar"
218:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
219:             .PicturePosition = 13
220:             .Top             = 5
221:             .Left            = 155
222:             .Width           = 75
223:             .Height          = 75
224:             .BackColor       = RGB(255, 255, 255)
225:             .ForeColor       = RGB(90, 90, 90)
226:             .FontName        = "Comic Sans MS"
227:             .FontSize        = 8
228:             .FontBold        = .T.
229:             .FontItalic      = .T.
230:             .Themes          = .F.
231:             .SpecialEffect   = 0
232:             .MousePointer    = 15
233:             .WordWrap        = .T.
234:             .Visible         = .T.
235:         ENDWITH
236:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
237: 
238:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
239:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
240:             .Caption         = "Excluir"
241:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
242:             .PicturePosition = 13
243:             .Top             = 5
244:             .Left            = 230
245:             .Width           = 75
246:             .Height          = 75
247:             .BackColor       = RGB(255, 255, 255)
248:             .ForeColor       = RGB(90, 90, 90)
249:             .FontName        = "Comic Sans MS"
250:             .FontSize        = 8
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
253:             .Themes          = .F.
254:             .SpecialEffect   = 0
255:             .MousePointer    = 15
256:             .WordWrap        = .T.
257:             .Visible         = .T.
258:         ENDWITH
259:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
260: 
261:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
262:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
263:             .Caption         = "Buscar"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
265:             .PicturePosition = 13
266:             .Top             = 5
267:             .Left            = 305
268:             .Width           = 75
269:             .Height          = 75
270:             .BackColor       = RGB(255, 255, 255)
271:             .ForeColor       = RGB(90, 90, 90)
272:             .FontName        = "Comic Sans MS"
273:             .FontSize        = 8
274:             .FontBold        = .T.
275:             .FontItalic      = .T.
276:             .Themes          = .F.
277:             .SpecialEffect   = 0
278:             .MousePointer    = 15
279:             .WordWrap        = .T.
280:             .Visible         = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
283: 
284:         *-- Container saida canonico (CLAUDE.md #10: Left=917, Width=90, Height=85)
285:         *-- Grupo_Saida.Left=918 no original -> usar 917 canonico
286:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
287:         WITH loc_oPagina.cnt_4c_Saida
288:             .Top         = 29
289:             .Left        = 917
290:             .Width       = 90
291:             .Height      = 85
292:             .BackStyle   = 0
293:             .BorderWidth = 0
294:             .Visible     = .T.
295:         ENDWITH
296: 
297:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
298:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
299:             .Caption         = "Encerrar"
300:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
301:             .PicturePosition = 13
302:             .Top             = 5
303:             .Left            = 5
304:             .Width           = 75
305:             .Height          = 75
306:             .BackColor       = RGB(255, 255, 255)
307:             .ForeColor       = RGB(90, 90, 90)
308:             .FontName        = "Comic Sans MS"
309:             .FontSize        = 8
310:             .FontBold        = .T.
311:             .FontItalic      = .T.
312:             .Themes          = .F.
313:             .SpecialEffect   = 0
314:             .MousePointer    = 15
315:             .WordWrap        = .T.
316:             .Visible         = .T.
317:         ENDWITH
318:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
319: 
320:         *-- Grid de lista (Grade legado: top=121+29=150, left=12, width=939, height=470)
321:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
322:         WITH loc_oPagina.grd_4c_Lista
323:             .Top                = 150
324:             .Left               = 12
325:             .Width              = 939
326:             .Height             = 470
327:             .ColumnCount        = 3
328:             .FontName           = "Verdana"
329:             .FontSize           = 8

*-- Linhas 352 a 452:
352:     * ConfigurarPaginaDados - Page2: botoes + primeira metade dos campos
353:     * Grupo_Salva: Left=816, Top=9+29=38, Width=165, Height=85
354:     * Fase 5/8: txt_4c_Codigos ate opt_4c_AlteEtiq (Top original 85-225)
355:     * Todos os Top compensados +29 (PageFrame.Top=-29)
356:     *--------------------------------------------------------------------------
357:     PROTECTED PROCEDURE ConfigurarPaginaDados()
358:         LOCAL loc_oPagina
359:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
360: 
361:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
362:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
363: 
364:         *-- Container salvar/cancelar (Grupo_Salva: Left=816, Top=9+29=38)
365:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
366:         WITH loc_oPagina.cnt_4c_Salva
367:             .Top         = 38
368:             .Left        = 816
369:             .Width       = 165
370:             .Height      = 85
371:             .BackStyle   = 0
372:             .BorderWidth = 0
373:             .Visible     = .T.
374:         ENDWITH
375: 
376:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
377:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
378:             .Caption         = "Confirmar"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
380:             .PicturePosition = 13
381:             .Top             = 5
382:             .Left            = 5
383:             .Width           = 75
384:             .Height          = 75
385:             .BackColor       = RGB(255, 255, 255)
386:             .ForeColor       = RGB(90, 90, 90)
387:             .FontName        = "Comic Sans MS"
388:             .FontSize        = 8
389:             .FontBold        = .T.
390:             .FontItalic      = .T.
391:             .Themes          = .F.
392:             .SpecialEffect   = 0
393:             .MousePointer    = 15
394:             .WordWrap        = .T.
395:             .Visible         = .T.
396:         ENDWITH
397:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
398: 
399:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
400:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
401:             .Caption         = "Encerrar"
402:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
403:             .PicturePosition = 13
404:             .Top             = 5
405:             .Left            = 80
406:             .Width           = 75
407:             .Height          = 75
408:             .BackColor       = RGB(255, 255, 255)
409:             .ForeColor       = RGB(90, 90, 90)
410:             .FontName        = "Comic Sans MS"
411:             .FontSize        = 8
412:             .FontBold        = .T.
413:             .FontItalic      = .T.
414:             .Themes          = .F.
415:             .SpecialEffect   = 0
416:             .MousePointer    = 15
417:             .WordWrap        = .T.
418:             .Visible         = .T.
419:         ENDWITH
420:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
421: 
422:         *======================================================================
423:         * FAIXA 1: Codigo e Descricao (original Top=85/90, compensado 114/119)
424:         *======================================================================
425: 
426:         *-- txt_4c_Codigos (getCodigos: top=85+29=114, left=294, width=30)
427:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
428:         WITH loc_oPagina.txt_4c_Codigos
429:             .Value         = ""
430:             .Top           = 114
431:             .Left          = 294
432:             .Width         = 30
433:             .Height        = 25
434:             .MaxLength     = 3
435:             .InputMask     = "XXX"
436:             .SpecialEffect = 1
437:             .FontName      = "Tahoma"
438:             .FontSize      = 8
439:             .Visible       = .T.
440:         ENDWITH
441: 
442:         *-- lbl_4c_Codigo (Say1: top=90+29=119, left=248)
443:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
444:         WITH loc_oPagina.lbl_4c_Codigo
445:             .Caption   = "C" + CHR(243) + "digo :"
446:             .Top       = 119
447:             .Left      = 248
448:             .Width     = 42
449:             .Height    = 15
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 459 a 483:
459:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
460:         WITH loc_oPagina.txt_4c_Descricao
461:             .Value         = ""
462:             .Top           = 114
463:             .Left          = 405
464:             .Width         = 290
465:             .Height        = 25
466:             .MaxLength     = 40
467:             .SpecialEffect = 1
468:             .FontName      = "Tahoma"
469:             .FontSize      = 8
470:             .Visible       = .T.
471:         ENDWITH
472: 
473:         *-- lbl_4c_Descricao (Say2: top=90+29=119, left=345)
474:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
475:         WITH loc_oPagina.lbl_4c_Descricao
476:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
477:             .Top       = 119
478:             .Left      = 345
479:             .Width     = 55
480:             .Height    = 15
481:             .FontName  = "Tahoma"
482:             .FontSize  = 8
483:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 495 a 520:
495:         loc_oPagina.AddObject("txt_4c_CodConPads", "TextBox")
496:         WITH loc_oPagina.txt_4c_CodConPads
497:             .Value         = ""
498:             .Top           = 142
499:             .Left          = 294
500:             .Width         = 108
501:             .Height        = 25
502:             .MaxLength     = 14
503:             .SpecialEffect = 1
504:             .FontName      = "Tahoma"
505:             .FontSize      = 8
506:             .Visible       = .T.
507:         ENDWITH
508:         BINDEVENT(loc_oPagina.txt_4c_CodConPads, "KeyPress", THIS, "AbrirLookupCodConPads")
509: 
510:         *-- lbl_4c_CodConPads (Say3: top=117+29=146, left=144)
511:         loc_oPagina.AddObject("lbl_4c_CodConPads", "Label")
512:         WITH loc_oPagina.lbl_4c_CodConPads
513:             .Caption   = "Produto Padr" + CHR(227) + "o de Conserto :"
514:             .Top       = 146
515:             .Left      = 144
516:             .Width     = 146
517:             .Height    = 15
518:             .FontName  = "Tahoma"
519:             .FontSize  = 8
520:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 527 a 536:
527:         loc_oPagina.AddObject("txt_4c_DCodConPads", "TextBox")
528:         WITH loc_oPagina.txt_4c_DCodConPads
529:             .Value         = ""
530:             .Top           = 142
531:             .Left          = 405
532:             .Width         = 290
533:             .Height        = 25
534:             .MaxLength     = 40
535:             .SpecialEffect = 1
536:             .FontName      = "Tahoma"

*-- Linhas 548 a 573:
548:         loc_oPagina.AddObject("txt_4c_Lin", "TextBox")
549:         WITH loc_oPagina.txt_4c_Lin
550:             .Value         = ""
551:             .Top           = 170
552:             .Left          = 294
553:             .Width         = 108
554:             .Height        = 23
555:             .MaxLength     = 10
556:             .SpecialEffect = 1
557:             .FontName      = "Tahoma"
558:             .FontSize      = 8
559:             .Visible       = .T.
560:         ENDWITH
561:         BINDEVENT(loc_oPagina.txt_4c_Lin, "KeyPress", THIS, "AbrirLookupLin")
562: 
563:         *-- lbl_4c_Lin (Say16: top=144+29=173, left=157)
564:         loc_oPagina.AddObject("lbl_4c_Lin", "Label")
565:         WITH loc_oPagina.lbl_4c_Lin
566:             .Caption   = "Linha Padr" + CHR(227) + "o de Cadastro :"
567:             .Top       = 173
568:             .Left      = 157
569:             .Width     = 133
570:             .Height    = 15
571:             .FontName  = "Tahoma"
572:             .FontSize  = 8
573:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 580 a 589:
580:         loc_oPagina.AddObject("txt_4c_DLin", "TextBox")
581:         WITH loc_oPagina.txt_4c_DLin
582:             .Value         = ""
583:             .Top           = 170
584:             .Left          = 405
585:             .Width         = 290
586:             .Height        = 23
587:             .MaxLength     = 40
588:             .SpecialEffect = 1
589:             .FontName      = "Tahoma"

*-- Linhas 600 a 624:
600:         loc_oPagina.AddObject("txt_4c_CodAut", "TextBox")
601:         WITH loc_oPagina.txt_4c_CodAut
602:             .Value         = ""
603:             .Top           = 196
604:             .Left          = 294
605:             .Width         = 18
606:             .Height        = 25
607:             .MaxLength     = 1
608:             .SpecialEffect = 1
609:             .FontName      = "Tahoma"
610:             .FontSize      = 8
611:             .Visible       = .T.
612:         ENDWITH
613: 
614:         *-- lbl_4c_CodAut (Say6: top=172+29=201, left=105)
615:         loc_oPagina.AddObject("lbl_4c_CodAut", "Label")
616:         WITH loc_oPagina.lbl_4c_CodAut
617:             .Caption   = "D" + CHR(237) + "gito do Produto C" + CHR(243) + "digo Autom" + CHR(225) + "tico :"
618:             .Top       = 201
619:             .Left      = 105
620:             .Width     = 185
621:             .Height    = 15
622:             .FontName  = "Tahoma"
623:             .FontSize  = 8
624:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 631 a 656:
631:         loc_oPagina.AddObject("txt_4c_Prioridade", "TextBox")
632:         WITH loc_oPagina.txt_4c_Prioridade
633:             .Value         = 0
634:             .Top           = 196
635:             .Left          = 522
636:             .Width         = 17
637:             .Height        = 25
638:             .MaxLength     = 1
639:             .InputMask     = "9"
640:             .SpecialEffect = 1
641:             .FontName      = "Tahoma"
642:             .FontSize      = 8
643:             .Visible       = .T.
644:         ENDWITH
645: 
646:         *-- lbl_4c_Prioridade (Say11: top=172+29=201, left=330)
647:         loc_oPagina.AddObject("lbl_4c_Prioridade", "Label")
648:         WITH loc_oPagina.lbl_4c_Prioridade
649:             .Caption   = "Prioridade de Rec" + CHR(225) + "lculo de Saldo (0/1) :"
650:             .Top       = 201
651:             .Left      = 330
652:             .Width     = 191
653:             .Height    = 15
654:             .FontName  = "Tahoma"
655:             .FontSize  = 8
656:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 669 a 715:
669:         WITH loc_oPagina.opt_4c_BlqEtq
670:             .ButtonCount = 2
671:             .Value       = 2
672:             .Top         = 223
673:             .Left        = 289
674:             .Width       = 94
675:             .Height      = 25
676:             .BackStyle   = 0
677:             .BorderStyle = 0
678:             .Visible     = .T.
679:         ENDWITH
680:         WITH loc_oPagina.opt_4c_BlqEtq.Buttons(1)
681:             .Caption   = "Sim"
682:             .Left      = 5
683:             .Top       = 5
684:             .Width     = 34
685:             .Height    = 15
686:             .AutoSize  = .T.
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(90, 90, 90)
690:             .BackStyle = 0
691:         ENDWITH
692:         WITH loc_oPagina.opt_4c_BlqEtq.Buttons(2)
693:             .Caption   = "N" + CHR(227) + "o"
694:             .Left      = 50
695:             .Top       = 5
696:             .Width     = 34
697:             .Height    = 15
698:             .AutoSize  = .T.
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .ForeColor = RGB(90, 90, 90)
702:             .BackStyle = 0
703:         ENDWITH
704: 
705:         *-- lbl_4c_BlqEtq (Say10: top=199+29=228, left=98)
706:         loc_oPagina.AddObject("lbl_4c_BlqEtq", "Label")
707:         WITH loc_oPagina.lbl_4c_BlqEtq
708:             .Caption   = "Bloquear Altera" + CHR(231) + CHR(227) + "o Etiqueta Individual :"
709:             .Top       = 228
710:             .Left      = 98
711:             .Width     = 192
712:             .Height    = 15
713:             .FontName  = "Tahoma"
714:             .FontSize  = 8
715:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 728 a 774:
728:         WITH loc_oPagina.opt_4c_AlteEtiq
729:             .ButtonCount = 2
730:             .Value       = 2
731:             .Top         = 249
732:             .Left        = 288
733:             .Width       = 94
734:             .Height      = 25
735:             .BackStyle   = 0
736:             .BorderStyle = 0
737:             .Visible     = .T.
738:         ENDWITH
739:         WITH loc_oPagina.opt_4c_AlteEtiq.Buttons(1)
740:             .Caption   = "Sim"
741:             .Left      = 5
742:             .Top       = 5
743:             .Width     = 34
744:             .Height    = 15
745:             .AutoSize  = .T.
746:             .FontName  = "Tahoma"
747:             .FontSize  = 8
748:             .ForeColor = RGB(90, 90, 90)
749:             .BackStyle = 0
750:         ENDWITH
751:         WITH loc_oPagina.opt_4c_AlteEtiq.Buttons(2)
752:             .Caption   = "N" + CHR(227) + "o"
753:             .Left      = 50
754:             .Top       = 5
755:             .Width     = 34
756:             .Height    = 15
757:             .AutoSize  = .T.
758:             .FontName  = "Tahoma"
759:             .FontSize  = 8
760:             .ForeColor = RGB(90, 90, 90)
761:             .BackStyle = 0
762:         ENDWITH
763: 
764:         *-- lbl_4c_AlteEtiq (Say13: top=225+29=254, left=118)
765:         loc_oPagina.AddObject("lbl_4c_AlteEtiq", "Label")
766:         WITH loc_oPagina.lbl_4c_AlteEtiq
767:             .Caption   = "Permite Alterar Dados da Etiqueta :"
768:             .Top       = 254
769:             .Left      = 118
770:             .Width     = 172
771:             .Height    = 15
772:             .FontName  = "Tahoma"
773:             .FontSize  = 8
774:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 785 a 807:
785:         *-- shp_4c_Separador (Shape2: top=250+29=279, left=9, height=1, width=980)
786:         loc_oPagina.AddObject("shp_4c_Separador", "Shape")
787:         WITH loc_oPagina.shp_4c_Separador
788:             .Top         = 279
789:             .Left        = 9
790:             .Height      = 1
791:             .Width       = 980
792:             .BackStyle   = 0
793:             .BorderColor = RGB(180, 180, 180)
794:             .Visible     = .T.
795:         ENDWITH
796: 
797:         *-- lbl_4c_Industria (Label1: top=256+29=285, left=101, width=54, bold)
798:         loc_oPagina.AddObject("lbl_4c_Industria", "Label")
799:         WITH loc_oPagina.lbl_4c_Industria
800:             .Caption   = "Ind" + CHR(250) + "stria"
801:             .Top       = 285
802:             .Left      = 101
803:             .Width     = 54
804:             .Height    = 15
805:             .FontName  = "Tahoma"
806:             .FontSize  = 8
807:             .FontBold  = .T.

*-- Linhas 815 a 841:
815:         loc_oPagina.AddObject("txt_4c_MatPrincs", "TextBox")
816:         WITH loc_oPagina.txt_4c_MatPrincs
817:             .Value         = ""
818:             .Top           = 297
819:             .Left          = 294
820:             .Width         = 108
821:             .Height        = 25
822:             .MaxLength     = 14
823:             .SpecialEffect = 1
824:             .FontName      = "Tahoma"
825:             .FontSize      = 8
826:             .Visible       = .T.
827:         ENDWITH
828:         BINDEVENT(loc_oPagina.txt_4c_MatPrincs, "InteractiveChange", THIS, "AbrirLookupMatPrincs")
829:         BINDEVENT(loc_oPagina.txt_4c_MatPrincs, "KeyPress",          THIS, "AbrirLookupMatPrincs")
830: 
831:         *-- lbl_4c_MatPrincs (Say4: top=272+29=301, left=201, width=89)
832:         loc_oPagina.AddObject("lbl_4c_MatPrincs", "Label")
833:         WITH loc_oPagina.lbl_4c_MatPrincs
834:             .Caption   = "Material Principal :"
835:             .Top       = 301
836:             .Left      = 201
837:             .Width     = 89
838:             .Height    = 15
839:             .FontName  = "Tahoma"
840:             .FontSize  = 8
841:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 854 a 889:
854:         loc_oPagina.AddObject("opt_4c_Cpq", "OptionGroup")
855:         WITH loc_oPagina.opt_4c_Cpq
856:             .Value       = 2
857:             .Top         = 320
858:             .Left        = 289
859:             .Width       = 100
860:             .Height      = 20
861:             .ButtonCount = 2
862:             .BackStyle   = 0
863:             .Visible     = .T.
864:             WITH .Buttons(1)
865:                 .Caption = "Sim"
866:                 .Width   = 46
867:                 .Height  = 20
868:             ENDWITH
869:             WITH .Buttons(2)
870:                 .Caption = "N" + CHR(227) + "o"
871:                 .Width   = 46
872:                 .Height  = 20
873:                 .Left    = 49
874:                 .FontName = "Tahoma"
875:                 .FontSize = 8
876:             ENDWITH
877:         ENDWITH
878: 
879:         *-- lbl_4c_Cpq (Say5: top=296+29=325, left=190, width=100)
880:         loc_oPagina.AddObject("lbl_4c_Cpq", "Label")
881:         WITH loc_oPagina.lbl_4c_Cpq
882:             .Caption   = "Controla por Qtde. :"
883:             .Top       = 325
884:             .Left      = 190
885:             .Width     = 100
886:             .Height    = 15
887:             .FontName  = "Tahoma"
888:             .FontSize  = 8
889:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 902 a 937:
902:         loc_oPagina.AddObject("opt_4c_FalhaAdm", "OptionGroup")
903:         WITH loc_oPagina.opt_4c_FalhaAdm
904:             .Value       = 1
905:             .Top         = 342
906:             .Left        = 289
907:             .Width       = 100
908:             .Height      = 20
909:             .ButtonCount = 2
910:             .BackStyle   = 0
911:             .Visible     = .T.
912:             WITH .Buttons(1)
913:                 .Caption = "Sim"
914:                 .Width   = 46
915:                 .Height  = 20
916:             ENDWITH
917:             WITH .Buttons(2)
918:                 .Caption = "N" + CHR(227) + "o"
919:                 .Width   = 46
920:                 .Height  = 20
921:                 .Left    = 49
922:                 .FontName = "Tahoma"
923:                 .FontSize = 8
924:             ENDWITH
925:         ENDWITH
926: 
927:         *-- lbl_4c_FalhaAdm (Say7: top=318+29=347, left=180, width=110)
928:         loc_oPagina.AddObject("lbl_4c_FalhaAdm", "Label")
929:         WITH loc_oPagina.lbl_4c_FalhaAdm
930:             .Caption   = "Aplica Falha Admitida :"
931:             .Top       = 347
932:             .Left      = 180
933:             .Width     = 110
934:             .Height    = 15
935:             .FontName  = "Tahoma"
936:             .FontSize  = 8
937:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 950 a 985:
950:         loc_oPagina.AddObject("opt_4c_PesEnvs", "OptionGroup")
951:         WITH loc_oPagina.opt_4c_PesEnvs
952:             .Value       = 2
953:             .Top         = 363
954:             .Left        = 289
955:             .Width       = 100
956:             .Height      = 20
957:             .ButtonCount = 2
958:             .BackStyle   = 0
959:             .Visible     = .T.
960:             WITH .Buttons(1)
961:                 .Caption = "Sim"
962:                 .Width   = 46
963:                 .Height  = 20
964:             ENDWITH
965:             WITH .Buttons(2)
966:                 .Caption = "N" + CHR(227) + "o"
967:                 .Width   = 46
968:                 .Height  = 20
969:                 .Left    = 49
970:                 .FontName = "Tahoma"
971:                 .FontSize = 8
972:             ENDWITH
973:         ENDWITH
974: 
975:         *-- lbl_4c_PesEnvs (Say8: top=339+29=368, left=149, width=141)
976:         loc_oPagina.AddObject("lbl_4c_PesEnvs", "Label")
977:         WITH loc_oPagina.lbl_4c_PesEnvs
978:             .Caption   = "OF Obrigat" + CHR(243) + "rio na Pesagem :"
979:             .Top       = 368
980:             .Left      = 149
981:             .Width     = 141
982:             .Height    = 15
983:             .FontName  = "Tahoma"
984:             .FontSize  = 8
985:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1000 a 1075:
1000:         loc_oPagina.AddObject("opt_4c_SemUso2", "OptionGroup")
1001:         WITH loc_oPagina.opt_4c_SemUso2
1002:             .Value       = 2
1003:             .Top         = 558
1004:             .Left        = 527
1005:             .Width       = 100
1006:             .Height      = 20
1007:             .ButtonCount = 2
1008:             .BackStyle   = 0
1009:             .Visible     = .F.
1010:             .ForeColor   = RGB(255, 0, 0)
1011:             WITH .Buttons(1)
1012:                 .Caption = "Sim"
1013:                 .Width   = 46
1014:                 .Height  = 20
1015:             ENDWITH
1016:             WITH .Buttons(2)
1017:                 .Caption = "N" + CHR(227) + "o"
1018:                 .Width   = 46
1019:                 .Height  = 20
1020:                 .Left    = 49
1021:             ENDWITH
1022:         ENDWITH
1023: 
1024:         *-- opt_4c_SemUso3 (fwoption3 / nChkObjs - sem uso)
1025:         loc_oPagina.AddObject("opt_4c_SemUso3", "OptionGroup")
1026:         WITH loc_oPagina.opt_4c_SemUso3
1027:             .Value       = 2
1028:             .Top         = 582
1029:             .Left        = 491
1030:             .Width       = 100
1031:             .Height      = 20
1032:             .ButtonCount = 2
1033:             .BackStyle   = 0
1034:             .Visible     = .F.
1035:             .ForeColor   = RGB(255, 0, 0)
1036:             WITH .Buttons(1)
1037:                 .Caption = "Sim"
1038:                 .Width   = 46
1039:                 .Height  = 20
1040:             ENDWITH
1041:             WITH .Buttons(2)
1042:                 .Caption = "N" + CHR(227) + "o"
1043:                 .Width   = 46
1044:                 .Height  = 20
1045:                 .Left    = 49
1046:             ENDWITH
1047:         ENDWITH
1048: 
1049:         *-- lbl_4c_SemUso9 (Say9 "sem uso": top=533+29=562, left=475)
1050:         loc_oPagina.AddObject("lbl_4c_SemUso9", "Label")
1051:         WITH loc_oPagina.lbl_4c_SemUso9
1052:             .Caption   = "sem uso :"
1053:             .Top       = 562
1054:             .Left      = 475
1055:             .Width     = 50
1056:             .Height    = 15
1057:             .FontName  = "Verdana"
1058:             .FontSize  = 8
1059:             .ForeColor = RGB(255, 0, 0)
1060:             .BackStyle = 0
1061:             .AutoSize  = .F.
1062:             .Visible   = .F.
1063:         ENDWITH
1064: 
1065:         *-- lbl_4c_SemUso12 (Say12 "sem uso :": top=558+29=587, left=435)
1066:         loc_oPagina.AddObject("lbl_4c_SemUso12", "Label")
1067:         WITH loc_oPagina.lbl_4c_SemUso12
1068:             .Caption   = "sem uso :"
1069:             .Top       = 587
1070:             .Left      = 435
1071:             .Width     = 50
1072:             .Height    = 15
1073:             .FontName  = "Verdana"
1074:             .FontSize  = 8
1075:             .ForeColor = RGB(255, 0, 0)

*-- Linhas 1086 a 1095:
1086:         *-- Reesconder campos "sem uso" (TornarControlesVisiveis forcou Visible=.T.)
1087:         loc_oPagina.opt_4c_SemUso2.Visible  = .F.
1088:         loc_oPagina.opt_4c_SemUso3.Visible  = .F.
1089:         loc_oPagina.lbl_4c_SemUso9.Visible  = .F.
1090:         loc_oPagina.lbl_4c_SemUso12.Visible = .F.
1091:     ENDPROC
1092: 
1093:     *--------------------------------------------------------------------------
1094:     * CarregarLista - Carrega dados no grid da Page1
1095:     * Grid e conexao do RecordSource serao configurados na Fase 4

*-- Linhas 1111 a 1121:
1111:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1112:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1113:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.linhas"
1114:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1115:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1116:                         loc_oGrid.Column3.Header1.Caption = "Linhas"
1117:                         THIS.FormatarGridLista(loc_oGrid)
1118:                         loc_oGrid.Refresh()
1119:                     ENDIF
1120:                 ENDIF
1121:             CATCH TO loException

*-- Linhas 1714 a 1726:
1714: 
1715:             DO CASE
1716:             CASE par_cModo = "NORMAL"
1717:                 loc_oCnt.cmd_4c_Confirmar.Enabled = .F.
1718:                 loc_oCnt.cmd_4c_Cancelar.Enabled  = .T.
1719:             CASE par_cModo = "EDICAO"
1720:                 loc_oCnt.cmd_4c_Confirmar.Enabled = .T.
1721:                 loc_oCnt.cmd_4c_Cancelar.Enabled  = .T.
1722:             ENDCASE
1723: 
1724:             loc_lResultado = .T.
1725:         CATCH TO loException
1726:             MsgErro("Erro ao ajustar botoes:" + CHR(13) + loException.Message, "Formgpr.AjustarBotoesPorModo")


### BO (C:\4c\projeto\app\classes\gprBO.prg):
*==============================================================================
* gprBO.prg
*
* Business Object para Grande Grupo de Produto (SigCdGpr)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS gprBO AS BusinessBase

    *-- Propriedades da tabela SigCdGpr
    this_cCodigos     = ""    && codigos    char(3)      PK
    this_cDescs       = ""    && descs      char(40)
    this_cCodConPads  = ""    && codconpads char(14)     Produto Padrao de Conserto
    this_cMatPrincs   = ""    && matprincs  char(14)     Material Principal
    this_nCpqtds      = 0     && cpqtds     numeric(1,0) Controla por Qtde
    this_cDigauts     = ""    && digauts    char(1)      Digito Codigo Automatico
    this_nIds         = 0     && ids        numeric(10,0)
    this_nAplicflhs   = 0     && aplicflhs  numeric(1,0) Aplica Falha Admitida
    this_nBarrefs     = 0     && barrefs    numeric(1,0) Bloquear Alteracao Etiqueta Individual
    this_nDigbars     = 0     && digbars    numeric(1,0)
    this_nPesenvs     = 0     && pesenvs    numeric(1,0) OF Obrigatorio na Pesagem
    this_cLinhas      = ""    && linhas     char(10)     Linha Padrao de Cadastro
    this_nFchcxs      = 0     && fchcxs     numeric(1,0)
    this_nPriors      = 0     && priors     numeric(1,0) Prioridade Recalculo Saldo
    this_nAltetiqs    = 0     && altetiqs   numeric(1,0) Permite Alterar Dados Etiqueta
    this_nNchkobjs    = 0     && nchkobjs   numeric(1,0)
    this_nProdecomm   = 0     && prodecomm  numeric(1,0)

    *-- Campos de exibicao (nao persistidos na tabela)
    this_cDescConPads = ""    && Descricao do Produto Padrao de Conserto (SigCdPro.DPros)
    this_cDescLin     = ""    && Descricao da Linha Padrao (SigCdLin.Descs)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdGpr"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "gprBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigos)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !INLIST(THIS.this_nPriors, 0, 1)
            MsgAviso("Prioridade Inv" + CHR(225) + "lida!!! Use 0 ou 1.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se codigos ja existe em SigCdGpr
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdGpr" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "gprBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos     = TratarNulo(codigos,    "C")
                THIS.this_cDescs       = TratarNulo(descs,      "C")
                THIS.this_cCodConPads  = TratarNulo(CodConPads, "C")
                THIS.this_cMatPrincs   = TratarNulo(Matprincs,  "C")
                THIS.this_nCpqtds      = TratarNulo(cpqtds,     "N")
                THIS.this_cDigauts     = TratarNulo(digauts,    "C")
                THIS.this_nIds         = TratarNulo(ids,        "N")
                THIS.this_nAplicflhs   = TratarNulo(AplicFlhs,  "N")
                THIS.this_nBarrefs     = TratarNulo(Barrefs,    "N")
                THIS.this_nDigbars     = TratarNulo(digbars,    "N")
                THIS.this_nPesenvs     = TratarNulo(PesEnvs,    "N")
                THIS.this_cLinhas      = TratarNulo(linhas,     "C")
                THIS.this_nFchcxs      = TratarNulo(Fchcxs,     "N")
                THIS.this_nPriors      = TratarNulo(priors,     "N")
                THIS.this_nAltetiqs    = TratarNulo(AltEtiqs,   "N")
                THIS.this_nNchkobjs    = TratarNulo(nChkObjs,   "N")
                THIS.this_nProdecomm   = TratarNulo(prodecomm,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "gprBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdGpr (codigos, descs, CodConPads, Matprincs,
                    cpqtds, digauts, AplicFlhs, Barrefs, PesEnvs,
                    linhas, priors, AltEtiqs, nChkObjs, Fchcxs, digbars, prodecomm)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>,
                    <<EscaparSQL(THIS.this_cCodConPads)>>,
                    <<EscaparSQL(THIS.this_cMatPrincs)>>,
                    <<FormatarNumeroSQL(THIS.this_nCpqtds, 0)>>,
                    <<EscaparSQL(THIS.this_cDigauts)>>,
                    <<FormatarNumeroSQL(THIS.this_nAplicflhs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBarrefs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesenvs, 0)>>,
                    <<EscaparSQL(THIS.this_cLinhas)>>,
                    <<FormatarNumeroSQL(THIS.this_nPriors, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAltetiqs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNchkobjs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFchcxs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDigbars, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nProdecomm, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "gprBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdGpr
                SET descs      = <<EscaparSQL(THIS.this_cDescs)>>,
                    CodConPads = <<EscaparSQL(THIS.this_cCodConPads)>>,
                    Matprincs  = <<EscaparSQL(THIS.this_cMatPrincs)>>,
                    cpqtds     = <<FormatarNumeroSQL(THIS.this_nCpqtds, 0)>>,
                    digauts    = <<EscaparSQL(THIS.this_cDigauts)>>,
                    AplicFlhs  = <<FormatarNumeroSQL(THIS.this_nAplicflhs, 0)>>,
                    Barrefs    = <<FormatarNumeroSQL(THIS.this_nBarrefs, 0)>>,
                    PesEnvs    = <<FormatarNumeroSQL(THIS.this_nPesenvs, 0)>>,
                    linhas     = <<EscaparSQL(THIS.this_cLinhas)>>,
                    priors     = <<FormatarNumeroSQL(THIS.this_nPriors, 0)>>,
                    AltEtiqs   = <<FormatarNumeroSQL(THIS.this_nAltetiqs, 0)>>,
                    nChkObjs   = <<FormatarNumeroSQL(THIS.this_nNchkobjs, 0)>>,
                    Fchcxs     = <<FormatarNumeroSQL(THIS.this_nFchcxs, 0)>>,
                    digbars    = <<FormatarNumeroSQL(THIS.this_nDigbars, 0)>>,
                    prodecomm  = <<FormatarNumeroSQL(THIS.this_nProdecomm, 0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "gprBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGpr WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "gprBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descs, linhas (colunas do grid)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(3), descs C(40), linhas C(10))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descs, a.linhas FROM SigCdGpr a"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grandes grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grandes grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "gprBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descs, a.CodConPads, a.Matprincs," + ;
                " a.cpqtds, a.digauts, a.ids, a.AplicFlhs, a.Barrefs," + ;
                " a.digbars, a.PesEnvs, a.linhas, a.Fchcxs, a.priors," + ;
                " a.AltEtiqs, a.nChkObjs, a.prodecomm" + ;
                " FROM SigCdGpr a WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grande Grupo n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "gprBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

