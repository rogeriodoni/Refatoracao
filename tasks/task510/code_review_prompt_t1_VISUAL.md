# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 198: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 223: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 248: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 273: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 298: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 323: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 407: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 432: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormReg.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1693 linhas total):

*-- Linhas 41 a 61:
41: 
42:         TRY
43:             *-- Caption com acento (CHR(245) = o-tilde)
44:             THIS.Caption = "Cadastro de Regi" + CHR(245) + "es"
45: 
46:             THIS.this_oBusinessObject = CREATEOBJECT("RegBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar RegBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "FormReg.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54: 
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Visible = .T.
58:                 THIS.pgf_4c_Paginas.ActivePage = 1
59:                 THIS.this_cModoAtual = "LISTA"
60: 
61:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 84 a 103:
84: 
85:         WITH THIS.pgf_4c_Paginas
86:             .PageCount = 2
87:             .Top       = -29
88:             .Left      = 0
89:             .Width     = THIS.Width
90:             .Height    = THIS.Height + 29
91:             .Tabs      = .F.
92:             .Visible   = .T.
93: 
94:             .Page1.Caption   = "Lista"
95:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page1.BackColor = RGB(255, 255, 255)
97: 
98:             .Page2.Caption   = "Dados"
99:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page2.BackColor = RGB(255, 255, 255)
101:         ENDWITH
102: 
103:         THIS.ConfigurarPaginaLista()

*-- Linhas 119 a 156:
119:         *-- Container Cabecalho (cntSombra no legado: Top=1 + 29 = 30 -> canonico 31)
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = 769
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .AutoSize  = .F.
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = 769
153:             .Height    = 46
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.

*-- Linhas 164 a 351:
164:         *-- Fase 4 adiciona os 5 botoes CRUD neste container
165:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
166:         WITH loc_oPagina.cnt_4c_Botoes
167:             .Top         = 29
168:             .Left        =  542
169:             .Width       = 385
170:             .Height      = 85
171:             .BackStyle   = 0
172:             .BorderWidth = 0
173:             .Visible     = .T.
174:         ENDWITH
175: 
176:         *-- Container Saida canonico (Left=917, Width=90, Height=85)
177:         *-- Grupo_Saida legado: Left=919, Top=-1 -> canonico prevalece
178:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
179:         WITH loc_oPagina.cnt_4c_Saida
180:             .Top         = 29
181:             .Left        = 917
182:             .Width       = 90
183:             .Height      = 85
184:             .BackStyle   = 0
185:             .BorderWidth = 0
186:             .Visible     = .T.
187:         ENDWITH
188: 
189:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
190:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
191:             .Caption         = "Encerrar"
192:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
193:             .PicturePosition = 13
194:             .Top             = 5
195:             .Left            = 5
196:             .Width           = 75
197:             .Height          = 75
198:             .FontName        = "Comic Sans MS"
199:             .FontBold        = .T.
200:             .FontItalic      = .T.
201:             .FontSize        = 8
202:             .ForeColor       = RGB(90, 90, 90)
203:             .BackColor       = RGB(255, 255, 255)
204:             .Themes          = .F.
205:             .SpecialEffect   = 0
206:             .MousePointer    = 15
207:             .WordWrap        = .T.
208:             .AutoSize        = .F.
209:             .Visible         = .T.
210:         ENDWITH
211:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
212: 
213:         *-- Botao Incluir
214:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
215:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
216:             .Caption         = "Incluir"
217:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
218:             .PicturePosition = 13
219:             .Top             = 5
220:             .Left            = 5
221:             .Width           = 75
222:             .Height          = 75
223:             .FontName        = "Comic Sans MS"
224:             .FontBold        = .T.
225:             .FontItalic      = .T.
226:             .FontSize        = 8
227:             .ForeColor       = RGB(90, 90, 90)
228:             .BackColor       = RGB(255, 255, 255)
229:             .Themes          = .F.
230:             .SpecialEffect   = 0
231:             .MousePointer    = 15
232:             .WordWrap        = .T.
233:             .AutoSize        = .F.
234:             .Visible         = .T.
235:         ENDWITH
236:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
237: 
238:         *-- Botao Visualizar
239:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
240:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
241:             .Caption         = "Visualizar"
242:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
243:             .PicturePosition = 13
244:             .Top             = 5
245:             .Left            = 80
246:             .Width           = 75
247:             .Height          = 75
248:             .FontName        = "Comic Sans MS"
249:             .FontBold        = .T.
250:             .FontItalic      = .T.
251:             .FontSize        = 8
252:             .ForeColor       = RGB(90, 90, 90)
253:             .BackColor       = RGB(255, 255, 255)
254:             .Themes          = .F.
255:             .SpecialEffect   = 0
256:             .MousePointer    = 15
257:             .WordWrap        = .T.
258:             .AutoSize        = .F.
259:             .Visible         = .T.
260:         ENDWITH
261:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
262: 
263:         *-- Botao Alterar
264:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
265:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
266:             .Caption         = "Alterar"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 155
271:             .Width           = 75
272:             .Height          = 75
273:             .FontName        = "Comic Sans MS"
274:             .FontBold        = .T.
275:             .FontItalic      = .T.
276:             .FontSize        = 8
277:             .ForeColor       = RGB(90, 90, 90)
278:             .BackColor       = RGB(255, 255, 255)
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .MousePointer    = 15
282:             .WordWrap        = .T.
283:             .AutoSize        = .F.
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
287: 
288:         *-- Botao Excluir
289:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
290:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
291:             .Caption         = "Excluir"
292:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
293:             .PicturePosition = 13
294:             .Top             = 5
295:             .Left            = 230
296:             .Width           = 75
297:             .Height          = 75
298:             .FontName        = "Comic Sans MS"
299:             .FontBold        = .T.
300:             .FontItalic      = .T.
301:             .FontSize        = 8
302:             .ForeColor       = RGB(90, 90, 90)
303:             .BackColor       = RGB(255, 255, 255)
304:             .Themes          = .F.
305:             .SpecialEffect   = 0
306:             .MousePointer    = 15
307:             .WordWrap        = .T.
308:             .AutoSize        = .F.
309:             .Visible         = .T.
310:         ENDWITH
311:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
312: 
313:         *-- Botao Buscar
314:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
315:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
316:             .Caption         = "Buscar"
317:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
318:             .PicturePosition = 13
319:             .Top             = 5
320:             .Left            = 305
321:             .Width           = 75
322:             .Height          = 75
323:             .FontName        = "Comic Sans MS"
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .FontSize        = 8
327:             .ForeColor       = RGB(90, 90, 90)
328:             .BackColor       = RGB(255, 255, 255)
329:             .Themes          = .F.
330:             .SpecialEffect   = 0
331:             .MousePointer    = 15
332:             .WordWrap        = .T.
333:             .AutoSize        = .F.
334:             .Visible         = .T.
335:         ENDWITH
336:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
337: 
338:         *-- Grid de listagem (Top=117 = 88+29 compensacao PageFrame, Left=26, Width=890)
339:         *-- Colunas: regiaos (Regioes), descs (Descricao) - de SigCdReg via cursor_4c_Dados
340:         *-- RecordSource e ColumnCount FORA do WITH (Problem 36: evita Unknown member COLUMN1)
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         loc_oPagina.grd_4c_Lista.RecordSource = ""
343:         loc_oPagina.grd_4c_Lista.ColumnCount  = 2
344:         WITH loc_oPagina.grd_4c_Lista
345:             .Top                = 117
346:             .Left               = 26
347:             .Width              = 890
348:             .Height             = 498
349:             .FontName           = "Verdana"
350:             .FontSize           = 8
351:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 362 a 371:
362:             .Visible            = .T.
363:             .Column1.Width              = 100
364:             .Column2.Width              = 400
365:             .Column1.Header1.Caption    = "Regi" + CHR(245) + "es"
366:             .Column2.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
367:         ENDWITH
368:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
369: 
370:         THIS.TornarControlesVisiveis(loc_oPagina)
371:     ENDPROC

*-- Linhas 385 a 457:
385:         *-- Container BotoesAcao (Grupo_Salva no legado: Left=843, Top=-4+29=25)
386:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
387:         WITH loc_oPagina.cnt_4c_BotoesAcao
388:             .Top         = 25
389:             .Left        = 843
390:             .Width       = 160
391:             .Height      = 85
392:             .BackStyle   = 0
393:             .BorderWidth = 0
394:             .Visible     = .T.
395:         ENDWITH
396: 
397:         *-- Botao Confirmar (cadastro_salvar_60.jpg - Problem 16: icone correto)
398:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
399:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
400:             .Caption         = "Confirmar"
401:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
402:             .PicturePosition = 13
403:             .Top             = 5
404:             .Left            = 5
405:             .Width           = 75
406:             .Height          = 75
407:             .FontName        = "Comic Sans MS"
408:             .FontBold        = .T.
409:             .FontItalic      = .T.
410:             .FontSize        = 8
411:             .ForeColor       = RGB(90, 90, 90)
412:             .BackColor       = RGB(255, 255, 255)
413:             .Themes          = .F.
414:             .SpecialEffect   = 0
415:             .MousePointer    = 15
416:             .WordWrap        = .T.
417:             .AutoSize        = .F.
418:             .Visible         = .T.
419:         ENDWITH
420:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
421: 
422:         *-- Botao Cancelar
423:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
424:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
425:             .Caption         = "Encerrar"
426:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
427:             .PicturePosition = 13
428:             .Top             = 5
429:             .Left            = 80
430:             .Width           = 75
431:             .Height          = 75
432:             .FontName        = "Comic Sans MS"
433:             .FontBold        = .T.
434:             .FontItalic      = .T.
435:             .FontSize        = 8
436:             .ForeColor       = RGB(90, 90, 90)
437:             .BackColor       = RGB(255, 255, 255)
438:             .Themes          = .F.
439:             .SpecialEffect   = 0
440:             .MousePointer    = 15
441:             .WordWrap        = .T.
442:             .AutoSize        = .F.
443:             .Visible         = .T.
444:         ENDWITH
445:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
446: 
447:         *-- Label Codigo (Say2 legado: Top=86+29=115, Left=53)
448:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
449:         WITH loc_oPagina.lbl_4c_Codigo
450:             .Caption   = "C" + CHR(243) + "digo :"
451:             .Top       = 115
452:             .Left      = 53
453:             .Width     = 50
454:             .Height    = 17
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 465 a 490:
465:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
466:         WITH loc_oPagina.txt_4c_Codigo
467:             .Value     = ""
468:             .Top       = 111
469:             .Left      = 97
470:             .Width     = 80
471:             .Height    = 23
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .MaxLength = 10
475:             .ReadOnly  = .F.
476:             .Visible   = .T.
477:         ENDWITH
478:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarCodigo")
479: 
480:         *-- Label Descricao (Say1 legado: Top=86+29=115, Left=210)
481:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
482:         WITH loc_oPagina.lbl_4c_Descricao
483:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
484:             .Top       = 115
485:             .Left      = 210
486:             .Width     = 60
487:             .Height    = 17
488:             .FontName  = "Tahoma"
489:             .FontSize  = 8
490:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 498 a 537:
498:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
499:         WITH loc_oPagina.txt_4c_Descricao
500:             .Value     = ""
501:             .Top       = 111
502:             .Left      = 267
503:             .Width     = 150
504:             .Height    = 23
505:             .FontName  = "Tahoma"
506:             .FontSize  = 8
507:             .MaxLength = 30
508:             .ReadOnly  = .F.
509:             .Visible   = .T.
510:         ENDWITH
511: 
512:         *-- Label Municipios (Say3 legado: Top=128+29=157, Left=54, Width=189, Height=15)
513:         loc_oPagina.AddObject("lbl_4c_Municipios", "Label")
514:         WITH loc_oPagina.lbl_4c_Municipios
515:             .Caption   = "Munic" + CHR(237) + "pios pertencentes a regi" + CHR(227) + "o"
516:             .Top       = 157
517:             .Left      = 54
518:             .Width     = 189
519:             .Height    = 15
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .ForeColor = RGB(90, 90, 90)
523:             .BackStyle = 0
524:             .Visible   = .T.
525:         ENDWITH
526: 
527:         *-- Label Vendedores (Say4 legado: Top=128+29=157, Left=498, Width=213, Height=15)
528:         loc_oPagina.AddObject("lbl_4c_Vendedores", "Label")
529:         WITH loc_oPagina.lbl_4c_Vendedores
530:             .Caption   = "Vendedores respons" + CHR(225) + "veis pela regi" + CHR(227) + "o"
531:             .Top       = 157
532:             .Left      = 498
533:             .Width     = 213
534:             .Height    = 15
535:             .FontName  = "Tahoma"
536:             .FontSize  = 8
537:             .FontBold  = .T.

*-- Linhas 547 a 556:
547:         loc_oPagina.grd_4c_Municipios.RecordSource = ""
548:         loc_oPagina.grd_4c_Municipios.ColumnCount  = 2
549:         WITH loc_oPagina.grd_4c_Municipios
550:             .Top                = 175
551:             .Left               = 51
552:             .Width              = 358
553:             .Height             = 438
554:             .FontName           = "Tahoma"
555:             .FontSize           = 8
556:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 569 a 628:
569:             .AllowRowSizing     = .F.
570:             .Column1.Width               = 24
571:             .Column2.Width               = 312
572:             .Column1.Header1.Caption     = "UF"
573:             .Column2.Header1.Caption     = "Munic" + CHR(237) + "pio"
574:             .Visible            = .T.
575:         ENDWITH
576:         BINDEVENT(loc_oPagina.grd_4c_Municipios, "AfterRowColChange", THIS, ;
577:             "GradMuniAfterRowColChange")
578: 
579:         *-- Botao Inserir Municipio (inserir legado: Top=324+29=353, Left=414, 45x45)
580:         loc_oPagina.AddObject("cmd_4c_InserirMun", "CommandButton")
581:         WITH loc_oPagina.cmd_4c_InserirMun
582:             .Top             = 353
583:             .Left            = 414
584:             .Width           = 40
585:             .Height          = 40
586:             .Caption         = ""
587:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
588:             .PicturePosition = 14
589:             .SpecialEffect   = 0
590:             .MousePointer    = 15
591:             .ToolTipText     = "Inserir Munic" + CHR(237) + "pio"
592:             .Themes          = .F.
593:             .Visible         = .T.
594:         ENDWITH
595:         BINDEVENT(loc_oPagina.cmd_4c_InserirMun, "Click", THIS, "BtnInserirMunClick")
596: 
597:         *-- Botao Excluir Municipio (excluir legado: Top=369+29=398, Left=414, 45x45)
598:         loc_oPagina.AddObject("cmd_4c_ExcluirMun", "CommandButton")
599:         WITH loc_oPagina.cmd_4c_ExcluirMun
600:             .Top             = 398
601:             .Left            = 414
602:             .Width           = 40
603:             .Height          = 40
604:             .Caption         = ""
605:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
606:             .PicturePosition = 14
607:             .SpecialEffect   = 0
608:             .MousePointer    = 15
609:             .ToolTipText     = "Excluir Munic" + CHR(237) + "pio"
610:             .Themes          = .F.
611:             .Visible         = .T.
612:         ENDWITH
613:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirMun, "Click", THIS, "BtnExcluirMunClick")
614: 
615:         *-- Grid Vendedores (GradVend legado: Top=146+29=175, Left=497, Width=402, Height=438)
616:         *-- RecordSource e ColumnCount FORA do WITH (Problem 36)
617:         *-- ControlSource definido em RebindGridsDetalhe() apos criacao do cursor crVend
618:         loc_oPagina.AddObject("grd_4c_Vendedores", "Grid")
619:         loc_oPagina.grd_4c_Vendedores.RecordSource = ""
620:         loc_oPagina.grd_4c_Vendedores.ColumnCount  = 2
621:         WITH loc_oPagina.grd_4c_Vendedores
622:             .Top                = 175
623:             .Left               = 497
624:             .Width              = 402
625:             .Height             = 438
626:             .FontName           = "Tahoma"
627:             .FontSize           = 8
628:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 641 a 690:
641:             .AllowRowSizing     = .F.
642:             .Column1.Width               = 90
643:             .Column2.Width               = 290
644:             .Column1.Header1.Caption     = "C" + CHR(243) + "digo"
645:             .Column2.Header1.Caption     = "Nome do Vendedor"
646:             .Visible            = .T.
647:         ENDWITH
648:         BINDEVENT(loc_oPagina.grd_4c_Vendedores, "AfterRowColChange", THIS, ;
649:             "GradVendAfterRowColChange")
650: 
651:         *-- Botao Inserir Vendedor (InserirV legado: Top=324+29=353, Left=903, 45x45)
652:         loc_oPagina.AddObject("cmd_4c_InserirVend", "CommandButton")
653:         WITH loc_oPagina.cmd_4c_InserirVend
654:             .Top             = 353
655:             .Left            = 903
656:             .Width           = 40
657:             .Height          = 40
658:             .Caption         = ""
659:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
660:             .PicturePosition = 14
661:             .SpecialEffect   = 0
662:             .MousePointer    = 15
663:             .ToolTipText     = "Inserir Vendedor"
664:             .Themes          = .F.
665:             .Visible         = .T.
666:         ENDWITH
667:         BINDEVENT(loc_oPagina.cmd_4c_InserirVend, "Click", THIS, "BtnInserirVendClick")
668: 
669:         *-- Botao Excluir Vendedor (ExcluirV legado: Top=369+29=398, Left=903, 45x45)
670:         loc_oPagina.AddObject("cmd_4c_ExcluirVend", "CommandButton")
671:         WITH loc_oPagina.cmd_4c_ExcluirVend
672:             .Top             = 398
673:             .Left            = 903
674:             .Width           = 40
675:             .Height          = 40
676:             .Caption         = ""
677:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
678:             .PicturePosition = 14
679:             .SpecialEffect   = 0
680:             .MousePointer    = 15
681:             .ToolTipText     = "Excluir Vendedor"
682:             .Themes          = .F.
683:             .Visible         = .T.
684:         ENDWITH
685:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirVend, "Click", THIS, "BtnExcluirVendClick")
686: 
687:         THIS.TornarControlesVisiveis(loc_oPagina)
688:     ENDPROC
689: 
690:     *==========================================================================

