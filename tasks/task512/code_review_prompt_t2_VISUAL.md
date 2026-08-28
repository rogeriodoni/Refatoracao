# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [GRID-HEADER] Header Caption 'Descr' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'DtCriacao' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'DtAlteracao' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ativo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descr' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'DtCriacao' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'DtAlteracao' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ativo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2830 linhas total):

*-- Linhas 59 a 67:
59:             SET DATE TO BRITISH
60:             SET CENTURY ON
61: 
62:             THIS.Caption = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
63: 
64:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
65:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
66:                     MsgErro("Conex" + CHR(227) + "o com banco de dados n" + CHR(227) + ;
67:                             "o estabelecida.", "Erro")

*-- Linhas 104 a 135:
104:         TRY
105:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
106:             WITH THIS.pgf_4c_Paginas
107:                 .Top       = -29
108:                 .Left      = 0
109:                 .Width     = THIS.Width
110:                 .Height    = THIS.Height + 29
111:                 .PageCount = 2
112:                 .Tabs      = .F.
113:             ENDWITH
114: 
115:             WITH THIS.pgf_4c_Paginas.Page1
116:                 .Caption = "Lista"
117:                 .Width   = THIS.Width
118:                 .Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
119:             ENDWITH
120: 
121:             WITH THIS.pgf_4c_Paginas.Page2
122:                 .Caption = "Dados"
123:                 .Width   = THIS.Width
124:             ENDWITH
125: 
126:             THIS.ConfigurarPaginaLista()
127:             THIS.ConfigurarPaginaDados()
128: 
129:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
130:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
131: 
132:             THIS.pgf_4c_Paginas.Visible = .T.
133: 
134:             loc_lResultado = .T.
135:         CATCH TO loc_oErro

*-- Linhas 152 a 216:
152:         TRY
153:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
154:             WITH loc_oPagina.cnt_4c_Cabecalho
155:                 .Top        = 31
156:                 .Left       = 0
157:                 .Width      = 1003
158:                 .Height     = 80
159:                 .BackColor  = RGB(100, 100, 100)
160:                 .BorderWidth = 0
161:                 .Visible    = .T.
162:             ENDWITH
163: 
164:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
165:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
166:                 .Top       = 15
167:                 .Left      = 10
168:                 .Width     = 980
169:                 .Height    = 40
170:                 .Caption   = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
171:                 .FontName  = "Tahoma"
172:                 .FontSize  = 16
173:                 .FontBold  = .T.
174:                 .ForeColor = RGB(0, 0, 0)
175:                 .BackStyle = 0
176:                 .Visible   = .T.
177:             ENDWITH
178: 
179:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
180:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
181:                 .Top       = 18
182:                 .Left      = 10
183:                 .Width     = 980
184:                 .Height    = 46
185:                 .Caption   = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
186:                 .FontName  = "Tahoma"
187:                 .FontSize  = 16
188:                 .FontBold  = .T.
189:                 .ForeColor = RGB(255, 255, 255)
190:                 .BackStyle = 0
191:                 .Visible   = .T.
192:             ENDWITH
193: 
194:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
195:             WITH loc_oPagina.cnt_4c_Botoes
196:                 .Top        = 29
197:                 .Left       = 542
198:                 .Width      = 375
199:                 .Height     = 85
200:                 .BackStyle = 0
201:                 .BorderWidth = 0
202:                 .Visible    = .T.
203:             ENDWITH
204: 
205:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
206:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
207:                 .Caption         = "Incluir"
208:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
209:                 .PicturePosition = 13
210:                 .Top             = 5
211:                 .Left            = 5
212:                 .Width           = 75
213:                 .Height          = 75
214:                 .BackColor       = RGB(255, 255, 255)
215:                 .ForeColor       = RGB(90, 90, 90)
216:                 .FontName        = "Tahoma"

*-- Linhas 223 a 239:
223:                 .WordWrap        = .T.
224:                 .Visible         = .T.
225:             ENDWITH
226:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
227: 
228:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
229:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
230:                 .Caption         = "Visualizar"
231:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
232:                 .PicturePosition = 13
233:                 .Top             = 5
234:                 .Left            = 80
235:                 .Width           = 75
236:                 .Height          = 75
237:                 .BackColor       = RGB(255, 255, 255)
238:                 .ForeColor       = RGB(90, 90, 90)
239:                 .FontName        = "Tahoma"

*-- Linhas 246 a 262:
246:                 .WordWrap        = .T.
247:                 .Visible         = .T.
248:             ENDWITH
249:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
250: 
251:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
252:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
253:                 .Caption         = "Alterar"
254:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
255:                 .PicturePosition = 13
256:                 .Top             = 5
257:                 .Left            = 155
258:                 .Width           = 75
259:                 .Height          = 75
260:                 .BackColor       = RGB(255, 255, 255)
261:                 .ForeColor       = RGB(90, 90, 90)
262:                 .FontName        = "Tahoma"

*-- Linhas 269 a 285:
269:                 .WordWrap        = .T.
270:                 .Visible         = .T.
271:             ENDWITH
272:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
273: 
274:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
275:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
276:                 .Caption         = "Excluir"
277:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
278:                 .PicturePosition = 13
279:                 .Top             = 5
280:                 .Left            = 230
281:                 .Width           = 75
282:                 .Height          = 75
283:                 .BackColor       = RGB(255, 255, 255)
284:                 .ForeColor       = RGB(90, 90, 90)
285:                 .FontName        = "Tahoma"

*-- Linhas 292 a 308:
292:                 .WordWrap        = .T.
293:                 .Visible         = .T.
294:             ENDWITH
295:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
296: 
297:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
298:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
299:                 .Caption         = "Buscar"
300:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
301:                 .PicturePosition = 13
302:                 .Top             = 5
303:                 .Left            = 305
304:                 .Width           = 75
305:                 .Height          = 75
306:                 .BackColor       = RGB(255, 255, 255)
307:                 .ForeColor       = RGB(90, 90, 90)
308:                 .FontName        = "Tahoma"

