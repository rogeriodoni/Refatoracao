# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (18)
- [GRID-HEADER] Header Caption 'Emp' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Mês' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Título' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total Orçado' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Emp' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Mês' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Título' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total Orçado' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Emp' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Mês' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ano' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Título' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total Orçado' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Valor, %, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOrc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1732 linhas total):

*-- Linhas 46 a 65:
46:         loc_lSucesso = .F.
47: 
48:         TRY
49:             THIS.Caption = "Or" + CHR(231) + "amento"
50: 
51:             THIS.this_oBusinessObject = CREATEOBJECT("OrcBO")
52: 
53:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
54:                 MostrarErro("Erro ao criar OrcBO" + CHR(13) + ;
55:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
56:                     "FormOrc.InicializarForm")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Visible    = .T.
62:                 THIS.pgf_4c_Paginas.ActivePage = 1
63:                 THIS.this_cModoAtual = "LISTA"
64: 
65:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 88 a 107:
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97: 
98:             .Page1.Caption   = "Lista"
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page1.BackColor = RGB(255, 255, 255)
101: 
102:             .Page2.Caption   = "Dados"
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.BackColor = RGB(255, 255, 255)
105:         ENDWITH
106: 
107:         THIS.ConfigurarPaginaLista()

*-- Linhas 120 a 157:
120:         *-- Container Cabecalho (cntSombra no legado, Top=1+29=30)
121:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
122:         WITH loc_oPagina.cnt_4c_Cabecalho
123:             .Top           = 30
124:             .Left          = 0
125:             .Width         = THIS.Width
126:             .Height        = 80
127:             .BackColor     = RGB(100, 100, 100)
128:             .BorderWidth   = 0
129:             .SpecialEffect = 0
130:             .Visible     = .T.
131:         ENDWITH
132: 
133:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
134:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
135:             .Caption   = THIS.Caption
136:             .Top       = 15
137:             .Left      = 10
138:             .Width     = 769
139:             .Height    = 40
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.
143:             .ForeColor = RGB(0, 0, 0)
144:             .BackStyle = 0
145:             .AutoSize  = .F.
146:         ENDWITH
147: 
148:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
150:             .Caption   = THIS.Caption
151:             .Top       = 18
152:             .Left      = 10
153:             .Width     = 769
154:             .Height    = 46
155:             .FontName  = "Tahoma"
156:             .FontSize  = 16
157:             .FontBold  = .T.

*-- Linhas 163 a 186:
163:         *-- Container Botoes CRUD (Grupo_Op no legado, Top=0+29=29)
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
175:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
176:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
177:             .Caption         = "Incluir"
178:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
179:             .PicturePosition = 13
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .BackColor       = RGB(255, 255, 255)
185:             .ForeColor       = RGB(90, 90, 90)
186:             .FontName        = "Tahoma"

*-- Linhas 194 a 208:
194:             .AutoSize        = .F.
195:         ENDWITH
196: 
197:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
198:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
199:             .Caption         = "Visualizar"
200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
201:             .PicturePosition = 13
202:             .Top             = 5
203:             .Left            = 80
204:             .Width           = 75
205:             .Height          = 75
206:             .BackColor       = RGB(255, 255, 255)
207:             .ForeColor       = RGB(90, 90, 90)
208:             .FontName        = "Tahoma"

*-- Linhas 216 a 230:
216:             .AutoSize        = .F.
217:         ENDWITH
218: 
219:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
220:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
221:             .Caption         = "Alterar"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:             .PicturePosition = 13
224:             .Top             = 5
225:             .Left            = 155
226:             .Width           = 75
227:             .Height          = 75
228:             .BackColor       = RGB(255, 255, 255)
229:             .ForeColor       = RGB(90, 90, 90)
230:             .FontName        = "Tahoma"

*-- Linhas 238 a 252:
238:             .AutoSize        = .F.
239:         ENDWITH
240: 
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:             .Caption         = "Excluir"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 230
248:             .Width           = 75
249:             .Height          = 75
250:             .BackColor       = RGB(255, 255, 255)
251:             .ForeColor       = RGB(90, 90, 90)
252:             .FontName        = "Tahoma"

*-- Linhas 260 a 274:
260:             .AutoSize        = .F.
261:         ENDWITH
262: 
263:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
264:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
265:             .Caption         = "Buscar"
266:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
267:             .PicturePosition = 13
268:             .Top             = 5
269:             .Left            = 305
270:             .Width           = 75
271:             .Height          = 75
272:             .BackColor       = RGB(255, 255, 255)
273:             .ForeColor       = RGB(90, 90, 90)
274:             .FontName        = "Tahoma"

*-- Linhas 285 a 308:
285:         *-- Container Saida canonico (Left=917, Width=90, cmd Width=75)
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
308:             .FontName        = "Tahoma"

