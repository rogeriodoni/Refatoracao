# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (21)
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Prior.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa De' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa Até' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Selecio.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Prior.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa De' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa Até' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Selecio.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Prior.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa De' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Faixa Até' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Selecio.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Motivo, Descrição, Tipo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCco.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1648 linhas total):

*-- Linhas 30 a 38:
30:     * Init - Corrige Caption com acentos e delega ao FormBase
31:     *==========================================================================
32:     PROCEDURE Init()
33:         THIS.Caption = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *==========================================================================
38:     * InicializarForm - Configura estrutura completa

*-- Linhas 53 a 62:
53: 
54:             *-- Montar estrutura visual
55:             THIS.ConfigurarPageFrame()
56:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58: 
59:             *-- Cursor crMotivos para grid de motivos (SigCdCmt via SigCdFs)
60:             IF USED("crMotivos")
61:                 USE IN crMotivos
62:             ENDIF

*-- Linhas 86 a 110:
86: 
87:     *==========================================================================
88:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
89:     * Legado: Pagina.Top=-28 -> compensacao +28 em todos os controles
90:     *==========================================================================
91:     PROTECTED PROCEDURE ConfigurarPageFrame()
92:         LOCAL loc_oPg1, loc_oPg2
93: 
94:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
95:         WITH THIS.pgf_4c_Paginas
96:             .PageCount = 2
97:             .Top       = -28
98:             .Left      = -1
99:             .Width     = THIS.Width + 2
100:             .Height    = THIS.Height + 30
101:             .Tabs      = .F.
102:             .Visible   = .T.
103:             .Page1.Caption   = "Lista"
104:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:             .Page2.Caption   = "Dados"
106:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page1.BackColor = RGB(100, 100, 100)
108:             .Page2.BackColor = RGB(100, 100, 100)
109:         ENDWITH
110: 

*-- Linhas 127 a 164:
127:         *-- Cabecalho cinza (cntSombra do legado, Top=0 -> +28 = 28)
128:         par_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
129:         WITH par_oPagina.cnt_4c_Cabecalho
130:             .Top         = 28
131:             .Left        = 0
132:             .Width       = THIS.Width
133:             .Height      = 80
134:             .BackColor   = RGB(100, 100, 100)
135:             .BorderWidth = 0
136:             .Visible     = .T.
137:         ENDWITH
138: 
139:         par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
140:         WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
141:             .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
142:             .Top       = 15
143:             .Left      = 10
144:             .Width     = THIS.Width - 20
145:             .Height    = 40
146:             .AutoSize  = .F.
147:             .FontName  = "Tahoma"
148:             .FontSize  = 16
149:             .FontBold  = .T.
150:             .ForeColor = RGB(0, 0, 0)
151:             .BackStyle = 0
152:             .Visible   = .T.
153:         ENDWITH
154: 
155:         par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
156:         WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
157:             .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
158:             .Top       = 18
159:             .Left      = 10
160:             .Width     = THIS.Width - 20
161:             .Height    = 46
162:             .AutoSize  = .F.
163:             .FontName  = "Tahoma"
164:             .FontSize  = 16

*-- Linhas 171 a 194:
171:         *-- Container botoes CRUD (Grupo_op: Left=544, Top=-2 -> +28 = 26)
172:         par_oPagina.AddObject("cnt_4c_Botoes", "Container")
173:         WITH par_oPagina.cnt_4c_Botoes
174:             .Top         = 26
175:             .Left        = 542
176:             .Width       = 390
177:             .Height      = 85
178:             .BackStyle = 0
179:             .BorderWidth = 0
180:             .Visible     = .T.
181:         ENDWITH
182: 
183:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
184:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
185:             .Caption         = "Incluir"
186:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
187:             .PicturePosition = 13
188:             .Top             = 5
189:             .Left            = 5
190:             .Width           = 75
191:             .Height          = 75
192:             .BackColor       = RGB(255, 255, 255)
193:             .ForeColor       = RGB(90, 90, 90)
194:             .FontName        = "Tahoma"

*-- Linhas 202 a 216:
202:             .Visible         = .T.
203:         ENDWITH
204: 
205:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
206:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
207:             .Caption         = "Visualizar"
208:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
209:             .PicturePosition = 13
210:             .Top             = 5
211:             .Left            = 80
212:             .Width           = 75
213:             .Height          = 75
214:             .BackColor       = RGB(255, 255, 255)
215:             .ForeColor       = RGB(90, 90, 90)
216:             .FontName        = "Tahoma"

*-- Linhas 224 a 238:
224:             .Visible         = .T.
225:         ENDWITH
226: 
227:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
228:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
229:             .Caption         = "Alterar"
230:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
231:             .PicturePosition = 13
232:             .Top             = 5
233:             .Left            = 155
234:             .Width           = 75
235:             .Height          = 75
236:             .BackColor       = RGB(255, 255, 255)
237:             .ForeColor       = RGB(90, 90, 90)
238:             .FontName        = "Tahoma"