*-- Linhas 315 a 343:
315:                 .WordWrap        = .T.
316:                 .Visible         = .T.
317:             ENDWITH
318:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
319: 
320:             *-- Container saida - padrao canonico (CLAUDE.md regra #10)
321:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
322:             WITH loc_oPagina.cnt_4c_Saida
323:                 .Top        = 29
324:                 .Left       = 917
325:                 .Width      = 90
326:                 .Height     = 85
327:                 .BackStyle  = 0
328:                 .BorderWidth = 0
329:                 .Visible    = .T.
330:             ENDWITH
331: 
332:             loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
333:             WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
334:                 .Caption         = "Encerrar"
335:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
336:                 .PicturePosition = 13
337:                 .Top             = 5
338:                 .Left            = 5
339:                 .Width           = 75
340:                 .Height          = 75
341:                 .BackColor       = RGB(255, 255, 255)
342:                 .ForeColor       = RGB(90, 90, 90)
343:                 .FontName        = "Tahoma"

*-- Linhas 350 a 363:
350:                 .WordWrap        = .T.
351:                 .Visible         = .T.
352:             ENDWITH
353:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
354: 
355:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
356:             WITH loc_oPagina.grd_4c_Lista
357:                 .Top                = 117
358:                 .Left               = 2
359:                 .Width              = 998
360:                 .Height             = 498
361:                 .FontName           = "Verdana"
362:                 .FontSize           = 8
363:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 397 a 421:
397:             *-- Botoes Confirmar + Cancelar (Grupo_Salva no legado)
398:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
399:             WITH loc_oPagina.cnt_4c_BotoesAcao
400:                 .Top        = 33
401:                 .Left       = 842
402:                 .Width      = 160
403:                 .Height     = 85
404:                 .BackStyle = 1
405:                 .BackColor = RGB(255, 255, 255)
406:                 .BorderWidth = 0
407:                 .Visible    = .T.
408:             ENDWITH
409: 
410:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
411:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
412:                 .Caption         = "Confirmar"
413:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
414:                 .PicturePosition = 13
415:                 .Top             = 5
416:                 .Left            = 5
417:                 .Width           = 75
418:                 .Height          = 75
419:                 .BackColor       = RGB(255, 255, 255)
420:                 .ForeColor       = RGB(90, 90, 90)
421:                 .FontName        = "Tahoma"

*-- Linhas 428 a 444:
428:                 .WordWrap        = .T.
429:                 .Visible         = .T.
430:             ENDWITH
431:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
432: 
433:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
434:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
435:                 .Caption         = "Encerrar"
436:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
437:                 .PicturePosition = 13
438:                 .Top             = 5
439:                 .Left            = 80
440:                 .Width           = 75
441:                 .Height          = 75
442:                 .BackColor       = RGB(255, 255, 255)
443:                 .ForeColor       = RGB(90, 90, 90)
444:                 .FontName        = "Tahoma"

*-- Linhas 451 a 480:
451:                 .WordWrap        = .T.
452:                 .Visible         = .T.
453:             ENDWITH
454:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
455: 
456:             *-- PageFrame interno (Pageframe1 no legado)
457:             *-- Top=-29 oculta abas; conteudo de Page1 usa coords SCX direto (sem offset adicional)
458:             loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
459:             WITH loc_oPagina.pgf_4c_Dados
460:                 .Top       = -29
461:                 .Left      = 0
462:                 .Width     = THIS.Width
463:                 .Height    = 631
464:                 .PageCount = 2
465:                 .Tabs      = .F.
466:                 .Visible   = .T.
467:             ENDWITH
468: 
469:             WITH loc_oPagina.pgf_4c_Dados.Page1
470:                 .Caption = "Editor SQL"
471:                 .Width   = THIS.Width
472:             ENDWITH
473: 
474:             WITH loc_oPagina.pgf_4c_Dados.Page2
475:                 .Caption = "Designer"
476:                 .Width   = THIS.Width
477:             ENDWITH
478: 
479:             THIS.ConfigurarEditorSQL(loc_oPagina.pgf_4c_Dados.Page1)
480:             THIS.ConfigurarDesignerLayout(loc_oPagina.pgf_4c_Dados.Page2)

*-- Linhas 495 a 519:
495:             *-- Container botoes de acao SQL (CmdGrp_Acoes no legado - 3 botoes)
496:             par_oPage.AddObject("cnt_4c_AcoesSQL", "Container")
497:             WITH par_oPage.cnt_4c_AcoesSQL
498:                 .Top        = 9
499:                 .Left       = 15
500:                 .Width      = 235
501:                 .Height     = 85
502:                 .BackColor  = RGB(53, 53, 53)
503:                 .BackStyle  = 1
504:                 .BorderWidth = 0
505:                 .Visible    = .T.
506:             ENDWITH
507: 
508:             par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_Processar", "CommandButton")
509:             WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_Processar
510:                 .Caption         = "Processar"
511:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
512:                 .PicturePosition = 13
513:                 .Top             = 5
514:                 .Left            = 5
515:                 .Width           = 75
516:                 .Height          = 75
517:                 .BackColor       = RGB(255, 255, 255)
518:                 .ForeColor       = RGB(90, 90, 90)
519:                 .FontName        = "Tahoma"

*-- Linhas 526 a 542:
526:                 .WordWrap        = .T.
527:                 .Visible         = .T.
528:             ENDWITH
529:             BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
530: 
531:             par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_VisualizarRpt", "CommandButton")
532:             WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_VisualizarRpt
533:                 .Caption         = "Visualizar"
534:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
535:                 .PicturePosition = 13
536:                 .Top             = 5
537:                 .Left            = 80
538:                 .Width           = 75
539:                 .Height          = 75
540:                 .BackColor       = RGB(255, 255, 255)
541:                 .ForeColor       = RGB(90, 90, 90)
542:                 .FontName        = "Tahoma"

*-- Linhas 549 a 565:
549:                 .WordWrap        = .T.
550:                 .Visible         = .T.
551:             ENDWITH
552:             BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_VisualizarRpt, "Click", THIS, "BtnVisualizarRptClick")
553: 
554:             par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_Estrutura", "CommandButton")
555:             WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_Estrutura
556:                 .Caption         = "Layout"
557:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
558:                 .PicturePosition = 13
559:                 .Top             = 5
560:                 .Left            = 155
561:                 .Width           = 75
562:                 .Height          = 75
563:                 .BackColor       = RGB(255, 255, 255)
564:                 .ForeColor       = RGB(90, 90, 90)
565:                 .FontName        = "Tahoma"