*-- Linhas 317 a 331:
317:         ENDWITH
318: 
319:         *-- Botao Copiar (cmdCopiar legado: Top=78+29=107, Left=614, W=115, H=55)
320:         loc_oPagina.AddObject("cmd_4c_Copiar", "CommandButton")
321:         WITH loc_oPagina.cmd_4c_Copiar
322:             .Caption         = "Copiar"
323:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
324:             .PicturePosition = 13
325:             .Top             = 107
326:             .Left            = 614
327:             .Width           = 115
328:             .Height          = 55
329:             .BackColor       = RGB(255, 255, 255)
330:             .ForeColor       = RGB(90, 90, 90)
331:             .FontName        = "Tahoma"

*-- Linhas 344 a 353:
344:         loc_oPagina.grd_4c_Lista.RecordSource = ""
345:         loc_oPagina.grd_4c_Lista.ColumnCount  = 6
346:         WITH loc_oPagina.grd_4c_Lista
347:             .Top                = 117
348:             .Left               = 26
349:             .Width              = 890
350:             .Height             = 450
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 365 a 400:
365:         ENDWITH
366: 
367:         WITH loc_oPagina.grd_4c_Lista
368:             .Column1.Header1.Caption = "Emp"
369:             .Column1.Width           = 40
370: 
371:             .Column2.Header1.Caption = "M" + CHR(234) + "s"
372:             .Column2.Width           = 35
373: 
374:             .Column3.Header1.Caption = "Ano"
375:             .Column3.Width           = 45
376: 
377:             .Column4.Header1.Caption = "T" + CHR(237) + "tulo"
378:             .Column4.Width           = 350
379: 
380:             .Column5.Header1.Caption = "Moeda"
381:             .Column5.Width           = 55
382: 
383:             .Column6.Header1.Caption = "Total Or" + CHR(231) + "ado"
384:             .Column6.Width           = 120
385:             .Column6.Alignment       = 1
386:         ENDWITH
387: 
388:         *-- BINDEVENTs dos botoes (PUBLIC methods - sem PROTECTED)
389:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
391:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
393:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
395:         BINDEVENT(loc_oPagina.cmd_4c_Copiar,                   "Click", THIS, "BtnCopiarClick")
396: 
397:         THIS.TornarControlesVisiveis(loc_oPagina)
398:     ENDPROC
399: 
400:     *===========================================================================

*-- Linhas 409 a 436:
409:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
410: 
411:         *-- Container botoes acao (Confirmar/Cancelar)
412:         *-- Original: Grupo_Salva.Top=4. Com compensacao +29: Top=33
413:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
414:         WITH loc_oPagina.cnt_4c_BotoesAcao
415:             .Top         = 33
416:             .Left        = 842
417:             .Width       = 160
418:             .Height      = 85
419:             .BackStyle = 1
420:             .BackColor = RGB(255, 255, 255)
421:             .BorderWidth = 0
422:             .Visible     = .T.
423:         ENDWITH
424: 
425:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
426:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
427:             .Caption         = "Confirmar"
428:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
429:             .PicturePosition = 13
430:             .Top             = 5
431:             .Left            = 5
432:             .Width           = 75
433:             .Height          = 75
434:             .BackColor       = RGB(255, 255, 255)
435:             .ForeColor       = RGB(90, 90, 90)
436:             .FontName        = "Tahoma"

*-- Linhas 444 a 458:
444:             .AutoSize        = .F.
445:         ENDWITH
446: 
447:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
448:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
449:             .Caption         = "Encerrar"
450:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
451:             .PicturePosition = 13
452:             .Top             = 5
453:             .Left            = 80
454:             .Width           = 75
455:             .Height          = 75
456:             .BackColor       = RGB(255, 255, 255)
457:             .ForeColor       = RGB(90, 90, 90)
458:             .FontName        = "Tahoma"

