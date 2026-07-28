# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 168: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 192: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 216: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 240: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 264: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 300: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 374: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 398: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCec.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1381 linhas total):

*-- Linhas 40 a 48:
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             THIS.Caption = "Cadastro de Acesso a Consulta Gen" + CHR(233) + ;
44:                            "rica de Situa" + CHR(231) + CHR(227) + "o"
45: 
46:             THIS.this_oBusinessObject = CREATEOBJECT("CecBO")
47:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
48:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio CecBO", "Erro")

*-- Linhas 72 a 90:
72:     PROTECTED PROCEDURE ConfigurarPageFrame()
73:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
74:         WITH THIS.pgf_4c_Paginas
75:             .Top        = -29
76:             .Left       = 0
77:             .Width      = THIS.Width
78:             .Height     = THIS.Height + 29
79:             .PageCount  = 2
80:             .Tabs       = .F.
81:             .TabStretch = 1
82:             .Page1.Caption   = "Lista"
83:             .Page1.BackColor = RGB(255, 255, 255)
84:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
85:             .Page2.Caption   = "Dados"
86:             .Page2.BackColor = RGB(255, 255, 255)
87:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
88:             .Visible = .T.
89:         ENDWITH
90:     ENDPROC

*-- Linhas 97 a 138:
97:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
98:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99: 
100:         *-- Cabecalho cinza (cntSombra no legado) - Top compensado +29 pelo PageFrame.Top=-29
101:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
102:         loc_oCab = loc_oPagina.cnt_4c_Cabecalho
103:         WITH loc_oCab
104:             .Top         = 31
105:             .Left        = 0
106:             .Width       = THIS.Width
107:             .Height      = 80
108:             .BackColor   = RGB(100, 100, 100)
109:             .BorderWidth = 0
110:             .Visible     = .T.
111:         ENDWITH
112: 
113:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
114:         WITH loc_oCab.lbl_4c_Sombra
115:             .Caption   = THIS.Caption
116:             .Top       = 15
117:             .Left      = 10
118:             .Width     = THIS.Width
119:             .Height    = 40
120:             .FontName  = "Tahoma"
121:             .FontSize  = 16
122:             .FontBold  = .T.
123:             .ForeColor = RGB(0, 0, 0)
124:             .BackStyle = 0
125:             .AutoSize  = .F.
126:             .Visible   = .T.
127:         ENDWITH
128: 
129:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
130:         WITH loc_oCab.lbl_4c_Titulo
131:             .Caption   = THIS.Caption
132:             .Top       = 18
133:             .Left      = 10
134:             .Width     = THIS.Width
135:             .Height    = 46
136:             .FontName  = "Tahoma"
137:             .FontSize  = 16
138:             .FontBold  = .T.

