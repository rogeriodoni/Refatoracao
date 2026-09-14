# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 183: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 204: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 226: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 248: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 270: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 304: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 397: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 418: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCst.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1127 linhas total):

*-- Linhas 48 a 57:
48:                     "FormCst.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible = .T.
54:                 THIS.pgf_4c_Paginas.ActivePage = 1
55:                 THIS.this_cModoAtual = "LISTA"
56: 
57:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 80 a 99:
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
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
98: 
99:         THIS.ConfigurarPaginaLista()

*-- Linhas 112 a 153:
112: 
113:         TRY
114:             *-- Container Cabecalho (cntSombra do legado)
115:             *-- Top=31: compensa PageFrame.Top=-29
116:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:             WITH loc_oPagina.cnt_4c_Cabecalho
118:                 .Top         = 31
119:                 .Left        = -1
120:                 .Width       = THIS.Width + 8
121:                 .Height      = 80
122:                 .BackColor   = RGB(100, 100, 100)
123:                 .BorderWidth = 0
124:                 .Visible     = .T.
125: 
126:                 .AddObject("lbl_4c_Sombra", "Label")
127:                 WITH .lbl_4c_Sombra
128:                     .Top       = 15
129:                     .Left      = 10
130:                     .Width     = THIS.Width
131:                     .Height    = 40
132:                     .Caption   = THIS.Caption
133:                     .FontName  = "Tahoma"
134:                     .FontSize  = 16
135:                     .FontBold  = .T.
136:                     .ForeColor = RGB(0, 0, 0)
137:                     .BackStyle = 0
138:                     .AutoSize  = .F.
139:                     .Visible   = .T.
140:                 ENDWITH
141: 
142:                 .AddObject("lbl_4c_Titulo", "Label")
143:                 WITH .lbl_4c_Titulo
144:                     .Top       = 18
145:                     .Left      = 10
146:                     .Width     = THIS.Width
147:                     .Height    = 46
148:                     .Caption   = THIS.Caption
149:                     .FontName  = "Tahoma"
150:                     .FontSize  = 16
151:                     .FontBold  = .T.
152:                     .ForeColor = RGB(255, 255, 255)
153:                     .BackStyle = 0