*-- Linhas 467 a 479:
467:         ENDWITH
468: 
469:         *-- Label "Emp:" (Say6 - Top=164+29=193, Left=32)
470:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
471:         WITH loc_oPagina.lbl_4c_Label6
472:             .Caption   = "Emp:"
473:             .Top       = 193
474:             .Left      = 32
475:             .Width     = 30
476:             .Height    = 17
477:             .FontName  = "Tahoma"
478:             .FontSize  = 8
479:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 485 a 507:
485:         loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
486:         WITH loc_oPagina.txt_4c_Emps
487:             .Value     = ""
488:             .Top       = 189
489:             .Left      = 65
490:             .Width     = 31
491:             .Height    = 23
492:             .FontName  = "Tahoma"
493:             .FontSize  = 8
494:             .MaxLength = 3
495:         ENDWITH
496: 
497:         *-- Label "Mes:" (Say1 - Top=165+29=194, Left=104)
498:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
499:         WITH loc_oPagina.lbl_4c_Label1
500:             .Caption   = "M" + CHR(234) + "s:"
501:             .Top       = 194
502:             .Left      = 104
503:             .Width     = 26
504:             .Height    = 17
505:             .FontName  = "Tahoma"
506:             .FontSize  = 8
507:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 513 a 535:
513:         loc_oPagina.AddObject("txt_4c_Mes", "TextBox")
514:         WITH loc_oPagina.txt_4c_Mes
515:             .Value     = ""
516:             .Top       = 189
517:             .Left      = 133
518:             .Width     = 24
519:             .Height    = 23
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .MaxLength = 2
523:         ENDWITH
524: 
525:         *-- Label "Ano:" (Say4 - Top=165+29=194, Left=165)
526:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
527:         WITH loc_oPagina.lbl_4c_Label4
528:             .Caption   = "Ano:"
529:             .Top       = 194
530:             .Left      = 165
531:             .Width     = 26
532:             .Height    = 17
533:             .FontName  = "Tahoma"
534:             .FontSize  = 8
535:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 541 a 563:
541:         loc_oPagina.AddObject("txt_4c_Ano", "TextBox")
542:         WITH loc_oPagina.txt_4c_Ano
543:             .Value     = ""
544:             .Top       = 189
545:             .Left      = 193
546:             .Width     = 38
547:             .Height    = 23
548:             .FontName  = "Tahoma"
549:             .FontSize  = 8
550:             .MaxLength = 4
551:         ENDWITH
552: 
553:         *-- Label "Titulo :" (Say5 - Top=165+29=194, Left=238)
554:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
555:         WITH loc_oPagina.lbl_4c_Label5
556:             .Caption   = "T" + CHR(237) + "tulo :"
557:             .Top       = 194
558:             .Left      = 238
559:             .Width     = 38
560:             .Height    = 17
561:             .FontName  = "Tahoma"
562:             .FontSize  = 8
563:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 569 a 591:
569:         loc_oPagina.AddObject("txt_4c_Titulo", "TextBox")
570:         WITH loc_oPagina.txt_4c_Titulo
571:             .Value     = ""
572:             .Top       = 189
573:             .Left      = 278
574:             .Width     = 280
575:             .Height    = 23
576:             .FontName  = "Tahoma"
577:             .FontSize  = 8
578:             .MaxLength = 40
579:         ENDWITH
580: 
581:         *-- Label "Moeda :" (lbl_moeda - Top=165+29=194, Left=563, Width=41)
582:         loc_oPagina.AddObject("lbl_4c_Lbl_moeda", "Label")
583:         WITH loc_oPagina.lbl_4c_Lbl_moeda
584:             .Caption   = "Moeda :"
585:             .Top       = 194
586:             .Left      = 563
587:             .Width     = 41
588:             .Height    = 17
589:             .FontName  = "Tahoma"
590:             .FontSize  = 8
591:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 597 a 632:
597:         loc_oPagina.AddObject("txt_4c_Cd_Moeda", "TextBox")
598:         WITH loc_oPagina.txt_4c_Cd_Moeda
599:             .Value     = ""
600:             .Top       = 189
601:             .Left      = 609
602:             .Width     = 31
603:             .Height    = 23
604:             .FontName  = "Tahoma"
605:             .FontSize  = 8
606:             .MaxLength = 3
607:         ENDWITH
608: 
609:         *-- TextBox Descricao Moeda (get_ds_moeda - Top=160+29=189, Left=643, Width=115, Height=23)
610:         loc_oPagina.AddObject("txt_4c__ds_moeda", "TextBox")
611:         WITH loc_oPagina.txt_4c__ds_moeda
612:             .Value     = ""
613:             .Top       = 189
614:             .Left      = 643
615:             .Width     = 115
616:             .Height    = 23
617:             .FontName  = "Tahoma"
618:             .FontSize  = 8
619:             .MaxLength = 40
620:         ENDWITH
621: 
622:         *-- Label "Total Orcado :" (Say7 - Top=192+29=221, Left=50, Height=15)
623:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
624:         WITH loc_oPagina.lbl_4c_Label7
625:             .Caption   = "Total Or" + CHR(231) + "ado :"
626:             .Top       = 221
627:             .Left      = 50
628:             .Width     = 80
629:             .Height    = 15
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 638 a 660:
638:         loc_oPagina.AddObject("txt_4c__nVlTots", "TextBox")
639:         WITH loc_oPagina.txt_4c__nVlTots
640:             .Value     = 0
641:             .Top       = 216
642:             .Left      = 132
643:             .Width     = 135
644:             .Height    = 23
645:             .FontName  = "Tahoma"
646:             .FontSize  = 8
647:             .InputMask = "999,999,999.99"
648:         ENDWITH
649: 
650:         *-- Label "Grupos" (Say2 - Top=214+29=243, Left=35, Width=54, Height=18)
651:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
652:         WITH loc_oPagina.lbl_4c_Label2
653:             .Caption   = "Grupos"
654:             .Top       = 243
655:             .Left      = 35
656:             .Width     = 54
657:             .Height    = 18
658:             .FontName  = "Tahoma"
659:             .FontSize  = 8
660:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 667 a 676:
667:         loc_oPagina.grd_4c_Grupos.RecordSource = ""
668:         loc_oPagina.grd_4c_Grupos.ColumnCount  = 4
669:         WITH loc_oPagina.grd_4c_Grupos
670:             .Top                = 262
671:             .Left               = 36
672:             .Width              = 719
673:             .Height             = 116
674:             .FontName           = "Verdana"
675:             .FontSize           = 8
676:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 684 a 711:
684:             .RowHeight          = 16
685:             .ScrollBars         = 2
686:             .GridLines          = 3
687:             .Column1.Header1.Caption = "Grupo"
688:             .Column1.Width           = 80
689:             .Column1.ReadOnly        = .T.
690:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
691:             .Column2.Width           = 300
692:             .Column2.ReadOnly        = .T.
693:             .Column3.Header1.Caption = "Valor"
694:             .Column3.Width           = 170
695:             .Column3.Alignment       = 1
696:             .Column4.Header1.Caption = "%"
697:             .Column4.Width           = 100
698:             .Column4.Alignment       = 1
699:         ENDWITH
700: 
701:         *-- Label "Contas" (Say3 - Top=362+29=391, Left=39, Width=54, Height=18)
702:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
703:         WITH loc_oPagina.lbl_4c_Label3
704:             .Caption   = "Contas"
705:             .Top       = 391
706:             .Left      = 39
707:             .Width     = 54
708:             .Height    = 18
709:             .FontName  = "Tahoma"
710:             .FontSize  = 8
711:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 718 a 727:
718:         loc_oPagina.grd_4c_Contas.RecordSource = ""
719:         loc_oPagina.grd_4c_Contas.ColumnCount  = 4
720:         WITH loc_oPagina.grd_4c_Contas
721:             .Top                = 409
722:             .Left               = 36
723:             .Width              = 719
724:             .Height             = 132
725:             .FontName           = "Verdana"
726:             .FontSize           = 8
727:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 735 a 762:
735:             .RowHeight          = 16
736:             .ScrollBars         = 2
737:             .GridLines          = 3
738:             .Column1.Header1.Caption = "Conta"
739:             .Column1.Width           = 80
740:             .Column1.ReadOnly        = .T.
741:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
742:             .Column2.Width           = 300
743:             .Column2.ReadOnly        = .T.
744:             .Column3.Header1.Caption = "Valor"
745:             .Column3.Width           = 170
746:             .Column3.Alignment       = 1
747:             .Column4.Header1.Caption = "%"
748:             .Column4.Width           = 100
749:             .Column4.Alignment       = 1
750:         ENDWITH
751: 
752:         *-- Label "Total Lancado :" (Say8 - Top=528+29=557, Left=399, Width=87)
753:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
754:         WITH loc_oPagina.lbl_4c_Label8
755:             .Caption   = "Total Lan" + CHR(231) + "ado :"
756:             .Top       = 557
757:             .Left      = 399
758:             .Width     = 87
759:             .Height    = 17
760:             .FontName  = "Tahoma"
761:             .FontSize  = 8
762:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 768 a 777:
768:         loc_oPagina.AddObject("txt_4c_TotLancado", "TextBox")
769:         WITH loc_oPagina.txt_4c_TotLancado
770:             .Value     = 0
771:             .Top       = 552
772:             .Left      = 488
773:             .Width     = 125
774:             .Height    = 23
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:             .ReadOnly  = .T.