*-- Linhas 146 a 324:
146:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
147:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
148:         WITH loc_oCnt
149:             .Top         = 29
150:             .Left        = 542
151:             .Width       = 390
152:             .Height      = 85
153:             .BackStyle   = 1
154:             .BackColor   = RGB(53, 53, 53)
155:             .BorderWidth = 0
156:             .Visible     = .T.
157:         ENDWITH
158: 
159:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
160:         WITH loc_oCnt.cmd_4c_Incluir
161:             .Caption         = "Incluir"
162:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
163:             .PicturePosition = 13
164:             .Top             = 5
165:             .Left            = 5
166:             .Width           = 75
167:             .Height          = 75
168:             .FontName        = "Comic Sans MS"
169:             .FontSize        = 8
170:             .FontBold        = .T.
171:             .FontItalic      = .T.
172:             .ForeColor       = RGB(90, 90, 90)
173:             .BackColor       = RGB(255, 255, 255)
174:             .Themes          = .F.
175:             .SpecialEffect   = 0
176:             .MousePointer    = 15
177:             .WordWrap        = .T.
178:             .AutoSize        = .F.
179:             .Visible         = .T.
180:         ENDWITH
181:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
182: 
183:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
184:         WITH loc_oCnt.cmd_4c_Visualizar
185:             .Caption         = "Visualizar"
186:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
187:             .PicturePosition = 13
188:             .Top             = 5
189:             .Left            = 80
190:             .Width           = 75
191:             .Height          = 75
192:             .FontName        = "Comic Sans MS"
193:             .FontSize        = 8
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .ForeColor       = RGB(90, 90, 90)
197:             .BackColor       = RGB(255, 255, 255)
198:             .Themes          = .F.
199:             .SpecialEffect   = 0
200:             .MousePointer    = 15
201:             .WordWrap        = .T.
202:             .AutoSize        = .F.
203:             .Visible         = .T.
204:         ENDWITH
205:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
206: 
207:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
208:         WITH loc_oCnt.cmd_4c_Alterar
209:             .Caption         = "Alterar"
210:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
211:             .PicturePosition = 13
212:             .Top             = 5
213:             .Left            = 155
214:             .Width           = 75
215:             .Height          = 75
216:             .FontName        = "Comic Sans MS"
217:             .FontSize        = 8
218:             .FontBold        = .T.
219:             .FontItalic      = .T.
220:             .ForeColor       = RGB(90, 90, 90)
221:             .BackColor       = RGB(255, 255, 255)
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .MousePointer    = 15
225:             .WordWrap        = .T.
226:             .AutoSize        = .F.
227:             .Visible         = .T.
228:         ENDWITH
229:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
230: 
231:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
232:         WITH loc_oCnt.cmd_4c_Excluir
233:             .Caption         = "Excluir"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 230
238:             .Width           = 75
239:             .Height          = 75
240:             .FontName        = "Comic Sans MS"
241:             .FontSize        = 8
242:             .FontBold        = .T.
243:             .FontItalic      = .T.
244:             .ForeColor       = RGB(90, 90, 90)
245:             .BackColor       = RGB(255, 255, 255)
246:             .Themes          = .F.
247:             .SpecialEffect   = 0
248:             .MousePointer    = 15
249:             .WordWrap        = .T.
250:             .AutoSize        = .F.
251:             .Visible         = .T.
252:         ENDWITH
253:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
254: 
255:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
256:         WITH loc_oCnt.cmd_4c_Buscar
257:             .Caption         = "Buscar"
258:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
259:             .PicturePosition = 13
260:             .Top             = 5
261:             .Left            = 305
262:             .Width           = 75
263:             .Height          = 75
264:             .FontName        = "Comic Sans MS"
265:             .FontSize        = 8
266:             .FontBold        = .T.
267:             .FontItalic      = .T.
268:             .ForeColor       = RGB(90, 90, 90)
269:             .BackColor       = RGB(255, 255, 255)
270:             .Themes          = .F.
271:             .SpecialEffect   = 0
272:             .MousePointer    = 15
273:             .WordWrap        = .T.
274:             .AutoSize        = .F.
275:             .Visible         = .T.
276:         ENDWITH
277:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
278: 
279:         *-- Container saida - padrao canonico: Left=917, Width=90
280:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
281:         WITH loc_oPagina.cnt_4c_Saida
282:             .Top         = 29
283:             .Left        = 917
284:             .Width       = 90
285:             .Height      = 85
286:             .BackStyle   = 0
287:             .BorderWidth = 0
288:             .Visible     = .T.
289:         ENDWITH
290: 
291:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
292:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
293:             .Caption         = "Encerrar"
294:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
295:             .PicturePosition = 13
296:             .Top             = 5
297:             .Left            = 5
298:             .Width           = 75
299:             .Height          = 75
300:             .FontName        = "Comic Sans MS"
301:             .FontSize        = 8
302:             .FontBold        = .T.
303:             .FontItalic      = .T.
304:             .ForeColor       = RGB(90, 90, 90)
305:             .BackColor       = RGB(255, 255, 255)
306:             .Themes          = .F.
307:             .SpecialEffect   = 0
308:             .MousePointer    = 15
309:             .WordWrap        = .T.
310:             .AutoSize        = .F.
311:             .Visible         = .T.
312:         ENDWITH
313:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
314: 
315:         *-- Grid da lista - colunas: Emps (Emp.), Razas (Razao Social), Tipos (Rede)
316:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
317:         loc_oGrid = loc_oPagina.grd_4c_Lista
318:         loc_oGrid.Top         = 117
319:         loc_oGrid.Left        = 12
320:         loc_oGrid.Width       = 890
321:         loc_oGrid.Height      = 450
322:         loc_oGrid.ColumnCount = 3
323:         WITH loc_oGrid
324:             .FontName           = "Verdana"