*-- Linhas 572 a 893:
572:                 .WordWrap        = .T.
573:                 .Visible         = .T.
574:             ENDWITH
575:             BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_Estrutura, "Click", THIS, "BtnLayoutClick")
576: 
577:             *-- Label "Nome do Arquivo do Report:"
578:             par_oPage.AddObject("lbl_4c_NmReport", "Label")
579:             WITH par_oPage.lbl_4c_NmReport
580:                 .Top       = 2
581:                 .Left      = 326
582:                 .Width     = 139
583:                 .Height    = 15
584:                 .Caption   = "Nome do Arquivo do Report:"
585:                 .FontName  = "Tahoma"
586:                 .FontSize  = 8
587:                 .BackStyle = 0
588:                 .Visible   = .T.
589:             ENDWITH
590: 
591:             *-- TextBox nome do relatorio (Txt_NmReport no legado)
592:             par_oPage.AddObject("txt_4c_NmReport", "TextBox")
593:             WITH par_oPage.txt_4c_NmReport
594:                 .Top       = 14
595:                 .Left      = 326
596:                 .Width     = 361
597:                 .Height    = 23
598:                 .FontName  = "Tahoma"
599:                 .FontSize  = 8
600:                 .MaxLength = 100
601:                 .Visible   = .T.
602:             ENDWITH
603: 
604:             *-- ComboBox para selecionar report existente (Cbo_NmReports no legado)
605:             par_oPage.AddObject("cbo_4c_NmReports", "ComboBox")
606:             WITH par_oPage.cbo_4c_NmReports
607:                 .Top           = 13
608:                 .Left          = 691
609:                 .Width         = 200
610:                 .Height        = 24
611:                 .Style         = 2
612:                 .FontName      = "Tahoma"
613:                 .FontSize      = 8
614:                 .RowSourceType = 0
615:                 .Visible       = .T.
616:             ENDWITH
617:             BINDEVENT(par_oPage.cbo_4c_NmReports, "InteractiveChange", THIS, "CboNmReportsChange")
618:             BINDEVENT(par_oPage.txt_4c_NmReport, "KeyPress", THIS, "NmReportLostFocus")
619: 
620:             *-- CheckBox Ativo (Chk_Ativo no legado)
621:             par_oPage.AddObject("chk_4c_Ativo", "CheckBox")
622:             WITH par_oPage.chk_4c_Ativo
623:                 .Top       = 19
624:                 .Left      = 733
625:                 .Width     = 48
626:                 .Height    = 15
627:                 .Caption   = "Ativo"
628:                 .FontName  = "Tahoma"
629:                 .FontSize  = 8
630:                 .Value     = 1
631:                 .BackStyle = 0
632:                 .Visible   = .T.
633:             ENDWITH
634: 
635:             *-- Label "Descricao desse Report:"
636:             par_oPage.AddObject("lbl_4c_Descr", "Label")
637:             WITH par_oPage.lbl_4c_Descr
638:                 .Top       = 38
639:                 .Left      = 326
640:                 .Width     = 119
641:                 .Height    = 15
642:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o desse Report:"
643:                 .FontName  = "Tahoma"
644:                 .FontSize  = 8
645:                 .BackStyle = 0
646:                 .Visible   = .T.
647:             ENDWITH
648: 
649:             *-- EditBox descricao (Edt_Descricao no legado)
650:             par_oPage.AddObject("edt_4c_Descricao", "EditBox")
651:             WITH par_oPage.edt_4c_Descricao
652:                 .Top        = 50
653:                 .Left       = 326
654:                 .Width      = 454
655:                 .Height     = 41
656:                 .FontName   = "Tahoma"
657:                 .FontSize   = 8
658:                 .ScrollBars = 3
659:                 .Visible    = .T.
660:             ENDWITH
661: 
662:             *-- Label "Data de Criacao:"
663:             par_oPage.AddObject("lbl_4c_DtCriacao", "Label")
664:             WITH par_oPage.lbl_4c_DtCriacao
665:                 .Top       = 92
666:                 .Left      = 326
667:                 .Width     = 83
668:                 .Height    = 15
669:                 .Caption   = "Data de Cria" + CHR(231) + CHR(227) + "o:"
670:                 .FontName  = "Tahoma"
671:                 .FontSize  = 8
672:                 .BackStyle = 0
673:                 .Visible   = .T.
674:             ENDWITH
675: 
676:             *-- TextBox data criacao - somente leitura (Txt_DtCriacao no legado)
677:             par_oPage.AddObject("txt_4c_DtCriacao", "TextBox")
678:             WITH par_oPage.txt_4c_DtCriacao
679:                 .Top       = 104
680:                 .Left      = 326
681:                 .Width     = 184
682:                 .Height    = 23
683:                 .FontName  = "Tahoma"
684:                 .FontSize  = 8
685:                 .ReadOnly  = .T.
686:                 .BackColor = RGB(240, 240, 240)
687:                 .Visible   = .T.
688:             ENDWITH
689: 
690:             *-- Label "Data de Alteracao:"
691:             par_oPage.AddObject("lbl_4c_DtAlteracao", "Label")
692:             WITH par_oPage.lbl_4c_DtAlteracao
693:                 .Top       = 92
694:                 .Left      = 596
695:                 .Width     = 93
696:                 .Height    = 15
697:                 .Caption   = "Data de Altera" + CHR(231) + CHR(227) + "o:"
698:                 .FontName  = "Tahoma"
699:                 .FontSize  = 8
700:                 .BackStyle = 0
701:                 .Visible   = .T.
702:             ENDWITH
703: 
704:             *-- TextBox data alteracao - somente leitura (Txt_DtAlteracao no legado)
705:             par_oPage.AddObject("txt_4c_DtAlteracao", "TextBox")
706:             WITH par_oPage.txt_4c_DtAlteracao
707:                 .Top       = 104
708:                 .Left      = 596
709:                 .Width     = 184
710:                 .Height    = 23
711:                 .FontName  = "Tahoma"
712:                 .FontSize  = 8
713:                 .ReadOnly  = .T.
714:                 .BackColor = RGB(240, 240, 240)
715:                 .Visible   = .T.
716:             ENDWITH
717: 
718:             *-- Labels "De:" e "Ate:" para filtros de data da query SQL
719:             par_oPage.AddObject("lbl_4c_De", "Label")
720:             WITH par_oPage.lbl_4c_De
721:                 .Top       = 132
722:                 .Left      = 26
723:                 .Width     = 25
724:                 .Height    = 16
725:                 .Caption   = "De:"
726:                 .FontName  = "Tahoma"
727:                 .FontSize  = 8
728:                 .BackStyle = 0
729:                 .Visible   = .T.
730:             ENDWITH
731: 
732:             par_oPage.AddObject("txt_4c_DtDe", "TextBox")
733:             WITH par_oPage.txt_4c_DtDe
734:                 .Top       = 128
735:                 .Left      = 53
736:                 .Width     = 100
737:                 .Height    = 23
738:                 .FontName  = "Tahoma"
739:                 .FontSize  = 8
740:                 .Visible   = .T.
741:             ENDWITH
742: 
743:             par_oPage.AddObject("lbl_4c_Ate", "Label")
744:             WITH par_oPage.lbl_4c_Ate
745:                 .Top       = 131
746:                 .Left      = 164
747:                 .Width     = 28
748:                 .Height    = 16
749:                 .Caption   = "At" + CHR(233) + ":"
750:                 .FontName  = "Tahoma"
751:                 .FontSize  = 8
752:                 .BackStyle = 0
753:                 .Visible   = .T.
754:             ENDWITH
755: 
756:             par_oPage.AddObject("txt_4c_DtAte", "TextBox")
757:             WITH par_oPage.txt_4c_DtAte
758:                 .Top       = 128
759:                 .Left      = 195
760:                 .Width     = 100
761:                 .Height    = 23
762:                 .FontName  = "Tahoma"
763:                 .FontSize  = 8
764:                 .Visible   = .T.
765:             ENDWITH
766: 
767:             *-- Container dica F8/F9 (Container1 no legado)
768:             par_oPage.AddObject("cnt_4c_HintF8F9", "Container")
769:             WITH par_oPage.cnt_4c_HintF8F9
770:                 .Top        = 141
771:                 .Left       = 326
772:                 .Width      = 397
773:                 .Height     = 24
774:                 .BackStyle  = 0
775:                 .BorderWidth = 0
776:                 .Visible    = .T.
777:             ENDWITH
778: 
779:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_HintTexto", "Label")
780:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_HintTexto
781:                 .Top       = 2
782:                 .Left      = 3
783:                 .Width     = 392
784:                 .Height    = 15
785:                 .Caption   = "Use: F8 para listar as Tabelas, e F9 para listar as Vari" + CHR(225) + "veis."
786:                 .FontName  = "Verdana"
787:                 .FontSize  = 8
788:                 .FontBold  = .T.
789:                 .ForeColor = RGB(90, 90, 90)
790:                 .BackStyle = 0
791:                 .Visible   = .T.
792:             ENDWITH
793: 
794:             *-- Lbl_F8: "F8" azul clicavel (overlay sobre texto do lbl_4c_HintTexto)
795:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_F8", "Label")
796:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F8
797:                 .AutoSize     = .T.
798:                 .Top          = 2
799:                 .Left         = 35
800:                 .Height       = 15
801:                 .Width        = 18
802:                 .Caption      = "F8"
803:                 .FontName     = "Verdana"
804:                 .FontSize     = 8
805:                 .FontBold     = .T.
806:                 .ForeColor    = RGB(0, 0, 255)
807:                 .BackStyle    = 0
808:                 .MousePointer = 15
809:                 .Visible      = .T.
810:             ENDWITH
811:             BINDEVENT(par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F8, "Click", THIS, "LblF8Click")
812: 
813:             *-- Lbl_Tabelas: "Tabelas" sublinhado (overlay)
814:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_Tabelas", "Label")
815:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_Tabelas
816:                 .AutoSize      = .T.
817:                 .Top           = 2
818:                 .Left          = 146
819:                 .Height        = 15
820:                 .Width         = 53
821:                 .Caption       = "Tabelas"
822:                 .FontName      = "Verdana"
823:                 .FontSize      = 8
824:                 .FontBold      = .T.
825:                 .FontUnderline = .T.
826:                 .ForeColor     = RGB(90, 90, 90)
827:                 .BackStyle     = 0
828:                 .Visible       = .T.
829:             ENDWITH
830: 
831:             *-- Lbl_F9: "F9" azul clicavel (overlay)
832:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_F9", "Label")
833:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F9
834:                 .AutoSize     = .T.
835:                 .Top          = 2
836:                 .Left         = 217
837:                 .Height       = 15
838:                 .Width        = 18
839:                 .Caption      = "F9"
840:                 .FontName     = "Verdana"
841:                 .FontSize     = 8
842:                 .FontBold     = .T.
843:                 .ForeColor    = RGB(0, 0, 255)
844:                 .BackStyle    = 0
845:                 .MousePointer = 15
846:                 .Visible      = .T.
847:             ENDWITH
848:             BINDEVENT(par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F9, "Click", THIS, "LblF9Click")
849: 
850:             *-- Lbl_Variaveis: "Variaveis" sublinhado (overlay)
851:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_Variaveis", "Label")
852:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_Variaveis
853:                 .AutoSize      = .T.
854:                 .Top           = 2
855:                 .Left          = 328
856:                 .Height        = 15
857:                 .Width         = 63
858:                 .Caption       = "Vari" + CHR(225) + "veis"
859:                 .FontName      = "Verdana"
860:                 .FontSize      = 8
861:                 .FontBold      = .T.
862:                 .FontUnderline = .T.
863:                 .ForeColor     = RGB(90, 90, 90)
864:                 .BackStyle     = 0
865:                 .Visible       = .T.
866:             ENDWITH
867: 
868:             *-- Indicador SQL modificado (Lbl_SQL_Alterado no legado - asterisco vermelho)
869:             par_oPage.AddObject("lbl_4c_SqlAlterado", "Label")
870:             WITH par_oPage.lbl_4c_SqlAlterado
871:                 .Top       = 147
872:                 .Left      = 8
873:                 .Width     = 27
874:                 .Height    = 17
875:                 .Caption   = ""
876:                 .FontName  = "Tahoma"
877:                 .FontSize  = 12
878:                 .FontBold  = .T.
879:                 .ForeColor = RGB(255, 0, 0)
880:                 .BackStyle = 0
881:                 .Visible   = .T.
882:             ENDWITH
883: 
884:             *-- EditBox SQL (OleRTF_SqlCMD no legado - substituido por EditBox nativo)
885:             par_oPage.AddObject("edt_4c_SqlCMD", "EditBox")
886:             WITH par_oPage.edt_4c_SqlCMD
887:                 .Top        = 158
888:                 .Left       = 8
889:                 .Width      = 986
890:                 .Height     = 214
891:                 .FontName   = "Courier New"
892:                 .FontSize   = 9
893:                 .ScrollBars = 3

*-- Linhas 899 a 908:
899:             *-- Grade de resultados SQL (FwGrade1_Resultado no legado)
900:             par_oPage.AddObject("grd_4c_Resultado", "Grid")
901:             WITH par_oPage.grd_4c_Resultado
902:                 .Top                = 379
903:                 .Left               = 8
904:                 .Width              = 986
905:                 .Height             = 218
906:                 .FontName           = "Verdana"
907:                 .FontSize           = 8
908:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 949 a 961:
949:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
950: 
951:                     *-- Redefinir headers APOS RecordSource (CRITICO - Problema 6)
952:                     loc_oGrid.Column1.Header1.Caption = "Titulo"
953:                     loc_oGrid.Column2.Header1.Caption = "Descr"
954:                     loc_oGrid.Column3.Header1.Caption = "DtCriacao"
955:                     loc_oGrid.Column4.Header1.Caption = "DtAlteracao"
956:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
957: 
958:                     loc_oGrid.Column1.Width = 350
959:                     loc_oGrid.Column2.Width = 350
960:                     loc_oGrid.Column3.Width = 90
961:                     loc_oGrid.Column4.Width = 90