*-- Linhas 789 a 798:
789:         BINDEVENT(loc_oPagina.grd_4c_Contas,    "AfterRowColChange", THIS, "ContasAfterRowColChange")
790: 
791:         *-- BINDEVENTs dos botoes Page2
792:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
793:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
794: 
795:         THIS.TornarControlesVisiveis(loc_oPagina)
796:     ENDPROC
797: 
798:     *===========================================================================

*-- Linhas 822 a 835:
822:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.nvltots"
823: 
824:                     *-- Reconfigurar cabecalhos apos RecordSource (obrigatorio - RecordSource reseta)
825:                     loc_oGrid.Column1.Header1.Caption = "Emp"
826:                     loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s"
827:                     loc_oGrid.Column3.Header1.Caption = "Ano"
828:                     loc_oGrid.Column4.Header1.Caption = "T" + CHR(237) + "tulo"
829:                     loc_oGrid.Column5.Header1.Caption = "Moeda"
830:                     loc_oGrid.Column6.Header1.Caption = "Total Or" + CHR(231) + "ado"
831: 
832:                     loc_oGrid.Column1.Width     = 40
833:                     loc_oGrid.Column2.Width     = 35
834:                     loc_oGrid.Column3.Width     = 45
835:                     loc_oGrid.Column4.Width     = 350

*-- Linhas 1016 a 1029:
1016:             loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ctitulo"
1017:             loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.moeda"
1018:             loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.nvltots"
1019:             loc_oGrid.Column1.Header1.Caption = "Emp"
1020:             loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s"
1021:             loc_oGrid.Column3.Header1.Caption = "Ano"
1022:             loc_oGrid.Column4.Header1.Caption = "T" + CHR(237) + "tulo"
1023:             loc_oGrid.Column5.Header1.Caption = "Moeda"
1024:             loc_oGrid.Column6.Header1.Caption = "Total Or" + CHR(231) + "ado"
1025:             loc_oGrid.Refresh()
1026:         ELSE
1027:             MsgAviso("Nenhum or" + CHR(231) + "amento encontrado.", "Busca")
1028:         ENDIF
1029:     ENDPROC