*-- Linhas 352 a 426:
352:         *-- Container botoes salvar/cancelar (grupo_salva no legado)
353:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
354:         WITH loc_oPagina.cnt_4c_Salva
355:             .Top         = 33
356:             .Left        = 842
357:             .Width       = 160
358:             .Height      = 85
359:             .BackStyle   = 0
360:             .Visible     = .T.
361:         ENDWITH
362: 
363:         loc_oCnt = loc_oPagina.cnt_4c_Salva
364: 
365:         loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
366:         WITH loc_oCnt.cmd_4c_Confirmar
367:             .Caption         = "Confirmar"
368:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
369:             .PicturePosition = 13
370:             .Top             = 5
371:             .Left            = 5
372:             .Width           = 75
373:             .Height          = 75
374:             .FontName        = "Comic Sans MS"
375:             .FontSize        = 8
376:             .FontBold        = .T.
377:             .FontItalic      = .T.
378:             .ForeColor       = RGB(90, 90, 90)
379:             .BackColor       = RGB(255, 255, 255)
380:             .Themes          = .F.
381:             .SpecialEffect   = 0
382:             .MousePointer    = 15
383:             .WordWrap        = .T.
384:             .AutoSize        = .F.
385:             .Visible         = .T.
386:         ENDWITH
387:         BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
388: 
389:         loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
390:         WITH loc_oCnt.cmd_4c_Cancelar
391:             .Caption         = "Encerrar"
392:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
393:             .PicturePosition = 13
394:             .Top             = 5
395:             .Left            = 80
396:             .Width           = 75
397:             .Height          = 75
398:             .FontName        = "Comic Sans MS"
399:             .FontSize        = 8
400:             .FontBold        = .T.
401:             .FontItalic      = .T.
402:             .ForeColor       = RGB(90, 90, 90)
403:             .BackColor       = RGB(255, 255, 255)
404:             .Themes          = .F.
405:             .SpecialEffect   = 0
406:             .MousePointer    = 15
407:             .WordWrap        = .T.
408:             .AutoSize        = .F.
409:             .Visible         = .T.
410:         ENDWITH
411:         BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
412: 
413:         *----------------------------------------------------------------------
414:         *-- EMPRESA (Labelocup2 + getEmpresa + getDesEmpresa)
415:         *-- getEmpresa.When: somente INSERIR/PROCURAR; getDesEmpresa.When: quando getEmpresa vazio
416:         *----------------------------------------------------------------------
417:         loc_oPagina.AddObject("lbl_4c_Ocup2", "Label")
418:         WITH loc_oPagina.lbl_4c_Ocup2
419:             .Caption   = "Empresa :"
420:             .Top       = 86
421:             .Left      = 188
422:             .Width     = 90
423:             .Height    = 17
424:             .FontName  = "Tahoma"
425:             .FontSize  = 8
426:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 432 a 472:
432:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
433:         WITH loc_oPagina.txt_4c_Empresa
434:             .Value     = ""
435:             .Top       = 84
436:             .Left      = 240
437:             .Width     = 31
438:             .Height    = 23
439:             .FontName  = "Tahoma"
440:             .FontSize  = 8
441:             .MaxLength = 3
442:             .Visible   = .T.
443:         ENDWITH
444:         BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresaCec")
445: 
446:         loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
447:         WITH loc_oPagina.txt_4c_DesEmpresa
448:             .Value     = ""
449:             .Top       = 84
450:             .Left      = 273
451:             .Width     = 290
452:             .Height    = 23
453:             .FontName  = "Tahoma"
454:             .FontSize  = 8
455:             .ReadOnly  = .T.
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *----------------------------------------------------------------------
460:         *-- TIPO (Labelocup1 + cmbTCons)
461:         *-- cmbTCons.When: somente INSERIR/PROCURAR
462:         *----------------------------------------------------------------------
463:         loc_oPagina.AddObject("lbl_4c_Ocup1", "Label")
464:         WITH loc_oPagina.lbl_4c_Ocup1
465:             .Caption   = "Tipo :"
466:             .Top       = 111
467:             .Left      = 209
468:             .Width     = 50
469:             .Height    = 17
470:             .FontName  = "Tahoma"
471:             .FontSize  = 8
472:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 478 a 487:
478:         loc_oPagina.AddObject("cbo_4c_CmbTCons", "ComboBox")
479:         WITH loc_oPagina.cbo_4c_CmbTCons
480:             .Value         = ""
481:             .Top           = 108
482:             .Left          = 240
483:             .Width         = 115
484:             .Height        = 24
485:             .FontName      = "Tahoma"
486:             .FontSize      = 8
487:             .RowSourceType = 1