*-- Linhas 1142 a 1154:
1142:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
1143:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
1144: 
1145:                     loc_oGrid.Column1.Header1.Caption = "Titulo"
1146:                     loc_oGrid.Column2.Header1.Caption = "Descr"
1147:                     loc_oGrid.Column3.Header1.Caption = "DtCriacao"
1148:                     loc_oGrid.Column4.Header1.Caption = "DtAlteracao"
1149:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
1150: 
1151:                     loc_oGrid.Column1.Width = 350
1152:                     loc_oGrid.Column2.Width = 350
1153:                     loc_oGrid.Column3.Width = 90
1154:                     loc_oGrid.Column4.Width = 90

*-- Linhas 1250 a 1262:
1250: 
1251:                     FOR loc_nI = 1 TO loc_nCols
1252:                         loc_oGrid.Columns(loc_nI).ControlSource = "cursor_4c_SqlResult." + laFields[loc_nI, 1]
1253:                         loc_oGrid.Columns(loc_nI).Header1.Caption = laFields[loc_nI, 1]
1254:                         loc_oGrid.Columns(loc_nI).Width = 100
1255:                     ENDFOR
1256: 
1257:                     loc_oPage.lbl_4c_SqlAlterado.Caption = ""
1258:                     THIS.this_oBusinessObject.this_cSqlQuery = loc_cSQL
1259:                     loc_oGrid.Refresh()
1260: 
1261:                     MsgInfo(ALLTRIM(STR(RECCOUNT("cursor_4c_SqlResult"))) + ;
1262:                             " registro(s) retornado(s).")

*-- Linhas 1433 a 1441:
1433:     *==========================================================================
1434:     PROCEDURE SqlCMDChange()
1435:         TRY
1436:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.lbl_4c_SqlAlterado.Caption = "*"
1437:         CATCH TO loc_oErro
1438:             *-- Indicador nao critico; silencioso
1439:         ENDTRY
1440:     ENDPROC
1441: 

*-- Linhas 1495 a 1503:
1495:             ENDIF
1496:             loc_oPage.edt_4c_SqlCMD.Value = loc_cSqlQuery
1497: 
1498:             loc_oPage.lbl_4c_SqlAlterado.Caption = ""
1499: 
1500:             THIS.PopularComboReports()
1501:         CATCH TO loc_oErro
1502:             MsgErro(loc_oErro.Message, "FormRPT.BOParaForm")
1503:         ENDTRY

*-- Linhas 1518 a 1526:
1518:             loc_oPage.edt_4c_SqlCMD.ReadOnly    = loc_lRO
1519:             loc_oPage.cbo_4c_NmReports.Enabled  = !loc_lRO
1520: 
1521:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lRO
1522:         CATCH TO loc_oErro
1523:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarModoEditor")
1524:         ENDTRY
1525:     ENDPROC
1526: 

*-- Linhas 1565 a 1589:
1565:             *-- Container botoes de acao do designer (CmdGrp_Acoes no legado - 2 botoes)
1566:             par_oPage.AddObject("cnt_4c_AcoesDesigner", "Container")
1567:             WITH par_oPage.cnt_4c_AcoesDesigner
1568:                 .Top         = 8
1569:                 .Left        = 11
1570:                 .Width       = 160
1571:                 .Height      = 85
1572:                 .BackColor   = RGB(53, 53, 53)
1573:                 .BackStyle   = 1
1574:                 .BorderWidth = 0
1575:                 .Visible     = .T.
1576:             ENDWITH
1577: 
1578:             par_oPage.cnt_4c_AcoesDesigner.AddObject("cmd_4c_VoltarEditor", "CommandButton")
1579:             WITH par_oPage.cnt_4c_AcoesDesigner.cmd_4c_VoltarEditor
1580:                 .Caption         = "Voltar"
1581:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1582:                 .PicturePosition = 13
1583:                 .Top             = 5
1584:                 .Left            = 5
1585:                 .Width           = 75
1586:                 .Height          = 75
1587:                 .BackColor       = RGB(255, 255, 255)
1588:                 .ForeColor       = RGB(90, 90, 90)
1589:                 .FontName        = "Tahoma"

*-- Linhas 1596 a 1612:
1596:                 .WordWrap        = .T.
1597:                 .Visible         = .T.
1598:             ENDWITH
1599:             BINDEVENT(par_oPage.cnt_4c_AcoesDesigner.cmd_4c_VoltarEditor, "Click", THIS, "BtnVoltarEditorClick")
1600: 
1601:             par_oPage.cnt_4c_AcoesDesigner.AddObject("cmd_4c_SalvarRPT", "CommandButton")
1602:             WITH par_oPage.cnt_4c_AcoesDesigner.cmd_4c_SalvarRPT
1603:                 .Caption         = "Salvar RPT"
1604:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1605:                 .PicturePosition = 13
1606:                 .Top             = 5
1607:                 .Left            = 80
1608:                 .Width           = 75
1609:                 .Height          = 75
1610:                 .BackColor       = RGB(255, 255, 255)
1611:                 .ForeColor       = RGB(90, 90, 90)
1612:                 .FontName        = "Tahoma"

*-- Linhas 1619 a 1696:
1619:                 .WordWrap        = .T.
1620:                 .Visible         = .T.
1621:             ENDWITH
1622:             BINDEVENT(par_oPage.cnt_4c_AcoesDesigner.cmd_4c_SalvarRPT, "Click", THIS, "BtnSalvarRPTClick")
1623: 
1624:             *-- Imagem orientacao (Img_Orientacao no legado)
1625:             par_oPage.AddObject("img_4c_Orientacao", "Image")
1626:             WITH par_oPage.img_4c_Orientacao
1627:                 .Top     = 6
1628:                 .Left    = 603
1629:                 .Width   = 130
1630:                 .Height  = 116
1631:                 .Stretch = 2
1632:                 .Picture = gc_4c_CaminhoIcones + "rpt_orientacao_retrato_26.jpg"
1633:                 .Visible = .T.
1634:             ENDWITH
1635: 
1636:             *-- OptionGroup orientacao Retrato/Paisagem (OptGrp_Orientacao no legado)
1637:             par_oPage.AddObject("opt_4c_Orientacao", "OptionGroup")
1638:             WITH par_oPage.opt_4c_Orientacao
1639:                 .Top         = 126
1640:                 .Left        = 580
1641:                 .Width       = 185
1642:                 .Height      = 28
1643:                 .ButtonCount = 2
1644:                 .BackStyle   = 0
1645:                 .BorderStyle = 0
1646:                 .Value       = 1
1647:                 .Visible     = .T.
1648:             ENDWITH
1649:             WITH par_oPage.opt_4c_Orientacao.Buttons(1)
1650:                 .Caption   = "Retrato"
1651:                 .BackStyle = 0
1652:                 .Left      = 5
1653:                 .Top       = 5
1654:                 .Width     = 72
1655:                 .AutoSize  = .T.
1656:                 .FontName  = "Tahoma"
1657:                 .FontSize  = 8
1658:                 .ForeColor = RGB(90, 90, 90)
1659:             ENDWITH
1660:             WITH par_oPage.opt_4c_Orientacao.Buttons(2)
1661:                 .Caption   = "Paisagem"
1662:                 .BackStyle = 0
1663:                 .Left      = 90
1664:                 .Top       = 5
1665:                 .Width     = 85
1666:                 .AutoSize  = .T.
1667:                 .FontName  = "Tahoma"
1668:                 .FontSize  = 8
1669:                 .ForeColor = RGB(90, 90, 90)
1670:             ENDWITH
1671:             BINDEVENT(par_oPage.opt_4c_Orientacao, "InteractiveChange", THIS, "OptOrientacaoChanged")
1672: 
1673:             *-- Label "Tamanho do Papel:" (Lbl_TamPapel no legado)
1674:             par_oPage.AddObject("lbl_4c_TamPapel", "Label")
1675:             WITH par_oPage.lbl_4c_TamPapel
1676:                 .Top       = 48
1677:                 .Left      = 202
1678:                 .Width     = 108
1679:                 .Height    = 16
1680:                 .Caption   = "Tamanho do Papel:"
1681:                 .FontName  = "Tahoma"
1682:                 .FontSize  = 8
1683:                 .BackStyle = 0
1684:                 .Visible   = .T.
1685:             ENDWITH
1686: 
1687:             *-- ComboBox tamanho papel (Cbo_TamPapel no legado)
1688:             par_oPage.AddObject("cbo_4c_TamPapel", "ComboBox")
1689:             WITH par_oPage.cbo_4c_TamPapel
1690:                 .Top           = 71
1691:                 .Left          = 202
1692:                 .Width         = 348
1693:                 .Height        = 24
1694:                 .Style         = 2
1695:                 .FontName      = "Tahoma"
1696:                 .FontSize      = 8