*-- Linhas 1141 a 1152:
1141:                 loc_oGrdGrupos.Column2.ControlSource = "cursor_4c_Grupos.descrs"
1142:                 loc_oGrdGrupos.Column3.ControlSource = "cursor_4c_Grupos.Valor"
1143:                 loc_oGrdGrupos.Column4.ControlSource = "cursor_4c_Grupos.Perc"
1144:                 loc_oGrdGrupos.Column1.Header1.Caption = "Grupo"
1145:                 loc_oGrdGrupos.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1146:                 loc_oGrdGrupos.Column3.Header1.Caption = "Valor"
1147:                 loc_oGrdGrupos.Column4.Header1.Caption = "%"
1148:                 loc_oGrdGrupos.Column1.Width = 80
1149:                 loc_oGrdGrupos.Column2.Width = 300
1150:                 loc_oGrdGrupos.Column3.Width = 170
1151:                 loc_oGrdGrupos.Column4.Width = 100
1152:                 GO TOP IN cursor_4c_Grupos

*-- Linhas 1163 a 1174:
1163:                 loc_oGrdContas.Column2.ControlSource = "cursor_4c_Contas.rclis"
1164:                 loc_oGrdContas.Column3.ControlSource = "cursor_4c_Contas.Valor"
1165:                 loc_oGrdContas.Column4.ControlSource = "cursor_4c_Contas.Perc"
1166:                 loc_oGrdContas.Column1.Header1.Caption = "Conta"
1167:                 loc_oGrdContas.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1168:                 loc_oGrdContas.Column3.Header1.Caption = "Valor"
1169:                 loc_oGrdContas.Column4.Header1.Caption = "%"
1170:                 loc_oGrdContas.Column1.Width = 80
1171:                 loc_oGrdContas.Column2.Width = 300
1172:                 loc_oGrdContas.Column3.Width = 170
1173:                 loc_oGrdContas.Column4.Width = 100
1174: 

*-- Linhas 1287 a 1296:
1287:             ENDIF
1288: 
1289:             *-- Botoes
1290:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdit
1291:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1292:         CATCH TO loException
1293:             MostrarErro(loException, "FormOrc.HabilitarCampos")
1294:         ENDTRY
1295:     ENDPROC
1296: 

*-- Linhas 1708 a 1729:
1708:         TRY
1709:             *-- Botoes CRUD da Page1: habilitados apenas quando na lista
1710:             WITH loc_oPg1.cnt_4c_Botoes
1711:                 .cmd_4c_Incluir.Enabled    = loc_lNaLista
1712:                 .cmd_4c_Visualizar.Enabled = loc_lNaLista
1713:                 .cmd_4c_Alterar.Enabled    = loc_lNaLista
1714:                 .cmd_4c_Excluir.Enabled    = loc_lNaLista
1715:                 .cmd_4c_Buscar.Enabled     = loc_lNaLista
1716:                 .Visible     = .T.
1717:             ENDWITH
1718:             loc_oPg1.cmd_4c_Copiar.Enabled = loc_lNaLista
1719: 
1720:             *-- Botoes da Page2: Confirmar habilitado so em INCLUIR/ALTERAR
1721:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
1722:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
1723:                     INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1724:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lNaLista
1725:             ENDIF
1726: 
1727:         CATCH TO loException
1728:             MostrarErro(loException, "FormOrc.AjustarBotoesPorModo")
1729:         ENDTRY


### BO (C:\4c\projeto\app\classes\OrcBO.prg):
*====================================================================
* OrcBO.prg
*
* Business Object para Orc (Orcamento/Previsao)
* Tabela: SigCdMrp (multi-linha: uma por grupo/conta)
*
* Chave composta do "cabecalho": cEmps + cMes + cAno + cTitulo + Moeda
* Chave de linha: cIdChaves (UUID gerado por fUniqueIds)
*
* Estrutura SigCdMrp:
*   cemps     - Empresa       (C(3))
*   cmes      - Mes           (C(2))
*   cano      - Ano           (C(4))
*   ctitulo   - Titulo        (C(40))
*   moeda     - Cod. Moeda    (C(3))
*   nvltots   - Total orcado  (N(15,2))
*   cgrupos   - Cod. Grupo    (C(10)) - linha de grupo
*   iclis     - Cod. Cliente  (C(10)) - linha de conta
*   nvalors   - Valor         (N(15,2))
*   npercs    - Percentual    (N(9,6))
*   cidchaves - ID unico linha (C(20))
*====================================================================

