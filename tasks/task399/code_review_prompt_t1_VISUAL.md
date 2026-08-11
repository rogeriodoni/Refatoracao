# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 177: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 201: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 225: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 249: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 273: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 309: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 404: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 428: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDsp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1186 linhas total):

*-- Linhas 75 a 94:
75: 
76:         WITH THIS.pgf_4c_Paginas
77:             .PageCount = 2
78:             .Top       = -29
79:             .Left      = 0
80:             .Width     = THIS.Width
81:             .Height    = THIS.Height + 29
82:             .Tabs      = .F.
83:             .Visible   = .T.
84: 
85:             .Page1.Caption   = "Lista"
86:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
87:             .Page1.BackColor = RGB(255, 255, 255)
88: 
89:             .Page2.Caption   = "Dados"
90:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
91:             .Page2.BackColor = RGB(255, 255, 255)
92:         ENDWITH
93: 
94:         THIS.ConfigurarPaginaLista()

*-- Linhas 108 a 279:
108:         *-- Container cabecalho (fundo escuro com titulo)
109:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
110:         WITH loc_oPagina.cnt_4c_Cabecalho
111:             .Top         = 31
112:             .Left        = 0
113:             .Width       = THIS.Width
114:             .Height      = 80
115:             .BackColor   = RGB(100, 100, 100)
116:             .BackStyle   = 1
117:             .BorderWidth = 0
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
122:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
123:             .Top       = 15
124:             .Left      = 10
125:             .Width     = THIS.Width - 20
126:             .Height    = 40
127:             .Caption   = THIS.Caption
128:             .FontName  = "Tahoma"
129:             .FontSize  = 16
130:             .FontBold  = .T.
131:             .ForeColor = RGB(0, 0, 0)
132:             .BackStyle = 0
133:             .AutoSize  = .F.
134:             .Visible   = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
139:             .Top       = 18
140:             .Left      = 10
141:             .Width     = THIS.Width - 20
142:             .Height    = 46
143:             .Caption   = THIS.Caption
144:             .FontName  = "Tahoma"
145:             .FontSize  = 16
146:             .FontBold  = .T.
147:             .ForeColor = RGB(255, 255, 255)
148:             .BackStyle = 0
149:             .AutoSize  = .F.
150:             .Visible   = .T.
151:         ENDWITH
152: 
153:         *-- Container botoes CRUD (canonico: Left=542)
154:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
155:         WITH loc_oPagina.cnt_4c_Botoes
156:             .Top         = 29
157:             .Left        = 542
158:             .Width       = 390
159:             .Height      = 85
160:             .BackStyle = 0
161:             .BorderWidth = 0
162:             .Visible     = .T.
163:         ENDWITH
164: 
165:         *-- Botao Incluir
166:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
167:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
168:             .Caption         = "Incluir"
169:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
170:             .PicturePosition = 13
171:             .Top             = 5
172:             .Left            = 5
173:             .Width           = 75
174:             .Height          = 75
175:             .BackColor       = RGB(255, 255, 255)
176:             .ForeColor       = RGB(90, 90, 90)
177:             .FontName        = "Comic Sans MS"
178:             .FontSize        = 8
179:             .FontBold        = .T.
180:             .FontItalic      = .T.
181:             .Themes          = .F.
182:             .SpecialEffect   = 0
183:             .MousePointer    = 15
184:             .WordWrap        = .T.
185:             .AutoSize        = .F.
186:             .Visible         = .T.
187:         ENDWITH
188: 
189:         *-- Botao Visualizar
190:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
191:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
192:             .Caption         = "Visualizar"
193:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
194:             .PicturePosition = 13
195:             .Top             = 5
196:             .Left            = 80
197:             .Width           = 75
198:             .Height          = 75
199:             .BackColor       = RGB(255, 255, 255)
200:             .ForeColor       = RGB(90, 90, 90)
201:             .FontName        = "Comic Sans MS"
202:             .FontSize        = 8
203:             .FontBold        = .T.
204:             .FontItalic      = .T.
205:             .Themes          = .F.
206:             .SpecialEffect   = 0
207:             .MousePointer    = 15
208:             .WordWrap        = .T.
209:             .AutoSize        = .F.
210:             .Visible         = .T.
211:         ENDWITH
212: 
213:         *-- Botao Alterar
214:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
215:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
216:             .Caption         = "Alterar"
217:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
218:             .PicturePosition = 13
219:             .Top             = 5
220:             .Left            = 155
221:             .Width           = 75
222:             .Height          = 75
223:             .BackColor       = RGB(255, 255, 255)
224:             .ForeColor       = RGB(90, 90, 90)
225:             .FontName        = "Comic Sans MS"
226:             .FontSize        = 8
227:             .FontBold        = .T.
228:             .FontItalic      = .T.
229:             .Themes          = .F.
230:             .SpecialEffect   = 0
231:             .MousePointer    = 15
232:             .WordWrap        = .T.
233:             .AutoSize        = .F.
234:             .Visible         = .T.
235:         ENDWITH
236: 
237:         *-- Botao Excluir
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
257:             .AutoSize        = .F.
258:             .Visible         = .T.
259:         ENDWITH
260: 
261:         *-- Botao Buscar
262:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
263:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
264:             .Caption         = "Buscar"
265:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
266:             .PicturePosition = 13
267:             .Top             = 5
268:             .Left            = 305
269:             .Width           = 75
270:             .Height          = 75
271:             .BackColor       = RGB(255, 255, 255)
272:             .ForeColor       = RGB(90, 90, 90)
273:             .FontName        = "Comic Sans MS"
274:             .FontSize        = 8
275:             .FontBold        = .T.
276:             .FontItalic      = .T.
277:             .Themes          = .F.
278:             .SpecialEffect   = 0
279:             .MousePointer    = 15