*-- Linhas 1702 a 1731:
1702:             THIS.PopularCboTamPapel(par_oPage.cbo_4c_TamPapel)
1703: 
1704:             *-- Label nome do relatorio (Lbl_Nm_Relatorio no legado)
1705:             par_oPage.AddObject("lbl_4c_NmRelatorio", "Label")
1706:             WITH par_oPage.lbl_4c_NmRelatorio
1707:                 .Top       = 131
1708:                 .Left      = 10
1709:                 .Width     = 540
1710:                 .Height    = 22
1711:                 .Caption   = ""
1712:                 .FontName  = "Tahoma"
1713:                 .FontSize  = 10
1714:                 .FontBold  = .T.
1715:                 .BackStyle = 0
1716:                 .Visible   = .T.
1717:             ENDWITH
1718: 
1719:             *-- Label "Titulo do Relatorio:" (Label1 no legado)
1720:             par_oPage.AddObject("lbl_4c_TituloRel", "Label")
1721:             WITH par_oPage.lbl_4c_TituloRel
1722:                 .Top       = 162
1723:                 .Left      = 10
1724:                 .Width     = 110
1725:                 .Height    = 16
1726:                 .Caption   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio: "
1727:                 .FontName  = "Tahoma"
1728:                 .FontSize  = 8
1729:                 .BackStyle = 0
1730:                 .Visible   = .T.
1731:             ENDWITH

*-- Linhas 1860 a 1869:
1860:             par_oPage.AddObject("grd_4c_TIT", "Grid")
1861:             loc_oGrd = par_oPage.grd_4c_TIT
1862:             WITH loc_oGrd
1863:                 .Top              = 180
1864:                 .Left             = 4
1865:                 .Width            = 990
1866:                 .Height           = 65
1867:                 .ColumnCount      = 5
1868:                 .RecordSourceType = 1
1869:                 .RecordSource     = ""

*-- Linhas 1878 a 1946:
1878: 
1879:             *- Col1: LblCaption - "Titulo" (EditBox)
1880:             loc_oCol = loc_oGrd.Column1
1881:             loc_oCol.Header1.Caption = "Titulo"
1882:             loc_oCol.Width  = 300
1883:             loc_oCol.Sparse = .F.
1884:             loc_oCol.AddObject("edt_4c_TitCaption", "EditBox")
1885:             loc_oCol.CurrentControl = "edt_4c_TitCaption"
1886:             WITH loc_oCol.edt_4c_TitCaption
1887:                 .Width      = 298
1888:                 .Height     = 28
1889:                 .ScrollBars = 0
1890:             ENDWITH
1891: 
1892:             *- Col2: LblFonte - "Fonte" (EditBox - string "FontName,Size,Style")
1893:             loc_oCol = loc_oGrd.Column2
1894:             loc_oCol.Header1.Caption = "Fonte"
1895:             loc_oCol.Width  = 230
1896:             loc_oCol.Sparse = .F.
1897:             loc_oCol.AddObject("edt_4c_TitFonte", "EditBox")
1898:             loc_oCol.CurrentControl = "edt_4c_TitFonte"
1899:             WITH loc_oCol.edt_4c_TitFonte
1900:                 .Width      = 228
1901:                 .Height     = 28
1902:                 .ScrollBars = 0
1903:             ENDWITH
1904: 
1905:             *- Col3: BtFonte - "Fte" (CommandButton - abre dialogo GETFONT)
1906:             loc_oCol = loc_oGrd.Column3
1907:             loc_oCol.Header1.Caption = "Fte"
1908:             loc_oCol.Width  = 80
1909:             loc_oCol.Sparse = .F.
1910:             loc_oCol.AddObject("cmd_4c_FonteTIT", "CommandButton")
1911:             loc_oCol.CurrentControl = "cmd_4c_FonteTIT"
1912:             WITH loc_oCol.cmd_4c_FonteTIT
1913:                 .Caption       = "..."
1914:                 .Width         = 75
1915:                 .Height        = 25
1916:                 .SpecialEffect = 0
1917:                 .FontName      = "Tahoma"
1918:                 .FontSize      = 8
1919:             ENDWITH
1920:             BINDEVENT(loc_oCol.cmd_4c_FonteTIT, "Click", THIS, "BtnFonteTITClick")
1921: 
1922:             *- Col4: BtCor - "Cor" (CommandButton - abre GETCOLOR)
1923:             loc_oCol = loc_oGrd.Column4
1924:             loc_oCol.Header1.Caption = "Cor"
1925:             loc_oCol.Width  = 80
1926:             loc_oCol.Sparse = .F.
1927:             loc_oCol.AddObject("cmd_4c_CorTIT", "CommandButton")
1928:             loc_oCol.CurrentControl = "cmd_4c_CorTIT"
1929:             WITH loc_oCol.cmd_4c_CorTIT
1930:                 .Caption       = "..."
1931:                 .Width         = 75
1932:                 .Height        = 25
1933:                 .SpecialEffect = 0
1934:                 .FontName      = "Tahoma"
1935:                 .FontSize      = 8
1936:             ENDWITH
1937:             BINDEVENT(loc_oCol.cmd_4c_CorTIT, "Click", THIS, "BtnCorTITClick")
1938: 
1939:             *- Col5: LblAlinhar - "Alinhar" (ComboBox Esq./Cen./Dir.)
1940:             loc_oCol = loc_oGrd.Column5
1941:             loc_oCol.Header1.Caption = "Alinhar"
1942:             loc_oCol.Width  = 300
1943:             loc_oCol.Sparse = .F.
1944:             loc_oCol.AddObject("cbo_4c_AlinharTIT", "ComboBox")
1945:             loc_oCol.CurrentControl = "cbo_4c_AlinharTIT"
1946:             WITH loc_oCol.cbo_4c_AlinharTIT

*-- Linhas 1957 a 1966:
1957:             par_oPage.AddObject("grd_4c_CMPs", "Grid")
1958:             loc_oGrd = par_oPage.grd_4c_CMPs
1959:             WITH loc_oGrd
1960:                 .Top              = 258
1961:                 .Left             = 4
1962:                 .Width            = 990
1963:                 .Height           = 238
1964:                 .ColumnCount      = 12
1965:                 .RecordSourceType = 1
1966:                 .RecordSource     = ""

*-- Linhas 1975 a 1983:
1975: 
1976:             *- Col1: NmCampo - "Campo" (TextBox, readonly - nome do campo do SQL)
1977:             loc_oCol = loc_oGrd.Column1
1978:             loc_oCol.Header1.Caption = "Campo"
1979:             loc_oCol.Width    = 140
1980:             loc_oCol.Sparse   = .F.
1981:             loc_oCol.ReadOnly = .T.
1982:             loc_oCol.AddObject("txt_4c_NmCampo", "TextBox")
1983:             loc_oCol.CurrentControl = "txt_4c_NmCampo"

*-- Linhas 1992 a 2000:
1992: 
1993:             *- Col2: TpCampo - "Tipo" (TextBox, readonly - tipo do campo)
1994:             loc_oCol = loc_oGrd.Column2
1995:             loc_oCol.Header1.Caption = "Tipo"
1996:             loc_oCol.Width    = 75
1997:             loc_oCol.Sparse   = .F.
1998:             loc_oCol.ReadOnly = .T.
1999:             loc_oCol.AddObject("txt_4c_TpCampo", "TextBox")
2000:             loc_oCol.CurrentControl = "txt_4c_TpCampo"