DEFINE CLASS OrcBO AS BusinessBase

	*-- ==========================================
	*-- Propriedades do cabecalho (identificacao)
	*-- ==========================================
	this_cEmps      = ""  && Empresa (C(3))
	this_cMes       = ""  && Mes (C(2)) - "01" a "12"
	this_cAno       = ""  && Ano (C(4)) - "2026"
	this_cTitulo    = ""  && Titulo da previsao (C(40))
	this_cMoeda     = ""  && Codigo da moeda (C(3))
	this_cDescMoeda = ""  && Descricao da moeda - de SigCdMoe.dmoes
	this_nVlTots    = 0   && Total orcado (N(15,2))

	*-- ==========================================
	*-- Propriedades de linha (detalhe)
	*-- ==========================================
	this_cIdChaves  = ""  && ID unico da linha - gerado por fUniqueIds
	this_cGrupos    = ""  && Codigo do grupo - SigCdGcr.codigos
	this_cIClis     = ""  && Codigo da conta/cliente - SigCdCli.iclis
	this_nValors    = 0   && Valor alocado (N(15,2))
	this_nPercs     = 0   && Percentual alocado (N(9,6))

	*-- ==========================================
	*-- Propriedades de controle interno
	*-- ==========================================
	this_cChaveCompostaAnterior = ""  && Chave antes de edicao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = DODEFAULT()

			THIS.this_cTabela     = "SigCdMrp"
			THIS.this_cCampoChave = "cIdChaves"

		CATCH TO loException
			MsgErro("Erro em OrcBO.Init: " + loException.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave composta para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cEmps) + "+" + ;
		       ALLTRIM(THIS.this_cMes)  + "+" + ;
		       ALLTRIM(THIS.this_cAno)  + "+" + ;
		       ALLTRIM(THIS.this_cTitulo) + "+" + ;
		       ALLTRIM(THIS.this_cMoeda)
	ENDPROC

	*====================================================================
	* Buscar - Carrega cursor_4c_Dados com lista agrupada de orcamentos
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cWhere = " WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
			IF !EMPTY(par_cFiltro)
				loc_cWhere = loc_cWhere + " AND " + par_cFiltro
			ENDIF

			loc_cSQL = "SELECT cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
			           "MAX(cidchaves) AS cidchaves " + ;
			           "FROM SIGCDMRP" + ;
			           loc_cWhere + ;
			           " GROUP BY cemps, cmes, cano, ctitulo, moeda, nvltots" + ;
			           " ORDER BY cano, cmes, ctitulo"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
				USE IN cursor_4c_DadosTmp
				GO TOP IN cursor_4c_Dados
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar or" + CHR(231) + "amentos."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cEmps     = ALLTRIM(cemps)
				THIS.this_cMes      = ALLTRIM(cmes)
				THIS.this_cAno      = ALLTRIM(cano)
				THIS.this_cTitulo   = ALLTRIM(ctitulo)
				THIS.this_cMoeda    = ALLTRIM(moeda)
				THIS.this_nVlTots   = nvltots
				THIS.this_cIdChaves = ALLTRIM(cidchaves)

				THIS.this_cChaveCompostaAnterior = THIS.ObterChavePrimaria()

				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Cursor n" + CHR(227) + "o dispon" + CHR(237) + "vel."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro por cidchaves
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cChave)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cemps, cmes, cano, ctitulo, moeda, nvltots, cidchaves " + ;
			           "FROM SIGCDMRP " + ;
			           "WHERE cidchaves = " + EscaparSQL(par_cChave)

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodTmp")
			IF loc_nResult > 0 AND !EOF("cursor_4c_CodTmp")
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CodTmp")
				THIS.this_lNovoRegistro = .F.
			ELSE
				THIS.this_cUltimoErro = "Registro n" + CHR(227) + "o encontrado."
			ENDIF

			IF USED("cursor_4c_CodTmp")
				USE IN cursor_4c_CodTmp
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarGrupos - Carrega cursor_4c_Grupos de SigCdGcr (READWRITE)
	*====================================================================
	PROCEDURE BuscarGrupos()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Grupos")
				USE IN cursor_4c_Grupos
			ENDIF

			loc_cSQL = "SELECT codigos, descrs, " + ;
			           "CAST(0.0 AS NUMERIC(15,2)) AS Valor, " + ;
			           "CAST(0.0 AS NUMERIC(9,6)) AS Perc " + ;
			           "FROM SigCdGcr " + ;
			           "ORDER BY codigos"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_GrpTmp INTO CURSOR cursor_4c_Grupos READWRITE
				USE IN cursor_4c_GrpTmp
				GO TOP IN cursor_4c_Grupos
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar grupos."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarContas - Carrega cursor_4c_Contas de SIGCDCLI (READWRITE)
	*====================================================================
	PROCEDURE BuscarContas()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Contas")
				USE IN cursor_4c_Contas
			ENDIF

			loc_cSQL = "SELECT grupos, iclis, rclis, " + ;
			           "CAST(0.0 AS NUMERIC(15,2)) AS Valor, " + ;
			           "CAST(0.0 AS NUMERIC(9,6)) AS Perc " + ;
			           "FROM SIGCDCLI " + ;
			           "ORDER BY rclis"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_CtaTmp INTO CURSOR cursor_4c_Contas READWRITE
				USE IN cursor_4c_CtaTmp
				GO TOP IN cursor_4c_Contas
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar contas."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDetalhe - Popula Valor/Perc em cursor_4c_Grupos e cursor_4c_Contas
	*                   com os valores existentes no BD para o orcamento atual
	*====================================================================
	PROCEDURE CarregarDetalhe()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_cGrupo, loc_cConta, loc_nValor, loc_nPerc
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cgrupos, iclis, nvalors, npercs " + ;
			           "FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Detalhe")
			IF loc_nResult > 0
				SELECT cursor_4c_Detalhe
				SCAN
					loc_cGrupo = ALLTRIM(cgrupos)
					loc_cConta = ALLTRIM(iclis)
					loc_nValor = nvalors
					loc_nPerc  = npercs

					IF !EMPTY(loc_cGrupo) AND USED("cursor_4c_Grupos")
						SELECT cursor_4c_Grupos
						LOCATE FOR ALLTRIM(codigos) == loc_cGrupo
						IF FOUND("cursor_4c_Grupos")
							SELECT cursor_4c_Grupos
							REPLACE Valor WITH loc_nValor, Perc WITH loc_nPerc
						ENDIF
					ENDIF

					IF !EMPTY(loc_cConta) AND USED("cursor_4c_Contas")
						SELECT cursor_4c_Contas
						LOCATE FOR ALLTRIM(iclis) == loc_cConta
						IF FOUND("cursor_4c_Contas")
							SELECT cursor_4c_Contas
							REPLACE Valor WITH loc_nValor, Perc WITH loc_nPerc
						ENDIF
					ENDIF
				ENDSCAN

				IF USED("cursor_4c_Detalhe")
					USE IN cursor_4c_Detalhe
				ENDIF

				IF USED("cursor_4c_Grupos")
					GO TOP IN cursor_4c_Grupos
				ENDIF
				IF USED("cursor_4c_Contas")
					GO TOP IN cursor_4c_Contas
				ENDIF
			ENDIF

			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Retorna .T. se chave composta ja existe no BD
	*====================================================================
	PROCEDURE VerificarDuplicidade()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtde FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")
			IF loc_nResult > 0
				SELECT cursor_4c_DupChk
				loc_lResultado = (qtde > 0)
				USE IN cursor_4c_DupChk
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterDescricaoMoeda - Retorna SigCdMoe.dmoes para o codigo informado
	*====================================================================
	PROCEDURE ObterDescricaoMoeda(par_cCodMoeda)
		LOCAL loc_cDescricao, loc_cSQL, loc_nResult
		loc_cDescricao = ""

		TRY
			IF !EMPTY(par_cCodMoeda)
				loc_cSQL = "SELECT dmoes FROM SigCdMoe " + ;
				           "WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cCodMoeda))

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")
				IF loc_nResult > 0 AND !EOF("cursor_4c_Moeda")
					SELECT cursor_4c_Moeda
					loc_cDescricao = ALLTRIM(dmoes)
				ENDIF
				IF USED("cursor_4c_Moeda")
					USE IN cursor_4c_Moeda
				ENDIF
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDPROC

	*====================================================================
	* EfetuarSalvamento - Delta save de grupos e contas em SIGCDMRP
	*   Para cada grupo/conta: faz UPDATE se ja existe, INSERT se novo
	*   Para ALTERAR: deleta previamente linhas zeradas (removidas pelo usuario)
	*====================================================================
	PROTECTED PROCEDURE EfetuarSalvamento()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_cEmps, loc_cMes, loc_cAno, loc_cTitulo, loc_cMoeda, loc_nVlTots
		LOCAL loc_cCodigo, loc_cIdChaves, loc_cOper, loc_lOk
		loc_lResultado = .F.

		TRY
			loc_lOk     = .T.
			loc_cEmps   = EscaparSQL(ALLTRIM(THIS.this_cEmps))
			loc_cMes    = EscaparSQL(ALLTRIM(THIS.this_cMes))
			loc_cAno    = EscaparSQL(ALLTRIM(THIS.this_cAno))
			loc_cTitulo = EscaparSQL(ALLTRIM(THIS.this_cTitulo))
			loc_cMoeda  = EscaparSQL(ALLTRIM(THIS.this_cMoeda))
			loc_nVlTots = FormatarNumeroSQL(THIS.this_nVlTots)
			loc_cOper   = IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE")

			*-- Para ALTERAR: remover linhas de grupos zerados (usuario removeu do orcamento)
			IF !THIS.this_lNovoRegistro AND loc_lOk AND USED("cursor_4c_Grupos")
				SELECT cursor_4c_Grupos
				SCAN FOR cursor_4c_Grupos.Valor = 0 AND cursor_4c_Grupos.Perc = 0
					SELECT cursor_4c_Grupos
					loc_cCodigo = EscaparSQL(ALLTRIM(codigos))
					loc_cSQL = "DELETE FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps   + ;
					           "  AND cmes    = " + loc_cMes    + ;
					           "  AND cano    = " + loc_cAno    + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND cgrupos = " + loc_cCodigo + ;
					           "  AND iclis   = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao remover grupo zerado."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Para ALTERAR: remover linhas de contas zeradas
			IF !THIS.this_lNovoRegistro AND loc_lOk AND USED("cursor_4c_Contas")
				SELECT cursor_4c_Contas
				SCAN FOR cursor_4c_Contas.Valor = 0 AND cursor_4c_Contas.Perc = 0
					SELECT cursor_4c_Contas
					loc_cCodigo = EscaparSQL(ALLTRIM(iclis))
					loc_cSQL = "DELETE FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps   + ;
					           "  AND cmes    = " + loc_cMes    + ;
					           "  AND cano    = " + loc_cAno    + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND iclis   = " + loc_cCodigo + ;
					           "  AND cgrupos = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao remover conta zerada."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Salvar grupos com valor ou percentual
			IF loc_lOk AND USED("cursor_4c_Grupos")
				SELECT cursor_4c_Grupos
				SCAN FOR cursor_4c_Grupos.Valor <> 0 OR cursor_4c_Grupos.Perc <> 0
					SELECT cursor_4c_Grupos
					loc_cCodigo = ALLTRIM(codigos)

					*-- Verifica se linha ja existe no BD
					loc_cSQL = "SELECT cidchaves FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps + ;
					           "  AND cmes    = " + loc_cMes  + ;
					           "  AND cano    = " + loc_cAno  + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND cgrupos = " + EscaparSQL(loc_cCodigo) + ;
					           "  AND iclis   = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

					IF loc_nResult > 0 AND !EOF("cursor_4c_ChkExiste")
						SELECT cursor_4c_ChkExiste
						loc_cIdChaves = ALLTRIM(cidchaves)
						USE IN cursor_4c_ChkExiste
						loc_cSQL = "UPDATE SIGCDMRP SET " + ;
						           "nvalors = " + FormatarNumeroSQL(cursor_4c_Grupos.Valor) + ", " + ;
						           "npercs  = " + FormatarNumeroSQL(cursor_4c_Grupos.Perc)  + ", " + ;
						           "nvltots = " + loc_nVlTots + ;
						           " WHERE cidchaves = " + EscaparSQL(loc_cIdChaves)
					ELSE
						IF USED("cursor_4c_ChkExiste")
							USE IN cursor_4c_ChkExiste
						ENDIF
						loc_cIdChaves = fUniqueIds()
						loc_cSQL = "INSERT INTO SIGCDMRP " + ;
						           "(cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
						           "cgrupos, iclis, nvalors, npercs, cidchaves) " + ;
						           "VALUES (" + ;
						           loc_cEmps   + ", " + ;
						           loc_cMes    + ", " + ;
						           loc_cAno    + ", " + ;
						           loc_cTitulo + ", " + ;
						           loc_cMoeda  + ", " + ;
						           loc_nVlTots + ", " + ;
						           EscaparSQL(loc_cCodigo) + ", " + ;
						           EscaparSQL("") + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Grupos.Valor) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Grupos.Perc)  + ", " + ;
						           EscaparSQL(loc_cIdChaves) + ")"
					ENDIF

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao salvar grupo " + loc_cCodigo + "."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Salvar contas com valor ou percentual
			IF loc_lOk AND USED("cursor_4c_Contas")
				SELECT cursor_4c_Contas
				SCAN FOR cursor_4c_Contas.Valor <> 0 OR cursor_4c_Contas.Perc <> 0
					SELECT cursor_4c_Contas
					loc_cCodigo = ALLTRIM(iclis)

					*-- Verifica se linha ja existe no BD
					loc_cSQL = "SELECT cidchaves FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps + ;
					           "  AND cmes    = " + loc_cMes  + ;
					           "  AND cano    = " + loc_cAno  + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND iclis   = " + EscaparSQL(loc_cCodigo) + ;
					           "  AND cgrupos = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

					IF loc_nResult > 0 AND !EOF("cursor_4c_ChkExiste")
						SELECT cursor_4c_ChkExiste
						loc_cIdChaves = ALLTRIM(cidchaves)
						USE IN cursor_4c_ChkExiste
						loc_cSQL = "UPDATE SIGCDMRP SET " + ;
						           "nvalors = " + FormatarNumeroSQL(cursor_4c_Contas.Valor) + ", " + ;
						           "npercs  = " + FormatarNumeroSQL(cursor_4c_Contas.Perc)  + ", " + ;
						           "nvltots = " + loc_nVlTots + ;
						           " WHERE cidchaves = " + EscaparSQL(loc_cIdChaves)
					ELSE
						IF USED("cursor_4c_ChkExiste")
							USE IN cursor_4c_ChkExiste
						ENDIF
						loc_cIdChaves = fUniqueIds()
						loc_cSQL = "INSERT INTO SIGCDMRP " + ;
						           "(cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
						           "cgrupos, iclis, nvalors, npercs, cidchaves) " + ;
						           "VALUES (" + ;
						           loc_cEmps   + ", " + ;
						           loc_cMes    + ", " + ;
						           loc_cAno    + ", " + ;
						           loc_cTitulo + ", " + ;
						           loc_cMoeda  + ", " + ;
						           loc_nVlTots + ", " + ;
						           EscaparSQL("") + ", " + ;
						           EscaparSQL(loc_cCodigo) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Contas.Valor) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Contas.Perc)  + ", " + ;
						           EscaparSQL(loc_cIdChaves) + ")"
					ENDIF

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao salvar conta " + loc_cCodigo + "."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			IF loc_lOk
				THIS.RegistrarAuditoria(loc_cOper)
				loc_lResultado = .T.
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Override: delega para EfetuarSalvamento
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = THIS.EfetuarSalvamento()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Override: delega para EfetuarSalvamento
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = THIS.EfetuarSalvamento()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui todas as linhas do orcamento no BD
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao excluir or" + CHR(231) + "amento."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE

