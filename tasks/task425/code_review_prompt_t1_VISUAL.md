# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 206: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 229: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 252: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 275: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 298: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 323: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 407: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 430: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpg.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1212 linhas total):

*-- Linhas 52 a 61:
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54: 
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57: 
58:                 THIS.pgf_4c_Paginas.Visible = .T.
59:                 THIS.pgf_4c_Paginas.ActivePage = 1
60:                 THIS.this_cModoAtual = "LISTA"
61: 

*-- Linhas 78 a 159:
78: 
79:     *==========================================================================
80:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
81:     * Pagina.Top = -28 nesta form (conforme SCX original: linha 118)
82:     * Compensacao: +28 em todos os controles dentro das Pages
83:     *==========================================================================
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .PageCount = 2
89:             .Top       = -28
90:             .Left      = 0
91:             .Width     = THIS.Width
92:             .Height    = THIS.Height + 28
93:             .Tabs      = .F.
94:             .Visible   = .T.
95: 
96:             .Page1.Caption   = "Lista"
97:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page1.BackColor = RGB(255, 255, 255)
99: 
100:             .Page2.Caption   = "Dados"
101:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.BackColor = RGB(255, 255, 255)
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()
106:         THIS.ConfigurarPaginaDados()
107:     ENDPROC
108: 
109:     *==========================================================================
110:     * ConfigurarPaginaLista - Configura Page1: cabecalho + botoes CRUD + grid
111:     * Legado: cntSombra, Grupo_op (5 botoes), Grupo_Saida, Grade
112:     * Compensacao +28 (Pagina.Top=-28)
113:     *==========================================================================
114:     PROTECTED PROCEDURE ConfigurarPaginaLista()
115:         LOCAL loc_oPagina
116:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
117: 
118:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
119:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120: 
121:         *-- Container Cabecalho (cntSombra no legado)
122:         *-- Framework: Top=2; com compensacao +28 = 30
123:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
124:         WITH loc_oPagina.cnt_4c_Cabecalho
125:             .Top         = 30
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BackColor   = RGB(100, 100, 100)
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
135:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
136:             .Caption   = THIS.Caption
137:             .Top       = 15
138:             .Left      = 10
139:             .Width     = 769
140:             .Height    = 40
141:             .FontName  = "Tahoma"
142:             .FontSize  = 16
143:             .FontBold  = .T.
144:             .ForeColor = RGB(0, 0, 0)
145:             .BackStyle = 0
146:             .AutoSize  = .F.
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
151:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
152:             .Caption   = THIS.Caption
153:             .Top       = 18
154:             .Left      = 10
155:             .Width     = 769
156:             .Height    = 46
157:             .FontName  = "Tahoma"
158:             .FontSize  = 16
159:             .FontBold  = .T.