*-- Linhas 495 a 507:
495:         *-- CONTRATO (Labelocup3 + GetContrato)
496:         *-- GetContrato.When: somente quando Tipos = "CHEQUE PRE" E INSERIR/ALTERAR
497:         *----------------------------------------------------------------------
498:         loc_oPagina.AddObject("lbl_4c_Ocup3", "Label")
499:         WITH loc_oPagina.lbl_4c_Ocup3
500:             .Caption   = "Contrato :"
501:             .Top       = 135
502:             .Left      = 186
503:             .Width     = 70
504:             .Height    = 17
505:             .FontName  = "Tahoma"
506:             .FontSize  = 8
507:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 513 a 539:
513:         loc_oPagina.AddObject("txt_4c_Contrato", "TextBox")
514:         WITH loc_oPagina.txt_4c_Contrato
515:             .Value     = ""
516:             .Top       = 133
517:             .Left      = 239
518:             .Width     = 365
519:             .Height    = 23
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .MaxLength = 100
523:             .Visible   = .T.
524:         ENDWITH
525: 
526:         *----------------------------------------------------------------------
527:         *-- CODIGO DA REDE (Labelocup5 + GetRede)
528:         *-- GetRede.When: somente quando Tipos = "CHEQUE PRE" E INSERIR/ALTERAR
529:         *----------------------------------------------------------------------
530:         loc_oPagina.AddObject("lbl_4c_Ocup5", "Label")
531:         WITH loc_oPagina.lbl_4c_Ocup5
532:             .Caption   = "Codigo da Rede :"
533:             .Top       = 159
534:             .Left      = 153
535:             .Width     = 105
536:             .Height    = 17
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 545 a 571:
545:         loc_oPagina.AddObject("txt_4c_Rede", "TextBox")
546:         WITH loc_oPagina.txt_4c_Rede
547:             .Value     = ""
548:             .Top       = 157
549:             .Left      = 240
550:             .Width     = 365
551:             .Height    = 23
552:             .FontName  = "Tahoma"
553:             .FontSize  = 8
554:             .MaxLength = 100
555:             .Visible   = .T.
556:         ENDWITH
557: 
558:         *----------------------------------------------------------------------
559:         *-- CODIGO DA LOJA (Labelocup6 + GetLoja)
560:         *-- GetLoja.When: somente quando Tipos = "CHEQUE PRE" E INSERIR/ALTERAR
561:         *----------------------------------------------------------------------
562:         loc_oPagina.AddObject("lbl_4c_Ocup6", "Label")
563:         WITH loc_oPagina.lbl_4c_Ocup6
564:             .Caption   = "Codigo do Loja :"
565:             .Top       = 183
566:             .Left      = 158
567:             .Width     = 100
568:             .Height    = 17
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 577 a 603:
577:         loc_oPagina.AddObject("txt_4c_Loja", "TextBox")
578:         WITH loc_oPagina.txt_4c_Loja
579:             .Value     = ""
580:             .Top       = 181
581:             .Left      = 240
582:             .Width     = 365
583:             .Height    = 23
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8
586:             .MaxLength = 100
587:             .Visible   = .T.
588:         ENDWITH
589: 
590:         *----------------------------------------------------------------------
591:         *-- LOGON (Labelocup4 + GetLogon)
592:         *-- GetLogon.When: somente quando Tipos <> "CHEQUE PRE" E INSERIR/ALTERAR
593:         *----------------------------------------------------------------------
594:         loc_oPagina.AddObject("lbl_4c_Ocup4", "Label")
595:         WITH loc_oPagina.lbl_4c_Ocup4
596:             .Caption   = "Logon :"
597:             .Top       = 207
598:             .Left      = 200
599:             .Width     = 55
600:             .Height    = 17
601:             .FontName  = "Tahoma"
602:             .FontSize  = 8
603:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 609 a 635:
609:         loc_oPagina.AddObject("txt_4c_Logon", "TextBox")
610:         WITH loc_oPagina.txt_4c_Logon
611:             .Value     = ""
612:             .Top       = 205
613:             .Left      = 240
614:             .Width     = 68
615:             .Height    = 23
616:             .FontName  = "Tahoma"
617:             .FontSize  = 8
618:             .MaxLength = 8
619:             .Visible   = .T.
620:         ENDWITH
621: 
622:         *----------------------------------------------------------------------
623:         *-- SENHA (Labelocup7 + GetSenha)
624:         *-- GetSenha.When: somente quando Tipos <> "CHEQUE PRE" E INSERIR/ALTERAR
625:         *----------------------------------------------------------------------
626:         loc_oPagina.AddObject("lbl_4c_Ocup7", "Label")
627:         WITH loc_oPagina.lbl_4c_Ocup7
628:             .Caption   = "Senha :"
629:             .Top       = 231
630:             .Left      = 199
631:             .Width     = 55
632:             .Height    = 17
633:             .FontName  = "Tahoma"
634:             .FontSize  = 8
635:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 641 a 650:
641:         loc_oPagina.AddObject("txt_4c_Senha", "TextBox")
642:         WITH loc_oPagina.txt_4c_Senha
643:             .Value        = ""
644:             .Top          = 229
645:             .Left         = 240
646:             .Width        = 68
647:             .Height       = 23
648:             .FontName     = "Tahoma"
649:             .FontSize     = 8
650:             .MaxLength    = 8