*-- Linhas 246 a 260:
246:             .Visible         = .T.
247:         ENDWITH
248: 
249:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
250:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
251:             .Caption         = "Excluir"
252:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253:             .PicturePosition = 13
254:             .Top             = 5
255:             .Left            = 230
256:             .Width           = 75
257:             .Height          = 75
258:             .BackColor       = RGB(255, 255, 255)
259:             .ForeColor       = RGB(90, 90, 90)
260:             .FontName        = "Tahoma"

*-- Linhas 268 a 282:
268:             .Visible         = .T.
269:         ENDWITH
270: 
271:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
272:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
273:             .Caption         = "Buscar"
274:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
275:             .PicturePosition = 13
276:             .Top             = 5
277:             .Left            = 305
278:             .Width           = 75
279:             .Height          = 75
280:             .BackColor       = RGB(255, 255, 255)
281:             .ForeColor       = RGB(90, 90, 90)
282:             .FontName        = "Tahoma"

*-- Linhas 293 a 316:
293:         *-- Container Saida - padrao canonico (prevalece sobre SCX legado)
294:         par_oPagina.AddObject("cnt_4c_Saida", "Container")
295:         WITH par_oPagina.cnt_4c_Saida
296:             .Top         = 29
297:             .Left        = 917
298:             .Width       = 90
299:             .Height      = 85
300:             .BackStyle   = 0
301:             .BorderWidth = 0
302:             .Visible     = .T.
303:         ENDWITH
304: 
305:         par_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
306:         WITH par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
307:             .Caption         = "Encerrar"
308:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
309:             .PicturePosition = 13
310:             .Top             = 5
311:             .Left            = 5
312:             .Width           = 75
313:             .Height          = 75
314:             .BackColor       = RGB(255, 255, 255)
315:             .ForeColor       = RGB(90, 90, 90)
316:             .FontName        = "Tahoma"

*-- Linhas 329 a 338:
329:         par_oPagina.grd_4c_Lista.RecordSource = ""
330:         par_oPagina.grd_4c_Lista.ColumnCount  = 8
331:         WITH par_oPagina.grd_4c_Lista
332:             .Top                = 115
333:             .Left               = 5
334:             .Width              = 990
335:             .Height             = 510
336:             .RecordMark         = .F.
337:             .DeleteMark         = .F.
338:             .GridLineColor      = RGB(238, 238, 238)

*-- Linhas 349 a 403:
349:             .Visible            = .T.
350:         ENDWITH
351:         WITH par_oPagina.grd_4c_Lista.Column1
352:             .Header1.Caption = "Empresa"
353:             .Width           = 50
354:             .Alignment       = 2
355:         ENDWITH
356:         WITH par_oPagina.grd_4c_Lista.Column2
357:             .Header1.Caption = "Grupo"
358:             .Width           = 90
359:             .Alignment       = 0
360:         ENDWITH
361:         WITH par_oPagina.grd_4c_Lista.Column3
362:             .Header1.Caption = "C" + CHR(243) + "digo"
363:             .Width           = 180
364:             .Alignment       = 0
365:         ENDWITH
366:         WITH par_oPagina.grd_4c_Lista.Column4
367:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
368:             .Width           = 290
369:             .Alignment       = 0
370:         ENDWITH
371:         WITH par_oPagina.grd_4c_Lista.Column5
372:             .Header1.Caption = "Prior."
373:             .Width           = 50
374:             .Alignment       = 2
375:         ENDWITH
376:         WITH par_oPagina.grd_4c_Lista.Column6
377:             .Header1.Caption = "Faixa De"
378:             .Width           = 100
379:             .Alignment       = 1
380:         ENDWITH
381:         WITH par_oPagina.grd_4c_Lista.Column7
382:             .Header1.Caption = "Faixa At" + CHR(233)
383:             .Width           = 100
384:             .Alignment       = 1
385:         ENDWITH
386:         WITH par_oPagina.grd_4c_Lista.Column8
387:             .Header1.Caption = "Selecio."
388:             .Width           = 120
389:             .Alignment       = 0
390:         ENDWITH
391: 
392:         *-- BINDEVENTs dos botoes CRUD (metodos PUBLIC - sem PROTECTED)
393:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
394:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
395:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
396:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
397:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
398:         BINDEVENT(par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
399: 
400:         THIS.TornarControlesVisiveis(par_oPagina)
401:     ENDPROC
402: 
403:     *==========================================================================

*-- Linhas 410 a 432:
410:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva: Left=841, Top=-3 -> +28=25)
411:         par_oPagina.AddObject("cnt_4c_Salva", "Container")
412:         WITH par_oPagina.cnt_4c_Salva
413:             .Top         = 25
414:             .Left        = 841
415:             .Width       = 165
416:             .Height      = 85
417:             .BackStyle   = 0
418:             .Visible     = .T.
419:         ENDWITH
420: 
421:         par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Salvar", "CommandButton")
422:         WITH par_oPagina.cnt_4c_Salva.cmd_4c_Salvar
423:             .Caption         = "Confirmar"
424:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
425:             .PicturePosition = 13
426:             .Top             = 5
427:             .Left            = 5
428:             .Width           = 75
429:             .Height          = 75
430:             .BackColor       = RGB(255, 255, 255)
431:             .ForeColor       = RGB(90, 90, 90)
432:             .FontName        = "Tahoma"