*-- Linhas 716 a 725:
716:                     loc_oGrid.Column2.Width = 400
717: 
718:                     *-- Reconfigurar headers: VFP9 os reseta ao mudar RecordSource (Problem 32)
719:                     loc_oGrid.Column1.Header1.Caption = "Regi" + CHR(245) + "es"
720:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
721: 
722:                     THIS.FormatarGridLista(loc_oGrid)
723:                     loc_oGrid.Refresh()
724:                     loc_lSucesso = .T.
725:                 ENDIF

*-- Linhas 1120 a 1130:
1120:         IF PEMSTATUS(loc_oPagina2, "grd_4c_Vendedores", 5)
1121:             loc_oPagina2.grd_4c_Vendedores.ReadOnly = !par_lHabilitar
1122:         ENDIF
1123:         IF PEMSTATUS(loc_oPagina2, "cmd_4c_InserirMun", 5)
1124:         ENDIF
1125:         IF PEMSTATUS(loc_oPagina2, "cmd_4c_InserirVend", 5)
1126:         ENDIF
1127:     ENDPROC
1128: 
1129:     *==========================================================================
1130:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme this_cModoAtual

*-- Linhas 1136 a 1145:
1136:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1137: 
1138:         WITH loc_oPagina2.cnt_4c_BotoesAcao
1139:             .cmd_4c_Confirmar.Enabled = loc_lEditando
1140:             .cmd_4c_Cancelar.Enabled  = .T.
1141:             .Visible     = .T.
1142:         ENDWITH
1143:     ENDPROC
1144: 
1145:     *==========================================================================