*-- Linhas 285 a 315:
285:         *-- Container saida (canonico: Left=917, Width=90)
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
297:         *-- Botao Encerrar (canonico)
298:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
299:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
300:             .Caption         = "Encerrar"
301:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
302:             .PicturePosition = 13
303:             .Top             = 5
304:             .Left            = 5
305:             .Width           = 75
306:             .Height          = 75
307:             .BackColor       = RGB(255, 255, 255)
308:             .ForeColor       = RGB(90, 90, 90)
309:             .FontName        = "Comic Sans MS"
310:             .FontSize        = 8
311:             .FontBold        = .T.
312:             .FontItalic      = .T.
313:             .Themes          = .F.
314:             .SpecialEffect   = 0
315:             .MousePointer    = 15

*-- Linhas 321 a 330:
321:         *-- Grid de lista
322:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
323:         loc_oGrd             = loc_oPagina.grd_4c_Lista
324:         loc_oGrd.Top         = 117
325:         loc_oGrd.Left        = 26
326:         loc_oGrd.Width       = 890
327:         loc_oGrd.Height      = 455
328:         loc_oGrd.ColumnCount = 5
329: 
330:         WITH loc_oGrd

*-- Linhas 356 a 369:
356:         ENDWITH
357: 
358:         *-- BINDEVENTs dos botoes (PUBLIC handlers obrigatorio)
359:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
360:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
361:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
362:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
363:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
364:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
365: 
366:         THIS.TornarControlesVisiveis(loc_oPagina)
367:     ENDPROC
368: 
369:     *==========================================================================

*-- Linhas 381 a 458:
381:         *-- Container botoes acao (Grupo_Salva no legado: Left=842, Top=4+29=33)
382:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
383:         WITH loc_oPagina.cnt_4c_BotoesAcao
384:             .Top         = 33
385:             .Left        = 842
386:             .Width       = 160
387:             .Height      = 85
388:             .BackStyle   = 0
389:             .Visible     = .T.
390:         ENDWITH
391: 
392:         *-- Botao Salvar (Salva no legado: Left=5, Top=5)
393:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
394:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
395:             .Caption         = "Salvar"
396:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
397:             .PicturePosition = 13
398:             .Top             = 5
399:             .Left            = 5
400:             .Width           = 75
401:             .Height          = 75
402:             .BackColor       = RGB(255, 255, 255)
403:             .ForeColor       = RGB(90, 90, 90)
404:             .FontName        = "Comic Sans MS"
405:             .FontSize        = 8
406:             .FontBold        = .T.
407:             .FontItalic      = .T.
408:             .Themes          = .F.
409:             .SpecialEffect   = 0
410:             .MousePointer    = 15
411:             .WordWrap        = .T.
412:             .AutoSize        = .F.
413:             .Visible         = .T.
414:         ENDWITH
415: 
416:         *-- Botao Cancelar (Cancelar no legado: Left=80, Top=5)
417:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
418:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
419:             .Caption         = "Encerrar"
420:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
421:             .PicturePosition = 13
422:             .Top             = 5
423:             .Left            = 80
424:             .Width           = 75
425:             .Height          = 75
426:             .BackColor       = RGB(255, 255, 255)
427:             .ForeColor       = RGB(90, 90, 90)
428:             .FontName        = "Comic Sans MS"
429:             .FontSize        = 8
430:             .FontBold        = .T.
431:             .FontItalic      = .T.
432:             .Themes          = .F.
433:             .SpecialEffect   = 0
434:             .MousePointer    = 15
435:             .WordWrap        = .T.
436:             .AutoSize        = .F.
437:             .Visible         = .T.
438:         ENDWITH
439: 
440:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
441:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
442: 
443:         *======================================================================
444:         * SECAO GRUPO
445:         * Original: lbl_grupo.Top=172, get_cd_grupo.Top=168 -> comp +29
446:         *======================================================================
447: 
448:         *-- Label "Grupo :" (lbl_grupo no legado: Top=172, Left=148)
449:         loc_oPagina.AddObject("lbl_4c_lbl_grupo", "Label")
450:         WITH loc_oPagina.lbl_4c_lbl_grupo
451:             .Caption   = "Grupo :"
452:             .Top       = 201
453:             .Left      = 148
454:             .Width     = 38
455:             .Height    = 17
456:             .AutoSize  = .T.
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8

