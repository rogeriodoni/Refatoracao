# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 185: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 210: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 235: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 260: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 285: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 323: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 431: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 456: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMtp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1513 linhas total):

*-- Linhas 41 a 60:
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             THIS.Caption = "Modelos de Trabalho de Produ" + CHR(231) + CHR(227) + "o"
45: 
46:             THIS.this_oBusinessObject = CREATEOBJECT("MtpBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar MtpBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "FormMtp.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Visible   = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual           = "LISTA"
59: 
60:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 83 a 102:
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount = 2
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .Tabs      = .F.
91:             .Visible   = .T.
92: 
93:             .Page1.Caption   = "Lista"
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()

*-- Linhas 115 a 155:
115:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116: 
117:         *-- Container Cabecalho (cntSombra no legado)
118:         *-- Original Top=1; com compensacao +29 para PageFrame.Top=-29: Top=31
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
132:             .Caption   = THIS.Caption
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = 769
136:             .Height    = 40
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .AutoSize  = .F.
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = 769
152:             .Height    = 46
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.

*-- Linhas 163 a 349:
163:         *-- Canonico: Left=542, Top=29, Width=390, Height=85
164:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
165:         WITH loc_oPagina.cnt_4c_Botoes
166:             .Top         = 29
167:             .Left        = 542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackStyle   = 0
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         *-- Botao Incluir (Inserir no legado: Left=5, Top=5)
176:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
177:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
178:             .Caption         = "Incluir"
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:             .PicturePosition = 13
181:             .Top             = 5
182:             .Left            = 5
183:             .Width           = 75
184:             .Height          = 75
185:             .FontName        = "Comic Sans MS"
186:             .FontBold        = .T.
187:             .FontItalic      = .T.
188:             .FontSize        = 8
189:             .ForeColor       = RGB(90, 90, 90)
190:             .BackColor       = RGB(255, 255, 255)
191:             .Themes          = .F.
192:             .SpecialEffect   = 0
193:             .MousePointer    = 15
194:             .WordWrap        = .T.
195:             .AutoSize        = .F.
196:             .Visible         = .T.
197:         ENDWITH
198:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
199: 
200:         *-- Botao Visualizar (Consultar no legado: Left=81, Top=5)
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
203:             .Caption         = "Visualizar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:             .PicturePosition = 13
206:             .Top             = 5
207:             .Left            = 80
208:             .Width           = 75
209:             .Height          = 75
210:             .FontName        = "Comic Sans MS"
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .FontSize        = 8
214:             .ForeColor       = RGB(90, 90, 90)
215:             .BackColor       = RGB(255, 255, 255)
216:             .Themes          = .F.
217:             .SpecialEffect   = 0
218:             .MousePointer    = 15
219:             .WordWrap        = .T.
220:             .AutoSize        = .F.
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
224: 
225:         *-- Botao Alterar (Alterar no legado: Left=157, Top=5)
226:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
227:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
228:             .Caption         = "Alterar"
229:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
230:             .PicturePosition = 13
231:             .Top             = 5
232:             .Left            = 155
233:             .Width           = 75
234:             .Height          = 75
235:             .FontName        = "Comic Sans MS"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .ForeColor       = RGB(90, 90, 90)
240:             .BackColor       = RGB(255, 255, 255)
241:             .Themes          = .F.
242:             .SpecialEffect   = 0
243:             .MousePointer    = 15
244:             .WordWrap        = .T.
245:             .AutoSize        = .F.
246:             .Visible         = .T.
247:         ENDWITH
248:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
249: 
250:         *-- Botao Excluir (Excluir no legado: Left=233, Top=5)
251:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
252:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
253:             .Caption         = "Excluir"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
255:             .PicturePosition = 13
256:             .Top             = 5
257:             .Left            = 230
258:             .Width           = 75
259:             .Height          = 75
260:             .FontName        = "Comic Sans MS"
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .FontSize        = 8
264:             .ForeColor       = RGB(90, 90, 90)
265:             .BackColor       = RGB(255, 255, 255)
266:             .Themes          = .F.
267:             .SpecialEffect   = 0
268:             .MousePointer    = 15
269:             .WordWrap        = .T.
270:             .AutoSize        = .F.
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
274: 
275:         *-- Botao Buscar (Procurar no legado: Left=309, Top=5)
276:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
278:             .Caption         = "Buscar"
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
280:             .PicturePosition = 13
281:             .Top             = 5
282:             .Left            = 305
283:             .Width           = 75
284:             .Height          = 75
285:             .FontName        = "Comic Sans MS"
286:             .FontBold        = .T.
287:             .FontItalic      = .T.
288:             .FontSize        = 8
289:             .ForeColor       = RGB(90, 90, 90)
290:             .BackColor       = RGB(255, 255, 255)
291:             .Themes          = .F.
292:             .SpecialEffect   = 0
293:             .MousePointer    = 15
294:             .WordWrap        = .T.
295:             .AutoSize        = .F.
296:             .Visible         = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
299: 
300:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
301:         *-- Legado: Grupo_Saida.Left=719, Top=-1. Canonico: Left=917, Top=29, Width=90
302:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
303:         WITH loc_oPagina.cnt_4c_Saida
304:             .Top         = 29
305:             .Left        = 917
306:             .Width       = 90
307:             .Height      = 85
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         *-- Botao Encerrar (Sair no legado: Left=5, Top=5 dentro de Grupo_Saida)
314:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
315:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
316:             .Caption         = "Encerrar"
317:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
318:             .PicturePosition = 13
319:             .Top             = 5
320:             .Left            = 5
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
336:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
337: 
338:         *-- Grid de lista (Grade no legado: FontName=Tahoma, FontSize=8, ForeColor=90,90,90)
339:         *-- Colunas originais: Tipos (Codigo), descs (Descricao), limites (Prod. Minima)
340:         *-- Top=88+29=117 (compensacao PageFrame), Width=890 (nao sobrepoe cnt_4c_Saida)
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         loc_oGrid              = loc_oPagina.grd_4c_Lista
343:         loc_oGrid.Top          = 117
344:         loc_oGrid.Left         = 26
345:         loc_oGrid.Width        = 890
346:         loc_oGrid.Height       = 498
347:         loc_oGrid.ColumnCount  = 3
348:         loc_oGrid.RecordSource = ""
349:         loc_oGrid.FontName     = "Tahoma"

*-- Linhas 366 a 481:
366:             .Alignment = 0
367:         ENDWITH
368:         WITH loc_oGrid.Column1.Header1
369:             .Caption  = "C" + CHR(243) + "digo"
370:             .FontName = "Tahoma"
371:             .FontSize = 8
372:         ENDWITH
373: 
374:         WITH loc_oGrid.Column2
375:             .Width     = 440
376:             .Alignment = 0
377:         ENDWITH
378:         WITH loc_oGrid.Column2.Header1
379:             .Caption  = "Descri" + CHR(231) + CHR(227) + "o"
380:             .FontName = "Tahoma"
381:             .FontSize = 8
382:         ENDWITH
383: 
384:         WITH loc_oGrid.Column3
385:             .Width     = 150
386:             .Alignment = 3
387:         ENDWITH
388:         WITH loc_oGrid.Column3.Header1
389:             .Caption  = "Prod. M" + CHR(237) + "nima"
390:             .FontName = "Tahoma"
391:             .FontSize = 8
392:         ENDWITH
393: 
394:         THIS.TornarControlesVisiveis(loc_oPagina)
395:     ENDPROC
396: 
397:     *===========================================================================
398:     * ConfigurarPaginaDados - Configura Page2 com todos os campos do formulario
399:     * Campos: Tipos, Grupos, Descs, Limites, Fmaxs, Valors, Moedas+DescMoe, Ganhos
400:     * Tops originais do legado compensados em +29 (PageFrame.Top=-29)
401:     *===========================================================================
402:     PROTECTED PROCEDURE ConfigurarPaginaDados()
403:         LOCAL loc_oPagina
404:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
405: 
406:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
407:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
408: 
409:         *-- Container Salva/Cancelar (Grupo_Salva no legado: Left=842, Top=4+29=33)
410:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
411:         WITH loc_oPagina.cnt_4c_Salva
412:             .Top         = 33
413:             .Left        = 842
414:             .Width       = 160
415:             .Height      = 85
416:             .BackStyle   = 0
417:             .BorderWidth = 0
418:             .Visible     = .T.
419:         ENDWITH
420: 
421:         *-- Botao Confirmar (Salva.Left=5, Top=5 no legado)
422:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
423:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
424:             .Caption         = "Confirmar"
425:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
426:             .PicturePosition = 13
427:             .Top             = 5
428:             .Left            = 5
429:             .Width           = 75
430:             .Height          = 75
431:             .FontName        = "Comic Sans MS"
432:             .FontBold        = .T.
433:             .FontItalic      = .T.
434:             .FontSize        = 8
435:             .ForeColor       = RGB(90, 90, 90)
436:             .BackColor       = RGB(255, 255, 255)
437:             .Themes          = .F.
438:             .SpecialEffect   = 0
439:             .MousePointer    = 15
440:             .WordWrap        = .T.
441:             .AutoSize        = .F.
442:             .Visible         = .T.
443:         ENDWITH
444:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
445: 
446:         *-- Botao Cancelar (Cancelar.Left=81, Top=5 no legado)
447:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
448:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
449:             .Caption         = "Encerrar"
450:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
451:             .PicturePosition = 13
452:             .Top             = 5
453:             .Left            = 80
454:             .Width           = 75
455:             .Height          = 75
456:             .FontName        = "Comic Sans MS"
457:             .FontBold        = .T.
458:             .FontItalic      = .T.
459:             .FontSize        = 8
460:             .ForeColor       = RGB(90, 90, 90)
461:             .BackColor       = RGB(255, 255, 255)
462:             .Themes          = .F.
463:             .SpecialEffect   = 0
464:             .MousePointer    = 15
465:             .WordWrap        = .T.
466:             .AutoSize        = .F.
467:             .Visible         = .T.
468:         ENDWITH
469:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
470: 
471:         *-- === LINHA 1: Codigo (Say1.Top=147->176 / Get_tipos.Top=144->173) ===
472:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
473:         WITH loc_oPagina.lbl_4c_Codigo
474:             .Caption   = "C" + CHR(243) + "digo : "
475:             .Top       = 176
476:             .Left      = 250
477:             .Height    = 17
478:             .Width     = 49
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .FontBold  = .F.

*-- Linhas 489 a 516:
489:         loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
490:         WITH loc_oPagina.txt_4c_Tipos
491:             .Value     = ""
492:             .Top       = 173
493:             .Left      = 299
494:             .Width     = 24
495:             .Height    = 20
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .BackColor = RGB(255, 255, 255)
499:             .ForeColor = RGB(90, 90, 90)
500:             .Alignment = 0
501:             .MaxLength = 5
502:             .TabIndex  = 1
503:             .Visible   = .T.
504:         ENDWITH
505: 
506:         *-- === LINHA 2: Grupo (Say8.Top=174->203 / Get_grupo.Top=171->200) ===
507:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
508:         WITH loc_oPagina.lbl_4c_Grupo
509:             .Caption   = "Grupo : "
510:             .Top       = 203
511:             .Left      = 254
512:             .Height    = 17
513:             .Width     = 45
514:             .FontName  = "Tahoma"
515:             .FontSize  = 8
516:             .FontBold  = .F.

*-- Linhas 524 a 533:
524:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
525:         WITH loc_oPagina.txt_4c_Grupo
526:             .Value     = ""
527:             .Top       = 200
528:             .Left      = 299
529:             .Width     = 80
530:             .Height    = 20
531:             .FontName  = "Tahoma"
532:             .FontSize  = 8
533:             .BackColor = RGB(255, 255, 255)

*-- Linhas 541 a 554:
541:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "GrupoKeyPress")
542:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick",  THIS, "GrupoDblClick")
543: 
544:         *-- === LINHA 3: Descricao (Say2.Top=202->231 / Get_Descs.Top=199->228) ===
545:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
546:         WITH loc_oPagina.lbl_4c_Descricao
547:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
548:             .Top       = 231
549:             .Left      = 237
550:             .Height    = 17
551:             .Width     = 62
552:             .FontName  = "Tahoma"
553:             .FontSize  = 8
554:             .FontBold  = .F.