*-- Linhas 167 a 329:
167:         *-- Legado: Top=-1, Left=538; com compensacao: Top=28(-1+28+1~), Left=542 (canonico)
168:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
169:         WITH loc_oPagina.cnt_4c_Botoes
170:             .Top         = 28
171:             .Left        = 542
172:             .Width       = 390
173:             .Height      = 85
174:             .BackStyle   = 0
175:             .BorderWidth = 0
176:             .Visible     = .T.
177:         ENDWITH
178: 
179:         *-- Container Saida - PADRAO CANONICO per CLAUDE.md regra #10
180:         *-- Grupo_Saida no legado. Canonico: Left=917, Top=28, Width=90, Height=85
181:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
182:         WITH loc_oPagina.cnt_4c_Saida
183:             .Top         = 28
184:             .Left        = 917
185:             .Width       = 90
186:             .Height      = 85
187:             .BackStyle   = 0
188:             .BorderWidth = 0
189:             .Visible     = .T.
190:         ENDWITH
191: 
192:         *-- Botoes CRUD dentro de cnt_4c_Botoes
193:         *-- Legado: Inserir.Left=5, Consultar.Left=80, Alterar.Left=155, Excluir.Left=230, procurar.Left=305
194:         *-- Top=5 em todos (Grupo_op.Top=-1+button.Top=5 -> absoluto=4+28=32; canonico top dentro container=5)
195:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
196:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
197:             .Caption         = "Incluir"
198:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
199:             .PicturePosition = 13
200:             .Top             = 5
201:             .Left            = 5
202:             .Width           = 75
203:             .Height          = 75
204:             .BackColor       = RGB(255, 255, 255)
205:             .ForeColor       = RGB(90, 90, 90)
206:             .FontName        = "Comic Sans MS"
207:             .FontSize        = 8
208:             .FontBold        = .T.
209:             .FontItalic      = .T.
210:             .Themes          = .F.
211:             .SpecialEffect   = 0
212:             .MousePointer    = 15
213:             .WordWrap        = .T.
214:             .AutoSize        = .F.
215:             .Visible         = .T.
216:         ENDWITH
217: 
218:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
219:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
220:             .Caption         = "Visualizar"
221:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
222:             .PicturePosition = 13
223:             .Top             = 5
224:             .Left            = 80
225:             .Width           = 75
226:             .Height          = 75
227:             .BackColor       = RGB(255, 255, 255)
228:             .ForeColor       = RGB(90, 90, 90)
229:             .FontName        = "Comic Sans MS"
230:             .FontSize        = 8
231:             .FontBold        = .T.
232:             .FontItalic      = .T.
233:             .Themes          = .F.
234:             .SpecialEffect   = 0
235:             .MousePointer    = 15
236:             .WordWrap        = .T.
237:             .AutoSize        = .F.
238:             .Visible         = .T.
239:         ENDWITH
240: 
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
243:             .Caption         = "Alterar"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 155
248:             .Width           = 75
249:             .Height          = 75
250:             .BackColor       = RGB(255, 255, 255)
251:             .ForeColor       = RGB(90, 90, 90)
252:             .FontName        = "Comic Sans MS"
253:             .FontSize        = 8
254:             .FontBold        = .T.
255:             .FontItalic      = .T.
256:             .Themes          = .F.
257:             .SpecialEffect   = 0
258:             .MousePointer    = 15
259:             .WordWrap        = .T.
260:             .AutoSize        = .F.
261:             .Visible         = .T.
262:         ENDWITH
263: 
264:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
265:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
266:             .Caption         = "Excluir"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 230
271:             .Width           = 75
272:             .Height          = 75
273:             .BackColor       = RGB(255, 255, 255)
274:             .ForeColor       = RGB(90, 90, 90)
275:             .FontName        = "Comic Sans MS"
276:             .FontSize        = 8
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .MousePointer    = 15
282:             .WordWrap        = .T.
283:             .AutoSize        = .F.
284:             .Visible         = .T.
285:         ENDWITH
286: 
287:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
288:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
289:             .Caption         = "Buscar"
290:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
291:             .PicturePosition = 13
292:             .Top             = 5
293:             .Left            = 305
294:             .Width           = 75
295:             .Height          = 75
296:             .BackColor       = RGB(255, 255, 255)
297:             .ForeColor       = RGB(90, 90, 90)
298:             .FontName        = "Comic Sans MS"
299:             .FontSize        = 8
300:             .FontBold        = .T.
301:             .FontItalic      = .T.
302:             .Themes          = .F.
303:             .SpecialEffect   = 0
304:             .MousePointer    = 15
305:             .WordWrap        = .T.
306:             .AutoSize        = .F.
307:             .Visible         = .T.
308:         ENDWITH
309: 
310:         *-- Botao Encerrar - PADRAO CANONICO per CLAUDE.md regra #10
311:         *-- Grupo_Saida.SAIR no legado: Top=5, Left=5; canonico Width=75, Height=75, Caption="Encerrar"
312:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
313:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
314:             .Caption         = "Encerrar"
315:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
316:             .PicturePosition = 13
317:             .Top             = 5
318:             .Left            = 5
319:             .Width           = 75
320:             .Height          = 75
321:             .BackColor       = RGB(255, 255, 255)
322:             .ForeColor       = RGB(90, 90, 90)
323:             .FontName        = "Comic Sans MS"
324:             .FontSize        = 8
325:             .FontBold        = .T.
326:             .FontItalic      = .T.
327:             .Themes          = .F.
328:             .SpecialEffect   = 0
329:             .MousePointer    = 15

*-- Linhas 337 a 346:
337:         *-- Top: framework Grade Top=93; com compensacao +28 = 121. Left=12, Width=940, Height=470
338:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
339:         WITH loc_oPagina.grd_4c_Lista
340:             .Top                = 121
341:             .Left               = 12
342:             .Width              = 940
343:             .Height             = 470
344:             .DeleteMark         = .F.
345:             .RecordMark         = .F.
346:             .RowHeight          = 16

