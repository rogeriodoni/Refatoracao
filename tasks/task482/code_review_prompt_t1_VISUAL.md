# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 183: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 207: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 231: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 255: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 279: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 314: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 423: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 447: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOpd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1292 linhas total):

*-- Linhas 41 a 60:
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             THIS.Caption = "Cadastro de Opera" + CHR(231) + CHR(245) + "es de Pedido"
45: 
46:             THIS.this_oBusinessObject = CREATEOBJECT("OpdBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar OpdBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "FormOpd.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Visible  = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual = "LISTA"
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

*-- Linhas 117 a 154:
117:         *-- Container Cabecalho (cntSombra no legado: Top=1; +29 -> Top=30)
118:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH loc_oPagina.cnt_4c_Cabecalho
120:             .Top         = 30
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127:         ENDWITH
128: 
129:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
130:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
131:             .Caption   = THIS.Caption
132:             .Top       = 15
133:             .Left      = 10
134:             .Width     = 769
135:             .Height    = 40
136:             .FontName  = "Tahoma"
137:             .FontSize  = 16
138:             .FontBold  = .T.
139:             .ForeColor = RGB(0, 0, 0)
140:             .BackStyle = 0
141:             .AutoSize  = .F.
142:             .Visible   = .T.
143:         ENDWITH
144: 
145:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
146:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
147:             .Caption   = THIS.Caption
148:             .Top       = 18
149:             .Left      = 10
150:             .Width     = 769
151:             .Height    = 46
152:             .FontName  = "Tahoma"
153:             .FontSize  = 16
154:             .FontBold  = .T.

*-- Linhas 161 a 189:
161:         *-- Container Botoes CRUD canonico: Left=542, Top=28 (-1+29), Width=390, Height=85
162:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
163:         WITH loc_oPagina.cnt_4c_Botoes
164:             .Top         = 28
165:             .Left        = 542
166:             .Width       = 390
167:             .Height      = 85
168:             .BackStyle   = 0
169:             .BorderWidth = 0
170:             .Visible     = .T.
171:         ENDWITH
172: 
173:         *-- Botao Incluir (Left=5)
174:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
175:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
176:             .Caption         = "Incluir"
177:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
178:             .PicturePosition = 13
179:             .Top             = 5
180:             .Left            = 5
181:             .Width           = 75
182:             .Height          = 75
183:             .FontName        = "Comic Sans MS"
184:             .FontSize        = 8
185:             .FontBold        = .T.
186:             .FontItalic      = .T.
187:             .ForeColor       = RGB(90, 90, 90)
188:             .BackColor       = RGB(255, 255, 255)
189:             .Themes          = .F.

*-- Linhas 195 a 213:
195:         ENDWITH
196: 
197:         *-- Botao Visualizar (Left=80)
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .FontName        = "Comic Sans MS"
208:             .FontSize        = 8
209:             .FontBold        = .T.
210:             .FontItalic      = .T.
211:             .ForeColor       = RGB(90, 90, 90)
212:             .BackColor       = RGB(255, 255, 255)
213:             .Themes          = .F.

*-- Linhas 219 a 237:
219:         ENDWITH
220: 
221:         *-- Botao Alterar (Left=155)
222:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .FontName        = "Comic Sans MS"
232:             .FontSize        = 8
233:             .FontBold        = .T.
234:             .FontItalic      = .T.
235:             .ForeColor       = RGB(90, 90, 90)
236:             .BackColor       = RGB(255, 255, 255)
237:             .Themes          = .F.

*-- Linhas 243 a 261:
243:         ENDWITH
244: 
245:         *-- Botao Excluir (Left=230)
246:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
247:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
248:             .Caption         = "Excluir"
249:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
250:             .PicturePosition = 13
251:             .Top             = 5
252:             .Left            = 230
253:             .Width           = 75
254:             .Height          = 75
255:             .FontName        = "Comic Sans MS"
256:             .FontSize        = 8
257:             .FontBold        = .T.
258:             .FontItalic      = .T.
259:             .ForeColor       = RGB(90, 90, 90)
260:             .BackColor       = RGB(255, 255, 255)
261:             .Themes          = .F.

*-- Linhas 267 a 285:
267:         ENDWITH
268: 
269:         *-- Botao Buscar (Left=305)
270:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
271:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
272:             .Caption         = "Buscar"
273:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
274:             .PicturePosition = 13
275:             .Top             = 5
276:             .Left            = 305
277:             .Width           = 75
278:             .Height          = 75
279:             .FontName        = "Comic Sans MS"
280:             .FontSize        = 8
281:             .FontBold        = .T.
282:             .FontItalic      = .T.
283:             .ForeColor       = RGB(90, 90, 90)
284:             .BackColor       = RGB(255, 255, 255)
285:             .Themes          = .F.

*-- Linhas 293 a 320:
293:         *-- Container Saida canonico: Left=917, Top=29, Width=90, Height=85
294:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
295:         WITH loc_oPagina.cnt_4c_Saida
296:             .Top         = 29
297:             .Left        = 917
298:             .Width       = 90
299:             .Height      = 85
300:             .BackStyle   = 0
301:             .BorderWidth = 0
302:             .Visible     = .T.
303:         ENDWITH
304: 
305:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
306:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
307:             .Caption         = "Encerrar"
308:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
309:             .PicturePosition = 13
310:             .Top             = 5
311:             .Left            = 5
312:             .Width           = 75
313:             .Height          = 75
314:             .FontName        = "Comic Sans MS"
315:             .FontSize        = 8
316:             .FontBold        = .T.
317:             .FontItalic      = .T.
318:             .ForeColor       = RGB(90, 90, 90)
319:             .BackColor       = RGB(255, 255, 255)
320:             .Themes          = .F.

*-- Linhas 328 a 337:
328:         *-- Grid da Lista (legado: Top=121, Left=12, Width=940; +29 -> Top=150)
329:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
330:         WITH loc_oPagina.grd_4c_Lista
331:             .Top                = 150
332:             .Left               = 12
333:             .Width              = 940
334:             .Height             = 470
335:             .FontName           = "Verdana"
336:             .FontSize           = 8
337:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 375 a 429:
375:         ENDWITH
376: 
377:         *-- BINDEVENTs para botoes (handlers devem ser PUBLIC)
378:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
379:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
380:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
381:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
382:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
383:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
384: 
385:         THIS.TornarControlesVisiveis(loc_oPagina)
386:     ENDPROC
387: 
388:     *===========================================================================
389:     * ConfigurarPaginaDados - Configura Page2 com todos os campos e botoes
390:     * Campos: lbl_4c_OperacaoLabel, txt_4c_Nopes, txt_4c_Dopes,
391:     *         opt_4c_Pagos (3 buttons), opt_4c_Utils (3 buttons)
392:     * Botoes: cnt_4c_BotoesAcao -> cmd_4c_Confirmar, cmd_4c_Cancelar
393:     * Compensacao PageFrame +29 aplicada a todos os Tops
394:     *===========================================================================
395:     PROTECTED PROCEDURE ConfigurarPaginaDados()
396:         LOCAL loc_oPagina
397:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
398: 
399:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
400: 
401:         *-- Container BotoesAcao (grupo_salva: Left=618, Top=11+29=40, Width=160, Height=85)
402:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
403:         WITH loc_oPagina.cnt_4c_BotoesAcao
404:             .Top         = 40
405:             .Left        = 618
406:             .Width       = 160
407:             .Height      = 85
408:             .BackStyle   = 0
409:             .BorderWidth = 0
410:             .Visible     = .T.
411:         ENDWITH
412: 
413:         *-- Botao Confirmar (salva: Left=5, Top=5, Width=75, Height=75)
414:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
415:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
416:             .Caption         = "Confirmar"
417:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
418:             .PicturePosition = 13
419:             .Top             = 5
420:             .Left            = 5
421:             .Width           = 75
422:             .Height          = 75
423:             .FontName        = "Comic Sans MS"
424:             .FontSize        = 8
425:             .FontBold        = .T.
426:             .FontItalic      = .T.
427:             .ForeColor       = RGB(90, 90, 90)
428:             .BackColor       = RGB(255, 255, 255)
429:             .Themes          = .F.

*-- Linhas 435 a 474:
435:         ENDWITH
436: 
437:         *-- Botao Cancelar (cancelar: Left=80, Top=5, Width=75, Height=75)
438:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
439:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
440:             .Caption         = "Encerrar"
441:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
442:             .PicturePosition = 13
443:             .Top             = 5
444:             .Left            = 80
445:             .Width           = 75
446:             .Height          = 75
447:             .FontName        = "Comic Sans MS"
448:             .FontSize        = 8
449:             .FontBold        = .T.
450:             .FontItalic      = .T.
451:             .ForeColor       = RGB(90, 90, 90)
452:             .BackColor       = RGB(255, 255, 255)
453:             .Themes          = .F.
454:             .SpecialEffect   = 0
455:             .MousePointer    = 15
456:             .WordWrap        = .T.
457:             .AutoSize        = .F.
458:             .Visible         = .T.
459:         ENDWITH
460: 
461:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
462:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
463: 
464:         *-- Label Opera??o: (Label3: Top=121+29=150, Left=135, Width=53, Height=15)
465:         loc_oPagina.AddObject("lbl_4c_OperacaoLabel", "Label")
466:         WITH loc_oPagina.lbl_4c_OperacaoLabel
467:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o:"
468:             .Top       = 150
469:             .Left      = 135
470:             .Width     = 53
471:             .Height    = 15
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .FontBold  = .F.

*-- Linhas 483 a 492:
483:         loc_oPagina.AddObject("txt_4c_Nopes", "TextBox")
484:         WITH loc_oPagina.txt_4c_Nopes
485:             .Value     = 0
486:             .Top       = 146
487:             .Left      = 203
488:             .Width     = 37
489:             .Height    = 23
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 503 a 512:
503:         loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
504:         WITH loc_oPagina.txt_4c_Dopes
505:             .Value     = ""
506:             .Top       = 146
507:             .Left      = 243
508:             .Width     = 150
509:             .Height    = 23
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 525 a 563:
525:             .ButtonCount = 3
526:             .BackStyle   = 0
527:             .BorderStyle = 0
528:             .Top         = 172
529:             .Left        = 198
530:             .Width       = 268
531:             .Height      = 27
532:             .Value       = 0
533:             .Visible     = .T.
534:         ENDWITH
535:         WITH loc_oPagina.opt_4c_Pagos.Buttons(1)
536:             .Caption   = "Pagos"
537:             .Left      = 5
538:             .Top       = 5
539:             .AutoSize  = .T.
540:             .FontName  = "Tahoma"
541:             .FontSize  = 8
542:             .ForeColor = RGB(90, 90, 90)
543:             .BackStyle = 0
544:         ENDWITH
545:         WITH loc_oPagina.opt_4c_Pagos.Buttons(2)
546:             .Caption   = "N" + CHR(227) + "o Pagos"
547:             .Left      = 87
548:             .Top       = 5
549:             .AutoSize  = .T.
550:             .FontName  = "Tahoma"
551:             .FontSize  = 8
552:             .ForeColor = RGB(90, 90, 90)
553:             .BackStyle = 0
554:         ENDWITH
555:         WITH loc_oPagina.opt_4c_Pagos.Buttons(3)
556:             .Caption   = "Todos"
557:             .Left      = 200
558:             .Top       = 5
559:             .Height    = 15
560:             .Width     = 47
561:             .AutoSize  = .T.
562:             .FontName  = "Tahoma"
563:             .FontSize  = 8

*-- Linhas 572 a 610:
572:             .ButtonCount = 3
573:             .BackStyle   = 0
574:             .BorderStyle = 0
575:             .Top         = 193
576:             .Left        = 198
577:             .Width       = 268
578:             .Height      = 27
579:             .Value       = 0
580:             .Visible     = .T.
581:         ENDWITH
582:         WITH loc_oPagina.opt_4c_Utils.Buttons(1)
583:             .Caption   = "Utilizados"
584:             .Left      = 5
585:             .Top       = 5
586:             .AutoSize  = .T.
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .ForeColor = RGB(90, 90, 90)
590:             .BackStyle = 0
591:         ENDWITH
592:         WITH loc_oPagina.opt_4c_Utils.Buttons(2)
593:             .Caption   = "N" + CHR(227) + "o Utilizados"
594:             .Left      = 87
595:             .Top       = 5
596:             .AutoSize  = .T.
597:             .FontName  = "Tahoma"
598:             .FontSize  = 8
599:             .ForeColor = RGB(90, 90, 90)
600:             .BackStyle = 0
601:         ENDWITH
602:         WITH loc_oPagina.opt_4c_Utils.Buttons(3)
603:             .Caption   = "Todos"
604:             .Left      = 200
605:             .Top       = 5
606:             .Height    = 15
607:             .Width     = 47
608:             .AutoSize  = .T.
609:             .FontName  = "Tahoma"
610:             .FontSize  = 8

*-- Linhas 651 a 662:
651:                     loc_oGrid.Column4.Width = 108
652: 
653:                     *-- Headers re-definidos APOS RecordSource (reset para nome do campo)
654:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
655:                     loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
656:                     loc_oGrid.Column3.Header1.Caption = "Pagamentos"
657:                     loc_oGrid.Column4.Header1.Caption = "Utilizados"
658: 
659:                     THIS.FormatarGridLista(loc_oGrid)
660:                     loc_oGrid.Refresh()
661:                 ENDIF
662:             ENDIF

*-- Linhas 967 a 978:
967:         ENDIF
968: 
969:         WITH THIS.this_oBusinessObject
970:             loc_oPagina2.txt_4c_Nopes.Value = .this_nNdopes
971:             loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(.this_cDopes)
972:             loc_oPagina2.opt_4c_Pagos.Value = .this_nTpagos
973:             loc_oPagina2.opt_4c_Utils.Value = .this_nTutils
974:         ENDWITH
975:     ENDPROC
976: 
977:     *===========================================================================
978:     * LimparCampos - Zera todos os campos da Page2

*-- Linhas 1035 a 1044:
1035:         LOCAL loc_lSalvar
1036:         loc_lSalvar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1037: 
1038:         loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lSalvar
1039:         loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1040:     ENDPROC
1041: 
1042:     *===========================================================================
1043:     * ValidarNopes - Handler de LostFocus do txt_4c_Nopes
1044:     * Busca SigCdOpe por Dopes; se nao achar abre picker


### BO (C:\4c\projeto\app\classes\OpdBO.prg):
*==============================================================================
* OpdBO.prg - Business Object para Opera??es de Pedido (SigOpPed)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS OpdBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (mapeamento das colunas de SigOpPed)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && cidchaves char(20) - identificador interno
    this_cDopes     = ""   && dopes     char(20) - PK: descri��o da opera��o
    this_nNdopes    = 0    && ndopes    numeric(10,0) - c�digo num�rico
    this_nTpagos    = 0    && tpagos    numeric(10,0) - tipo pagamento (1=Pagos,2=N�o Pagos,3=Todos)
    this_nTutils    = 0    && tutils    numeric(10,0) - tipo utiliza��o (1=Utilizados,2=N�o Utilizados,3=Todos)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = "SigOpPed"
                THIS.this_cCampoChave = "Dopes"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
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
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDopes     = TratarNulo(dopes,     "C")
                THIS.this_nNdopes    = TratarNulo(ndopes,    "N")
                THIS.this_nTpagos    = TratarNulo(tpagos,   "N")
                THIS.this_nTutils    = TratarNulo(tutils,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "OpdBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cDopes)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Opera" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nTpagos < 1
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Pagamento!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nTutils < 1
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Utiliza" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDopesExistente(THIS.this_cDopes)
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + " Cadastrada!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDopesExistente - Verifica se dopes ja existe em SigOpPed
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDopesExistente(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpPed" + ;
                " WHERE dopes = " + EscaparSQL(par_cDopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpd")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOpd")
                SELECT cursor_4c_ChkOpd
                loc_lExiste = (cursor_4c_ChkOpd.qtd > 0)
                USE IN cursor_4c_ChkOpd
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "OpdBO.VerificarDopesExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigOpPed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves se nao definido (equivalente ao fUniqueIds() do legado)
            loc_cCidChaves = ALLTRIM(THIS.this_cCidChaves)
            IF EMPTY(loc_cCidChaves)
                loc_cCidChaves = PADR(ALLTRIM(THIS.this_cDopes), 20)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpPed (cidchaves, dopes, ndopes, tpagos, tutils)
                VALUES (
                    <<EscaparSQL(PADR(loc_cCidChaves, 20))>>,
                    <<EscaparSQL(THIS.this_cDopes)>>,
                    <<FormatarNumeroSQL(THIS.this_nNdopes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpagos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTutils, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChaves = loc_cCidChaves
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "OpdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigOpPed
    * Nota: dopes e a PK, nao pode ser alterado - apenas ndopes, tpagos, tutils
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpPed
                SET ndopes = <<FormatarNumeroSQL(THIS.this_nNdopes, 0)>>,
                    tpagos = <<FormatarNumeroSQL(THIS.this_nTpagos, 0)>>,
                    tutils = <<FormatarNumeroSQL(THIS.this_nTutils, 0)>>
                WHERE dopes = <<EscaparSQL(THIS.this_cDopes)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "OpdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigOpPed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpPed WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "OpdBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com ndopes, dopes, tpagos, tutils
    * Grid colunas 3 e 4 usam IIF no ControlSource para exibir texto
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (ndopes N(10,0), dopes C(20), tpagos N(10,0), tutils N(10,0), desc_pagos C(20), desc_utils C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT ndopes, dopes, tpagos, tutils," + ;
                    " CASE WHEN tpagos = 1 THEN 'Pagos'" + ;
                    " WHEN tpagos = 2 THEN 'Nao Pagos' ELSE 'Todos' END AS desc_pagos," + ;
                    " CASE WHEN tutils = 1 THEN 'Utilizados'" + ;
                    " WHEN tutils = 2 THEN 'Nao Utilizados' ELSE 'Todos' END AS desc_utils" + ;
                    " FROM SigOpPed"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY ndopes"

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
                        MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "OpdBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (dopes)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, dopes, ndopes, tpagos, tutils" + ;
                " FROM SigOpPed WHERE dopes = " + EscaparSQL(par_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "OpdBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