*-- Linhas 1182 a 1205:
1182:                 loc_oGridMuni.Column2.ControlSource   = "crMuni.munici"
1183:                 loc_oGridMuni.Column1.Width            = 24
1184:                 loc_oGridMuni.Column2.Width            = 312
1185:                 loc_oGridMuni.Column1.Header1.Caption  = "UF"
1186:                 loc_oGridMuni.Column2.Header1.Caption  = "Munic" + CHR(237) + "pio"
1187:                 loc_oGridMuni.Refresh()
1188:             ENDIF
1189: 
1190:             IF PEMSTATUS(loc_oPagina2, "grd_4c_Vendedores", 5) AND USED("crVend")
1191:                 loc_oGridVend = loc_oPagina2.grd_4c_Vendedores
1192:                 loc_oGridVend.RecordSource = ""
1193:                 loc_oGridVend.RecordSource = "crVend"
1194:                 loc_oGridVend.ColumnCount  = 2
1195:                 loc_oGridVend.Column1.ControlSource   = "crVend.iclis"
1196:                 loc_oGridVend.Column2.ControlSource   = "crVend.vend"
1197:                 loc_oGridVend.Column1.Width            = 90
1198:                 loc_oGridVend.Column2.Width            = 290
1199:                 loc_oGridVend.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
1200:                 loc_oGridVend.Column2.Header1.Caption  = "Nome do Vendedor"
1201:                 loc_oGridVend.Refresh()
1202:             ENDIF
1203:         CATCH TO loc_oErro
1204:             MsgErro(loc_oErro.Message, "Erro ao vincular grids de detalhe")
1205:         ENDTRY