*-- Linhas 657 a 669:
657:         *-- Ativo somente quando Tipos = "SERASA" E INSERIR/ALTERAR
658:         *-- Valid original: aceita apenas ' ', 'CP', 'CH'
659:         *----------------------------------------------------------------------
660:         loc_oPagina.AddObject("lbl_4c_Ocup12", "Label")
661:         WITH loc_oPagina.lbl_4c_Ocup12
662:             .Caption   = "Consulta Serasa :"
663:             .Top       = 256
664:             .Left      = 151
665:             .Width     = 115
666:             .Height    = 17
667:             .FontName  = "Tahoma"
668:             .FontSize  = 8
669:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 675 a 701:
675:         loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
676:         WITH loc_oPagina.txt_4c_Fwget1
677:             .Value     = ""
678:             .Top       = 254
679:             .Left      = 240
680:             .Width     = 24
681:             .Height    = 23
682:             .FontName  = "Tahoma"
683:             .FontSize  = 8
684:             .MaxLength = 2
685:             .Visible   = .T.
686:         ENDWITH
687:         BINDEVENT(loc_oPagina.txt_4c_Fwget1, "KeyPress", THIS, "ValidarTipoSerasa")
688: 
689:         *----------------------------------------------------------------------
690:         *-- VALOR MINIMO (Labelocup9 + GetValMin)
691:         *----------------------------------------------------------------------
692:         loc_oPagina.AddObject("lbl_4c_Ocup9", "Label")
693:         WITH loc_oPagina.lbl_4c_Ocup9
694:             .Caption   = "Valor Minimo :"
695:             .Top       = 281
696:             .Left      = 170
697:             .Width     = 95
698:             .Height    = 17
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 707 a 733:
707:         loc_oPagina.AddObject("txt_4c_ValMin", "TextBox")
708:         WITH loc_oPagina.txt_4c_ValMin
709:             .Value     = 0
710:             .Top       = 279
711:             .Left      = 240
712:             .Width     = 130
713:             .Height    = 23
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .Format    = "N"
717:             .InputMask = "999999999.99"
718:             .Visible   = .T.
719:         ENDWITH
720: 
721:         *----------------------------------------------------------------------
722:         *-- VALOR FIXO (Labelocup10 + GetValFix)
723:         *----------------------------------------------------------------------
724:         loc_oPagina.AddObject("lbl_4c_Ocup10", "Label")
725:         WITH loc_oPagina.lbl_4c_Ocup10
726:             .Caption   = "Valor Fixo :"
727:             .Top       = 305
728:             .Left      = 182
729:             .Width     = 80
730:             .Height    = 17
731:             .FontName  = "Tahoma"
732:             .FontSize  = 8
733:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 739 a 765:
739:         loc_oPagina.AddObject("txt_4c_ValFix", "TextBox")
740:         WITH loc_oPagina.txt_4c_ValFix
741:             .Value     = 0
742:             .Top       = 303
743:             .Left      = 240
744:             .Width     = 130
745:             .Height    = 23
746:             .FontName  = "Tahoma"
747:             .FontSize  = 8
748:             .Format    = "N"
749:             .InputMask = "999999999.99"
750:             .Visible   = .T.
751:         ENDWITH
752: 
753:         *----------------------------------------------------------------------
754:         *-- URL / IP PROXY (Labelocup8 + GetIp)
755:         *----------------------------------------------------------------------
756:         loc_oPagina.AddObject("lbl_4c_Ocup8", "Label")
757:         WITH loc_oPagina.lbl_4c_Ocup8
758:             .Caption   = "URL / IP - Proxi :"
759:             .Top       = 332
760:             .Left      = 156
761:             .Width     = 115
762:             .Height    = 17
763:             .FontName  = "Tahoma"
764:             .FontSize  = 8
765:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 771 a 796:
771:         loc_oPagina.AddObject("txt_4c_Ip", "TextBox")
772:         WITH loc_oPagina.txt_4c_Ip
773:             .Value     = ""
774:             .Top       = 328
775:             .Left      = 240
776:             .Width     = 365
777:             .Height    = 23
778:             .FontName  = "Tahoma"
779:             .FontSize  = 8
780:             .MaxLength = 32
781:             .Visible   = .T.
782:         ENDWITH
783: 
784:         *----------------------------------------------------------------------
785:         *-- PORTA (Labelocup11 + GetPorta)
786:         *----------------------------------------------------------------------
787:         loc_oPagina.AddObject("lbl_4c_Ocup11", "Label")
788:         WITH loc_oPagina.lbl_4c_Ocup11
789:             .Caption   = "Porta :"
790:             .Top       = 355
791:             .Left      = 203
792:             .Width     = 50
793:             .Height    = 17
794:             .FontName  = "Tahoma"
795:             .FontSize  = 8
796:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 802 a 828:
802:         loc_oPagina.AddObject("txt_4c_Porta", "TextBox")
803:         WITH loc_oPagina.txt_4c_Porta
804:             .Value     = 0
805:             .Top       = 353
806:             .Left      = 240
807:             .Width     = 43
808:             .Height    = 23
809:             .FontName  = "Tahoma"
810:             .FontSize  = 8
811:             .Format    = "N"
812:             .InputMask = "99999"
813:             .Visible   = .T.
814:         ENDWITH
815: 
816:         *----------------------------------------------------------------------
817:         *-- USUARIO PROXY (Labelocup13 + GetUsuProxy)
818:         *----------------------------------------------------------------------
819:         loc_oPagina.AddObject("lbl_4c_Ocup13", "Label")
820:         WITH loc_oPagina.lbl_4c_Ocup13
821:             .Caption   = "Usuario Proxy :"
822:             .Top       = 380
823:             .Left      = 162
824:             .Width     = 100
825:             .Height    = 17
826:             .FontName  = "Tahoma"
827:             .FontSize  = 8
828:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 834 a 859:
834:         loc_oPagina.AddObject("txt_4c_UsuProxy", "TextBox")
835:         WITH loc_oPagina.txt_4c_UsuProxy
836:             .Value     = ""
837:             .Top       = 378
838:             .Left      = 240
839:             .Width     = 363
840:             .Height    = 23
841:             .FontName  = "Tahoma"
842:             .FontSize  = 8
843:             .MaxLength = 64
844:             .Visible   = .T.
845:         ENDWITH
846: 
847:         *----------------------------------------------------------------------
848:         *-- SENHA PROXY (Labelocup14 + GetSenProxy)
849:         *----------------------------------------------------------------------
850:         loc_oPagina.AddObject("lbl_4c_Ocup14", "Label")
851:         WITH loc_oPagina.lbl_4c_Ocup14
852:             .Caption   = "Senha Proxy :"
853:             .Top       = 405
854:             .Left      = 168
855:             .Width     = 95
856:             .Height    = 17
857:             .FontName  = "Tahoma"
858:             .FontSize  = 8
859:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 865 a 874:
865:         loc_oPagina.AddObject("txt_4c_SenProxy", "TextBox")
866:         WITH loc_oPagina.txt_4c_SenProxy
867:             .Value        = ""
868:             .Top          = 403
869:             .Left         = 240
870:             .Width        = 198
871:             .Height       = 23
872:             .FontName     = "Tahoma"
873:             .FontSize     = 8
874:             .MaxLength    = 20