*-- Linhas 2007 a 2089:
2007:                 .FontSize  = 8
2008:             ENDWITH
2009: 
2010:             *- Col3: CkOutRPT - "Saida Rel." (CheckBox - inclui campo na saida do relatorio)
2011:             loc_oCol = loc_oGrd.Column3
2012:             loc_oCol.Header1.Caption = "Sa" + CHR(237) + "da Rel."
2013:             loc_oCol.Width  = 60
2014:             loc_oCol.Sparse = .F.
2015:             loc_oCol.AddObject("chk_4c_SaidaRPT", "CheckBox")
2016:             loc_oCol.CurrentControl = "chk_4c_SaidaRPT"
2017:             WITH loc_oCol.chk_4c_SaidaRPT
2018:                 .Caption   = ""
2019:                 .Alignment = 0
2020:                 .ReadOnly  = .F.
2021:                 .Visible   = .T.
2022:                 .Top       = 9
2023:                 .Left      = 2
2024:                 .Height    = 17
2025:                 .Width     = 22
2026:             ENDWITH
2027: 
2028:             *- Col4: CkFiltro - "Filtro" (CheckBox - habilita como filtro)
2029:             loc_oCol = loc_oGrd.Column4
2030:             loc_oCol.Header1.Caption = "Filtro"
2031:             loc_oCol.Width  = 50
2032:             loc_oCol.Sparse = .F.
2033:             loc_oCol.AddObject("chk_4c_CkFiltro", "CheckBox")
2034:             loc_oCol.CurrentControl = "chk_4c_CkFiltro"
2035:             WITH loc_oCol.chk_4c_CkFiltro
2036:                 .Caption   = ""
2037:                 .Alignment = 0
2038:                 .ReadOnly  = .F.
2039:                 .Visible   = .T.
2040:                 .Top       = 9
2041:                 .Left      = 2
2042:                 .Height    = 17
2043:                 .Width     = 22
2044:             ENDWITH
2045: 
2046:             *- Col5: CkSubTot - "SubTot" (CheckBox - subtotalizar)
2047:             loc_oCol = loc_oGrd.Column5
2048:             loc_oCol.Header1.Caption = "SubTot"
2049:             loc_oCol.Width  = 55
2050:             loc_oCol.Sparse = .F.
2051:             loc_oCol.AddObject("chk_4c_CkSubTot", "CheckBox")
2052:             loc_oCol.CurrentControl = "chk_4c_CkSubTot"
2053:             WITH loc_oCol.chk_4c_CkSubTot
2054:                 .Caption   = ""
2055:                 .Alignment = 0
2056:                 .ReadOnly  = .F.
2057:                 .Visible   = .T.
2058:                 .Top       = 9
2059:                 .Left      = 2
2060:                 .Height    = 17
2061:                 .Width     = 22
2062:             ENDWITH
2063: 
2064:             *- Col6: CkTotal - "Total" (CheckBox - total final)
2065:             loc_oCol = loc_oGrd.Column6
2066:             loc_oCol.Header1.Caption = "Total"
2067:             loc_oCol.Width  = 50
2068:             loc_oCol.Sparse = .F.
2069:             loc_oCol.AddObject("chk_4c_CkTotal", "CheckBox")
2070:             loc_oCol.CurrentControl = "chk_4c_CkTotal"
2071:             WITH loc_oCol.chk_4c_CkTotal
2072:                 .Caption   = ""
2073:                 .Alignment = 0
2074:                 .ReadOnly  = .F.
2075:                 .Visible   = .T.
2076:                 .Top       = 9
2077:                 .Left      = 2
2078:                 .Height    = 17
2079:                 .Width     = 22
2080:             ENDWITH
2081: 
2082:             *- Col7: LblCaption - "Titulo do Campo" (EditBox - rotulo da coluna no relatorio)
2083:             loc_oCol = loc_oGrd.Column7
2084:             loc_oCol.Header1.Caption = "Titulo do Campo"
2085:             loc_oCol.Width  = 130
2086:             loc_oCol.Sparse = .F.
2087:             loc_oCol.AddObject("edt_4c_LblCaption", "EditBox")
2088:             loc_oCol.CurrentControl = "edt_4c_LblCaption"
2089:             WITH loc_oCol.edt_4c_LblCaption

*-- Linhas 2096 a 2104:
2096: 
2097:             *- Col8: LblFonte - "Fonte" (EditBox - fonte da coluna)
2098:             loc_oCol = loc_oGrd.Column8
2099:             loc_oCol.Header1.Caption = "Fonte"
2100:             loc_oCol.Width  = 130
2101:             loc_oCol.Sparse = .F.
2102:             loc_oCol.AddObject("edt_4c_LblFonte", "EditBox")
2103:             loc_oCol.CurrentControl = "edt_4c_LblFonte"
2104:             WITH loc_oCol.edt_4c_LblFonte

*-- Linhas 2111 a 2153:
2111: 
2112:             *- Col9: LblBtFonte - "Fte" (CommandButton - abre GETFONT)
2113:             loc_oCol = loc_oGrd.Column9
2114:             loc_oCol.Header1.Caption = "Fte"
2115:             loc_oCol.Width  = 65
2116:             loc_oCol.Sparse = .F.
2117:             loc_oCol.AddObject("cmd_4c_FonteCMP", "CommandButton")
2118:             loc_oCol.CurrentControl = "cmd_4c_FonteCMP"
2119:             WITH loc_oCol.cmd_4c_FonteCMP
2120:                 .Caption       = "..."
2121:                 .Width         = 60
2122:                 .Height        = 25
2123:                 .SpecialEffect = 0
2124:                 .FontName      = "Tahoma"
2125:                 .FontSize      = 8
2126:             ENDWITH
2127:             BINDEVENT(loc_oCol.cmd_4c_FonteCMP, "Click", THIS, "BtnFonteCMPClick")
2128: 
2129:             *- Col10: LblBtCor - "Cor" (CommandButton - abre GETCOLOR)
2130:             loc_oCol = loc_oGrd.Column10
2131:             loc_oCol.Header1.Caption = "Cor"
2132:             loc_oCol.Width  = 65
2133:             loc_oCol.Sparse = .F.
2134:             loc_oCol.AddObject("cmd_4c_CorCMP", "CommandButton")
2135:             loc_oCol.CurrentControl = "cmd_4c_CorCMP"
2136:             WITH loc_oCol.cmd_4c_CorCMP
2137:                 .Caption       = "..."
2138:                 .Width         = 60
2139:                 .Height        = 25
2140:                 .SpecialEffect = 0
2141:                 .FontName      = "Tahoma"
2142:                 .FontSize      = 8
2143:             ENDWITH
2144:             BINDEVENT(loc_oCol.cmd_4c_CorCMP, "Click", THIS, "BtnCorCMPClick")
2145: 
2146:             *- Col11: LblAlinhar - "Alinhar" (ComboBox)
2147:             loc_oCol = loc_oGrd.Column11
2148:             loc_oCol.Header1.Caption = "Alinhar"
2149:             loc_oCol.Width  = 80
2150:             loc_oCol.Sparse = .F.
2151:             loc_oCol.AddObject("cbo_4c_AlinharCMP", "ComboBox")
2152:             loc_oCol.CurrentControl = "cbo_4c_AlinharCMP"
2153:             WITH loc_oCol.cbo_4c_AlinharCMP

*-- Linhas 2162 a 2170:
2162: 
2163:             *- Col12: LblTamCmp - "Tam." (Spinner - tamanho da fonte)
2164:             loc_oCol = loc_oGrd.Column12
2165:             loc_oCol.Header1.Caption = "Tam."
2166:             loc_oCol.Width  = 90
2167:             loc_oCol.Sparse = .F.
2168:             loc_oCol.AddObject("spn_4c_TamCMP", "Spinner")
2169:             loc_oCol.CurrentControl = "spn_4c_TamCMP"
2170:             WITH loc_oCol.spn_4c_TamCMP

*-- Linhas 2176 a 2203:
2176:             ENDWITH
2177: 
2178:             *=== Label "Totalizar pelo Campo:..." (Lbl_CmpGrupo) ===
2179:             par_oPage.AddObject("lbl_4c_CmpGrupo", "Label")
2180:             WITH par_oPage.lbl_4c_CmpGrupo
2181:                 .Top       = 510
2182:                 .Left      = 10
2183:                 .Width     = 316
2184:                 .Height    = 16
2185:                 .Caption   = "Totalizar pelo Campo: ( Use o clique direito, para apagar )"
2186:                 .FontName  = "Tahoma"
2187:                 .FontSize  = 8
2188:                 .FontBold  = .T.
2189:                 .BackStyle = 0
2190:                 .Visible   = .T.
2191:             ENDWITH
2192: 
2193:             *=== GRADE 3: grd_4c_GRP (FwGrade3_GRP) - grupos/totalizacao, 7 colunas ===
2194:             par_oPage.AddObject("grd_4c_GRP", "Grid")
2195:             loc_oGrd = par_oPage.grd_4c_GRP
2196:             WITH loc_oGrd
2197:                 .Top              = 529
2198:                 .Left             = 4
2199:                 .Width            = 989
2200:                 .Height           = 67
2201:                 .ColumnCount      = 7
2202:                 .RecordSourceType = 1
2203:                 .RecordSource     = ""

