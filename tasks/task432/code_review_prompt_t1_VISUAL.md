# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 328: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 352: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 376: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 400: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 424: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 451: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 825: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 849: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFte.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1029 linhas total):

*-- Linhas 107 a 128:
107:                 THIS.this_oBusinessObject.this_cContextTitulos = THIS.this_cContextTitulos
108: 
109:                 *-- Caption dinamico: "Ficha Tecnica - Cargo - Titulo"
110:                 THIS.Caption = "Ficha T" + CHR(233) + "cnica - " + ;
111:                                ALLTRIM(THIS.this_cContextCargos) + " - " + ;
112:                                ALLTRIM(THIS.this_cContextTitulos)
113: 
114:                 *-- Montar estrutura visual base
115:                 THIS.ConfigurarPageFrame()
116:                 THIS.ConfigurarPaginaLista()
117:                 THIS.ConfigurarPaginaDados()
118: 
119:                 *-- Propagar caption nos labels de titulo (sombra/titulo em ambas paginas)
120:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption  = THIS.Caption
121:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption  = THIS.Caption
122:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_sombra2.Caption = THIS.Caption
123:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_titulo2.Caption = THIS.Caption
124: 
125:                 THIS.pgf_4c_Paginas.Visible    = .T.
126:                 THIS.pgf_4c_Paginas.ActivePage = 1
127:                 THIS.this_cModoAtual = "LISTA"
128: 

*-- Linhas 143 a 282:
143:     *==========================================================================
144:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas e containers base
145:     *
146:     * Compensacao PageFrame.Top = -29:
147:     *   Todos os controles dentro das Pages compensam +29 no Top.
148:     *   cntSombra (original Top=2) -> Top = 31
149:     *   grupo_op  (original Top=-1) -> Top = 28 -> canonico: 29
150:     *   grupo_salva (original Top=4) -> Top = 33
151:     *==========================================================================
152:     PROTECTED PROCEDURE ConfigurarPageFrame()
153:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
154: 
155:         WITH THIS.pgf_4c_Paginas
156:             .PageCount = 2
157:             .Top       = -29
158:             .Left      = 0
159:             .Width     = 1003
160:             .Height    = 631    && VFP9 adiciona +4 em runtime -> total 635
161:             .Tabs      = .F.
162:         ENDWITH
163: 
164:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
165:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
166:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
167: 
168:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
169:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
170:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
171: 
172:         *----------------------------------------------------------------------
173:         * PAGE 1 - Container sombra/titulo (cntSombra Top=2 + comp29 = 31)
174:         *----------------------------------------------------------------------
175:         THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_Sombra", "Container")
176:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra
177:             .Top         = 31
178:             .Left        = 0
179:             .Width       = 1003
180:             .Height      = 80
181:             .BackColor   = RGB(100, 100, 100)
182:             .BorderWidth = 0
183:             .Visible     = .T.
184:         ENDWITH
185: 
186:         THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
187:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra
188:             .Caption   = THIS.Caption
189:             .Top       = 15
190:             .Left      = 12
191:             .Width     = 980
192:             .Height    = 40
193:             .FontName  = "Tahoma"
194:             .FontSize  = 16
195:             .FontBold  = .T.
196:             .ForeColor = RGB(0, 0, 0)
197:             .BackStyle = 0
198:             .AutoSize  = .F.
199:             .Visible   = .T.
200:         ENDWITH
201: 
202:         THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
203:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo
204:             .Caption   = THIS.Caption
205:             .Top       = 18
206:             .Left      = 10
207:             .Width     = 980
208:             .Height    = 46
209:             .FontName  = "Tahoma"
210:             .FontSize  = 16
211:             .FontBold  = .T.
212:             .ForeColor = RGB(255, 255, 255)
213:             .BackStyle = 0
214:             .AutoSize  = .F.
215:             .Visible   = .T.
216:         ENDWITH
217: 
218:         *-- Container botoes CRUD - Page1
219:         *-- Canonico: Left=542 (escalonado de grupo_op.Left=344 na form 800->1000px)
220:         THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_Botoes", "Container")
221:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
222:             .Top         = 29
223:             .Left        = 542
224:             .Width       = 380
225:             .Height      = 88
226:             .BackStyle   = 0
227:             .BorderWidth = 0
228:             .Visible     = .T.
229:         ENDWITH
230: 
231:         *-- Container botao Encerrar - Page1 (canonico: Left=917, Width=90)
232:         THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_Saida", "Container")
233:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida
234:             .Top         = 29
235:             .Left        = 917
236:             .Width       = 90
237:             .Height      = 85
238:             .BackStyle   = 0
239:             .BorderWidth = 0
240:             .Visible     = .T.
241:         ENDWITH
242: 
243:         *----------------------------------------------------------------------
244:         * PAGE 2 - Container sombra/titulo (compensacao Top = 2 + 29 = 31)
245:         *----------------------------------------------------------------------
246:         THIS.pgf_4c_Paginas.Page2.AddObject("cnt_4c_Sombra", "Container")
247:         WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra
248:             .Top         = 31
249:             .Left        = 0
250:             .Width       = 1003
251:             .Height      = 80
252:             .BackColor   = RGB(100, 100, 100)
253:             .BorderWidth = 0
254:             .Visible     = .T.
255:         ENDWITH
256: 
257:         THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.AddObject("lbl_4c_sombra2", "Label")
258:         WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_sombra2
259:             .Caption   = THIS.Caption
260:             .Top       = 15
261:             .Left      = 12
262:             .Width     = 980
263:             .Height    = 40
264:             .FontName  = "Tahoma"
265:             .FontSize  = 16
266:             .FontBold  = .T.
267:             .ForeColor = RGB(0, 0, 0)
268:             .BackStyle = 0
269:             .AutoSize  = .F.
270:             .Visible   = .T.
271:         ENDWITH
272: 
273:         THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.AddObject("lbl_4c_titulo2", "Label")
274:         WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_titulo2
275:             .Caption   = THIS.Caption
276:             .Top       = 18
277:             .Left      = 10
278:             .Width     = 980
279:             .Height    = 46
280:             .FontName  = "Tahoma"
281:             .FontSize  = 16
282:             .FontBold  = .T.