*-- Linhas 358 a 473:
358:         ENDWITH
359: 
360:         *-- BINDEVENTs: handlers devem ser PUBLIC (nao PROTECTED) para BINDEVENT funcionar
361:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
362:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
363:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
364:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
365:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
366:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
367: 
368:         THIS.TornarControlesVisiveis(loc_oPagina)
369:     ENDPROC
370: 
371:     *==========================================================================
372:     * ConfigurarPaginaDados - Configura Page2: botoes Salvar/Cancelar + campos
373:     * Campos (TextBox, OptionGroup) adicionados nas Fases seguintes
374:     * Compensacao +28 (Pagina.Top=-28)
375:     *==========================================================================
376:     PROTECTED PROCEDURE ConfigurarPaginaDados()
377:         LOCAL loc_oPagina
378:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
379: 
380:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
381:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
382: 
383:         *-- Container botoes Salvar/Cancelar (Grupo_Salva no legado)
384:         *-- Legado: Grupo_Salva.Salva.Top=5, Left=5, Cancelar.Left=80; canonico Left=842, Top=32
385:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
386:         WITH loc_oPagina.cnt_4c_Salva
387:             .Top         = 32
388:             .Left        = 842
389:             .Width       = 160
390:             .Height      = 85
391:             .BackStyle   = 0
392:             .BorderWidth = 0
393:             .Visible     = .T.
394:         ENDWITH
395: 
396:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
397:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
398:             .Caption         = "Confirmar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
400:             .PicturePosition = 13
401:             .Top             = 5
402:             .Left            = 5
403:             .Width           = 75
404:             .Height          = 75
405:             .BackColor       = RGB(255, 255, 255)
406:             .ForeColor       = RGB(90, 90, 90)
407:             .FontName        = "Comic Sans MS"
408:             .FontSize        = 8
409:             .FontBold        = .T.
410:             .FontItalic      = .T.
411:             .Themes          = .F.
412:             .SpecialEffect   = 0
413:             .MousePointer    = 15
414:             .WordWrap        = .T.
415:             .AutoSize        = .F.
416:             .Visible         = .T.
417:         ENDWITH
418: 
419:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
420:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
421:             .Caption         = "Encerrar"
422:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
423:             .PicturePosition = 13
424:             .Top             = 5
425:             .Left            = 80
426:             .Width           = 75
427:             .Height          = 75
428:             .BackColor       = RGB(255, 255, 255)
429:             .ForeColor       = RGB(90, 90, 90)
430:             .FontName        = "Comic Sans MS"
431:             .FontSize        = 8
432:             .FontBold        = .T.
433:             .FontItalic      = .T.
434:             .Themes          = .F.
435:             .SpecialEffect   = 0
436:             .MousePointer    = 15
437:             .WordWrap        = .T.
438:             .AutoSize        = .F.
439:             .Visible         = .T.
440:         ENDWITH
441: 
442:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
443:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
444: 
445:         *-- Label titulo do cadastro (lbl_cadastro no legado)
446:         *-- Legado: Top=163, compensacao +28 = 191; Left=255; FontBold=.T.; BackStyle=0
447:         loc_oPagina.AddObject("lbl_4c_Lbl_cadastro", "Label")
448:         WITH loc_oPagina.lbl_4c_Lbl_cadastro
449:             .Caption    = "Cadastro de Contas a Pagar"
450:             .Top        = 191
451:             .Left       = 255
452:             .FontName   = "Tahoma"
453:             .FontSize   = 8
454:             .FontBold   = .T.
455:             .FontItalic = .F.
456:             .BackStyle  = 0
457:             .ForeColor  = RGB(90, 90, 90)
458:             .AutoSize   = .T.
459:             .Visible    = .T.
460:         ENDWITH
461: 
462:         *-- Label "Grupo :" (lbl_grupo no legado)
463:         *-- Legado: Top=186+28=214, Left=207, Width=38
464:         loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
465:         WITH loc_oPagina.lbl_4c_Lbl_grupo
466:             .Caption   = "Grupo :"
467:             .Top       = 214
468:             .Left      = 207
469:             .Width     = 38
470:             .Height    = 17
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8
473:             .FontBold  = .F.