*-- Linhas 160 a 276:
160:             *-- Left=543 (do original), Top=29 (0+29 compensacao)
161:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
162:             WITH loc_oPagina.cnt_4c_Botoes
163:                 .Top       = 29
164:                 .Left      =  542
165:                 .Width     = 385
166:                 .Height    = 85
167:                 .BackStyle = 1
168:                 .BackColor = RGB(53, 53, 53)
169:                 .BorderWidth = 0
170:                 .Visible   = .T.
171: 
172:                 .AddObject("cmd_4c_Incluir", "CommandButton")
173:                 WITH .cmd_4c_Incluir
174:                     .Caption         = "Incluir"
175:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
176:                     .PicturePosition = 13
177:                     .Top             = 5
178:                     .Left            =  542
179:                     .Width           = 75
180:                     .Height          = 75
181:                     .BackColor       = RGB(255, 255, 255)
182:                     .ForeColor       = RGB(90, 90, 90)
183:                     .FontName        = "Comic Sans MS"
184:                     .FontBold        = .T.
185:                     .FontItalic      = .T.
186:                     .FontSize        = 8
187:                     .SpecialEffect   = 0
188:                     .MousePointer    = 15
189:                     .WordWrap        = .T.
190:                     .AutoSize        = .F.
191:                 ENDWITH
192: 
193:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
194:                 WITH .cmd_4c_Visualizar
195:                     .Caption         = "Visualizar"
196:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
197:                     .PicturePosition = 13
198:                     .Top             = 5
199:                     .Left            =  542
200:                     .Width           = 75
201:                     .Height          = 75
202:                     .BackColor       = RGB(255, 255, 255)
203:                     .ForeColor       = RGB(90, 90, 90)
204:                     .FontName        = "Comic Sans MS"
205:                     .FontBold        = .T.
206:                     .FontItalic      = .T.
207:                     .FontSize        = 8
208:                     .Themes          = .F.
209:                     .SpecialEffect   = 0
210:                     .MousePointer    = 15
211:                     .WordWrap        = .T.
212:                     .AutoSize        = .F.
213:                 ENDWITH
214: 
215:                 .AddObject("cmd_4c_Alterar", "CommandButton")
216:                 WITH .cmd_4c_Alterar
217:                     .Caption         = "Alterar"
218:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
219:                     .PicturePosition = 13
220:                     .Top             = 5
221:                     .Left            =  542
222:                     .Width           = 75
223:                     .Height          = 75
224:                     .BackColor       = RGB(255, 255, 255)
225:                     .ForeColor       = RGB(90, 90, 90)
226:                     .FontName        = "Comic Sans MS"
227:                     .FontBold        = .T.
228:                     .FontItalic      = .T.
229:                     .FontSize        = 8
230:                     .Themes          = .F.
231:                     .SpecialEffect   = 0
232:                     .MousePointer    = 15
233:                     .WordWrap        = .T.
234:                     .AutoSize        = .F.
235:                 ENDWITH
236: 
237:                 .AddObject("cmd_4c_Excluir", "CommandButton")
238:                 WITH .cmd_4c_Excluir
239:                     .Caption         = "Excluir"
240:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
241:                     .PicturePosition = 13
242:                     .Top             = 5
243:                     .Left            =  542
244:                     .Width           = 75
245:                     .Height          = 75
246:                     .BackColor       = RGB(255, 255, 255)
247:                     .ForeColor       = RGB(90, 90, 90)
248:                     .FontName        = "Comic Sans MS"
249:                     .FontBold        = .T.
250:                     .FontItalic      = .T.
251:                     .FontSize        = 8
252:                     .Themes          = .F.
253:                     .SpecialEffect   = 0
254:                     .MousePointer    = 15
255:                     .WordWrap        = .T.
256:                     .AutoSize        = .F.
257:                 ENDWITH
258: 
259:                 .AddObject("cmd_4c_Buscar", "CommandButton")
260:                 WITH .cmd_4c_Buscar
261:                     .Caption         = "Buscar"
262:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
263:                     .PicturePosition = 13
264:                     .Top             = 5
265:                     .Left            =  542
266:                     .Width           = 75
267:                     .Height          = 75
268:                     .BackColor       = RGB(255, 255, 255)
269:                     .ForeColor       = RGB(90, 90, 90)
270:                     .FontName        = "Comic Sans MS"
271:                     .FontBold        = .T.
272:                     .FontItalic      = .T.
273:                     .FontSize        = 8
274:                     .Themes          = .F.
275:                     .SpecialEffect   = 0
276:                     .MousePointer    = 15

*-- Linhas 282 a 310:
282:             *-- Container Saida (padrao canonico: Left=917, Width=90)
283:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
284:             WITH loc_oPagina.cnt_4c_Saida
285:                 .Top         = 29
286:                 .Left        = 917
287:                 .Width       = 90
288:                 .Height      = 85
289:                 .BackStyle   = 0
290:                 .BorderWidth = 0
291:                 .Visible     = .T.
292: 
293:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
294:                 WITH .cmd_4c_Encerrar
295:                     .Caption         = "Encerrar"
296:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
297:                     .PicturePosition = 13
298:                     .Top             = 5
299:                     .Left            = 917
300:                     .Width           = 90
301:                     .Height          = 75
302:                     .BackColor       = RGB(255, 255, 255)
303:                     .ForeColor       = RGB(90, 90, 90)
304:                     .FontName        = "Comic Sans MS"
305:                     .FontBold        = .T.
306:                     .FontItalic      = .T.
307:                     .FontSize        = 8
308:                     .SpecialEffect   = 0
309:                     .MousePointer    = 15
310:                     .WordWrap        = .T.