*-- Linhas 464 a 473:
464:         *-- TextBox codigo do grupo (get_cd_grupo: Left=197, Width=79, MaxLength=10)
465:         loc_oPagina.AddObject("txt_4c_cd_grupo", "TextBox")
466:         WITH loc_oPagina.txt_4c_cd_grupo
467:             .Top       = 197
468:             .Left      = 197
469:             .Width     = 79
470:             .Height    = 23
471:             .MaxLength = 10
472:             .Format    = "!"
473:             .Value     = ""

*-- Linhas 480 a 489:
480:         *-- ReadOnly: descricao preenchida automaticamente pelo lookup/validacao
481:         loc_oPagina.AddObject("txt_4c_ds_grupo", "TextBox")
482:         WITH loc_oPagina.txt_4c_ds_grupo
483:             .Top       = 197
484:             .Left      = 278
485:             .Width     = 150
486:             .Height    = 23
487:             .MaxLength = 20
488:             .ReadOnly  = .T.
489:             .Value     = ""

*-- Linhas 497 a 513:
497: 
498:         *======================================================================
499:         * SECAO CONTA
500:         * Original: lbl_conta.Top=197, get_cd_conta.Top=193 -> comp +29
501:         *======================================================================
502: 
503:         *-- Label "Conta :" (lbl_conta no legado: Top=197, Left=148)
504:         loc_oPagina.AddObject("lbl_4c_lbl_conta", "Label")
505:         WITH loc_oPagina.lbl_4c_lbl_conta
506:             .Caption   = "Conta :"
507:             .Top       = 226
508:             .Left      = 148
509:             .Width     = 38
510:             .Height    = 17
511:             .AutoSize  = .T.
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8

*-- Linhas 519 a 528:
519:         *-- TextBox codigo da conta (get_cd_conta: Left=197, Width=79, MaxLength=10)
520:         loc_oPagina.AddObject("txt_4c_cd_conta", "TextBox")
521:         WITH loc_oPagina.txt_4c_cd_conta
522:             .Top       = 222
523:             .Left      = 197
524:             .Width     = 79
525:             .Height    = 23
526:             .MaxLength = 10
527:             .Format    = "!"
528:             .Value     = ""

*-- Linhas 535 a 544:
535:         *-- ReadOnly: preenchida automaticamente pelo lookup/validacao
536:         loc_oPagina.AddObject("txt_4c_ds_conta", "TextBox")
537:         WITH loc_oPagina.txt_4c_ds_conta
538:             .Top       = 222
539:             .Left      = 278
540:             .Width     = 290
541:             .Height    = 23
542:             .MaxLength = 40
543:             .ReadOnly  = .T.
544:             .Value     = ""

*-- Linhas 552 a 568:
552: 
553:         *======================================================================
554:         * SECAO TIPO (OptionGroup)
555:         * Original: Say8.Top=230, ObjUniDop.Top=228 -> comp +29
556:         *======================================================================
557: 
558:         *-- Label "Tipo :" (Say8 no legado: Top=230, Left=157, Width=29, Height=15)
559:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
560:         WITH loc_oPagina.lbl_4c_Label8
561:             .Caption   = "Tipo :"
562:             .Top       = 259
563:             .Left      = 157
564:             .Width     = 29
565:             .Height    = 15
566:             .AutoSize  = .T.
567:             .FontName  = "Tahoma"
568:             .FontSize  = 8