*-- Linhas 485 a 494:
485:         WITH loc_oPagina.txt_4c__cd_grupo
486:             .Value     = ""
487:             .MaxLength = 10
488:             .Top       = 209
489:             .Left      = 254
490:             .Width     = 79
491:             .Height    = 23
492:             .FontName  = "Tahoma"
493:             .FontSize  = 8
494:             .ReadOnly  = .F.

*-- Linhas 503 a 527:
503:         WITH loc_oPagina.txt_4c__ds_grupo
504:             .Value     = ""
505:             .MaxLength = 20
506:             .Top       = 209
507:             .Left      = 335
508:             .Width     = 150
509:             .Height    = 23
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .ReadOnly  = .F.
513:             .Visible   = .T.
514:         ENDWITH
515: 
516:         *-- Label "Tipo :" (Say11 no legado)
517:         *-- Legado: Top=211+28=239, Left=216, Width=29, Height=15
518:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
519:         WITH loc_oPagina.lbl_4c_Label11
520:             .Caption   = "Tipo :"
521:             .Top       = 239
522:             .Left      = 216
523:             .Width     = 29
524:             .Height    = 15
525:             .FontName  = "Tahoma"
526:             .FontSize  = 8
527:             .FontBold  = .F.

*-- Linhas 537 a 570:
537:         WITH loc_oPagina.opt_4c_Op_con
538:             .ButtonCount   = 2
539:             .Value         = 1
540:             .Top           = 234
541:             .Left          = 254
542:             .Width         = 118
543:             .Height        = 25
544:             .BackStyle     = 0
545:             .BorderStyle   = 0
546:             .SpecialEffect = 0
547:             .Visible       = .T.
548:         ENDWITH
549: 
550:         WITH loc_oPagina.opt_4c_Op_con.Buttons(1)
551:             .Caption   = "Real"
552:             .Left      = 5
553:             .Top       = 5
554:             .Width     = 40
555:             .AutoSize  = .T.
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .ForeColor = RGB(90, 90, 90)
559:             .BackStyle = 0
560:         ENDWITH
561: 
562:         WITH loc_oPagina.opt_4c_Op_con.Buttons(2)
563:             .Caption   = "Previsto"
564:             .Left      = 51
565:             .Top       = 5
566:             .Width     = 57
567:             .AutoSize  = .T.
568:             .FontName  = "Tahoma"
569:             .FontSize  = 8
570:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 612 a 630:
612:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
613:                         .Column1.Width           = 80
614:                         .Column1.Alignment       = 0
615:                         .Column1.Header1.Caption = "Grupo"
616: 
617:                         .Column2.ControlSource   = "cursor_4c_Dados.descrs"
618:                         .Column2.Width           = 560
619:                         .Column2.Alignment       = 0
620:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
621: 
622:                         .Column3.ControlSource   = "cursor_4c_Dados.relprevs"
623:                         .Column3.Width           = 80
624:                         .Column3.Alignment       = 2
625:                         .Column3.Header1.Caption = "Tipo"
626:                     ENDWITH
627: 
628:                     THIS.FormatarGridLista(loc_oGrid)
629:                     THIS.AjustarBotoesPorModo()
630:                     loc_lResultado = .T.

*-- Linhas 887 a 896:
887:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
888: 
889:             *-- Confirmar desabilitado em VISUALIZAR
890:             IF VARTYPE(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
891:                 loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
892:             ENDIF
893: 
894:             *-- grupos = PK: editavel somente em INCLUIR (legado: When='INSERIR/PROCURAR')
895:             IF VARTYPE(loc_oPagina.txt_4c__cd_grupo) = "O"
896:                 loc_oPagina.txt_4c__cd_grupo.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")

*-- Linhas 1038 a 1058:
1038:                 !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1039: 
1040:             *-- Botoes que requerem selecao: Visualizar, Alterar, Excluir
1041:             IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar) = "O"
1042:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1043:             ENDIF
1044:             IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar) = "O"
1045:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1046:             ENDIF
1047:             IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir) = "O"
1048:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1049:             ENDIF
1050: 
1051:             *-- Confirmar desabilitado em VISUALIZAR
1052:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
1053:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
1054:             ENDIF
1055: 
1056:             *-- Foco em Page2 conforme modo (legado: INSERIR/PROCURAR -> cd_grupo; CONSULTAR -> Salva)
1057:             IF THIS.pgf_4c_Paginas.ActivePage = 2
1058:                 DO CASE