*-- Linhas 562 a 588:
562:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
563:         WITH loc_oPagina.txt_4c_Descricao
564:             .Value     = ""
565:             .Top       = 228
566:             .Left      = 299
567:             .Width     = 80
568:             .Height    = 20
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .BackColor = RGB(255, 255, 255)
572:             .ForeColor = RGB(90, 90, 90)
573:             .Alignment = 0
574:             .TabIndex  = 3
575:             .Visible   = .T.
576:         ENDWITH
577: 
578:         *-- === LINHA 4: Producao Minima (Say3.Top=229->258 / Get_limites.Top=226->255) ===
579:         loc_oPagina.AddObject("lbl_4c_ProdMinima", "Label")
580:         WITH loc_oPagina.lbl_4c_ProdMinima
581:             .Caption   = "Produ" + CHR(231) + CHR(227) + "o M" + CHR(237) + "nima : "
582:             .Top       = 258
583:             .Left      = 203
584:             .Height    = 17
585:             .Width     = 96
586:             .FontName  = "Tahoma"
587:             .FontSize  = 8
588:             .FontBold  = .F.

*-- Linhas 596 a 622:
596:         loc_oPagina.AddObject("txt_4c_Limites", "TextBox")
597:         WITH loc_oPagina.txt_4c_Limites
598:             .Value     = 0
599:             .Top       = 255
600:             .Left      = 299
601:             .Width     = 94
602:             .Height    = 20
603:             .FontName  = "Tahoma"
604:             .FontSize  = 8
605:             .BackColor = RGB(255, 255, 255)
606:             .ForeColor = RGB(90, 90, 90)
607:             .Alignment = 3
608:             .TabIndex  = 4
609:             .Visible   = .T.
610:         ENDWITH
611: 
612:         *-- === LINHA 5: Falha Admitida (Say4.Top=256->285 / Get_fmaxs.Top=253->282) + % (Say6.Top=256->285) ===
613:         loc_oPagina.AddObject("lbl_4c_FalhaAdmitida", "Label")
614:         WITH loc_oPagina.lbl_4c_FalhaAdmitida
615:             .Caption   = "Falha Admitida : "
616:             .Top       = 285
617:             .Left      = 213
618:             .Height    = 17
619:             .Width     = 86
620:             .FontName  = "Tahoma"
621:             .FontSize  = 8
622:             .FontBold  = .F.