*-- Linhas 440 a 454:
440:             .Visible         = .T.
441:         ENDWITH
442: 
443:         par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
444:         WITH par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
445:             .Caption         = "Encerrar"
446:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
447:             .PicturePosition = 13
448:             .Top             = 5
449:             .Left            = 80
450:             .Width           = 75
451:             .Height          = 75
452:             .BackColor       = RGB(255, 255, 255)
453:             .ForeColor       = RGB(90, 90, 90)
454:             .FontName        = "Tahoma"

*-- Linhas 467 a 542:
467:         *-- Top original 49-53 -> +28 = 77-81
468:         *----------------------------------------------------------------------
469: 
470:         *-- lbl_4c_Codigo (Say2: Left=95, Top=53 -> +28=81)
471:         par_oPagina.AddObject("lbl_4c_Codigo", "Label")
472:         WITH par_oPagina.lbl_4c_Codigo
473:             .Caption   = "C" + CHR(243) + "digo :"
474:             .Left      = 95
475:             .Top       = 81
476:             .FontName  = "Tahoma"
477:             .FontSize  = 8
478:             .FontBold  = .F.
479:             .ForeColor = RGB(90, 90, 90)
480:             .BackStyle = 0
481:             .Visible   = .T.
482:         ENDWITH
483: 
484:         *-- txt_4c_Codigo (Get_codigo: Left=139, Top=49 -> +28=77, Width=80, codigos C80)
485:         par_oPagina.AddObject("txt_4c_Codigo", "TextBox")
486:         WITH par_oPagina.txt_4c_Codigo
487:             .Value         = ""
488:             .Left          = 139
489:             .Top           = 77
490:             .Width         = 80
491:             .Height        = 23
492:             .SpecialEffect = 1
493:             .FontName      = "Tahoma"
494:             .FontSize      = 8
495:             .ForeColor     = RGB(0, 0, 0)
496:             .BorderColor   = RGB(100, 100, 100)
497:             .MaxLength     = 80
498:             .Visible       = .T.
499:         ENDWITH
500: 
501:         *-- lbl_4c_Descricao (Say3: Left=270, Top=53 -> +28=81)
502:         par_oPagina.AddObject("lbl_4c_Descricao", "Label")
503:         WITH par_oPagina.lbl_4c_Descricao
504:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
505:             .Left      = 270
506:             .Top       = 81
507:             .FontName  = "Tahoma"
508:             .FontSize  = 8
509:             .FontBold  = .F.
510:             .ForeColor = RGB(90, 90, 90)
511:             .BackStyle = 0
512:             .Visible   = .T.
513:         ENDWITH
514: 
515:         *-- txt_4c_Descricao (Get_descricao: Left=327, Top=49 -> +28=77, Width=220, descs C220)
516:         par_oPagina.AddObject("txt_4c_Descricao", "TextBox")
517:         WITH par_oPagina.txt_4c_Descricao
518:             .Value         = ""
519:             .Left          = 327
520:             .Top           = 77
521:             .Width         = 220
522:             .Height        = 23
523:             .SpecialEffect = 1
524:             .FontName      = "Tahoma"
525:             .FontSize      = 8
526:             .ForeColor     = RGB(0, 0, 0)
527:             .BorderColor   = RGB(100, 100, 100)
528:             .MaxLength     = 220
529:             .Visible       = .T.
530:         ENDWITH
531: 
532:         *-- lbl_4c_ClcStatus (Say8: Left=573, Top=52 -> +28=80)
533:         par_oPagina.AddObject("lbl_4c_ClcStatus", "Label")
534:         WITH par_oPagina.lbl_4c_ClcStatus
535:             .Caption   = "Selecionavel nos Cadastros :"
536:             .Left      = 573
537:             .Top       = 80
538:             .FontName  = "Tahoma"
539:             .FontSize  = 8
540:             .FontBold  = .F.
541:             .ForeColor = RGB(90, 90, 90)
542:             .BackStyle = 0

*-- Linhas 548 a 581:
548:         par_oPagina.AddObject("opt_4c_ClcStatus", "OptionGroup")
549:         WITH par_oPagina.opt_4c_ClcStatus
550:             .ButtonCount = 2
551:             .Left        = 711
552:             .Top         = 75
553:             .Width       = 105
554:             .Height      = 26
555:             .BackStyle   = 0
556:             .BorderStyle = 0
557:             .Value       = 1
558:             .Visible     = .T.
559:         ENDWITH
560:         WITH par_oPagina.opt_4c_ClcStatus.Buttons(1)
561:             .Caption   = "Sim"
562:             .BackStyle = 0
563:             .Left      = 5
564:             .Top       = 5
565:             .Width     = 40
566:             .AutoSize  = .T.
567:             .ForeColor = RGB(90, 90, 90)
568:             .Themes    = .F.
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:         ENDWITH
572:         WITH par_oPagina.opt_4c_ClcStatus.Buttons(2)
573:             .Caption   = "N" + CHR(227) + "o"
574:             .BackStyle = 0
575:             .Left      = 51
576:             .Top       = 5
577:             .Width     = 44
578:             .AutoSize  = .T.
579:             .ForeColor = RGB(90, 90, 90)
580:             .Themes    = .F.
581:             .FontName  = "Tahoma"