*-- Linhas 921 a 931:
921:                     loc_oGrid.Column1.Width          = 50
922:                     loc_oGrid.Column2.Width          = 300
923:                     loc_oGrid.Column3.Width          = 150
924:                     loc_oGrid.Column1.Header1.Caption = "Emp."
925:                     loc_oGrid.Column2.Header1.Caption = "Razao Social"
926:                     loc_oGrid.Column3.Header1.Caption = "Rede"
927:                     THIS.FormatarGridLista(loc_oGrid)
928:                     loc_lResultado = .T.
929:                 ENDIF
930:             ENDIF
931:         CATCH TO loc_oErro

*-- Linhas 1223 a 1245:
1223: 
1224:         *-- Campos somente CHEQUE PRE
1225:         loc_oPagina.txt_4c_Contrato.Visible = loc_lChequePre
1226:         loc_oPagina.lbl_4c_Ocup3.Visible    = loc_lChequePre
1227:         loc_oPagina.txt_4c_Rede.Visible     = loc_lChequePre
1228:         loc_oPagina.lbl_4c_Ocup5.Visible    = loc_lChequePre
1229:         loc_oPagina.txt_4c_Loja.Visible     = loc_lChequePre
1230:         loc_oPagina.lbl_4c_Ocup6.Visible    = loc_lChequePre
1231: 
1232:         *-- Campos somente nao CHEQUE PRE
1233:         loc_oPagina.txt_4c_Logon.Visible   = !loc_lChequePre
1234:         loc_oPagina.lbl_4c_Ocup4.Visible   = !loc_lChequePre
1235:         loc_oPagina.txt_4c_Senha.Visible   = !loc_lChequePre
1236:         loc_oPagina.lbl_4c_Ocup7.Visible   = !loc_lChequePre
1237: 
1238:         *-- Campo somente SERASA
1239:         loc_oPagina.txt_4c_Fwget1.Visible  = (loc_cTipo == "SERASA")
1240:         loc_oPagina.lbl_4c_Ocup12.Visible  = (loc_cTipo == "SERASA")
1241:     ENDPROC
1242: 
1243:     *--------------------------------------------------------------------------
1244:     PROTECTED PROCEDURE AtualizarVisibilidadeCampos()
1245:         THIS.TipoConsultaChanged()