*-- Linhas 2212 a 2220:
2212: 
2213:             *- Col1: NmCampo - "Grupo" (ComboBox - escolhe campo do SQL como agrupador)
2214:             loc_oCol = loc_oGrd.Column1
2215:             loc_oCol.Header1.Caption = "Grupo"
2216:             loc_oCol.Width  = 200
2217:             loc_oCol.Sparse = .F.
2218:             loc_oCol.AddObject("cbo_4c_NmCampoGRP", "ComboBox")
2219:             loc_oCol.CurrentControl = "cbo_4c_NmCampoGRP"
2220:             WITH loc_oCol.cbo_4c_NmCampoGRP

*-- Linhas 2229 a 2237:
2229: 
2230:             *- Col2: LblCaption - "Titulo do Campo" (EditBox)
2231:             loc_oCol = loc_oGrd.Column2
2232:             loc_oCol.Header1.Caption = "Titulo do Campo"
2233:             loc_oCol.Width  = 160
2234:             loc_oCol.Sparse = .F.
2235:             loc_oCol.AddObject("edt_4c_GrpCaption", "EditBox")
2236:             loc_oCol.CurrentControl = "edt_4c_GrpCaption"
2237:             WITH loc_oCol.edt_4c_GrpCaption

*-- Linhas 2244 a 2252:
2244: 
2245:             *- Col3: LblFonte - "Fonte" (EditBox)
2246:             loc_oCol = loc_oGrd.Column3
2247:             loc_oCol.Header1.Caption = "Fonte"
2248:             loc_oCol.Width  = 160
2249:             loc_oCol.Sparse = .F.
2250:             loc_oCol.AddObject("edt_4c_GrpFonte", "EditBox")
2251:             loc_oCol.CurrentControl = "edt_4c_GrpFonte"
2252:             WITH loc_oCol.edt_4c_GrpFonte

*-- Linhas 2259 a 2301:
2259: 
2260:             *- Col4: LblBtFonte - "Fte" (CommandButton - abre GETFONT)
2261:             loc_oCol = loc_oGrd.Column4
2262:             loc_oCol.Header1.Caption = "Fte"
2263:             loc_oCol.Width  = 80
2264:             loc_oCol.Sparse = .F.
2265:             loc_oCol.AddObject("cmd_4c_FonteGRP", "CommandButton")
2266:             loc_oCol.CurrentControl = "cmd_4c_FonteGRP"
2267:             WITH loc_oCol.cmd_4c_FonteGRP
2268:                 .Caption       = "..."
2269:                 .Width         = 75
2270:                 .Height        = 25
2271:                 .SpecialEffect = 0
2272:                 .FontName      = "Tahoma"
2273:                 .FontSize      = 8
2274:             ENDWITH
2275:             BINDEVENT(loc_oCol.cmd_4c_FonteGRP, "Click", THIS, "BtnFonteGRPClick")
2276: 
2277:             *- Col5: BtCor - "Cor" (CommandButton - abre GETCOLOR)
2278:             loc_oCol = loc_oGrd.Column5
2279:             loc_oCol.Header1.Caption = "Cor"
2280:             loc_oCol.Width  = 80
2281:             loc_oCol.Sparse = .F.
2282:             loc_oCol.AddObject("cmd_4c_CorGRP", "CommandButton")
2283:             loc_oCol.CurrentControl = "cmd_4c_CorGRP"
2284:             WITH loc_oCol.cmd_4c_CorGRP
2285:                 .Caption       = "..."
2286:                 .Width         = 75
2287:                 .Height        = 25
2288:                 .SpecialEffect = 0
2289:                 .FontName      = "Tahoma"
2290:                 .FontSize      = 8
2291:             ENDWITH
2292:             BINDEVENT(loc_oCol.cmd_4c_CorGRP, "Click", THIS, "BtnCorGRPClick")
2293: 
2294:             *- Col6: LblAlinhar - "Alinhar" (ComboBox)
2295:             loc_oCol = loc_oGrd.Column6
2296:             loc_oCol.Header1.Caption = "Alinhar"
2297:             loc_oCol.Width  = 160
2298:             loc_oCol.Sparse = .F.
2299:             loc_oCol.AddObject("cbo_4c_AlinharGRP", "ComboBox")
2300:             loc_oCol.CurrentControl = "cbo_4c_AlinharGRP"
2301:             WITH loc_oCol.cbo_4c_AlinharGRP

*-- Linhas 2310 a 2318:
2310: 
2311:             *- Col7: LblTamCmp - "Tam." (Spinner)
2312:             loc_oCol = loc_oGrd.Column7
2313:             loc_oCol.Header1.Caption = "Tam."
2314:             loc_oCol.Width  = 149
2315:             loc_oCol.Sparse = .F.
2316:             loc_oCol.AddObject("spn_4c_TamGRP", "Spinner")
2317:             loc_oCol.CurrentControl = "spn_4c_TamGRP"
2318:             WITH loc_oCol.spn_4c_TamGRP

*-- Linhas 2606 a 2614:
2606:             loc_oPage.txt_4c_DtCriacao.Value     = ""
2607:             loc_oPage.txt_4c_DtAlteracao.Value   = ""
2608:             loc_oPage.edt_4c_SqlCMD.Value        = ""
2609:             loc_oPage.lbl_4c_SqlAlterado.Caption = ""
2610:         CATCH TO loc_oErro
2611:             MsgErro(loc_oErro.Message, "FormRPT.LimparCampos")
2612:         ENDTRY
2613:     ENDPROC
2614: 

*-- Linhas 2622 a 2638:
2622:             loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2623: 
2624:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
2625:             loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lModoLista
2626:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lModoLista
2627:             loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lModoLista
2628:             loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lModoLista
2629:             loc_oCnt.cmd_4c_Buscar.Enabled     = loc_lModoLista
2630: 
2631:             WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2632:                 .cmd_4c_Confirmar.Enabled = loc_lModoEdicao
2633:                 .cmd_4c_Cancelar.Enabled  = !loc_lModoLista
2634:                 .Visible     = .T.
2635:             ENDWITH
2636:         CATCH TO loc_oErro
2637:             MsgErro(loc_oErro.Message, "FormRPT.AjustarBotoesPorModo")
2638:         ENDTRY

*-- Linhas 2649 a 2672:
2649:             THIS.this_oWLstTABs = CREATEOBJECT("Form")
2650:             WITH THIS.this_oWLstTABs
2651:                 .BorderStyle       = 1
2652:                 .Caption           = "Tabelas (ESC para fechar)"
2653:                 .HalfHeightCaption = .T.
2654:                 .Left              = 0
2655:                 .Top               = 0
2656:                 .Height            = 280
2657:                 .Width             = 180
2658:                 .Closable          = .F.
2659:                 .MaxButton         = .F.
2660:                 .MinButton         = .F.
2661:                 .Name              = "FrmLstTABs"
2662:                 .ShowTips          = .T.
2663:             ENDWITH
2664:             THIS.this_oWLstTABs.AddObject("Lst_TABs", "ListBox")
2665:             WITH THIS.this_oWLstTABs.Lst_TABs
2666:                 .Left    = 0
2667:                 .Top     = 0
2668:                 .Height  = 280
2669:                 .Width   = 180
2670:                 .Visible = .T.
2671:             ENDWITH
2672:             BINDEVENT(THIS.this_oWLstTABs.Lst_TABs, "DblClick", THIS, "LstTABsDblClick")

*-- Linhas 2690 a 2713:
2690:             THIS.this_oWLstVARs = CREATEOBJECT("Form")
2691:             WITH THIS.this_oWLstVARs
2692:                 .BorderStyle       = 1
2693:                 .Caption           = "Vari" + CHR(225) + "veis (ESC para fechar)"
2694:                 .HalfHeightCaption = .T.
2695:                 .Left              = 0
2696:                 .Top               = 0
2697:                 .Height            = 100
2698:                 .Width             = 180
2699:                 .Closable          = .F.
2700:                 .MaxButton         = .F.
2701:                 .MinButton         = .F.
2702:                 .Name              = "FrmLstVARs"
2703:                 .ShowTips          = .T.
2704:             ENDWITH
2705:             THIS.this_oWLstVARs.AddObject("Lst_VARs", "ListBox")
2706:             WITH THIS.this_oWLstVARs.Lst_VARs
2707:                 .Left    = 0
2708:                 .Top     = 0
2709:                 .Height  = 100
2710:                 .Width   = 180
2711:                 .Visible = .T.
2712:             ENDWITH
2713:             THIS.this_oWLstVARs.Lst_VARs.AddItem("?_vp_DtInicial")

*-- Linhas 2747 a 2756:
2747:                 IF loc_oWLst.Visible
2748:                     loc_oWLst.Hide()
2749:                 ELSE
2750:                     loc_oWLst.Top  = 420
2751:                     loc_oWLst.Left = 20
2752:                     loc_oWLst.Show()
2753:                 ENDIF
2754:             ENDIF
2755:         CATCH TO loc_oErro
2756:             MsgErro(loc_oErro.Message, "FormRPT.AtivarListas")