*-- Linhas 587 a 600:
587:         *-- Top original 74-78 -> +28 = 102-106
588:         *----------------------------------------------------------------------
589: 
590:         *-- lbl_4c_Grupo (Say1: Left=99, Top=78 -> +28=106)
591:         par_oPagina.AddObject("lbl_4c_Grupo", "Label")
592:         WITH par_oPagina.lbl_4c_Grupo
593:             .Caption   = "Grupo :"
594:             .Left      = 99
595:             .Top       = 106
596:             .FontName  = "Tahoma"
597:             .FontSize  = 8
598:             .FontBold  = .F.
599:             .ForeColor = RGB(90, 90, 90)
600:             .BackStyle = 0

*-- Linhas 606 a 615:
606:         par_oPagina.AddObject("txt_4c_Grupo", "TextBox")
607:         WITH par_oPagina.txt_4c_Grupo
608:             .Value         = ""
609:             .Left          = 139
610:             .Top           = 102
611:             .Width         = 80
612:             .Height        = 23
613:             .SpecialEffect = 1
614:             .FontName      = "Tahoma"
615:             .FontSize      = 8

*-- Linhas 621 a 648:
621:         BINDEVENT(par_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "TxtGrupoKeyPress")
622:         BINDEVENT(par_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
623: 
624:         *-- lbl_4c_Priori (Say7: Left=268, Top=78 -> +28=106)
625:         par_oPagina.AddObject("lbl_4c_Priori", "Label")
626:         WITH par_oPagina.lbl_4c_Priori
627:             .Caption   = "Prioridade :"
628:             .Left      = 268
629:             .Top       = 106
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .FontBold  = .F.
633:             .ForeColor = RGB(90, 90, 90)
634:             .BackStyle = 0
635:             .Visible   = .T.
636:         ENDWITH
637: 
638:         *-- txt_4c_Priori (GetPriori: Left=327, Top=74 -> +28=102, Width=26, InputMask="99")
639:         par_oPagina.AddObject("txt_4c_Priori", "TextBox")
640:         WITH par_oPagina.txt_4c_Priori
641:             .Value         = 0
642:             .Left          = 327
643:             .Top           = 102
644:             .Width         = 26
645:             .Height        = 23
646:             .SpecialEffect = 1
647:             .FontName      = "Tahoma"
648:             .FontSize      = 8

*-- Linhas 658 a 685:
658:         *-- Top original 99-103 -> +28 = 127-131
659:         *----------------------------------------------------------------------
660: 
661:         *-- lbl_4c_Empresa (Say6: Left=87, Top=103 -> +28=131)
662:         par_oPagina.AddObject("lbl_4c_Empresa", "Label")
663:         WITH par_oPagina.lbl_4c_Empresa
664:             .Caption   = "Empresa :"
665:             .Left      = 87
666:             .Top       = 131
667:             .FontName  = "Tahoma"
668:             .FontSize  = 8
669:             .FontBold  = .F.
670:             .ForeColor = RGB(90, 90, 90)
671:             .BackStyle = 0
672:             .Visible   = .T.
673:         ENDWITH
674: 
675:         *-- txt_4c_Emps (GetEmps: Left=139, Top=99 -> +28=127, Width=34, H=23, C(3))
676:         par_oPagina.AddObject("txt_4c_Emps", "TextBox")
677:         WITH par_oPagina.txt_4c_Emps
678:             .Value         = ""
679:             .Left          = 139
680:             .Top           = 127
681:             .Width         = 34
682:             .Height        = 23
683:             .SpecialEffect = 1
684:             .FontName      = "Tahoma"
685:             .FontSize      = 8

*-- Linhas 691 a 749:
691:         BINDEVENT(par_oPagina.txt_4c_Emps, "KeyPress",  THIS, "TxtEmpsKeyPress")
692:         BINDEVENT(par_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmps")
693: 
694:         *-- lbl_4c_FaixaDe (Say4: Left=275, Top=103 -> +28=131)
695:         par_oPagina.AddObject("lbl_4c_FaixaDe", "Label")
696:         WITH par_oPagina.lbl_4c_FaixaDe
697:             .Caption   = "Faixa de :"
698:             .Left      = 275
699:             .Top       = 131
700:             .FontName  = "Tahoma"
701:             .FontSize  = 8
702:             .FontBold  = .F.
703:             .ForeColor = RGB(90, 90, 90)
704:             .BackStyle = 0
705:             .Visible   = .T.
706:         ENDWITH
707: 
708:         *-- txt_4c_FaixaI (Get_faixai: Left=327, Top=99 -> +28=127, Width=108, H=23)
709:         par_oPagina.AddObject("txt_4c_FaixaI", "TextBox")
710:         WITH par_oPagina.txt_4c_FaixaI
711:             .Value         = 0
712:             .Left          = 327
713:             .Top           = 127
714:             .Width         = 108
715:             .Height        = 23
716:             .SpecialEffect = 1
717:             .FontName      = "Tahoma"
718:             .FontSize      = 8
719:             .ForeColor     = RGB(0, 0, 0)
720:             .BorderColor   = RGB(100, 100, 100)
721:             .InputMask     = "9999999999.99"
722:             .Visible       = .T.
723:         ENDWITH
724: 
725:         *-- lbl_4c_FaixaAte (Say5: Left=439, Top=103 -> +28=131)
726:         par_oPagina.AddObject("lbl_4c_FaixaAte", "Label")
727:         WITH par_oPagina.lbl_4c_FaixaAte
728:             .Caption   = "at" + CHR(233) + " :"
729:             .Left      = 439
730:             .Top       = 131
731:             .FontName  = "Tahoma"
732:             .FontSize  = 8
733:             .FontBold  = .F.
734:             .ForeColor = RGB(90, 90, 90)
735:             .BackStyle = 0
736:             .Visible   = .T.
737:         ENDWITH
738: 
739:         *-- txt_4c_FaixaF (Get_faixaf: Left=461, Top=99 -> +28=127, Width=115, H=23)
740:         par_oPagina.AddObject("txt_4c_FaixaF", "TextBox")
741:         WITH par_oPagina.txt_4c_FaixaF
742:             .Value         = 0
743:             .Left          = 461
744:             .Top           = 127
745:             .Width         = 115
746:             .Height        = 23
747:             .SpecialEffect = 1
748:             .FontName      = "Tahoma"
749:             .FontSize      = 8

*-- Linhas 763 a 772:
763:             .ColumnCount       = 3
764:             .FontName          = "Tahoma"
765:             .FontSize          = 8
766:             .Left              = 98
767:             .Top               = 160
768:             .Width             = 706
769:             .Height            = 464
770:             .AllowHeaderSizing = .F.
771:             .AllowRowSizing    = .F.
772:             .DeleteMark        = .F.

*-- Linhas 789 a 797:
789:                 .FontName      = "Tahoma"
790:                 .FontSize      = 8
791:                 WITH .Header1
792:                     .Caption   = "Motivo"
793:                     .FontName  = "Tahoma"
794:                     .FontSize  = 8
795:                     .Alignment = 2
796:                 ENDWITH
797:                 WITH .Text1

*-- Linhas 817 a 825:
817:                 .FontName      = "Tahoma"
818:                 .FontSize      = 8
819:                 WITH .Header1
820:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
821:                     .FontName  = "Tahoma"
822:                     .FontSize  = 8
823:                     .Alignment = 2
824:                 ENDWITH
825:                 WITH .Text1

*-- Linhas 846 a 854:
846:                 .FontName      = "Tahoma"
847:                 .FontSize      = 8
848:                 WITH .Header1
849:                     .Caption   = "Tipo"
850:                     .FontName  = "Tahoma"
851:                     .FontSize  = 8
852:                     .Alignment = 2
853:                 ENDWITH
854:             ENDWITH

*-- Linhas 861 a 908:
861:             .BorderStyle = 0
862:             .AutoSize    = .F.
863:             .Value       = 1
864:             .Left        = 2
865:             .Top         = 2
866:             .Width       = 191
867:             .Height      = 16
868:             .BackStyle   = 0
869:         ENDWITH
870:         WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(1)
871:             .Caption  = "Inserir"
872:             .BackStyle = 0
873:             .Value    = 1
874:             .Left     = 5
875:             .Top      = 2
876:             .Width    = 48
877:             .Height   = 14
878:             .AutoSize = .T.
879:             .FontSize = 8
880:         ENDWITH
881:         WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(2)
882:             .Caption  = "Excluir"
883:             .BackStyle = 0
884:             .Left     = 60
885:             .Top      = 2
886:             .Width    = 50
887:             .Height   = 14
888:             .AutoSize = .T.
889:             .FontSize = 8
890:         ENDWITH
891:         WITH par_oPagina.grd_4c_Motivos.Column3.opt_4c_Tipos.Buttons(3)
892:             .Caption  = "Nenhum"
893:             .BackStyle = 0
894:             .Left     = 120
895:             .Top      = 2
896:             .Width    = 61
897:             .Height   = 15
898:             .FontSize = 8
899:         ENDWITH
900: 
901:         *-- BINDEVENTs dos botoes Confirmar/Cancelar
902:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
903:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
904: 
905:         THIS.TornarControlesVisiveis(par_oPagina)
906:     ENDPROC
907: 
908:     *==========================================================================

*-- Linhas 935 a 950:
935:                         loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
936:                         loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
937:                         *-- Redefinir headers apos RecordSource (VFP reseta automaticamente)
938:                         loc_oGrid.Column1.Header1.Caption   = "Empresa"
939:                         loc_oGrid.Column2.Header1.Caption   = "Grupo"
940:                         loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
941:                         loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
942:                         loc_oGrid.Column5.Header1.Caption   = "Prior."
943:                         loc_oGrid.Column6.Header1.Caption   = "Faixa De"
944:                         loc_oGrid.Column7.Header1.Caption   = "Faixa At" + CHR(233)
945:                         loc_oGrid.Column8.Header1.Caption   = "Selecio."
946:                         THIS.FormatarGridLista(loc_oGrid)
947:                     ENDIF
948:                 ENDIF
949:             ENDIF
950:         CATCH TO loException

*-- Linhas 1181 a 1196:
1181:                     loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.faixais"
1182:                     loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
1183:                     loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
1184:                     loc_oGrid.Column1.Header1.Caption   = "Empresa"
1185:                     loc_oGrid.Column2.Header1.Caption   = "Grupo"
1186:                     loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
1187:                     loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1188:                     loc_oGrid.Column5.Header1.Caption   = "Prior."
1189:                     loc_oGrid.Column6.Header1.Caption   = "Faixa De"
1190:                     loc_oGrid.Column7.Header1.Caption   = "Faixa At" + CHR(233)
1191:                     loc_oGrid.Column8.Header1.Caption   = "Selecio."
1192:                     THIS.FormatarGridLista(loc_oGrid)
1193:                 ENDIF
1194:             ENDIF
1195:         ENDIF
1196:     ENDPROC

*-- Linhas 1609 a 1621:
1609:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1610:             IF VARTYPE(loc_oPg2) = "O"
1611:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1612:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Salvar", 5)
1613:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Salvar.Enabled  = loc_lConfirmar
1614:                     ENDIF
1615:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1616:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1617:                     ENDIF
1618:                 ENDIF
1619:             ENDIF
1620:         CATCH TO loException
1621:             MsgErro("Erro em FormCco.AjustarBotoesPorModo: " + loException.Message, "Erro")


### BO (C:\4c\projeto\app\classes\CcoBO.prg):
*==============================================================================
* CcoBO.prg - Business Object para Classificacao de Contas (SigCdClc)
* Tabela principal : SigCdClc
* Tabela detalhe  : SigCdCmt (motivos/tipos da classificacao)
* Chave primaria  : cIdChaves (UUID gerado por fUniqueIds)
*==============================================================================
DEFINE CLASS CcoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdClc
    *--------------------------------------------------------------------------
    this_cIdChaves      = ""    && cIdChaves   C     - chave primaria (UUID)
    this_cEmps          = ""    && Emps        C(3)  - empresa
    this_cGrupos        = ""    && grupos      C(10) - grupo de conta corrente (FK SigCdGcr)
    this_cCodigos       = ""    && codigos     C(80) - codigo da classificacao
    this_cDescs         = ""    && descs       C(220)- descricao
    this_nPrioridades   = 0     && Prioridades N(2)  - prioridade
    this_nFaixaIs       = 0     && faixais     N(12,2) - faixa inicial
    this_nFaixaFs       = 0     && faixafs     N(12,2) - faixa final
    this_nClcStatus     = 1     && ClcStatus   N(1)  - 1=Sim (selecionavel), 2=Nao

    *--------------------------------------------------------------------------
    * Nomes dos cursores auxiliares
    *--------------------------------------------------------------------------
    this_cCursorMotivos = "crMotivos"    && cursor local de motivos (SigCdCmt + SigCdFs)
    this_cCursorGrupos  = "crSigCdGcr"  && cursor de grupos (SigCdGcr)

    *--------------------------------------------------------------------------
    * Contexto de filtragem (definido pelo Form conforme parametro pCli do legado)
    *--------------------------------------------------------------------------
    this_cGruposFiltro   = ""    && grupo padrao (de SigCdPam.GrPadClis)
    this_lClientesFiltro = .F.   && .T. = filtrar pelo grupo, .F. = excluir o grupo

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdClc"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro(loException.Message, "CcoBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor aberto
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves    = TratarNulo(cIdChaves,   "C")
                THIS.this_cEmps        = TratarNulo(Emps,        "C")
                THIS.this_cGrupos      = TratarNulo(grupos,      "C")
                THIS.this_cCodigos     = TratarNulo(codigos,     "C")
                THIS.this_cDescs       = TratarNulo(descs,       "C")
                THIS.this_nPrioridades = TratarNulo(Prioridades, "N")
                THIS.this_nFaixaIs     = TratarNulo(faixais,     "N")
                THIS.this_nFaixaFs     = TratarNulo(faixafs,     "N")
                THIS.this_nClcStatus   = TratarNulo(ClcStatus,   "N")
                IF THIS.this_nClcStatus = 0
                    THIS.this_nClcStatus = 1
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.CarregarDoCursor: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT de SigCdClc para o grid (cursor_4c_Dados)
    * Aplica filtro de grupo conforme this_cGruposFiltro / this_lClientesFiltro
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cGruposFiltro))
                IF THIS.this_lClientesFiltro
                    loc_cWhere = " WHERE grupos = " + EscaparSQL(THIS.this_cGruposFiltro)
                ELSE
                    loc_cWhere = " WHERE NOT grupos = " + EscaparSQL(THIS.this_cGruposFiltro)
                ENDIF
            ENDIF

            IF !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = " WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus" + ;
                       " FROM SigCdClc" + loc_cWhere + ;
                       " ORDER BY grupos, codigos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(245) + "es: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cIdChaves)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus" + ;
                       " FROM SigCdClc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarParametros - Carrega GrPadClis de SigCdPam
    * Popula this_cGruposFiltro
    *==========================================================================
    FUNCTION BuscarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrPadClis FROM SigCdPam"

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Pam") > 0
                SELECT cursor_4c_Pam
                THIS.this_cGruposFiltro = PADR(TratarNulo(GrPadClis, "C"), 10)
                loc_lSucesso = .T.
            ELSE
                THIS.this_cGruposFiltro = ""
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.BuscarParametros: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarGrupos - Carrega SigCdGcr para lookup (cursor crSigCdGcr)
    *==========================================================================
    FUNCTION BuscarGrupos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"

            IF USED("crSigCdGcr")
                USE IN crSigCdGcr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGcr")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.BuscarGrupos: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarMotivosClassif - Carrega motivos de uma classificacao (SigCdCmt + SigCdFs)
    * Popula cursor crMotivos (Codigos C10, Descrs C40, Tipos N1)
    * par_cIdChaves: cIdChaves da classificacao
    *==========================================================================
    FUNCTION CarregarMotivosClassif(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ClaMt")
                USE IN cursor_4c_ClaMt
            ENDIF

            loc_cSQL = "SELECT a.Codigos, b.Descrs, a.Tipos" + ;
                       " FROM SigCdCmt a, SigCdFs b" + ;
                       " WHERE a.fkChaves = " + EscaparSQL(par_cIdChaves) + ;
                       " AND a.Codigos = b.codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClaMt")
            IF loc_nResultado >= 0
                SELECT crMotivos
                ZAP IN crMotivos
                SELECT cursor_4c_ClaMt
                SCAN
                    INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                        VALUES (cursor_4c_ClaMt.Codigos, cursor_4c_ClaMt.Descrs, cursor_4c_ClaMt.Tipos)
                ENDSCAN
                IF USED("cursor_4c_ClaMt")
                    USE IN cursor_4c_ClaMt
                ENDIF
                GO TOP IN crMotivos
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_ClaMt")
                    USE IN cursor_4c_ClaMt
                ENDIF
                MsgErro("Erro ao carregar motivos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_ClaMt")
                USE IN cursor_4c_ClaMt
            ENDIF
            MsgErro("Erro em CcoBO.CarregarMotivosClassif: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CompletarMotivosFS - Adiciona ao cursor crMotivos os motivos de SigCdFs
    * ausentes (com Tipos=3, Nenhum). Usado em modo INSERIR/ALTERAR.
    *==========================================================================
    FUNCTION CompletarMotivosFS()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodigos
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_MdSc")
                USE IN cursor_4c_MdSc
            ENDIF

            loc_cSQL = "SELECT codigos, descrs FROM SigCdFs ORDER BY codigos"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MdSc")

            IF loc_nResultado >= 0
                SELECT cursor_4c_MdSc
                SCAN
                    loc_cCodigos = ALLTRIM(cursor_4c_MdSc.codigos)
                    IF !USED("crMotivos") OR EOF("crMotivos")
                        INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                            VALUES (loc_cCodigos, cursor_4c_MdSc.descrs, 3)
                    ELSE
                        SELECT crMotivos
                        GO TOP IN crMotivos
                        LOCATE FOR ALLTRIM(crMotivos.Codigos) = loc_cCodigos
                        IF EOF("crMotivos")
                            INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                                VALUES (loc_cCodigos, cursor_4c_MdSc.descrs, 3)
                        ENDIF
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_MdSc")
                    USE IN cursor_4c_MdSc
                ENDIF
                GO TOP IN crMotivos
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_MdSc")
                    USE IN cursor_4c_MdSc
                ENDIF
                MsgErro("Erro ao carregar motivos FS: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_MdSc")
                USE IN cursor_4c_MdSc
            ENDIF
            MsgErro("Erro em CcoBO.CompletarMotivosFS: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * VerificarDuplicidade - Verifica se grupo+codigos+emps ja existe em SigCdClc
    * Retorna .T. se JA EXISTE (duplicado), .F. se pode inserir
    *==========================================================================
    FUNCTION VerificarDuplicidade(par_cEmps, par_cGrupos, par_cCodigos, par_cIdChavesExcluir)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            IF VARTYPE(par_cIdChavesExcluir) != "C"
                par_cIdChavesExcluir = ""
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdClc" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " AND grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND codigos = " + EscaparSQL(par_cCodigos)

            IF !EMPTY(ALLTRIM(par_cIdChavesExcluir))
                loc_cSQL = loc_cSQL + " AND NOT cIdChaves = " + EscaparSQL(par_cIdChavesExcluir)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lExiste = (cursor_4c_Dup.qtd > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
            MsgErro("Erro em CcoBO.VerificarDuplicidade: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *==========================================================================
    * VerificarFaixaSobreposta - Verifica se faixa sobrepe outra existente
    * Retorna "" se OK, ou mensagem descricao do conflito
    *==========================================================================
    FUNCTION VerificarFaixaSobreposta(par_cEmps, par_cGrupos, par_nFaixaI, par_nFaixaF, par_cIdChavesExcluir)
        LOCAL loc_cSQL, loc_nResultado, loc_cMensagem
        loc_cMensagem = ""

        TRY
            IF VARTYPE(par_cIdChavesExcluir) != "C"
                par_cIdChavesExcluir = ""
            ENDIF

            loc_cSQL = "SELECT descs, faixais, faixafs FROM SigCdClc" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " AND grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND NOT cIdChaves = " + EscaparSQL(par_cIdChavesExcluir) + ;
                       " AND (" + ;
                       "   (" + FormatarNumeroSQL(par_nFaixaI) + " BETWEEN faixais AND faixafs)" + ;
                       "   OR (" + FormatarNumeroSQL(par_nFaixaF) + " BETWEEN faixais AND faixafs)" + ;
                       "   OR (faixais BETWEEN " + FormatarNumeroSQL(par_nFaixaI) + " AND " + FormatarNumeroSQL(par_nFaixaF) + ")" + ;
                       "   OR (faixafs BETWEEN " + FormatarNumeroSQL(par_nFaixaI) + " AND " + FormatarNumeroSQL(par_nFaixaF) + ")" + ;
                       ")"

            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Faixa")
            IF loc_nResultado >= 0 AND !EOF("cursor_4c_Faixa")
                SELECT cursor_4c_Faixa
                loc_cMensagem = "Faixa Cadastrada no C" + CHR(243) + "digo " + ;
                    ALLTRIM(cursor_4c_Faixa.descs) + CHR(13) + ;
                    "Valor : " + ALLTRIM(STR(cursor_4c_Faixa.faixais, 12, 2)) + ;
                    " " + CHR(224) + " " + ALLTRIM(STR(cursor_4c_Faixa.faixafs, 12, 2))
            ENDIF

            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF
            MsgErro("Erro em CcoBO.VerificarFaixaSobreposta: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_cMensagem
    ENDFUNC

    *==========================================================================
    * VerificarVinculoCli - Verifica se classificacao tem conta vinculada em SigCdCli
    * Retorna .T. se existir vinculo (bloqueio de exclusao)
    *==========================================================================
    FUNCTION VerificarVinculoCli(par_cGrupos, par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lTemVinculo
        loc_lTemVinculo = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCli" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND codigos = " + EscaparSQL(par_cCodigos)

            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VinCli")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VinCli") > 0
                SELECT cursor_4c_VinCli
                loc_lTemVinculo = (cursor_4c_VinCli.qtd > 0)
            ENDIF

            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF
            MsgErro("Erro em CcoBO.VerificarVinculoCli: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lTemVinculo
    ENDFUNC

    *==========================================================================
    * SalvarMotivos - Delete + Insert de SigCdCmt para a classificacao atual
    * par_cIdChaves: cIdChaves da classificacao
    * par_cCursorMotivos: nome do cursor com os motivos a salvar
    *   (colunas: Codigos C10, Descrs C40, Tipos N1 - tipos 1 e 2 sao salvos)
    *==========================================================================
    FUNCTION SalvarMotivos(par_cIdChaves, par_cCursorMotivos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cIdMot
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmt WHERE fkChaves = " + EscaparSQL(par_cIdChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir motivos antigos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorMotivos)
                    SELECT (par_cCursorMotivos)
                    GO TOP
                    SCAN
                        IF INLIST(Tipos, 1, 2)
                            loc_cIdMot = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdCmt (fkChaves, cIdChaves, Codigos, Tipos)" + ;
                                       " VALUES (" + EscaparSQL(par_cIdChaves) + ;
                                       ", " + EscaparSQL(loc_cIdMot) + ;
                                       ", " + EscaparSQL(ALLTRIM(Codigos)) + ;
                                       ", " + FormatarNumeroSQL(Tipos) + ")"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao gravar motivo: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                                EXIT
                            ENDIF
                        ENDIF
                    ENDSCAN
                    loc_lSucesso = .T.
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.SalvarMotivos: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT INTO SigCdClc (chamado pelo BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdClc" + ;
                       " (cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus)" + ;
                       " VALUES (" + EscaparSQL(THIS.this_cIdChaves) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cCodigos, 80)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cDescs, 220)) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nPrioridades) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nFaixaIs) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nFaixaFs) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nClcStatus) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE SigCdClc (chamado pelo BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdClc SET" + ;
                       " Emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ;
                       ", grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ;
                       ", codigos = " + EscaparSQL(LEFT(THIS.this_cCodigos, 80)) + ;
                       ", descs = " + EscaparSQL(LEFT(THIS.this_cDescs, 220)) + ;
                       ", Prioridades = " + FormatarNumeroSQL(THIS.this_nPrioridades) + ;
                       ", faixais = " + FormatarNumeroSQL(THIS.this_nFaixaIs) + ;
                       ", faixafs = " + FormatarNumeroSQL(THIS.this_nFaixaFs) + ;
                       ", ClcStatus = " + FormatarNumeroSQL(THIS.this_nClcStatus) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE SigCdClc + cascade SigCdCmt
    * (chamado pelo BusinessBase.Excluir via PublicExcluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmt WHERE fkChaves = " + EscaparSQL(THIS.this_cIdChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir motivos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigCdClc WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o: " + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