*-- Linhas 1065 a 1074:
1065:                             loc_oPg2.txt_4c__ds_grupo.SetFocus()
1066:                         ENDIF
1067:                     CASE THIS.this_cModoAtual = "VISUALIZAR"
1068:                         IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar) = "O"
1069:                             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
1070:                         ENDIF
1071:                 ENDCASE
1072:             ENDIF
1073: 
1074:         CATCH TO loException


### BO (C:\4c\projeto\app\classes\FpgBO.prg):
*====================================================================
* FpgBO.prg
*
* Business Object para Cadastro Financeiro de Pagamentos
* Tabela: SigCdPag
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS FpgBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdPag)
    this_cGrupos   = ""    && grupos char(10) - PK
    this_cDescrs   = ""    && descrs char(30)
    this_nRelprevs = 0     && relprevs numeric(1,0) - 1=Real, 2=Previsto

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPag"
            THIS.this_cCampoChave = "grupos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FpgBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cGrupos   = TratarNulo(grupos,   "C")
                THIS.this_cDescrs   = TratarNulo(descrs,   "C")
                THIS.this_nRelprevs = TratarNulo(relprevs, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "FpgBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cGrupos)
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarGrupoExistente(THIS.this_cGrupos)
                MsgAviso("Grupo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarGrupoExistente - Verifica se grupos ja existe no banco
    *====================================================================
    PROCEDURE VerificarGrupoExistente(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPag" + ;
                " WHERE grupos = " + EscaparSQL(par_cGrupos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkGrp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkGrp")
                SELECT cursor_4c_ChkGrp
                loc_lExiste = (cursor_4c_ChkGrp.qtd > 0)
                USE IN cursor_4c_ChkGrp
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar grupo:" + CHR(13) + loException.Message, "FpgBO.VerificarGrupoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdPag (grupos, descrs, relprevs)
                VALUES (
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<FormatarNumeroSQL(THIS.this_nRelprevs, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "FpgBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdPag
                SET descrs   = <<EscaparSQL(THIS.this_cDescrs)>>,
                    relprevs = <<FormatarNumeroSQL(THIS.this_nRelprevs, 0)>>
                WHERE grupos = <<EscaparSQL(THIS.this_cGrupos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "FpgBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPag WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "FpgBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com grupos, descrs, relprevs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (grupos C(10), descrs C(30), relprevs N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupos, descrs, relprevs FROM SigCdPag"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY grupos"

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
                        MostrarErro("Erro ao buscar grupos de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FpgBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (grupos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs, relprevs FROM SigCdPag" + ;
                " WHERE grupos = " + EscaparSQL(par_cGrupos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grupo de pagamento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "FpgBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarGrupoGcr - Busca grupo de conta corrente em SigCdGcr
    * Usado pelo Form para validar/lookup do campo grupos via fAcessoContab
    * Substitui fAcessoContab(Usuar,'C',codigo,...) e
    *          fAcessoContab(Usuar,'D',descricao,...)
    *====================================================================
    PROCEDURE BuscarGrupoGcr(par_cValor, par_cModo, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCursorDest
        loc_lSucesso = .F.
        loc_cCursorDest = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
            par_cCursorDestino, "cursor_4c_BuscaGcr")

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lSucesso = .T.
            ELSE
                DO CASE
                    CASE UPPER(ALLTRIM(par_cModo)) = "C"
                        loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr" + ;
                            " WHERE grupos = " + EscaparSQL(par_cValor)
                    CASE UPPER(ALLTRIM(par_cModo)) = "D"
                        loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr" + ;
                            " WHERE UPPER(RTRIM(descrs)) LIKE UPPER(" + EscaparSQL(par_cValor + "%") + ")"
                    OTHERWISE
                        loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr ORDER BY grupos"
                ENDCASE

                IF USED(loc_cCursorDest)
                    USE IN (loc_cCursorDest)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorDest)
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar grupo conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar grupo GCR:" + CHR(13) + loException.Message, "FpgBO.BuscarGrupoGcr")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