*-- Linhas 1367 a 1375:
1367:             loc_cCaption = "Confirmar"
1368:         ENDCASE
1369: 
1370:         loc_oCnt.cmd_4c_Confirmar.Caption = loc_cCaption
1371:     ENDPROC
1372: 
1373:     *--------------------------------------------------------------------------
1374:     PROCEDURE Destroy()
1375:         IF VARTYPE(THIS.this_oBusinessObject) = "O"


### BO (C:\4c\projeto\app\classes\CecBO.prg):
*==============================================================================
* CecBO.prg - Business Object para Cadastro de Acesso a Consulta Generica
* Tabela: SigFiChc
* PK: cIdChaves (char 20, gerado por fUniqueIds)
*==============================================================================

DEFINE CLASS CecBO AS BusinessBase

    *-- Chave primaria
    this_cIdChaves    = ""   && char(20) PK

    *-- Campos de identificacao / chave composta funcional
    this_cEmps        = ""   && char(3)  Empresa (FK SigCdEmp.cEmps)
    this_cTipos       = ""   && char(20) Tipo de Consulta (CHEQUE PRE / SERASA / ACSP)

    *-- Campos de acesso CHEQUE PRE
    this_cCtr         = ""   && char(100) Contrato
    this_cRde         = ""   && char(100) Codigo da Rede
    this_cRdeLja      = ""   && char(100) Codigo da Loja

    *-- Campos de acesso nao-CHEQUE PRE
    this_cLogon       = ""   && char(8)  Logon
    this_cNSenha      = ""   && char(8)  nSenha (campo interno, armazenado no banco)
    this_cSenha       = ""   && char(8)  Senha de acesso

    *-- Valores de referencia
    this_nVlrMin      = 0    && numeric(11,2) Valor Minimo
    this_nVlrFixo     = 0    && numeric(11,2) Valor Fixo

    *-- Configuracao de conexao
    this_cCipchps     = ""   && char(32) URL / IP Proxy
    this_nPortachps   = 0    && int      Porta
    this_cVersao      = ""   && char(10) Versao

    *-- Consulta Serasa
    this_cCTipos      = ""   && char(2)  Tipo Consulta Serasa (CP / CH)

    *-- Proxy
    this_cUsuProxys   = ""   && char(64) Usuario Proxy
    this_cSenProxys   = ""   && char(20) Senha Proxy

    *-- Campo de exibicao (JOIN com SigCdEmp)
    this_cRazas       = ""   && char(40) Razao Social (SigCdEmp.Razas, somente leitura)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiChc"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros com JOIN para exibir Razao Social
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.Emps, a.Tipos, a.Ctr, a.Rde, a.RdeLja," + ;
                       " a.Logon, a.Senha, a.VlrMin, a.VlrFixo, a.cipchps, a.nPortachps," + ;
                       " a.cTipos, a.cUsuProxys, a.cSenProxys, b.Razas" + ;
                       " FROM SigFiChc a" + ;
                       " INNER JOIN SigCdEmp b ON a.Cemps = b.cEmps"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.Emps = " + EscaparSQL(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Tipos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pela PK (cIdChaves)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.Emps, a.Tipos, a.Ctr, a.Rde, a.RdeLja," + ;
                       " a.Logon, a.Senha, a.VlrMin, a.VlrFixo, a.cipchps, a.nPortachps," + ;
                       " a.cTipos, a.cUsuProxys, a.cSenProxys, b.Razas" + ;
                       " FROM SigFiChc a" + ;
                       " INNER JOIN SigCdEmp b ON a.Cemps = b.cEmps" + ;
                       " WHERE a.cIdChaves = " + EscaparSQL(par_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se ja existe registro com Emps+Tipos
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves FROM SigFiChc" + ;
                       " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Tipos = " + EscaparSQL(THIS.this_cTipos)

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

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves   = TratarNulo(cIdChaves,   "C")
            THIS.this_cEmps       = TratarNulo(Emps,        "C")
            THIS.this_cTipos      = TratarNulo(Tipos,       "C")
            THIS.this_cCtr        = TratarNulo(Ctr,         "C")
            THIS.this_cRde        = TratarNulo(Rde,         "C")
            THIS.this_cRdeLja     = TratarNulo(RdeLja,      "C")
            THIS.this_cLogon      = TratarNulo(Logon,       "C")
            THIS.this_cSenha      = TratarNulo(Senha,       "C")
            THIS.this_nVlrMin     = TratarNulo(VlrMin,      "N")
            THIS.this_nVlrFixo    = TratarNulo(VlrFixo,     "N")
            THIS.this_cCipchps    = TratarNulo(cipchps,     "C")
            THIS.this_nPortachps  = TratarNulo(nPortachps,  "N")
            THIS.this_cCTipos     = TratarNulo(cTipos,      "C")
            THIS.this_cUsuProxys  = TratarNulo(cUsuProxys,  "C")
            THIS.this_cSenProxys  = TratarNulo(cSenProxys,  "C")
            THIS.this_cRazas      = TratarNulo(Razas,       "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigFiChc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIdChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigFiChc" + ;
                       " (cIdChaves, Emps, Tipos, Ctr, Rde, RdeLja," + ;
                       " Logon, Senha, VlrMin, VlrFixo, cipchps, nPortachps," + ;
                       " cTipos, cUsuProxys, cSenProxys)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       EscaparSQL(THIS.this_cCtr) + "," + ;
                       EscaparSQL(THIS.this_cRde) + "," + ;
                       EscaparSQL(THIS.this_cRdeLja) + "," + ;
                       EscaparSQL(THIS.this_cLogon) + "," + ;
                       EscaparSQL(THIS.this_cSenha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVlrMin) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVlrFixo) + "," + ;
                       EscaparSQL(THIS.this_cCipchps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPortachps) + "," + ;
                       EscaparSQL(THIS.this_cCTipos) + "," + ;
                       EscaparSQL(THIS.this_cUsuProxys) + "," + ;
                       EscaparSQL(THIS.this_cSenProxys) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigFiChc (Emps e Tipos sao chave, nao alterar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigFiChc SET" + ;
                       " Ctr = " + EscaparSQL(THIS.this_cCtr) + "," + ;
                       " Rde = " + EscaparSQL(THIS.this_cRde) + "," + ;
                       " RdeLja = " + EscaparSQL(THIS.this_cRdeLja) + "," + ;
                       " Logon = " + EscaparSQL(THIS.this_cLogon) + "," + ;
                       " Senha = " + EscaparSQL(THIS.this_cSenha) + "," + ;
                       " VlrMin = " + FormatarNumeroSQL(THIS.this_nVlrMin) + "," + ;
                       " VlrFixo = " + FormatarNumeroSQL(THIS.this_nVlrFixo) + "," + ;
                       " cipchps = " + EscaparSQL(THIS.this_cCipchps) + "," + ;
                       " nPortachps = " + FormatarNumeroSQL(THIS.this_nPortachps) + "," + ;
                       " cTipos = " + EscaparSQL(THIS.this_cCTipos) + "," + ;
                       " cUsuProxys = " + EscaparSQL(THIS.this_cUsuProxys) + "," + ;
                       " cSenProxys = " + EscaparSQL(THIS.this_cSenProxys) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE da tabela SigFiChc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiChc WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