### BO (C:\4c\projeto\app\classes\RPTBO.prg):
*------------------------------------------------------------------------------
* RPTBO.prg - Business Object para Cadastro Customizado de Relatorios 4Report
* Herda de BusinessBase
* Tabelas principais: SIGCDRLC (cabecalho), SIGCDRLD (detalhes/layout FRX)
* Migrado de: SIGCDRPT (tasks/task512)
*------------------------------------------------------------------------------
DEFINE CLASS RPTBO AS BusinessBase

    *-- Propriedades: Cabecalho do Relatorio (SIGCDRLC)
    this_cRptId        = ""    && RPT_ID - Chave Primaria: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
    this_cNmReport     = ""    && NmReport - Nome do arquivo do report
    this_cDescr        = ""    && Descr - Descricao do report
    this_lAtivo        = .T.   && Ativo - Flag ativo (1=Ativo, 0=Inativo)
    this_dDtCriacao    = {}    && DtCriacao - Data de criacao do report
    this_dDtAlteracao  = {}    && DtAlteracao - Data da ultima alteracao
    this_cSqlQuery     = ""    && SqlQuery - Comando SQL do report (memo)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDRLC"
        THIS.this_cCampoChave = "RPT_ID"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cRptId
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarRptId - Gera novo RPT_ID no formato original: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarRptId()
        RETURN DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT para listar relatorios no grid
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso  = .F.
        loc_cFiltro   = IIF(VARTYPE(par_cFiltro) = "C", ALLTRIM(par_cFiltro), "")

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao" + ;
                       " FROM SIGCDRLC"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE NmReport LIKE " + EscaparSQL("%" + loc_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY NmReport"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar relat" + CHR(243) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega cabecalho do relatorio por RPT_ID
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cRptId)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            MsgErro("RPT_ID inv" + CHR(225) + "lido para carregamento.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
                       " FROM SIGCDRLC" + ;
                       " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorNome - Carrega cabecalho do relatorio por NmReport
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorNome(par_cNmReport)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cNmReport) != "C" OR EMPTY(ALLTRIM(par_cNmReport))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
                       " FROM SIGCDRLC" + ;
                       " WHERE NmReport = " + EscaparSQL(ALLTRIM(par_cNmReport))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarPorNome:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSqlQuery - Carrega apenas o SqlQuery de um relatorio (campo memo)
    *--------------------------------------------------------------------------
    FUNCTION CarregarSqlQuery(par_cRptId)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.
        loc_cQuery   = ""

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            RETURN ""
        ENDIF

        TRY
            IF USED("cursor_4c_SqlQuery")
                USE IN cursor_4c_SqlQuery
            ENDIF

            loc_cSQL = "SELECT SqlQuery FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlQuery")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_SqlQuery") > 0
                SELECT cursor_4c_SqlQuery
                loc_cQuery = NVL(SqlQuery, "")
            ENDIF

            IF USED("cursor_4c_SqlQuery")
                USE IN cursor_4c_SqlQuery
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cQuery
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_
    * SEMPRE usa SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
            THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
            THIS.this_cDescr       = TratarNulo(Descr,       "C")
            THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
            THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
            THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")

            IF PEMSTATUS(ALIAS() + "", "SqlQuery", 5) OR ;
               AFIELDS(laFields, par_cAliasCursor) > 0
                IF ASCAN(laFields, "SQLQUERY") > 0
                    THIS.this_cSqlQuery = TratarNulo(SqlQuery, "C")
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursorCompleto - Mapeia TODOS os campos incluindo SqlQuery
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursorCompleto(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
            THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
            THIS.this_cDescr       = TratarNulo(Descr,       "C")
            THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
            THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
            THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
            THIS.this_cSqlQuery    = TratarNulo(SqlQuery,    "C")
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarDoCursorCompleto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cNmReport))
            MsgAviso("Campo NOME do Report n" + CHR(227) + "o preenchido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cSqlQuery))
            MsgAviso("Campo SQL do Report n" + CHR(227) + "o preenchido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SIGCDRLC (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cRptId
        loc_lSucesso = .F.

        TRY
            *-- Gerar RPT_ID unico no formato original
            loc_cRptId = THIS.GerarRptId()
            THIS.this_cRptId      = loc_cRptId
            THIS.this_dDtCriacao  = DATE()
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "INSERT INTO SIGCDRLC" + ;
                       " (RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cRptId) + ", " + ;
                       EscaparSQL(THIS.this_cNmReport) + ", " + ;
                       EscaparSQL(THIS.this_cDescr) + ", " + ;
                       IIF(THIS.this_lAtivo, "1", "0") + ", " + ;
                       FormatarDataSQL(THIS.this_dDtCriacao) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlteracao) + ", " + ;
                       EscaparSQL(THIS.this_cSqlQuery) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SIGCDRLC (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cRptId))
            MsgErro("RPT_ID n" + CHR(227) + "o definido para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                       " NmReport = " + EscaparSQL(THIS.this_cNmReport) + "," + ;
                       " Descr = " + EscaparSQL(THIS.this_cDescr) + "," + ;
                       " Ativo = " + IIF(THIS.this_lAtivo, "1", "0") + "," + ;
                       " DtAlteracao = " + FormatarDataSQL(THIS.this_dDtAlteracao) + "," + ;
                       " SqlQuery = " + EscaparSQL(THIS.this_cSqlQuery) + ;
                       " WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SIGCDRLD + SIGCDRLC (PROTECTED)
    * Ordem obrigatoria: SIGCDRLD primeiro (filhos), depois SIGCDRLC (pai)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cRptId))
            MsgErro("RPT_ID n" + CHR(227) + "o definido para exclus" + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- 1. Excluir detalhes/layout FRX (SIGCDRLD) - filhos primeiro
            loc_cSQL = "DELETE FROM SIGCDRLD WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir detalhes do relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Excluir cabecalho (SIGCDRLC) - pai depois
            loc_cSQL = "DELETE FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarSqlQuery - Atualiza apenas o campo SqlQuery de um relatorio existente
    * Chamado pelo editor SQL quando o usuario edita a query sem alterar outros campos
    *--------------------------------------------------------------------------
    FUNCTION SalvarSqlQuery(par_cRptId, par_cSqlQuery)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                       " SqlQuery = " + EscaparSQL(par_cSqlQuery) + "," + ;
                       " DtAlteracao = " + FormatarDataSQL(THIS.this_dDtAlteracao) + ;
                       " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao salvar SQL do relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.SalvarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarSqlQuery - Executa o SqlQuery e retorna cursor com resultado
    * Usado pelo editor SQL para pre-visualizar resultados
    *--------------------------------------------------------------------------
    FUNCTION ExecutarSqlQuery(par_cSqlQuery, par_cCursorDestino)
        LOCAL loc_nResultado, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
                           par_cCursorDestino, "cursor_4c_SqlResult")

        IF VARTYPE(par_cSqlQuery) != "C" OR EMPTY(ALLTRIM(par_cSqlQuery))
            MsgAviso("SQL n" + CHR(227) + "o informado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ALLTRIM(par_cSqlQuery), loc_cCursor)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.ExecutarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarTabelasSqlServer - Lista tabelas do banco para o editor SQL (F8)
    *--------------------------------------------------------------------------
    FUNCTION BuscarTabelasSqlServer()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Tabelas")
                USE IN cursor_4c_Tabelas
            ENDIF

            loc_cSQL = "SELECT UPPER(Name) AS NmTable, Object_ID, Modify_Date" + ;
                       " FROM sys.tables" + ;
                       " ORDER BY Name"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tabelas")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tabelas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.BuscarTabelasSqlServer:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarColunasDaTabela - Lista colunas de uma tabela especifica (F9)
    *--------------------------------------------------------------------------
    FUNCTION BuscarColunasDaTabela(par_cNomeTabela)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cNomeTabela) != "C" OR EMPTY(ALLTRIM(par_cNomeTabela))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Colunas")
                USE IN cursor_4c_Colunas
            ENDIF

            loc_cSQL = "SELECT c.Column_ID, c.Name AS Column_Name, t.Name AS Type, c.Max_Length" + ;
                       " FROM sys.all_Columns c" + ;
                       " JOIN sys.types t ON t.System_Type_ID = c.System_Type_ID" + ;
                       " WHERE c.Object_ID = OBJECT_ID(" + EscaparSQL(ALLTRIM(par_cNomeTabela)) + ")" + ;
                       " ORDER BY c.Column_ID"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Colunas")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar colunas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.BuscarColunasDaTabela:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