*-- Linhas 290 a 299:
290:         *-- grupo_salva: Top=4 + comp29 = 33, Left=842 (canonico)
291:         THIS.pgf_4c_Paginas.Page2.AddObject("cnt_4c_BotoesAcao", "Container")
292:         WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
293:             .Top         = 33
294:             .Left        = 842
295:             .Width       = 160
296:             .Height      = 85
297:             .BackStyle   = 0
298:             .BorderWidth = 0
299:             .Visible     = .T.

*-- Linhas 316 a 483:
316:         * Botoes CRUD - Left=5/80/155/230/305, Top=5, 75x75
317:         * Ordem original: inserir, consultar, alterar, excluir, procurar
318:         *----------------------------------------------------------------------
319:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
320:         WITH loc_oCnt.cmd_4c_Incluir
321:             .Caption         = "Incluir"
322:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
323:             .PicturePosition = 13
324:             .Top             = 5
325:             .Left            = 5
326:             .Width           = 75
327:             .Height          = 75
328:             .FontName        = "Comic Sans MS"
329:             .FontBold        = .T.
330:             .FontItalic      = .T.
331:             .FontSize        = 8
332:             .ForeColor       = RGB(90, 90, 90)
333:             .BackColor       = RGB(255, 255, 255)
334:             .Themes          = .F.
335:             .SpecialEffect   = 0
336:             .MousePointer    = 15
337:             .WordWrap        = .T.
338:             .AutoSize        = .F.
339:             .Visible         = .T.
340:         ENDWITH
341:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
342: 
343:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
344:         WITH loc_oCnt.cmd_4c_Visualizar
345:             .Caption         = "Visualizar"
346:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
347:             .PicturePosition = 13
348:             .Top             = 5
349:             .Left            = 80
350:             .Width           = 75
351:             .Height          = 75
352:             .FontName        = "Comic Sans MS"
353:             .FontBold        = .T.
354:             .FontItalic      = .T.
355:             .FontSize        = 8
356:             .ForeColor       = RGB(90, 90, 90)
357:             .BackColor       = RGB(255, 255, 255)
358:             .Themes          = .F.
359:             .SpecialEffect   = 0
360:             .MousePointer    = 15
361:             .WordWrap        = .T.
362:             .AutoSize        = .F.
363:             .Visible         = .T.
364:         ENDWITH
365:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
366: 
367:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
368:         WITH loc_oCnt.cmd_4c_Alterar
369:             .Caption         = "Alterar"
370:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
371:             .PicturePosition = 13
372:             .Top             = 5
373:             .Left            = 155
374:             .Width           = 75
375:             .Height          = 75
376:             .FontName        = "Comic Sans MS"
377:             .FontBold        = .T.
378:             .FontItalic      = .T.
379:             .FontSize        = 8
380:             .ForeColor       = RGB(90, 90, 90)
381:             .BackColor       = RGB(255, 255, 255)
382:             .Themes          = .F.
383:             .SpecialEffect   = 0
384:             .MousePointer    = 15
385:             .WordWrap        = .T.
386:             .AutoSize        = .F.
387:             .Visible         = .T.
388:         ENDWITH
389:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
390: 
391:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
392:         WITH loc_oCnt.cmd_4c_Excluir
393:             .Caption         = "Excluir"
394:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
395:             .PicturePosition = 13
396:             .Top             = 5
397:             .Left            = 230
398:             .Width           = 75
399:             .Height          = 75
400:             .FontName        = "Comic Sans MS"
401:             .FontBold        = .T.
402:             .FontItalic      = .T.
403:             .FontSize        = 8
404:             .ForeColor       = RGB(90, 90, 90)
405:             .BackColor       = RGB(255, 255, 255)
406:             .Themes          = .F.
407:             .SpecialEffect   = 0
408:             .MousePointer    = 15
409:             .WordWrap        = .T.
410:             .AutoSize        = .F.
411:             .Visible         = .T.
412:         ENDWITH
413:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
414: 
415:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
416:         WITH loc_oCnt.cmd_4c_Buscar
417:             .Caption         = "Buscar"
418:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
419:             .PicturePosition = 13
420:             .Top             = 5
421:             .Left            = 305
422:             .Width           = 75
423:             .Height          = 75
424:             .FontName        = "Comic Sans MS"
425:             .FontBold        = .T.
426:             .FontItalic      = .T.
427:             .FontSize        = 8
428:             .ForeColor       = RGB(90, 90, 90)
429:             .BackColor       = RGB(255, 255, 255)
430:             .Themes          = .F.
431:             .SpecialEffect   = 0
432:             .MousePointer    = 15
433:             .WordWrap        = .T.
434:             .AutoSize        = .F.
435:             .Visible         = .T.
436:         ENDWITH
437:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
438: 
439:         *----------------------------------------------------------------------
440:         * Botao Encerrar (padrao canonico: cnt_4c_Saida.Left=917, Width=90)
441:         *----------------------------------------------------------------------
442:         loc_oCntSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
443:         WITH loc_oCntSaida.cmd_4c_Encerrar
444:             .Caption         = "Encerrar"
445:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
446:             .PicturePosition = 13
447:             .Top             = 5
448:             .Left            = 5
449:             .Width           = 75
450:             .Height          = 75
451:             .FontName        = "Comic Sans MS"
452:             .FontBold        = .T.
453:             .FontItalic      = .T.
454:             .FontSize        = 8
455:             .ForeColor       = RGB(90, 90, 90)
456:             .BackColor       = RGB(255, 255, 255)
457:             .Themes          = .F.
458:             .SpecialEffect   = 0
459:             .MousePointer    = 15
460:             .WordWrap        = .T.
461:             .AutoSize        = .F.
462:             .Visible         = .T.
463:         ENDWITH
464:         BINDEVENT(loc_oCntSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
465: 
466:         *----------------------------------------------------------------------
467:         * Grid de listagem - grd_4c_Lista
468:         * FontName=Tahoma, FontSize=8, RowHeight=16, ForeColor=90,90,90
469:         * Top = cnt_4c_Sombra.Top(31) + cnt_4c_Sombra.Height(80) + 6 = 117
470:         * 2 colunas: Column1=Resps (Respostas), Column2=nResps (Fixa Sim/Nao)
471:         * ColumnCount FORA do WITH para evitar Problema 36 (criacao imediata)
472:         *----------------------------------------------------------------------
473:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
474:         loc_oPg1.grd_4c_Lista.ColumnCount = 2
475: 
476:         WITH loc_oPg1.grd_4c_Lista
477:             .Top                = 117
478:             .Left               = 10
479:             .Width              = 880
480:             .Height             = 440
481:             .FontName           = "Tahoma"
482:             .FontSize           = 8
483:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 491 a 501:
491:             .RecordMark         = .F.
492:             .RowHeight          = 16
493:             .ScrollBars         = 2
494:             .Column1.Header1.Caption = "Respostas"
495:             .Column1.Alignment       = 0
496:             .Column2.Header1.Caption = "Fixa"
497:             .Column2.Alignment       = 2
498:             .Visible            = .T.
499:         ENDWITH
500: 
501:         THIS.TornarControlesVisiveis(loc_oPg1)

*-- Linhas 526 a 538:
526:                 WITH loc_oGrid
527:                     .Column1.ControlSource   = "cursor_4c_Dados.Resps"
528:                     .Column1.Width           = 795
529:                     .Column1.Header1.Caption = "Respostas"
530:                     .Column1.Alignment       = 0
531:                     .Column2.ControlSource   = "IIF(cursor_4c_Dados.nResps=1,'Sim','N" + CHR(227) + "o')"
532:                     .Column2.Width           = 75
533:                     .Column2.Header1.Caption = "Fixa"
534:                     .Column2.Alignment       = 2
535:                 ENDWITH
536: 
537:                 THIS.FormatarGridLista(loc_oGrid)
538:                 loc_oGrid.Refresh()

*-- Linhas 591 a 616:
591: 
592:         DO CASE
593:             CASE THIS.this_cModoAtual = "LISTA"
594:                 IF VARTYPE(loc_oCnt) = "O" AND PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
595:                     loc_oCnt.cmd_4c_Incluir.Enabled    = THIS.this_lPermiteEditar
596:                     loc_oCnt.cmd_4c_Alterar.Enabled    = THIS.this_lPermiteEditar
597:                     loc_oCnt.cmd_4c_Excluir.Enabled    = THIS.this_lPermiteEditar
598:                     loc_oCnt.cmd_4c_Visualizar.Enabled = .T.
599:                     loc_oCnt.cmd_4c_Buscar.Enabled     = .T.
600:                 ENDIF
601: 
602:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
603:                 IF VARTYPE(loc_oCntAcao) = "O" AND PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
604:                     loc_oCntAcao.cmd_4c_Confirmar.Enabled = .T.
605:                     loc_oCntAcao.cmd_4c_Cancelar.Enabled  = .T.
606:                 ENDIF
607: 
608:             CASE THIS.this_cModoAtual = "VISUALIZAR"
609:                 IF VARTYPE(loc_oCntAcao) = "O" AND PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
610:                     loc_oCntAcao.cmd_4c_Confirmar.Enabled = .F.
611:                     loc_oCntAcao.cmd_4c_Cancelar.Enabled  = .T.
612:                 ENDIF
613:         ENDCASE
614:     ENDPROC
615: 
616:     *==========================================================================

*-- Linhas 796 a 804:
796:     * ConfigurarPaginaDados - Cria campos da Page2 (edicao/visualizacao)
797:     *
798:     * Fase 5 (primeira metade): botoes Confirmar/Cancelar + label + EditBox Resps
799:     * Compensacao PageFrame.Top=-29: todos os controles Top += 29.
800:     *
801:     * Original getResps: Top=217, Left=196, Width=408, Height=72
802:     *   -> migrado edt_4c_Resps: Top=246 (217+29)
803:     *==========================================================================
804:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 811 a 877:
811:         * Botoes Confirmar/Cancelar
812:         * Container cnt_4c_BotoesAcao ja criado em ConfigurarPageFrame:
813:         *   Left=842, Top=33, Width=160, Height=85
814:         * grupo_salva.salva.Left=5 / .cancelar.Left=80 (do original)
815:         *----------------------------------------------------------------------
816:         loc_oCntAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
817:         WITH loc_oCntAcao.cmd_4c_Confirmar
818:             .Caption         = "Confirmar"
819:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
820:             .PicturePosition = 13
821:             .Top             = 5
822:             .Left            = 5
823:             .Width           = 75
824:             .Height          = 75
825:             .FontName        = "Comic Sans MS"
826:             .FontBold        = .T.
827:             .FontItalic      = .T.
828:             .FontSize        = 8
829:             .ForeColor       = RGB(90, 90, 90)
830:             .BackColor       = RGB(255, 255, 255)
831:             .Themes          = .F.
832:             .SpecialEffect   = 0
833:             .MousePointer    = 15
834:             .WordWrap        = .T.
835:             .AutoSize        = .F.
836:             .Visible         = .T.
837:         ENDWITH
838:         BINDEVENT(loc_oCntAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
839: 
840:         loc_oCntAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
841:         WITH loc_oCntAcao.cmd_4c_Cancelar
842:             .Caption         = "Encerrar"
843:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
844:             .PicturePosition = 13
845:             .Top             = 5
846:             .Left            = 80
847:             .Width           = 75
848:             .Height          = 75
849:             .FontName        = "Comic Sans MS"
850:             .FontBold        = .T.
851:             .FontItalic      = .T.
852:             .FontSize        = 8
853:             .ForeColor       = RGB(90, 90, 90)
854:             .BackColor       = RGB(255, 255, 255)
855:             .Themes          = .F.
856:             .SpecialEffect   = 0
857:             .MousePointer    = 15
858:             .WordWrap        = .T.
859:             .AutoSize        = .F.
860:             .Visible         = .T.
861:         ENDWITH
862:         BINDEVENT(loc_oCntAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
863: 
864:         *----------------------------------------------------------------------
865:         * Label "Resposta:" - alinhado ao topo do EditBox
866:         * EditBox.Left=196, portanto label ocupa Left=10..193
867:         *----------------------------------------------------------------------
868:         loc_oPg2.AddObject("lbl_4c_Resps", "Label")
869:         WITH loc_oPg2.lbl_4c_Resps
870:             .Caption   = "Resposta:"
871:             .Top       = 246
872:             .Left      = 10
873:             .Width     = 183
874:             .Height    = 17
875:             .FontName  = "Tahoma"
876:             .FontSize  = 8
877:             .FontBold  = .F.

*-- Linhas 889 a 898:
889:         *----------------------------------------------------------------------
890:         loc_oPg2.AddObject("edt_4c_Resps", "EditBox")
891:         WITH loc_oPg2.edt_4c_Resps
892:             .Top        = 246
893:             .Left       = 196
894:             .Width      = 408
895:             .Height     = 72
896:             .FontName   = "Tahoma"
897:             .FontSize   = 8
898:             .ForeColor  = RGB(90, 90, 90)

*-- Linhas 904 a 920:
904:         ENDWITH
905: 
906:         *----------------------------------------------------------------------
907:         * CheckBox "Resposta Fixa" (chkRespFixa original)
908:         * Original: Top=294, Left=196, Width=109, Height=19
909:         * Migrado:  Top=323 (294+29, compensacao PageFrame)
910:         *----------------------------------------------------------------------
911:         loc_oPg2.AddObject("chk_4c_RespFixa", "CheckBox")
912:         WITH loc_oPg2.chk_4c_RespFixa
913:             .Caption   = "Resposta Fixa"
914:             .Top       = 323
915:             .Left      = 196
916:             .Width     = 109
917:             .Height    = 19
918:             .FontName  = "Tahoma"
919:             .FontSize  = 8
920:             .Alignment = 0

*-- Linhas 1013 a 1021:
1013: 
1014:         loc_oPg2.edt_4c_Resps.Enabled        = par_lHabilitar
1015:         loc_oPg2.chk_4c_RespFixa.Enabled     = par_lHabilitar
1016:         loc_oCntAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1017:     ENDPROC
1018: 
1019:     *==========================================================================
1020:     * Destroy - Libera recursos
1021:     *==========================================================================


### BO (C:\4c\projeto\app\classes\FteBO.prg):
*==============================================================================
* FteBO.prg - Business Object para Fichas Tecnicas
* Tabela: SigCdFtr
* PK: cIdChaves
*==============================================================================
DEFINE CLASS FteBO AS BusinessBase

    *-- Chave primaria
    this_cIdChaves    = ""

    *-- Campos de contexto (filtro/PK composta)
    this_cCGrus       = ""    && CGrus - Grupo
    this_cSGrus       = ""    && SGrus - SubGrupo
    this_cCCars       = ""    && CCars - Cargo
    this_cCTits       = ""    && CTits - Titulo
    this_cGruCarTits  = ""    && GruCarTits - Chave composta (CGrus+CCars+CTits+SGrus)

    *-- Campos de conteudo
    this_cResps       = ""    && Resps - Texto da resposta (memo)
    this_nNResps      = 0     && nResps - Resposta Fixa (0=Nao, 1=Sim)

    *-- Contexto de abertura (parametros recebidos pelo form)
    this_cContextGrupos  = ""
    this_cContextSubGrp  = ""
    this_cContextCargos  = ""
    this_cContextTitulos = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdFtr"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT filtrado pelo contexto (GruCarTits = CGrus+CCars+CTits+SGrus)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cChave, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.this_cContextGrupos + THIS.this_cContextCargos + ;
                         THIS.this_cContextTitulos + THIS.this_cContextSubGrp

            loc_cSQL = "SELECT cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits," + ;
                       " Resps, nResps" + ;
                       " FROM SigCdFtr" + ;
                       " WHERE GruCarTits = " + EscaparSQL(loc_cChave)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cIdChaves"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar fichas t" + CHR(233) + "cnicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por PK (cIdChaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits," + ;
                       " Resps, nResps" + ;
                       " FROM SigCdFtr" + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves   = TratarNulo(cIdChaves,   "C")
            THIS.this_cCGrus      = TratarNulo(CGrus,        "C")
            THIS.this_cSGrus      = TratarNulo(SGrus,        "C")
            THIS.this_cCCars      = TratarNulo(CCars,        "C")
            THIS.this_cCTits      = TratarNulo(CTits,        "C")
            THIS.this_cGruCarTits = TratarNulo(GruCarTits,   "C")
            THIS.this_cResps      = TratarNulo(Resps,        "C")
            THIS.this_nNResps     = TratarNulo(nResps,       "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_cNovaChave, loc_nResId, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cNovaChave = ""
            loc_nResId = SQLEXEC(gnConnHandle, "SELECT CONVERT(varchar(36), NEWID()) AS NovaChave", "cursor_4c_NewId")
            IF loc_nResId >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                loc_cNovaChave = ALLTRIM(cursor_4c_NewId.NovaChave)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF

            IF EMPTY(loc_cNovaChave)
                MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ELSE
                THIS.this_cIdChaves   = loc_cNovaChave
                THIS.this_cGruCarTits = THIS.this_cCGrus + THIS.this_cCCars + ;
                                        THIS.this_cCTits + THIS.this_cSGrus

                loc_cSQL = "INSERT INTO SigCdFtr" + ;
                           " (cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits, Resps, nResps)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cIdChaves)   + ", " + ;
                           EscaparSQL(THIS.this_cCGrus)      + ", " + ;
                           EscaparSQL(THIS.this_cSGrus)      + ", " + ;
                           EscaparSQL(THIS.this_cCCars)      + ", " + ;
                           EscaparSQL(THIS.this_cCTits)      + ", " + ;
                           EscaparSQL(THIS.this_cGruCarTits) + ", " + ;
                           EscaparSQL(THIS.this_cResps)      + ", " + ;
                           FormatarNumeroSQL(THIS.this_nNResps) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cGruCarTits = THIS.this_cCGrus + THIS.this_cCCars + ;
                                    THIS.this_cCTits + THIS.this_cSGrus

            loc_cSQL = "UPDATE SigCdFtr SET" + ;
                       " CGrus = "      + EscaparSQL(THIS.this_cCGrus)      + "," + ;
                       " SGrus = "      + EscaparSQL(THIS.this_cSGrus)      + "," + ;
                       " CCars = "      + EscaparSQL(THIS.this_cCCars)      + "," + ;
                       " CTits = "      + EscaparSQL(THIS.this_cCTits)      + "," + ;
                       " GruCarTits = " + EscaparSQL(THIS.this_cGruCarTits) + "," + ;
                       " Resps = "      + EscaparSQL(THIS.this_cResps)      + "," + ;
                       " nResps = "     + FormatarNumeroSQL(THIS.this_nNResps) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFtr" + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