### BO (C:\4c\projeto\app\classes\RegBO.prg):
*====================================================================
* RegBO.prg
*
* Business Object para Cadastro de Regioes
* Tabela principal : SigCdReg (regiaos, descs, skchaves)
* Tabela filha     : SigCdRgi (municipios tipos='M' e vendedores tipos='C')
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS RegBO AS BusinessBase

    *-- ----------------------------------------------------------------
    *-- Propriedades da entidade principal (SigCdReg)
    *-- ----------------------------------------------------------------
    this_cRegiaos   = ""    && regiaos  char(10)  - PK
    this_cDescs     = ""    && descs    char(30)
    this_cSkChaves  = ""    && skchaves char(20)  - chave UUID (liga SigCdRgi)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdReg"
            THIS.this_cCampoChave = "regiaos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "RegBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cRegiaos  = TratarNulo(regiaos,  "C")
                THIS.this_cDescs    = TratarNulo(descs,    "C")
                THIS.this_cSkChaves = TratarNulo(skchaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Seleciona todas as regioes para o grid de listagem
    * par_cFiltro: filtro opcional (nao usado - mantido por padrao)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT regiaos, descs, skchaves" + ;
                       " FROM SigCdReg" + ;
                       " ORDER BY regiaos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar regi" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega uma regiao pelo codigo (PK)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cRegiaos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT regiaos, descs, skchaves" + ;
                       " FROM SigCdReg" + ;
                       " WHERE regiaos = " + EscaparSQL(ALLTRIM(par_cRegiaos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar regi" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.CarregarPorCodigo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarMunicipios - Carrega municipios da regiao no crMuni
    * par_cSkChaves: skchaves da regiao
    *====================================================================
    PROCEDURE BuscarMunicipios(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("crMuni")
                USE IN crMuni
            ENDIF

            IF EMPTY(ALLTRIM(par_cSkChaves))
                *-- Regiao nova: criar cursor vazio com linha em branco
                SET NULL ON
                CREATE CURSOR crMuni (skchaves C(20), pkChaves C(20), ;
                    codibges C(7), tipos C(1), iclis C(10), munici C(40), uf C(2))
                SET NULL OFF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkChaves, a.codibges, a.tipos," + ;
                           " c.descs AS munici, d.estados AS uf" + ;
                           " FROM SigCdRgi a" + ;
                           " LEFT JOIN sigcdmun c ON c.codigos = a.codibges" + ;
                           " LEFT JOIN sigcdufs d ON d.ufibges = c.ufibges" + ;
                           " WHERE a.skchaves = " + EscaparSQL(ALLTRIM(par_cSkChaves)) + ;
                           " AND a.tipos = 'M'" + ;
                           " ORDER BY c.descs"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniTemp")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar munic" + CHR(237) + "pios: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SET NULL ON
                    CREATE CURSOR crMuni (skchaves C(20), pkChaves C(20), ;
                        codibges C(7), tipos C(1), iclis C(10), munici C(40), uf C(2))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_MuniTemp") > 0
                        APPEND FROM DBF("cursor_4c_MuniTemp")
                    ENDIF

                    IF RECCOUNT("crMuni") = 0
                        APPEND BLANK
                    ENDIF

                    GO TOP IN crMuni
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_MuniTemp")
                    USE IN cursor_4c_MuniTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.BuscarMunicipios")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarVendedores - Carrega vendedores/clientes da regiao no crVend
    * par_cSkChaves: skchaves da regiao
    *====================================================================
    PROCEDURE BuscarVendedores(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("crVend")
                USE IN crVend
            ENDIF

            IF EMPTY(ALLTRIM(par_cSkChaves))
                *-- Regiao nova: criar cursor vazio com linha em branco
                SET NULL ON
                CREATE CURSOR crVend (skchaves C(20), pkChaves C(20), ;
                    codibges C(7), tipos C(1), iclis C(10), vend C(50))
                SET NULL OFF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkChaves, a.codibges, a.tipos," + ;
                           " a.iclis, c.razaos AS vend" + ;
                           " FROM SigCdRgi a" + ;
                           " LEFT JOIN sigcdcli c ON c.iclis = a.iclis" + ;
                           " WHERE a.skchaves = " + EscaparSQL(ALLTRIM(par_cSkChaves)) + ;
                           " AND a.tipos = 'C'" + ;
                           " ORDER BY c.razaos"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendTemp")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar vendedores: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SET NULL ON
                    CREATE CURSOR crVend (skchaves C(20), pkChaves C(20), ;
                        codibges C(7), tipos C(1), iclis C(10), vend C(50))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_VendTemp") > 0
                        APPEND FROM DBF("cursor_4c_VendTemp")
                    ENDIF

                    IF RECCOUNT("crVend") = 0
                        APPEND BLANK
                    ENDIF

                    GO TOP IN crVend
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_VendTemp")
                    USE IN cursor_4c_VendTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.BuscarVendedores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirFilhos - Insere registros em SigCdRgi a partir de crMuni e crVend
    * par_cSkChaves: skchaves da regiao (recem gerado ou existente)
    *====================================================================
    PROTECTED PROCEDURE InserirFilhos(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cPkChaves
        loc_lSucesso = .T.
        TRY
            *-- Inserir municipios do crMuni (tipos='M', codibges nao vazio)
            IF USED("crMuni")
                SELECT crMuni
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crMuni.codibges)) .AND. !DELETED()
                        loc_cPkChaves = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigCdRgi" + ;
                                   " (pkChaves, skchaves, codibges, tipos, iclis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cSkChaves)) + ", " + ;
                                   EscaparSQL(ALLTRIM(crMuni.codibges)) + ", 'M', '')"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsMuni")
                        IF USED("cursor_4c_InsMuni")
                            USE IN cursor_4c_InsMuni
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir munic" + CHR(237) + "pio: " + ;
                                    CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Inserir vendedores do crVend (tipos='C', iclis nao vazio)
            IF loc_lSucesso AND USED("crVend")
                SELECT crVend
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crVend.iclis)) .AND. !DELETED()
                        loc_cPkChaves = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigCdRgi" + ;
                                   " (pkChaves, skchaves, codibges, tipos, iclis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cSkChaves)) + ", '', 'C', " + ;
                                   EscaparSQL(ALLTRIM(crVend.iclis)) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsVend")
                        IF USED("cursor_4c_InsVend")
                            USE IN cursor_4c_InsVend
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir vendedor: " + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.InserirFilhos")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdReg + filhos em SigCdRgi
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cSkChaves
        loc_lSucesso = .F.
        TRY
            *-- Gerar chave UUID para skchaves
            loc_cSkChaves = fUniqueIds()
            THIS.this_cSkChaves = loc_cSkChaves

            loc_cSQL = "INSERT INTO SigCdReg (regiaos, descs, skchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cRegiaos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ", " + ;
                       EscaparSQL(loc_cSkChaves) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsReg")
            IF USED("cursor_4c_InsReg")
                USE IN cursor_4c_InsReg
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao inserir regi" + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = THIS.InserirFilhos(loc_cSkChaves)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE em SigCdReg + rebuild de SigCdRgi
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Atualizar descricao (regiaos nao pode ser alterado)
            loc_cSQL = "UPDATE SigCdReg" + ;
                       " SET descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                       " WHERE regiaos = " + EscaparSQL(ALLTRIM(THIS.this_cRegiaos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdReg")
            IF USED("cursor_4c_UpdReg")
                USE IN cursor_4c_UpdReg
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar regi" + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remover todos os filhos existentes e reinserir
                loc_cSQL = "DELETE FROM SigCdRgi" + ;
                           " WHERE skchaves = " + EscaparSQL(ALLTRIM(THIS.this_cSkChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgi")
                IF USED("cursor_4c_DelRgi")
                    USE IN cursor_4c_DelRgi
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao remover municipios/vendedores:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lSucesso = THIS.InserirFilhos(ALLTRIM(THIS.this_cSkChaves))
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE de SigCdRgi + SigCdReg
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Excluir filhos primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM SigCdRgi" + ;
                       " WHERE skchaves = " + EscaparSQL(ALLTRIM(THIS.this_cSkChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgi")
            IF USED("cursor_4c_DelRgi")
                USE IN cursor_4c_DelRgi
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao excluir municipios/vendedores:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir regiao principal
                loc_cSQL = "DELETE FROM SigCdReg" + ;
                           " WHERE regiaos = " + EscaparSQL(ALLTRIM(THIS.this_cRegiaos))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelReg")
                IF USED("cursor_4c_DelReg")
                    USE IN cursor_4c_DelReg
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir regi" + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cRegiaos)
    ENDPROC

ENDDEFINE