*-- Linhas 574 a 620:
574:         *-- OptionGroup tipo (ObjUniDop: Top=228, Left=191, Width=308, Height=19, ButtonCount=3)
575:         loc_oPagina.AddObject("opt_4c_Tipos", "OptionGroup")
576:         WITH loc_oPagina.opt_4c_Tipos
577:             .Top         = 257
578:             .Left        = 191
579:             .Width       = 308
580:             .Height      = 19
581:             .ButtonCount = 3
582:             .BackStyle   = 0
583:             .BorderStyle = 0
584:             .Value       = 1
585:             .Visible     = .T.
586:         ENDWITH
587: 
588:         WITH loc_oPagina.opt_4c_Tipos.Buttons(1)
589:             .Caption   = "Disponibilidade"
590:             .Left      = 5
591:             .Top       = 2
592:             .AutoSize  = .T.
593:             .FontName  = "Tahoma"
594:             .FontSize  = 8
595:             .ForeColor = RGB(90, 90, 90)
596:             .BackStyle = 0
597:             .Themes    = .F.
598:         ENDWITH
599: 
600:         WITH loc_oPagina.opt_4c_Tipos.Buttons(2)
601:             .Caption   = "Investimento"
602:             .Left      = 116
603:             .Top       = 2
604:             .AutoSize  = .T.
605:             .FontName  = "Tahoma"
606:             .FontSize  = 8
607:             .ForeColor = RGB(90, 90, 90)
608:             .BackStyle = 0
609:             .Themes    = .F.
610:         ENDWITH
611: 
612:         WITH loc_oPagina.opt_4c_Tipos.Buttons(3)
613:             .Caption   = "Empr" + CHR(233) + "stimo"
614:             .Left      = 216
615:             .Top       = 2
616:             .Width     = 73
617:             .AutoSize  = .T.
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 647 a 659:
647:                     loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.DsConta"
648:                     loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.Tipos"
649: 
650:                     loc_oGrd.Column1.Header1.Caption = "Grupo"
651:                     loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Grupo"
652:                     loc_oGrd.Column3.Header1.Caption = "Conta"
653:                     loc_oGrd.Column4.Header1.Caption = "Nome da Conta"
654:                     loc_oGrd.Column5.Header1.Caption = "Tipo"
655: 
656:                     THIS.FormatarGridLista(loc_oGrd)
657:                     loc_lResultado = .T.
658:                 ENDIF
659:             ENDIF

*-- Linhas 983 a 993:
983:         loc_lEdicao = THIS.this_cModoAtual $ "INCLUIR/ALTERAR"
984: 
985:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
986:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Salvar", 5)
987:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled  = loc_lEdicao
988:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
989:             ENDIF
990:         ENDIF
991:     ENDPROC
992: 
993:     *==========================================================================