*-- Linhas 319 a 328:
319:             loc_oPagina.grd_4c_Lista.ColumnCount = 4
320: 
321:             WITH loc_oPagina.grd_4c_Lista
322:                 .Top                = 150
323:                 .Left               = 12
324:                 .Width              = 890
325:                 .Height             = 460
326:                 .FontName           = "Verdana"
327:                 .FontSize           = 8
328:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 340 a 353:
340:             ENDWITH
341: 
342:             *-- BINDEVENT para botoes CRUD (metodos PUBLIC obrigatorios)
343:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
344:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
345:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
346:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
347:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
348:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
349: 
350:             THIS.TornarControlesVisiveis(loc_oPagina)
351: 
352:         CATCH TO loc_oErro
353:             MostrarErro("Erro ao configurar Page1:" + CHR(13) + ;

*-- Linhas 361 a 369:
361:     * ConfigurarPaginaDados - Configura Page2: Botoes de Acao + campos Parte 1
362:     * FASE 5/8: cnt_4c_BotoesAcao (Salvar+Cancelar), Label1+txt_4c_Codigo,
363:     *           Label2+txt_4c_Descricao, Label3+txt_4c_Constante
364:     * Top += 29 em todos os controles (compensacao PageFrame.Top=-29)
365:     *===========================================================================
366:     PROTECTED PROCEDURE ConfigurarPaginaDados()
367:         LOCAL loc_oPagina, loc_oErro
368:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
369: 

*-- Linhas 375 a 444:
375:             *-- Original: Left=820, Top=8 -> Migrado: Top=37 (8+29)
376:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
377:             WITH loc_oPagina.cnt_4c_BotoesAcao
378:                 .Top         = 37
379:                 .Left        = 820
380:                 .Width       = 160
381:                 .Height      = 85
382:                 .BackStyle   = 0
383:                 .BorderWidth = 0
384:                 .Visible     = .T.
385: 
386:                 .AddObject("cmd_4c_Salvar", "CommandButton")
387:                 WITH .cmd_4c_Salvar
388:                     .Caption         = "Salvar"
389:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
390:                     .PicturePosition = 13
391:                     .Top             = 5
392:                     .Left            = 5
393:                     .Width           = 75
394:                     .Height          = 75
395:                     .BackColor       = RGB(255, 255, 255)
396:                     .ForeColor       = RGB(90, 90, 90)
397:                     .FontName        = "Comic Sans MS"
398:                     .FontBold        = .T.
399:                     .FontItalic      = .T.
400:                     .FontSize        = 8
401:                     .SpecialEffect   = 0
402:                     .MousePointer    = 15
403:                     .WordWrap        = .T.
404:                     .AutoSize        = .F.
405:                 ENDWITH
406: 
407:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
408:                 WITH .cmd_4c_Cancelar
409:                     .Caption         = "Encerrar"
410:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
411:                     .PicturePosition = 13
412:                     .Top             = 5
413:                     .Left            = 80
414:                     .Width           = 75
415:                     .Height          = 75
416:                     .BackColor       = RGB(255, 255, 255)
417:                     .ForeColor       = RGB(90, 90, 90)
418:                     .FontName        = "Comic Sans MS"
419:                     .FontBold        = .T.
420:                     .FontItalic      = .T.
421:                     .FontSize        = 8
422:                     .Themes          = .F.
423:                     .SpecialEffect   = 0
424:                     .MousePointer    = 15
425:                     .WordWrap        = .T.
426:                     .AutoSize        = .F.
427:                 ENDWITH
428:             ENDWITH
429: 
430:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
431:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
432: 
433:             *-- Label1 + txt_4c_Codigo (Get_Codigo do legado)
434:             *-- Original: Label1.Top=126, Get_Codigo.Top=122 -> Migrado: +29
435:             loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
436:             WITH loc_oPagina.lbl_4c_Codigo
437:                 .Caption   = "C" + CHR(243) + "digo : "
438:                 .Top       = 155
439:                 .Left      = 281
440:                 .Width     = 45
441:                 .Height    = 15
442:                 .FontName  = "Tahoma"
443:                 .FontSize  = 8
444:                 .FontBold  = .F.

*-- Linhas 451 a 478:
451:             loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
452:             WITH loc_oPagina.txt_4c_Codigo
453:                 .Value         = ""
454:                 .Top           = 151
455:                 .Left          = 330
456:                 .Width         = 34
457:                 .Height        = 23
458:                 .InputMask     = "!!!"
459:                 .MaxLength     = 3
460:                 .SpecialEffect = 1
461:                 .FontName      = "Tahoma"
462:                 .FontSize      = 8
463:                 .TabIndex      = 2
464:                 .Visible       = .T.
465:             ENDWITH
466: 
467:             *-- Label2 + txt_4c_Descricao (Get_Descricao do legado)
468:             *-- Original: Label2.Top=152, Get_Descricao.Top=148 -> Migrado: +29
469:             loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
470:             WITH loc_oPagina.lbl_4c_Descricao
471:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
472:                 .Top       = 181
473:                 .Left      = 268
474:                 .Width     = 58
475:                 .Height    = 15
476:                 .FontName  = "Tahoma"
477:                 .FontSize  = 8
478:                 .FontBold  = .F.

*-- Linhas 485 a 511:
485:             loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
486:             WITH loc_oPagina.txt_4c_Descricao
487:                 .Value         = ""
488:                 .Top           = 177
489:                 .Left          = 330
490:                 .Width         = 290
491:                 .Height        = 23
492:                 .MaxLength     = 40
493:                 .SpecialEffect = 1
494:                 .FontName      = "Tahoma"
495:                 .FontSize      = 8
496:                 .TabIndex      = 4
497:                 .Visible       = .T.
498:             ENDWITH
499: 
500:             *-- Label3 + txt_4c_Constante (Get_Constante do legado)
501:             *-- Original: Label3.Top=178, Get_Constante.Top=174 -> Migrado: +29
502:             loc_oPagina.AddObject("lbl_4c_Constante", "Label")
503:             WITH loc_oPagina.lbl_4c_Constante
504:                 .Caption   = "Valor da Constante : "
505:                 .Top       = 207
506:                 .Left      = 222
507:                 .Width     = 104
508:                 .Height    = 15
509:                 .FontName  = "Tahoma"
510:                 .FontSize  = 8
511:                 .FontBold  = .F.

*-- Linhas 518 a 545:
518:             loc_oPagina.AddObject("txt_4c_Constante", "TextBox")
519:             WITH loc_oPagina.txt_4c_Constante
520:                 .Value         = 0
521:                 .Top           = 203
522:                 .Left          = 330
523:                 .Width         = 150
524:                 .Height        = 23
525:                 .InputMask     = "9,999,999.999999"
526:                 .Alignment     = 3
527:                 .SpecialEffect = 1
528:                 .FontName      = "Tahoma"
529:                 .FontSize      = 8
530:                 .TabIndex      = 6
531:                 .Visible       = .T.
532:             ENDWITH
533: 
534:             *-- Label4 + txt_4c_CodMoeda (get_cd_moeda) + txt_4c_DescMoeda (get_ds_moeda)
535:             *-- Original: Label4.Top=204, get_cd_moeda.Top=200, get_ds_moeda.Top=200 -> Migrado: +29
536:             loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
537:             WITH loc_oPagina.lbl_4c_Moeda
538:                 .Caption   = "Moeda : "
539:                 .Top       = 233
540:                 .Left      = 282
541:                 .Width     = 44
542:                 .Height    = 15
543:                 .FontName  = "Tahoma"
544:                 .FontSize  = 8
545:                 .FontBold  = .F.

*-- Linhas 552 a 561:
552:             loc_oPagina.AddObject("txt_4c_CodMoeda", "TextBox")
553:             WITH loc_oPagina.txt_4c_CodMoeda
554:                 .Value         = ""
555:                 .Top           = 229
556:                 .Left          = 330
557:                 .Width         = 32
558:                 .Height        = 23
559:                 .InputMask     = "!!!"
560:                 .MaxLength     = 3
561:                 .SpecialEffect = 1

*-- Linhas 568 a 577:
568:             loc_oPagina.AddObject("txt_4c_DescMoeda", "TextBox")
569:             WITH loc_oPagina.txt_4c_DescMoeda
570:                 .Value         = ""
571:                 .Top           = 229
572:                 .Left          = 365
573:                 .Width         = 115
574:                 .Height        = 23
575:                 .SpecialEffect = 1
576:                 .FontName      = "Tahoma"
577:                 .FontSize      = 8

*-- Linhas 614 a 637:
614:                     WITH loc_oGrid
615:                         .Column1.ControlSource   = "crSigCdCnt.codigos"
616:                         .Column1.Width           = 60
617:                         .Column1.Header1.Caption = "C" + CHR(243) + "digo"
618:                         .Column1.Alignment       = 0
619: 
620:                         .Column2.ControlSource   = "crSigCdCnt.descricaos"
621:                         .Column2.Width           = 267
622:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
623:                         .Column2.Alignment       = 0
624: 
625:                         .Column3.ControlSource   = "crSigCdCnt.consts"
626:                         .Column3.Width           = 177
627:                         .Column3.Header1.Caption = "Valor"
628:                         .Column3.Alignment       = 1
629: 
630:                         .Column4.ControlSource   = "crSigCdCnt.moedas"
631:                         .Column4.Width           = 42
632:                         .Column4.Header1.Caption = "Moeda"
633:                         .Column4.Alignment       = 0
634:                     ENDWITH
635: 
636:                     THIS.FormatarGridLista(loc_oGrid)
637:                     loc_oGrid.Refresh()

*-- Linhas 805 a 817:
805: 
806:         DO CASE
807:         CASE THIS.this_cModoAtual = "VISUALIZAR"
808:             loc_oCnt.cmd_4c_Salvar.Enabled   = .F.
809:             loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
810:         OTHERWISE
811:             loc_oCnt.cmd_4c_Salvar.Enabled   = .T.
812:             loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
813:         ENDCASE
814:     ENDPROC
815: 
816:     *===========================================================================
817:     * BtnIncluirClick - Prepara formulario para inclusao de nova constante

*-- Linhas 846 a 854:
846:             THIS.HabilitarCampos(.F.)
847:             THIS.AjustarBotoesPorModo()
848:             THIS.AlternarPagina(2)
849:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
850:         ENDIF
851:     ENDPROC
852: 
853:     *===========================================================================
854:     * BtnAlterarClick - Abre registro selecionado para edicao

*-- Linhas 929 a 946:
929:             WITH loc_oGrid
930:                 .Column1.ControlSource   = "crSigCdCnt.codigos"
931:                 .Column1.Width           = 60
932:                 .Column1.Header1.Caption = "C" + CHR(243) + "digo"
933:                 .Column2.ControlSource   = "crSigCdCnt.descricaos"
934:                 .Column2.Width           = 267
935:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
936:                 .Column3.ControlSource   = "crSigCdCnt.consts"
937:                 .Column3.Width           = 177
938:                 .Column3.Header1.Caption = "Valor"
939:                 .Column4.ControlSource   = "crSigCdCnt.moedas"
940:                 .Column4.Width           = 42
941:                 .Column4.Header1.Caption = "Moeda"
942:             ENDWITH
943:             THIS.FormatarGridLista(loc_oGrid)
944:             loc_oGrid.Refresh()
945:         ENDIF
946:     ENDPROC


### BO (C:\4c\projeto\app\classes\CstBO.prg):
*==============================================================================
* CstBO.prg - Business Object para Constantes
* Tabela: SigCdCnt
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS CstBO AS BusinessBase

    *-- Propriedades da tabela SigCdCnt
    this_cCodigo    = ""    && Codigos     C(3)  - PK
    this_cDescricao = ""    && Descricaos  C(40)
    this_nConstante = 0     && Consts      N(13,6) - Valor da Constante
    this_cMoeda     = ""    && Moedas      C(3)  - FK SigCdMoe.Cmoes

    *-- Propriedade auxiliar de exibicao (nao persistida em SigCdCnt)
    this_cDescMoeda = ""    && SigCdMoe.Dmoes C(15) - Descricao da Moeda

    *--------------------------------------------------------------------------
    * Init - Inicializa BO configurando tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCnt"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "CstBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                THIS.this_cDescricao = TratarNulo(descricaos, "C")
                THIS.this_nConstante = TratarNulo(consts,     "N")
                THIS.this_cMoeda     = TratarNulo(moedas,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CstBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo da Constante j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cMoeda)
            MsgAviso("Moeda n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se codigos ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nTotal FROM SigCdCnt" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (NVL(cursor_4c_ChkCod.nTotal, 0) > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CstBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCnt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCnt (codigos, descricaos, consts, moedas)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<FormatarNumeroSQL(THIS.this_nConstante, 6)>>,
                    <<EscaparSQL(THIS.this_cMoeda)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CstBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCnt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCnt
                SET descricaos = <<EscaparSQL(THIS.this_cDescricao)>>,
                    consts     = <<FormatarNumeroSQL(THIS.this_nConstante, 6)>>,
                    moedas     = <<EscaparSQL(THIS.this_cMoeda)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CstBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCnt
    * Valida uso em SigOpTdt (6 campos de constante) antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar se constante esta sendo usada em operacoes (SigOpTdt)
            loc_cSQL = "SELECT COUNT(*) AS nTotal FROM SigOpTdt" + ;
                " WHERE (const1t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const1t2s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const2t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const2t2s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const3t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const3t2s = " + EscaparSQL(THIS.this_cCodigo) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCnt")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkCnt")
                    SELECT cursor_4c_ChkCnt
                    loc_nUso = NVL(cursor_4c_ChkCnt.nTotal, 0)
                    USE IN cursor_4c_ChkCnt
                ENDIF

                IF loc_nUso > 0
                    MsgAviso("Constante sendo utilizada em Opera" + CHR(231) + CHR(245) + "es!")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCnt WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CstBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor crSigCdCnt com codigos, descricaos, consts, moedas
    * (cursor nomeado igual ao legado para compatibilidade com grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("crSigCdCnt")
                    SET NULL ON
                    CREATE CURSOR crSigCdCnt (codigos C(3), descricaos C(40), consts N(13,6), moedas C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descricaos, a.consts, a.moedas" + ;
                    " FROM SigCdCnt a"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

                IF USED("crSigCdCnt")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT crSigCdCnt
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar constantes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCnt")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar constantes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CstBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    * Tambem carrega descricao da moeda via JOIN com SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descricaos, a.consts, a.moedas," + ;
                " b.dmoes AS descmoes" + ;
                " FROM SigCdCnt a" + ;
                " LEFT JOIN SigCdMoe b ON b.cmoes = a.moedas" + ;
                " WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    SELECT cursor_4c_Carrega
                    THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                    THIS.this_cDescricao = TratarNulo(descricaos, "C")
                    THIS.this_nConstante = TratarNulo(consts,     "N")
                    THIS.this_cMoeda     = TratarNulo(moedas,     "C")
                    THIS.this_cDescMoeda = TratarNulo(descmoes,   "C")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Constante n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CstBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescMoeda - Carrega descricao da moeda pelo codigo
    * Usado apos lookup de moeda para atualizar campo de exibicao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescMoeda(par_cCodigoMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cCodigoMoeda)
                THIS.this_cDescMoeda = ""
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.dmoes FROM SigCdMoe a" + ;
                    " WHERE a.cmoes = " + EscaparSQL(par_cCodigoMoeda)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe")

                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_Moe") > 0
                        SELECT cursor_4c_Moe
                        THIS.this_cDescMoeda = TratarNulo(dmoes, "C")
                    ELSE
                        THIS.this_cDescMoeda = ""
                    ENDIF

                    IF USED("cursor_4c_Moe")
                        USE IN cursor_4c_Moe
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao carregar moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da moeda:" + CHR(13) + loException.Message, "CstBO.CarregarDescMoeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