*-- Linhas 630 a 671:
630:         loc_oPagina.AddObject("txt_4c_Fmaxs", "TextBox")
631:         WITH loc_oPagina.txt_4c_Fmaxs
632:             .Value     = 0
633:             .Top       = 282
634:             .Left      = 299
635:             .Width     = 66
636:             .Height    = 23
637:             .FontName  = "Tahoma"
638:             .FontSize  = 8
639:             .BackColor = RGB(255, 255, 255)
640:             .ForeColor = RGB(90, 90, 90)
641:             .Alignment = 3
642:             .TabIndex  = 5
643:             .Visible   = .T.
644:         ENDWITH
645: 
646:         loc_oPagina.AddObject("lbl_4c_Porcentagem", "Label")
647:         WITH loc_oPagina.lbl_4c_Porcentagem
648:             .Caption   = "%"
649:             .Top       = 285
650:             .Left      = 371
651:             .Height    = 17
652:             .Width     = 15
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .FontBold  = .F.
656:             .ForeColor = RGB(90, 90, 90)
657:             .BackStyle = 0
658:             .Visible   = .T.
659:         ENDWITH
660: 
661:         *-- === LINHA 6: Valor do Premio (Say5.Top=284->313 / Get_valors.Top=281->310) ===
662:         loc_oPagina.AddObject("lbl_4c_ValorPremio", "Label")
663:         WITH loc_oPagina.lbl_4c_ValorPremio
664:             .Caption   = "Valor do Pr" + CHR(234) + "mio : "
665:             .Top       = 313
666:             .Left      = 209
667:             .Height    = 17
668:             .Width     = 90
669:             .FontName  = "Tahoma"
670:             .FontSize  = 8
671:             .FontBold  = .F.

*-- Linhas 679 a 705:
679:         loc_oPagina.AddObject("txt_4c_Valors", "TextBox")
680:         WITH loc_oPagina.txt_4c_Valors
681:             .Value     = 0
682:             .Top       = 310
683:             .Left      = 299
684:             .Width     = 66
685:             .Height    = 20
686:             .FontName  = "Tahoma"
687:             .FontSize  = 8
688:             .BackColor = RGB(255, 255, 255)
689:             .ForeColor = RGB(90, 90, 90)
690:             .Alignment = 3
691:             .TabIndex  = 6
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         *-- === LINHA 7: Moeda (Say7.Top=311->340) + Cmoes (Top=308->337) + Dmoes (Top=308->337) ===
696:         loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
697:         WITH loc_oPagina.lbl_4c_Moeda
698:             .Caption   = "Moeda : "
699:             .Top       = 340
700:             .Left      = 251
701:             .Height    = 17
702:             .Width     = 48
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .FontBold  = .F.

*-- Linhas 713 a 722:
713:         loc_oPagina.AddObject("txt_4c_Moedas", "TextBox")
714:         WITH loc_oPagina.txt_4c_Moedas
715:             .Value     = ""
716:             .Top       = 337
717:             .Left      = 299
718:             .Width     = 31
719:             .Height    = 20
720:             .FontName  = "Tahoma"
721:             .FontSize  = 8
722:             .BackColor = RGB(255, 255, 255)

*-- Linhas 733 a 742:
733:         loc_oPagina.AddObject("txt_4c_DescMoe", "TextBox")
734:         WITH loc_oPagina.txt_4c_DescMoe
735:             .Value     = ""
736:             .Top       = 337
737:             .Left      = 335
738:             .Width     = 115
739:             .Height    = 20
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .BackColor = RGB(255, 255, 255)

*-- Linhas 749 a 763:
749:         BINDEVENT(loc_oPagina.txt_4c_DescMoe, "KeyPress",  THIS, "DescMoeKeyPress")
750:         BINDEVENT(loc_oPagina.txt_4c_DescMoe, "DblClick",  THIS, "DescMoeDblClick")
751: 
752:         *-- === LINHA 8: Contabilizar Ganhos (fwcheckbox.Top=338->367) ===
753:         loc_oPagina.AddObject("chk_4c_Ganhos", "CheckBox")
754:         WITH loc_oPagina.chk_4c_Ganhos
755:             .Caption   = "Contabilizar Ganhos"
756:             .Value     = 0
757:             .Top       = 367
758:             .Left      = 298
759:             .Width     = 132
760:             .Height    = 17
761:             .FontName  = "Tahoma"
762:             .FontSize  = 8
763:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 848 a 858:
848:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.limites"
849: 
850:                     *-- Reconfigurar cabecalhos APOS ControlSource (VFP9 reseta ao alterar)
851:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
852:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
853:                     loc_oGrid.Column3.Header1.Caption = "Prod. M" + CHR(237) + "nima"
854: 
855:                     THIS.FormatarGridLista(loc_oGrid)
856:                     loc_lResultado = .T.
857:                 ENDIF
858:             CATCH TO loException

*-- Linhas 1284 a 1292:
1284:         loc_oPag2.chk_4c_Ganhos.Enabled     = par_lHabilitar
1285: 
1286:         IF VARTYPE(loc_oPag2.cnt_4c_Salva) = "O"
1287:             loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1288:         ENDIF
1289:     ENDPROC
1290: 
1291:     *===========================================================================
1292:     * LimparCampos - Limpa todos os campos de Page2 para valores defaults

*-- Linhas 1495 a 1503:
1495:             loc_oPag2.txt_4c_Descricao.SetFocus()
1496:         CASE THIS.this_cModoAtual == "VISUALIZAR"
1497:             IF VARTYPE(loc_oPag2.cnt_4c_Salva) = "O"
1498:                 loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
1499:             ENDIF
1500:         ENDCASE
1501:     ENDPROC
1502: 
1503:     *===========================================================================


### BO (C:\4c\projeto\app\classes\MtpBO.prg):
*==============================================================================
* MtpBO.prg - Business Object para Modelos de Trabalho de Producao
* Tabela: SigIdPcp
* Migrado de: SigCdMtp.SCX
*==============================================================================

DEFINE CLASS MtpBO AS BusinessBase

    *-- Chave primaria (gerada internamente no INSERT)
    this_cIdChaves = ""

    *-- Chave de negocio composta: Tipos + Grupos
    this_cTipos    = ""
    this_cGrupos   = ""

    *-- Dados principais
    this_cDescs    = ""
    this_nLimites  = 0
    this_nFmaxs    = 0
    this_nValors   = 0
    this_cMoedas   = ""
    this_lGanhos   = .F.

    *-- Exibicao (nao persistido na tabela SigIdPcp)
    this_cDescMoe  = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigIdPcp"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * Buscar - Lista registros de SigIdPcp com JOIN para descricao de moeda
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.tipos LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.tipos, a.grupos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar modelos de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar modelos de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorTipoGrupo - Carrega registro pela chave de negocio tipos+grupos
    *==========================================================================
    PROCEDURE CarregarPorTipoGrupo(par_cTipos, par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes" + ;
                       " WHERE a.tipos = " + EscaparSQL(par_cTipos) + ;
                       " AND a.grupos = " + EscaparSQL(par_cGrupos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar modelo por tipo/grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com tipos+grupos
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigIdPcp" + ;
                       " WHERE tipos = " + EscaparSQL(THIS.this_cTipos) + ;
                       " AND grupos = " + EscaparSQL(THIS.this_cGrupos)

            IF !EMPTY(ALLTRIM(THIS.this_cIdChaves))
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(THIS.this_cIdChaves)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dupl")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dupl") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves = ALLTRIM(NVL(cidchaves, ""))
            THIS.this_cTipos    = ALLTRIM(NVL(tipos,     ""))
            THIS.this_cGrupos   = ALLTRIM(NVL(grupos,    ""))
            THIS.this_cDescs    = ALLTRIM(NVL(descs,     ""))
            THIS.this_nLimites  = NVL(limites, 0)
            THIS.this_nFmaxs    = NVL(fmaxs,   0)
            THIS.this_nValors   = NVL(valors,  0)
            THIS.this_cMoedas   = ALLTRIM(NVL(moedas,   ""))
            IF VARTYPE(ganhos) = "L"
                THIS.this_lGanhos = ganhos
            ELSE
                THIS.this_lGanhos = (NVL(ganhos, 0) = 1)
            ENDIF
            THIS.this_cDescMoe  = ALLTRIM(NVL(desc_moe, ""))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigIdPcp
    * Gera cidchaves via fUniqueIds()
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cTipos))
                MsgAviso("C" + CHR(243) + "digo do tipo obrigat" + CHR(243) + "rio!", "Erro de valida" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cGrupos))
                    MsgErro("Grupo obrigat" + CHR(243) + "rio!", "Erro de valida" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF THIS.VerificarDuplicidade()
                        MsgErro("J" + CHR(225) + " existe registro com este Tipo e Grupo!", "Erro de valida" + CHR(231) + CHR(227) + "o")
                    ELSE
                        THIS.this_cIdChaves = fUniqueIds()

                        loc_cSQL = "INSERT INTO SigIdPcp" + ;
                                   " (cidchaves, tipos, grupos, descs," + ;
                                   " limites, fmaxs, valors, moedas, ganhos)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cIdChaves)           + ", " + ;
                                   EscaparSQL(THIS.this_cTipos)              + ", " + ;
                                   EscaparSQL(THIS.this_cGrupos)             + ", " + ;
                                   EscaparSQL(THIS.this_cDescs)              + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nLimites, 2)  + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nFmaxs,   2)  + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nValors,  2)  + ", " + ;
                                   EscaparSQL(THIS.this_cMoedas)             + ", " + ;
                                   IIF(THIS.this_lGanhos, "1", "0")          + ;
                                   ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado >= 0
                            THIS.RegistrarAuditoria("INSERT")
                            loc_lSucesso = .T.
                        ELSE
                            MsgErro("Erro ao inserir modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigIdPcp (cidchaves e chave, nao alterar)
    * tipos e grupos podem ser alterados (nao sao a PK tecnica)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                MsgErro("J" + CHR(225) + " existe outro registro com este Tipo e Grupo!", "Erro de valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "UPDATE SigIdPcp SET" + ;
                           " tipos   = " + EscaparSQL(THIS.this_cTipos)             + ", " + ;
                           " grupos  = " + EscaparSQL(THIS.this_cGrupos)            + ", " + ;
                           " descs   = " + EscaparSQL(THIS.this_cDescs)             + ", " + ;
                           " limites = " + FormatarNumeroSQL(THIS.this_nLimites, 2) + ", " + ;
                           " fmaxs   = " + FormatarNumeroSQL(THIS.this_nFmaxs,   2) + ", " + ;
                           " valors  = " + FormatarNumeroSQL(THIS.this_nValors,  2) + ", " + ;
                           " moedas  = " + EscaparSQL(THIS.this_cMoedas)            + ", " + ;
                           " ganhos  = " + IIF(THIS.this_lGanhos, "1", "0") + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE da tabela SigIdPcp
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigIdPcp" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