### BO (C:\4c\projeto\app\classes\DspBO.prg):
*==============================================================================
* DspBO.prg - Business Object para Cadastro de Disponibilidades
* Tabela: SigCdDis
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DspBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdDis
    *--------------------------------------------------------------------------
    this_cCodigos   = ""   && char(20) PK - gerado por SYS(2015)
    this_cGrupos    = ""   && char(10) FK -> SigCdGcr.Codigos
    this_cIclis     = ""   && char(10) FK -> SigCdCli.IClis
    this_nTipos     = 1    && numeric(1,0) 1=Disponibilidade 2=Investimento 3=Emprestimo

    *--------------------------------------------------------------------------
    * Campos auxiliares (nao persistidos - apenas para exibicao no form)
    *--------------------------------------------------------------------------
    this_cDsGrupo   = ""   && descricao do grupo (SigCdGcr.Descrs)
    this_cDsConta   = ""   && descricao da conta (SigCdCli.RClis)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDis"
            THIS.this_cCampoChave = "Codigos"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de disponibilidades no cursor cursor_4c_Dados
    * par_cFiltro: filtro SQL adicional (vazio = todos)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
                       " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
                       " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
                       " FROM SigCdDis a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Iclis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_Dados
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar disponibilidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega disponibilidade pelo Codigos (PK)
    * par_cCodigo: valor do Codigos
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
                       " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
                       " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
                       " FROM SigCdDis a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * par_cAliasCursor: nome do cursor (SELECT antes de acessar campos)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos   = TratarNulo(Codigos,  "C")
                THIS.this_cGrupos    = TratarNulo(Grupos,   "C")
                THIS.this_cIclis     = TratarNulo(Iclis,    "C")
                THIS.this_nTipos     = TratarNulo(Tipos,    "N")
                THIS.this_cDsGrupo   = TratarNulo(DsGrupos, "C")
                THIS.this_cDsConta   = TratarNulo(DsConta,  "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Insere nova disponibilidade (PROTECTED)
    * Gera Codigos via SYS(2015), verifica duplicidade antes de INSERT
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cIclis, "")
                MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.this_cCodigos = LEFT(SYS(2015) + SYS(2015), 20)

                loc_cSQL = "INSERT INTO SigCdDis (Codigos, Grupos, Iclis, Tipos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCodigos)               + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cGrupos, 10))      + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cIclis, 10))       + ", " + ;
                           FormatarNumeroSQL(THIS.this_nTipos)          + ;
                           ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza disponibilidade existente (PROTECTED)
    * Verifica duplicidade (excluindo o registro atual) antes de UPDATE
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cIclis, THIS.this_cCodigos)
                MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "UPDATE SigCdDis SET" + ;
                           " Grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                           " Iclis  = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))  + "," + ;
                           " Tipos  = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
                           " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui disponibilidade (PROTECTED)
    * Chamado internamente por Excluir() do BusinessBase
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDis WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com Grupos+Iclis
    * par_cGrupos: codigo do grupo
    * par_cContas: codigo da conta (Iclis)
    * par_cExcluirChave: PK a excluir da verificacao (vazio=INSERT, atual=UPDATE)
    * Retorna: .T. se duplicado, .F. se nao existe
    *==========================================================================
    PROCEDURE VerificarDuplicidade(par_cGrupos, par_cContas, par_cExcluirChave)
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Duplic")
                USE IN cursor_4c_Duplic
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDis" + ;
                       " WHERE Grupos = " + EscaparSQL(LEFT(par_cGrupos, 10)) + ;
                       " AND Iclis = " + EscaparSQL(par_cContas)

            IF VARTYPE(par_cExcluirChave) = "C" AND !EMPTY(ALLTRIM(par_cExcluirChave))
                loc_cSQL = loc_cSQL + " AND Codigos <> " + EscaparSQL(par_cExcluirChave)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Duplic") > 0
                SELECT cursor_4c_Duplic
                loc_lDuplicado = (Total > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Duplic")
            USE IN cursor_4c_Duplic
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Valida codigo de grupo e carrega descricao
    * par_cGrupo: codigo do grupo (SigCdGcr.Codigos)
    * Retorna: .T. se valido | Efeito: popula this_cDsGrupo
    *==========================================================================
    PROCEDURE ValidarGrupo(par_cGrupo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_ValGrupo")
                USE IN cursor_4c_ValGrupo
            ENDIF

            IF EMPTY(ALLTRIM(par_cGrupo))
                THIS.this_cDsGrupo = ""
            ELSE
                loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(par_cGrupo)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrupo")

                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValGrupo") > 0
                    SELECT cursor_4c_ValGrupo
                    THIS.this_cDsGrupo = ALLTRIM(cursor_4c_ValGrupo.Descrs)
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cDsGrupo = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ValGrupo")
            USE IN cursor_4c_ValGrupo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarConta - Valida codigo de conta (SigCdCli.IClis)
    * par_cGrupo: nao utilizado no filtro SQL
    * par_cConta: codigo da conta (SigCdCli.IClis)
    * Retorna: .T. se valida | Efeito: popula this_cDsConta
    *==========================================================================
    PROCEDURE ValidarConta(par_cGrupo, par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_ValConta")
                USE IN cursor_4c_ValConta
            ENDIF

            IF EMPTY(ALLTRIM(par_cConta))
                THIS.this_cDsConta = ""
            ELSE
                loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(par_cConta)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")

                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValConta") > 0
                    SELECT cursor_4c_ValConta
                    THIS.this_cDsConta = ALLTRIM(cursor_4c_ValConta.Rclis)
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cDsConta = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar conta: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ValConta")
            USE IN cursor_4c_ValConta
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarGrupos - Popula cursor_4c_BuscaGrupo para lookup de grupos
    * par_cFiltro: prefixo para filtrar por Codigos (vazio = todos)
    *==========================================================================
    PROCEDURE BuscarGrupos(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE Codigos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_BuscaGrupo
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarContas - Popula cursor_4c_BuscaConta para lookup de contas
    * par_cGrupo: nao utilizado no filtro SQL
    * par_cFiltro: prefixo para filtrar por Iclis (vazio = todos)
    *==========================================================================
    PROCEDURE BuscarContas(par_cGrupo, par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
        loc_lResultado = .F.
        loc_cWhere     = ""

        TRY
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE Iclis LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + loc_cWhere + " ORDER BY Iclis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_BuscaConta
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar contas: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

