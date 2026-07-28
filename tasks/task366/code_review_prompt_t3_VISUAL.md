# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (26)
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [LAYOUT-POSITION] Controle 'Combo2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=315 vs migrado 'cbo_4c_Combo2' Top=27 (diff=288px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Combo2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=380 vs migrado 'cbo_4c_Combo2' Left=642 (diff=262px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opc_situacao' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=243 vs migrado 'obj_4c_Opc_situacao' Left=0 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=368 vs migrado 'obj_4c_Fwoption1' Top=0 (diff=368px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=686 vs migrado 'obj_4c_Fwoption1' Left=0 (diff=686px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=399 vs migrado 'obj_4c_Fwoption2' Top=0 (diff=399px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=686 vs migrado 'obj_4c_Fwoption2' Left=0 (diff=686px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optAgrupas' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=79 vs migrado 'obj_4c_OptAgrupas' Top=0 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optAgrupas' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=638 vs migrado 'obj_4c_OptAgrupas' Left=0 (diff=638px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optZeradas' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=103 vs migrado 'obj_4c_OptZeradas' Top=0 (diff=103px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optZeradas' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=638 vs migrado 'obj_4c_OptZeradas' Left=0 (diff=638px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=127 vs migrado 'obj_4c_Fwoption1' Top=0 (diff=127px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=638 vs migrado 'obj_4c_Fwoption1' Left=0 (diff=638px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optutilvars' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=150 vs migrado 'obj_4c_Optutilvars' Top=0 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optutilvars' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=638 vs migrado 'obj_4c_Optutilvars' Left=0 (diff=638px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=233 vs migrado 'obj_4c_Fwoption2' Top=0 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption2' Left=0 (diff=231px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=253 vs migrado 'obj_4c_Fwoption3' Top=0 (diff=253px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption3' Left=0 (diff=231px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption4' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=272 vs migrado 'obj_4c_Fwoption4' Top=0 (diff=272px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption4' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption4' Left=0 (diff=231px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption5' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=292 vs migrado 'obj_4c_Fwoption5' Top=0 (diff=292px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption5' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption5' Left=0 (diff=231px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption6' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=312 vs migrado 'obj_4c_Fwoption6' Top=0 (diff=312px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption6' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption6' Left=0 (diff=231px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3911 linhas total):

*-- Linhas 50 a 61:
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52: 
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
59:                     THIS.CarregarLista()
60:                 ENDIF
61: 

*-- Linhas 77 a 93:
77:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
78:         WITH THIS.pgf_4c_Paginas
79:             .PageCount  = 2
80:             .Top        = -29
81:             .Left       = 0
82:             .Width      = THIS.Width
83:             .Height     = THIS.Height + 29
84:             .Tabs       = .F.
85:             .Visible    = .T.
86:             .Page1.Caption   = "Lista"
87:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
88:             .Page2.Caption   = "Dados"
89:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:             .Page1.BackColor = RGB(224, 223, 227)
91:             .Page2.BackColor = RGB(224, 223, 227)
92:         ENDWITH
93: 

*-- Linhas 107 a 144:
107:         *-- Container cabecalho cinza superior (cntSombra no legado)
108:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
109:         WITH loc_oPagina.cnt_4c_Cabecalho
110:             .Top         = 31
111:             .Left        = 0
112:             .Width       = THIS.Width
113:             .Height      = 80
114:             .BackColor   = RGB(100, 100, 100)
115:             .BorderWidth = 0
116:             .SpecialEffect = 0
117:             .Visible     = .T.
118: 
119:             .AddObject("lbl_4c_Sombra", "Label")
120:             WITH .lbl_4c_Sombra
121:                 .Caption   = "Cadastro de CFOP"
122:                 .Top       = 15
123:                 .Left      = 10
124:                 .Width     = THIS.Parent.Width - 20
125:                 .Height    = 40
126:                 .FontName  = "Tahoma"
127:                 .FontSize  = 16
128:                 .FontBold  = .T.
129:                 .ForeColor = RGB(0, 0, 0)
130:                 .BackStyle = 0
131:                 .AutoSize  = .F.
132:                 .Visible   = .T.
133:             ENDWITH
134: 
135:             .AddObject("lbl_4c_Titulo", "Label")
136:             WITH .lbl_4c_Titulo
137:                 .Caption   = "Cadastro de CFOP"
138:                 .Top       = 18
139:                 .Left      = 10
140:                 .Width     = THIS.Parent.Width - 20
141:                 .Height    = 46
142:                 .FontName  = "Tahoma"
143:                 .FontSize  = 16
144:                 .FontBold  = .T.

*-- Linhas 152 a 176:
152:         *-- Container botoes CRUD (Grupo_Op no legado)
153:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
154:         WITH loc_oPagina.cnt_4c_Botoes
155:             .Top         = 29
156:             .Left        = 542
157:             .Width       = 390
158:             .Height      = 85
159:             .BackStyle = 0
160:             .BorderWidth = 0
161:             .SpecialEffect = 0
162:             .Visible     = .T.
163:         ENDWITH
164: 
165:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
166:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
167:             .Caption         = "Incluir"
168:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
169:             .PicturePosition = 13
170:             .Top             = 5
171:             .Left            = 5
172:             .Width           = 75
173:             .Height          = 75
174:             .FontName        = "Tahoma"
175:             .FontBold        = .T.
176:             .FontItalic      = .T.

*-- Linhas 185 a 199:
185:             .Visible         = .T.
186:         ENDWITH
187: 
188:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
189:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
190:             .Caption         = "Visualizar"
191:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
192:             .PicturePosition = 13
193:             .Top             = 5
194:             .Left            = 80
195:             .Width           = 75
196:             .Height          = 75
197:             .FontName        = "Tahoma"
198:             .FontBold        = .T.
199:             .FontItalic      = .T.

*-- Linhas 208 a 222:
208:             .Visible         = .T.
209:         ENDWITH
210: 
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
213:             .Caption         = "Alterar"
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
215:             .PicturePosition = 13
216:             .Top             = 5
217:             .Left            = 155
218:             .Width           = 75
219:             .Height          = 75
220:             .FontName        = "Tahoma"
221:             .FontBold        = .T.
222:             .FontItalic      = .T.

*-- Linhas 231 a 245:
231:             .Visible         = .T.
232:         ENDWITH
233: 
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
236:             .Caption         = "Excluir"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 230
241:             .Width           = 75
242:             .Height          = 75
243:             .FontName        = "Tahoma"
244:             .FontBold        = .T.
245:             .FontItalic      = .T.

*-- Linhas 254 a 268:
254:             .Visible         = .T.
255:         ENDWITH
256: 
257:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
258:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
259:             .Caption         = "Buscar"
260:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
261:             .PicturePosition = 13
262:             .Top             = 5
263:             .Left            = 305
264:             .Width           = 75
265:             .Height          = 75
266:             .FontName        = "Tahoma"
267:             .FontBold        = .T.
268:             .FontItalic      = .T.

*-- Linhas 280 a 303:
280:         *-- Container saida - padrao canonico (Grupo_Saida no legado)
281:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
282:         WITH loc_oPagina.cnt_4c_Saida
283:             .Top         = 29
284:             .Left        = 917
285:             .Width       = 90
286:             .Height      = 85
287:             .BackStyle   = 0
288:             .BorderWidth = 0
289:             .SpecialEffect = 0
290:             .Visible     = .T.
291: 
292:             .AddObject("cmd_4c_Encerrar", "CommandButton")
293:             WITH .cmd_4c_Encerrar
294:                 .Caption         = "Encerrar"
295:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
296:                 .PicturePosition = 13
297:                 .Top             = 5
298:                 .Left            = 917
299:                 .Width           = 75
300:                 .Height          = 75
301:                 .FontName        = "Tahoma"
302:                 .FontBold        = .T.
303:                 .FontItalic      = .T.

*-- Linhas 313 a 325:
313:         ENDWITH
314: 
315:         *-- Botoes Exporta/Importa XML (legado: btnExpXML/btnImpXML top=82+29=111)
316:         loc_oPagina.AddObject("cmd_4c_ExpXML", "CommandButton")
317:         WITH loc_oPagina.cmd_4c_ExpXML
318:             .Caption       = "Exporta XML"
319:             .Top           = 111
320:             .Left          = 681
321:             .Width         = 120
322:             .Height        = 40
323:             .FontName      = "Tahoma"
324:             .FontBold      = .F.
325:             .FontSize      = 8

*-- Linhas 332 a 344:
332:             .Visible       = .T.
333:         ENDWITH
334: 
335:         loc_oPagina.AddObject("cmd_4c_ImpXML", "CommandButton")
336:         WITH loc_oPagina.cmd_4c_ImpXML
337:             .Caption       = "Importa XML"
338:             .Top           = 111
339:             .Left          = 801
340:             .Width         = 120
341:             .Height        = 40
342:             .FontName      = "Tahoma"
343:             .FontBold      = .F.
344:             .FontSize      = 8

*-- Linhas 354 a 363:
354:         *-- Grid de lista (Grade no legado) - top=127+29=156 com compensacao PageFrame
355:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
356:         WITH loc_oPagina.grd_4c_Lista
357:             .Top                = 156
358:             .Left               = 11
359:             .Width              = 972
360:             .Height             = 520
361:             .FontName           = "Verdana"
362:             .FontSize           = 8
363:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 377 a 392:
377:         ENDWITH
378: 
379:         *-- BINDEVENTs para botoes CRUD e auxiliares
380:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
381:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
382:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
383:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
384:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,    "Click", THIS, "BtnBuscarClick")
385:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
386:         BINDEVENT(loc_oPagina.cmd_4c_ExpXML,                   "Click", THIS, "BtnExpXMLClick")
387:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML,                   "Click", THIS, "BtnImpXMLClick")
388: 
389:         THIS.TornarControlesVisiveis(loc_oPagina)
390:     ENDPROC
391: 
392:     *==========================================================================

*-- Linhas 401 a 438:
401:         *-- Cabecalho cinza (identico ao da Page1 Lista)
402:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
403:         WITH loc_oPagina.cnt_4c_Cabecalho
404:             .Top           = 29
405:             .Left          = 0
406:             .Width         = THIS.Width
407:             .Height        = 80
408:             .BackColor     = RGB(100, 100, 100)
409:             .BorderWidth   = 0
410:             .SpecialEffect = 0
411:             .Visible       = .T.
412: 
413:             .AddObject("lbl_4c_Sombra", "Label")
414:             WITH .lbl_4c_Sombra
415:                 .Caption   = "Cadastro de CFOP"
416:                 .Top       = 15
417:                 .Left      = 10
418:                 .Width     = THIS.Parent.Width - 20
419:                 .Height    = 40
420:                 .FontName  = "Tahoma"
421:                 .FontSize  = 16
422:                 .FontBold  = .T.
423:                 .ForeColor = RGB(0, 0, 0)
424:                 .BackStyle = 0
425:                 .AutoSize  = .F.
426:                 .Visible   = .T.
427:             ENDWITH
428: 
429:             .AddObject("lbl_4c_Titulo", "Label")
430:             WITH .lbl_4c_Titulo
431:                 .Caption   = "Cadastro de CFOP"
432:                 .Top       = 18
433:                 .Left      = 10
434:                 .Width     = THIS.Parent.Width - 20
435:                 .Height    = 46
436:                 .FontName  = "Tahoma"
437:                 .FontSize  = 16
438:                 .FontBold  = .T.

*-- Linhas 446 a 515:
446:         *-- Container salvar/cancelar (botoes adicionados na Fase 6)
447:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
448:         WITH loc_oPagina.cnt_4c_Salva
449:             .Top           = 33
450:             .Left          = 842
451:             .Width         = 160
452:             .Height        = 85
453:             .BackStyle     = 0
454:             .BorderWidth   = 0
455:             .SpecialEffect = 0
456:             .Visible       = .T.
457:         ENDWITH
458: 
459:         *-- Botao Salvar
460:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Salvar", "CommandButton")
461:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Salvar
462:             .Caption         = "Salvar"
463:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
464:             .PicturePosition = 13
465:             .Width           = 75
466:             .Height          = 75
467:             .Left            = 5
468:             .Top             = 5
469:             .FontName        = "Tahoma"
470:             .FontSize        = 8
471:             .Themes          = .F.
472:             .SpecialEffect   = 0
473:             .BackColor       = RGB(255, 255, 255)
474:             .ForeColor       = RGB(90, 90, 90)
475:             .Visible         = .T.
476:         ENDWITH
477:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
478: 
479:         *-- Botao Cancelar / Encerrar edicao
480:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
481:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
482:             .Caption         = "Encerrar"
483:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
484:             .PicturePosition = 13
485:             .Width           = 75
486:             .Height          = 75
487:             .Left            = 83
488:             .Top             = 5
489:             .FontName        = "Tahoma"
490:             .FontSize        = 8
491:             .Themes          = .F.
492:             .SpecialEffect   = 0
493:             .BackColor       = RGB(255, 255, 255)
494:             .ForeColor       = RGB(90, 90, 90)
495:             .Visible         = .T.
496:         ENDWITH
497:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
498: 
499:         *-- PageFrame interno (PagDados no legado) - top=120+29=149
500:         loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
501:         WITH loc_oPagina.pgf_4c_PagDados
502:             .PageCount       = 2
503:             .Top             = 149
504:             .Left            = -1
505:             .Width           = 998
506:             .Height          = 730
507:             .Tabs            = .T.
508:             .Visible         = .T.
509:             .Page1.Caption   = "Dados CFOP"
510:             .Page2.Caption   = "Contabilidade"
511:             .Page1.BackColor = RGB(224, 223, 227)
512:             .Page2.BackColor = RGB(224, 223, 227)
513:         ENDWITH
514: 
515:         THIS.ConfigurarPgPage1()

*-- Linhas 530 a 1695:
530:         *-- Separadores horizontais
531:         loc_oPage1.AddObject("shp_4c_Shp01", "Shape")
532:         WITH loc_oPage1.shp_4c_Shp01
533:             .Top         = 92
534:             .Left        = 3
535:             .Width       = 984
536:             .Height      = 1
537:             .BackColor   = RGB(128, 128, 128)
538:             .BorderColor = RGB(128, 128, 128)
539:             .Visible     = .T.
540:         ENDWITH
541: 
542:         loc_oPage1.AddObject("shp_4c_Shp03", "Shape")
543:         WITH loc_oPage1.shp_4c_Shp03
544:             .Top         = 236
545:             .Left        = 3
546:             .Width       = 984
547:             .Height      = 1
548:             .BackColor   = RGB(128, 128, 128)
549:             .BorderColor = RGB(128, 128, 128)
550:             .Visible     = .T.
551:         ENDWITH
552: 
553:         *-- Separador vertical NF-e
554:         loc_oPage1.AddObject("shp_4c_Shape1", "Shape")
555:         WITH loc_oPage1.shp_4c_Shape1
556:             .Top         = 243
557:             .Left        = 488
558:             .Width       = 1
559:             .Height      = 206
560:             .BackColor   = RGB(128, 128, 128)
561:             .BorderColor = RGB(128, 128, 128)
562:             .Visible     = .T.
563:         ENDWITH
564: 
565:         *-- Label: Codigo
566:         loc_oPage1.AddObject("lbl_4c_Label1", "Label")
567:         WITH loc_oPage1.lbl_4c_Label1
568:             .Caption   = "C" + CHR(243) + "digo :"
569:             .Top       = 11
570:             .Left      = 90
571:             .Width     = 42
572:             .Height    = 15
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8
575:             .BackStyle = 0
576:             .Visible   = .T.
577:         ENDWITH
578: 
579:         *-- txt_4c_Codigo (getCodigo) - codigos char(10)
580:         loc_oPage1.AddObject("txt_4c_Codigo", "TextBox")
581:         WITH loc_oPage1.txt_4c_Codigo
582:             .Top       = 7
583:             .Left      = 136
584:             .Width     = 91
585:             .Height    = 24
586:             .MaxLength = 10
587:             .Value     = ""
588:             .FontName  = "Tahoma"
589:             .FontSize  = 8
590:             .Visible   = .T.
591:         ENDWITH
592: 
593:         *-- opc_situacao - situas (0=Ativo 1=Inativo)
594:         loc_oPage1.AddObject("obj_4c_Opc_situacao", "OptionGroup")
595:         WITH loc_oPage1.obj_4c_Opc_situacao
596:             .Top         = 11
597:             .Left        = 243
598:             .Width       = 137
599:             .Height      = 17
600:             .ButtonCount = 2
601:             .BackStyle   = 0
602:             .Value       = 1
603:             .Visible     = .T.
604: 
605:             WITH .Buttons(1)
606:                 .Caption   = "Ativo"
607:                 .Width     = 65
608:                 .Height    = 17
609:                 .Left      = 0
610:                 .Top       = 0
611:                 .BackStyle = 0
612:                 .Visible   = .T.
613:             ENDWITH
614: 
615:             WITH .Buttons(2)
616:                 .Caption   = "Inativo"
617:                 .Width     = 65
618:                 .Height    = 17
619:                 .Left      = 67
620:                 .Top       = 0
621:                 .BackStyle = 0
622:                 .FontName  = "Tahoma"
623:                 .FontSize  = 8
624:                 .Visible   = .T.
625:             ENDWITH
626:         ENDWITH
627: 
628:         *-- Label: Operacao
629:         loc_oPage1.AddObject("lbl_4c_Label3", "Label")
630:         WITH loc_oPage1.lbl_4c_Label3
631:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
632:             .Top       = 11
633:             .Left      = 393
634:             .Width     = 56
635:             .Height    = 15
636:             .FontName  = "Tahoma"
637:             .FontSize  = 8
638:             .BackStyle = 0
639:             .Visible   = .T.
640:         ENDWITH
641: 
642:         *-- cmbOperacao - operacaos char(1) E/S
643:         loc_oPage1.AddObject("cbo_4c_CmbOperacao", "ComboBox")
644:         WITH loc_oPage1.cbo_4c_CmbOperacao
645:             .Top           = 7
646:             .Left          = 459
647:             .Width         = 107
648:             .Height        = 24
649:             .RowSourceType = 1
650:             .RowSource     = "E,S"
651:             .Style         = 2
652:             .Value         = "E"
653:             .FontName      = "Tahoma"
654:             .FontSize      = 8
655:             .Visible       = .T.
656:         ENDWITH
657: 
658:         *-- Label: Tipo
659:         loc_oPage1.AddObject("lbl_4c_Label37", "Label")
660:         WITH loc_oPage1.lbl_4c_Label37
661:             .Caption   = "Tipo :"
662:             .Top       = 11
663:             .Left      = 620
664:             .Width     = 29
665:             .Height    = 15
666:             .FontName  = "Tahoma"
667:             .FontSize  = 8
668:             .BackStyle = 0
669:             .Visible   = .T.
670:         ENDWITH
671: 
672:         *-- cmbtipo - tipos numeric(1,0)
673:         loc_oPage1.AddObject("cbo_4c_Cmbtipo", "ComboBox")
674:         WITH loc_oPage1.cbo_4c_Cmbtipo
675:             .Top           = 7
676:             .Left          = 653
677:             .Width         = 151
678:             .Height        = 24
679:             .RowSourceType = 1
680:             .RowSource     = "0,1,2,3,4,5,6,7,8,9"
681:             .Style         = 2
682:             .Value         = "0"
683:             .FontName      = "Tahoma"
684:             .FontSize      = 8
685:             .Visible       = .T.
686:         ENDWITH
687: 
688:         *-- Label: Digitos Para NF
689:         loc_oPage1.AddObject("lbl_4c_Label24", "Label")
690:         WITH loc_oPage1.lbl_4c_Label24
691:             .Caption   = "D" + CHR(237) + "gitos Para NF :"
692:             .Top       = 12
693:             .Left      = 861
694:             .Width     = 82
695:             .Height    = 15
696:             .FontName  = "Tahoma"
697:             .FontSize  = 8
698:             .BackStyle = 0
699:             .Visible   = .T.
700:         ENDWITH
701: 
702:         *-- spn_4c_Ndigito - ndigitos numeric(2,0)
703:         loc_oPage1.AddObject("spn_4c_Ndigito", "Spinner")
704:         WITH loc_oPage1.spn_4c_Ndigito
705:             .Top              = 7
706:             .Left             = 947
707:             .Width            = 40
708:             .Height           = 24
709:             .SpinnerLowValue  = 0
710:             .SpinnerHighValue = 99
711:             .Value            = 0
712:             .FontName         = "Tahoma"
713:             .FontSize         = 8
714:             .Visible          = .T.
715:         ENDWITH
716: 
717:         *-- Label: Descricao Nota Fiscal
718:         loc_oPage1.AddObject("lbl_4c_Label2", "Label")
719:         WITH loc_oPage1.lbl_4c_Label2
720:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Nota Fiscal :"
721:             .Top       = 38
722:             .Left      = 22
723:             .Width     = 110
724:             .Height    = 15
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .BackStyle = 0
728:             .Visible   = .T.
729:         ENDWITH
730: 
731:         *-- txt_4c_Descricao - descricaos char(60)
732:         loc_oPage1.AddObject("txt_4c_Descricao", "TextBox")
733:         WITH loc_oPage1.txt_4c_Descricao
734:             .Top       = 34
735:             .Left      = 136
736:             .Width     = 430
737:             .Height    = 24
738:             .MaxLength = 60
739:             .Value     = ""
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .Visible   = .T.
743:         ENDWITH
744: 
745:         *-- Label: Descricao Consulta
746:         loc_oPage1.AddObject("lbl_4c_Label29", "Label")
747:         WITH loc_oPage1.lbl_4c_Label29
748:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Consulta :"
749:             .Top       = 65
750:             .Left      = 32
751:             .Width     = 100
752:             .Height    = 15
753:             .FontName  = "Tahoma"
754:             .FontSize  = 8
755:             .BackStyle = 0
756:             .Visible   = .T.
757:         ENDWITH
758: 
759:         *-- txt_4c_Desc2s - desc2s char(60)
760:         loc_oPage1.AddObject("txt_4c_Desc2s", "TextBox")
761:         WITH loc_oPage1.txt_4c_Desc2s
762:             .Top       = 61
763:             .Left      = 136
764:             .Width     = 430
765:             .Height    = 24
766:             .MaxLength = 60
767:             .Value     = ""
768:             .FontName  = "Tahoma"
769:             .FontSize  = 8
770:             .Visible   = .T.
771:         ENDWITH
772: 
773:         *-- === SECAO ICMS ===
774: 
775:         *-- Label: ICMS
776:         loc_oPage1.AddObject("lbl_4c_Label4", "Label")
777:         WITH loc_oPage1.lbl_4c_Label4
778:             .Caption   = "I C M S :"
779:             .Top       = 105
780:             .Left      = 88
781:             .Width     = 43
782:             .Height    = 15
783:             .FontName  = "Tahoma"
784:             .FontSize  = 8
785:             .BackStyle = 0
786:             .Visible   = .T.
787:         ENDWITH
788: 
789:         *-- cmbIcms - icms char(1) T/I/O/N
790:         loc_oPage1.AddObject("cbo_4c_CmbIcms", "ComboBox")
791:         WITH loc_oPage1.cbo_4c_CmbIcms
792:             .Top           = 101
793:             .Left          = 136
794:             .Width         = 82
795:             .Height        = 23
796:             .RowSourceType = 1
797:             .RowSource     = "T,I,O,N"
798:             .Style         = 2
799:             .Value         = "T"
800:             .FontName      = "Tahoma"
801:             .FontSize      = 8
802:             .Visible       = .T.
803:         ENDWITH
804: 
805:         *-- Label: Sobre Desconto (icmsincs)
806:         loc_oPage1.AddObject("lbl_4c_Label31", "Label")
807:         WITH loc_oPage1.lbl_4c_Label31
808:             .Caption   = "Sobre Desconto :"
809:             .Top       = 131
810:             .Left      = 46
811:             .Width     = 85
812:             .Height    = 15
813:             .FontName  = "Tahoma"
814:             .FontSize  = 8
815:             .BackStyle = 0
816:             .Visible   = .T.
817:         ENDWITH
818: 
819:         *-- Combo6 - icmsincs numeric(1,0)
820:         loc_oPage1.AddObject("cbo_4c_Combo6", "ComboBox")
821:         WITH loc_oPage1.cbo_4c_Combo6
822:             .Top           = 127
823:             .Left          = 136
824:             .Width         = 82
825:             .Height        = 23
826:             .RowSourceType = 1
827:             .RowSource     = "0,1"
828:             .Style         = 2
829:             .Value         = "0"
830:             .FontName      = "Tahoma"
831:             .FontSize      = 8
832:             .Visible       = .T.
833:         ENDWITH
834: 
835:         *-- Label: Incluir ICMS
836:         loc_oPage1.AddObject("lbl_4c_Label26", "Label")
837:         WITH loc_oPage1.lbl_4c_Label26
838:             .Caption   = "Incluir ICMS :"
839:             .Top       = 105
840:             .Left      = 309
841:             .Width     = 66
842:             .Height    = 15
843:             .FontName  = "Tahoma"
844:             .FontSize  = 8
845:             .BackStyle = 0
846:             .Visible   = .T.
847:         ENDWITH
848: 
849:         *-- Combo3 - inclicms numeric(1,0)
850:         loc_oPage1.AddObject("cbo_4c_Combo3", "ComboBox")
851:         WITH loc_oPage1.cbo_4c_Combo3
852:             .Top           = 101
853:             .Left          = 380
854:             .Width         = 82
855:             .Height        = 23
856:             .RowSourceType = 1
857:             .RowSource     = "0,1"
858:             .Style         = 2
859:             .Value         = "0"
860:             .FontName      = "Tahoma"
861:             .FontSize      = 8
862:             .Visible       = .T.
863:         ENDWITH
864: 
865:         *-- Label: Inclui IPI na Base
866:         loc_oPage1.AddObject("lbl_4c_Label25", "Label")
867:         WITH loc_oPage1.lbl_4c_Label25
868:             .Caption   = "Inclui IPI na Base :"
869:             .Top       = 131
870:             .Left      = 283
871:             .Width     = 92
872:             .Height    = 15
873:             .FontName  = "Tahoma"
874:             .FontSize  = 8
875:             .BackStyle = 0
876:             .Visible   = .T.
877:         ENDWITH
878: 
879:         *-- Combo4 - inclipis numeric(1,0)
880:         loc_oPage1.AddObject("cbo_4c_Combo4", "ComboBox")
881:         WITH loc_oPage1.cbo_4c_Combo4
882:             .Top           = 127
883:             .Left          = 380
884:             .Width         = 82
885:             .Height        = 23
886:             .RowSourceType = 1
887:             .RowSource     = "0,1"
888:             .Style         = 2
889:             .Value         = "0"
890:             .FontName      = "Tahoma"
891:             .FontSize      = 8
892:             .Visible       = .T.
893:         ENDWITH
894: 
895:         *-- Label: ICMS Sobre
896:         loc_oPage1.AddObject("lbl_4c_Label14", "Label")
897:         WITH loc_oPage1.lbl_4c_Label14
898:             .Caption   = "ICMS Sobre :"
899:             .Top       = 104
900:             .Left      = 481
901:             .Width     = 65
902:             .Height    = 15
903:             .FontName  = "Tahoma"
904:             .FontSize  = 8
905:             .BackStyle = 0
906:             .Visible   = .T.
907:         ENDWITH
908: 
909:         *-- chk_4c_ObjFreteICM - frticms numeric(1,0)
910:         loc_oPage1.AddObject("chk_4c_ObjFreteICM", "CheckBox")
911:         WITH loc_oPage1.chk_4c_ObjFreteICM
912:             .Caption   = "Frete"
913:             .Top       = 102
914:             .Left      = 549
915:             .Width     = 44
916:             .Height    = 15
917:             .FontName  = "Tahoma"
918:             .FontSize  = 8
919:             .BackStyle = 0
920:             .Value     = 0
921:             .Visible   = .T.
922:         ENDWITH
923: 
924:         *-- chk_4c_ObjSegIcm - segicms numeric(1,0)
925:         loc_oPage1.AddObject("chk_4c_ObjSegIcm", "CheckBox")
926:         WITH loc_oPage1.chk_4c_ObjSegIcm
927:             .Caption   = "Seguro"
928:             .Top       = 117
929:             .Left      = 549
930:             .Width     = 52
931:             .Height    = 15
932:             .FontName  = "Tahoma"
933:             .FontSize  = 8
934:             .BackStyle = 0
935:             .Value     = 0
936:             .Visible   = .T.
937:         ENDWITH
938: 
939:         *-- chk_4c_ObjDespIcm - desicms numeric(1,0)
940:         loc_oPage1.AddObject("chk_4c_ObjDespIcm", "CheckBox")
941:         WITH loc_oPage1.chk_4c_ObjDespIcm
942:             .Caption   = "Despesas Acess" + CHR(243) + "rias"
943:             .Top       = 132
944:             .Left      = 549
945:             .Width     = 118
946:             .Height    = 15
947:             .FontName  = "Tahoma"
948:             .FontSize  = 8
949:             .BackStyle = 0
950:             .Value     = 0
951:             .Visible   = .T.
952:         ENDWITH
953: 
954:         *-- chk_4c_Fwcheckbox1 - incicmnfs numeric(1,0)
955:         loc_oPage1.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
956:         WITH loc_oPage1.chk_4c_Fwcheckbox1
957:             .Caption   = "Incluir ICMS no Total da N.F."
958:             .Top       = 147
959:             .Left      = 549
960:             .Width     = 156
961:             .Height    = 15
962:             .FontName  = "Tahoma"
963:             .FontSize  = 8
964:             .BackStyle = 0
965:             .Value     = 0
966:             .Visible   = .T.
967:         ENDWITH
968: 
969:         *-- Label: CFOP ST60
970:         loc_oPage1.AddObject("lbl_4c_Label49", "Label")
971:         WITH loc_oPage1.lbl_4c_Label49
972:             .Caption   = "CFOP ST60:"
973:             .Top       = 104
974:             .Left      = 627
975:             .Width     = 60
976:             .Height    = 15
977:             .FontName  = "Tahoma"
978:             .FontSize  = 8
979:             .BackStyle = 0
980:             .Visible   = .T.
981:         ENDWITH
982: 
983:         *-- txt_4c_CfoST60 - cfost60s char(10)
984:         loc_oPage1.AddObject("txt_4c_CfoST60", "TextBox")
985:         WITH loc_oPage1.txt_4c_CfoST60
986:             .Top       = 101
987:             .Left      = 690
988:             .Width     = 82
989:             .Height    = 23
990:             .MaxLength = 10
991:             .Value     = ""
992:             .FontName  = "Tahoma"
993:             .FontSize  = 8
994:             .Visible   = .T.
995:         ENDWITH
996: 
997:         *-- Label: CFOP Subst.Trib.
998:         loc_oPage1.AddObject("lbl_4c_Label11", "Label")
999:         WITH loc_oPage1.lbl_4c_Label11
1000:             .Caption   = "CFOP Subst.Trib.:"
1001:             .Top       = 103
1002:             .Left      = 794
1003:             .Width     = 89
1004:             .Height    = 15
1005:             .FontName  = "Tahoma"
1006:             .FontSize  = 8
1007:             .BackStyle = 0
1008:             .Visible   = .T.
1009:         ENDWITH
1010: 
1011:         *-- txt_4c_CfoST - cfosts char(10)
1012:         loc_oPage1.AddObject("txt_4c_CfoST", "TextBox")
1013:         WITH loc_oPage1.txt_4c_CfoST
1014:             .Top       = 101
1015:             .Left      = 887
1016:             .Width     = 82
1017:             .Height    = 23
1018:             .MaxLength = 10
1019:             .Value     = ""
1020:             .FontName  = "Tahoma"
1021:             .FontSize  = 8
1022:             .Visible   = .T.
1023:         ENDWITH
1024: 
1025:         *-- Label: Substituicao Tributaria
1026:         loc_oPage1.AddObject("lbl_4c_Label10", "Label")
1027:         WITH loc_oPage1.lbl_4c_Label10
1028:             .Caption   = "Substitui" + CHR(231) + CHR(227) + "o Tribut.:"
1029:             .Top       = 157
1030:             .Left      = 32
1031:             .Width     = 99
1032:             .Height    = 15
1033:             .FontName  = "Tahoma"
1034:             .FontSize  = 8
1035:             .BackStyle = 0
1036:             .Visible   = .T.
1037:         ENDWITH
1038: 
1039:         *-- CmbSTRIB - subtribs char(1) S/N
1040:         loc_oPage1.AddObject("cbo_4c_CmbSTRIB", "ComboBox")
1041:         WITH loc_oPage1.cbo_4c_CmbSTRIB
1042:             .Top           = 153
1043:             .Left          = 136
1044:             .Width         = 82
1045:             .Height        = 23
1046:             .RowSourceType = 1
1047:             .RowSource     = "S,N"
1048:             .Style         = 2
1049:             .Value         = "N"
1050:             .FontName      = "Tahoma"
1051:             .FontSize      = 8
1052:             .Visible       = .T.
1053:         ENDWITH
1054: 
1055:         *-- Label: Base Substituicao
1056:         loc_oPage1.AddObject("lbl_4c_Label12", "Label")
1057:         WITH loc_oPage1.lbl_4c_Label12
1058:             .Caption   = "Base Substitui" + CHR(231) + CHR(227) + "o :"
1059:             .Top       = 157
1060:             .Left      = 282
1061:             .Width     = 93
1062:             .Height    = 15
1063:             .FontName  = "Tahoma"
1064:             .FontSize  = 8
1065:             .BackStyle = 0
1066:             .Visible   = .T.
1067:         ENDWITH
1068: 
1069:         *-- txt_4c_Bcst - pbcsts numeric(5,2)
1070:         loc_oPage1.AddObject("txt_4c_Bcst", "TextBox")
1071:         WITH loc_oPage1.txt_4c_Bcst
1072:             .Top       = 153
1073:             .Left      = 380
1074:             .Width     = 82
1075:             .Height    = 23
1076:             .Value     = 0
1077:             .Format    = "N"
1078:             .InputMask = "999.99"
1079:             .FontName  = "Tahoma"
1080:             .FontSize  = 8
1081:             .Visible   = .T.
1082:         ENDWITH
1083: 
1084:         *-- Label: CFOP Transporte
1085:         loc_oPage1.AddObject("lbl_4c_Label28", "Label")
1086:         WITH loc_oPage1.lbl_4c_Label28
1087:             .Caption   = "CFOP Transporte :"
1088:             .Top       = 158
1089:             .Left      = 791
1090:             .Width     = 92
1091:             .Height    = 15
1092:             .FontName  = "Tahoma"
1093:             .FontSize  = 8
1094:             .BackStyle = 0
1095:             .Visible   = .T.
1096:         ENDWITH
1097: 
1098:         *-- Combo5 - transps numeric(1,0)
1099:         loc_oPage1.AddObject("cbo_4c_Combo5", "ComboBox")
1100:         WITH loc_oPage1.cbo_4c_Combo5
1101:             .Top           = 153
1102:             .Left          = 887
1103:             .Width         = 82
1104:             .Height        = 23
1105:             .RowSourceType = 1
1106:             .RowSource     = "0,1"
1107:             .Style         = 2
1108:             .Value         = "0"
1109:             .FontName      = "Tahoma"
1110:             .FontSize      = 8
1111:             .Visible       = .T.
1112:         ENDWITH
1113: 
1114:         *-- Label: Situacao Tributaria
1115:         loc_oPage1.AddObject("lbl_4c_Label22", "Label")
1116:         WITH loc_oPage1.lbl_4c_Label22
1117:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut.:"
1118:             .Top       = 183
1119:             .Left      = 49
1120:             .Width     = 82
1121:             .Height    = 15
1122:             .FontName  = "Tahoma"
1123:             .FontSize  = 8
1124:             .BackStyle = 0
1125:             .Visible   = .T.
1126:         ENDWITH
1127: 
1128:         *-- txt_4c_Sittricm - sittribs char(3)
1129:         loc_oPage1.AddObject("txt_4c_Sittricm", "TextBox")
1130:         WITH loc_oPage1.txt_4c_Sittricm
1131:             .Top       = 179
1132:             .Left      = 136
1133:             .Width     = 31
1134:             .Height    = 22
1135:             .MaxLength = 3
1136:             .Value     = ""
1137:             .FontName  = "Tahoma"
1138:             .FontSize  = 8
1139:             .Visible   = .T.
1140:         ENDWITH
1141: 
1142:         *-- Label: ICMS Incluso no Preco
1143:         loc_oPage1.AddObject("lbl_4c_Label36", "Label")
1144:         WITH loc_oPage1.lbl_4c_Label36
1145:             .Caption   = "ICMS Incluso no Pre" + CHR(231) + "o:"
1146:             .Top       = 182
1147:             .Left      = 262
1148:             .Width     = 113
1149:             .Height    = 15
1150:             .FontName  = "Tahoma"
1151:             .FontSize  = 8
1152:             .BackStyle = 0
1153:             .Visible   = .T.
1154:         ENDWITH
1155: 
1156:         *-- Combo10 - icmsdscs numeric(1,0)
1157:         loc_oPage1.AddObject("cbo_4c_Combo10", "ComboBox")
1158:         WITH loc_oPage1.cbo_4c_Combo10
1159:             .Top           = 178
1160:             .Left          = 380
1161:             .Width         = 82
1162:             .Height        = 23
1163:             .RowSourceType = 1
1164:             .RowSource     = "0,1"
1165:             .Style         = 2
1166:             .Value         = "0"
1167:             .FontName      = "Tahoma"
1168:             .FontSize      = 8
1169:             .Visible       = .T.
1170:         ENDWITH
1171: 
1172:         *-- Label: Contribuinte
1173:         loc_oPage1.AddObject("lbl_4c_Label6", "Label")
1174:         WITH loc_oPage1.lbl_4c_Label6
1175:             .Caption   = "Contribuinte :"
1176:             .Top       = 184
1177:             .Left      = 815
1178:             .Width     = 68
1179:             .Height    = 15
1180:             .FontName  = "Tahoma"
1181:             .FontSize  = 8
1182:             .BackStyle = 0
1183:             .Visible   = .T.
1184:         ENDWITH
1185: 
1186:         *-- cmbContribuinte - contribs char(1) S/N/O
1187:         loc_oPage1.AddObject("cbo_4c_CmbContribuinte", "ComboBox")
1188:         WITH loc_oPage1.cbo_4c_CmbContribuinte
1189:             .Top           = 179
1190:             .Left          = 887
1191:             .Width         = 82
1192:             .Height        = 23
1193:             .RowSourceType = 1
1194:             .RowSource     = "S,N,O"
1195:             .Style         = 2
1196:             .Value         = "N"
1197:             .FontName      = "Tahoma"
1198:             .FontSize      = 8
1199:             .Visible       = .T.
1200:         ENDWITH
1201: 
1202:         *-- Label: Venda Consumidor
1203:         loc_oPage1.AddObject("lbl_4c_Label23", "Label")
1204:         WITH loc_oPage1.lbl_4c_Label23
1205:             .Caption   = "Venda Consumidor :"
1206:             .Top       = 207
1207:             .Left      = 33
1208:             .Width     = 98
1209:             .Height    = 15
1210:             .FontName  = "Tahoma"
1211:             .FontSize  = 8
1212:             .BackStyle = 0
1213:             .Visible   = .T.
1214:         ENDWITH
1215: 
1216:         *-- txt_4c_AliqIVCs - aliqivcs numeric(4,2)
1217:         loc_oPage1.AddObject("txt_4c_AliqIVCs", "TextBox")
1218:         WITH loc_oPage1.txt_4c_AliqIVCs
1219:             .Top       = 203
1220:             .Left      = 136
1221:             .Width     = 82
1222:             .Height    = 23
1223:             .Value     = 0
1224:             .Format    = "N"
1225:             .InputMask = "99.99"
1226:             .FontName  = "Tahoma"
1227:             .FontSize  = 8
1228:             .Visible   = .T.
1229:         ENDWITH
1230: 
1231:         *-- Label: % (aliqivcs)
1232:         loc_oPage1.AddObject("lbl_4c_Label13", "Label")
1233:         WITH loc_oPage1.lbl_4c_Label13
1234:             .Caption   = "%"
1235:             .Top       = 207
1236:             .Left      = 219
1237:             .Width     = 13
1238:             .Height    = 15
1239:             .FontName  = "Tahoma"
1240:             .FontSize  = 8
1241:             .BackStyle = 0
1242:             .Visible   = .T.
1243:         ENDWITH
1244: 
1245:         *-- Label: CFOP Destino
1246:         loc_oPage1.AddObject("lbl_4c_Label19", "Label")
1247:         WITH loc_oPage1.lbl_4c_Label19
1248:             .Caption   = "CFOP Destino :"
1249:             .Top       = 132
1250:             .Left      = 808
1251:             .Width     = 75
1252:             .Height    = 15
1253:             .FontName  = "Tahoma"
1254:             .FontSize  = 8
1255:             .BackStyle = 0
1256:             .Visible   = .T.
1257:         ENDWITH
1258: 
1259:         *-- txt_4c_Cfdest - coddests char(10)
1260:         loc_oPage1.AddObject("txt_4c_Cfdest", "TextBox")
1261:         WITH loc_oPage1.txt_4c_Cfdest
1262:             .Top       = 127
1263:             .Left      = 887
1264:             .Width     = 82
1265:             .Height    = 23
1266:             .MaxLength = 10
1267:             .Value     = ""
1268:             .FontName  = "Tahoma"
1269:             .FontSize  = 8
1270:             .Visible   = .T.
1271:         ENDWITH
1272: 
1273:         *-- Label: Inibe Valor Unitario NF Importacao
1274:         loc_oPage1.AddObject("lbl_4c_Label21", "Label")
1275:         WITH loc_oPage1.lbl_4c_Label21
1276:             .Caption   = "Inibe Valor Unit" + CHR(225) + "rio na NF Importa" + CHR(231) + CHR(227) + "o :"
1277:             .Top       = 211
1278:             .Left      = 694
1279:             .Width     = 189
1280:             .Height    = 15
1281:             .FontName  = "Tahoma"
1282:             .FontSize  = 8
1283:             .BackStyle = 0
1284:             .Visible   = .T.
1285:         ENDWITH
1286: 
1287:         *-- Combo9 - unitimps char(1) S/N
1288:         loc_oPage1.AddObject("cbo_4c_Combo9", "ComboBox")
1289:         WITH loc_oPage1.cbo_4c_Combo9
1290:             .Top           = 206
1291:             .Left          = 887
1292:             .Width         = 82
1293:             .Height        = 23
1294:             .RowSourceType = 1
1295:             .RowSource     = "S,N"
1296:             .Style         = 2
1297:             .Value         = "N"
1298:             .FontName      = "Tahoma"
1299:             .FontSize      = 8
1300:             .Visible       = .T.
1301:         ENDWITH
1302: 
1303:         *-- Label: Especificacoes Para NF-e
1304:         loc_oPage1.AddObject("lbl_4c_Label38", "Label")
1305:         WITH loc_oPage1.lbl_4c_Label38
1306:             .Caption   = "Especifica" + CHR(231) + CHR(245) + "es Para NF-e"
1307:             .Top       = 246
1308:             .Left      = 498
1309:             .Width     = 140
1310:             .Height    = 15
1311:             .FontName  = "Tahoma"
1312:             .FontSize  = 8
1313:             .BackStyle = 0
1314:             .Visible   = .T.
1315:         ENDWITH
1316: 
1317:         *-- Label: Destaca ICMS na Nota Fiscal (S/N)
1318:         loc_oPage1.AddObject("lbl_4c_Label27", "Label")
1319:         WITH loc_oPage1.lbl_4c_Label27
1320:             .Caption   = "Destaca ICMS na Nota Fiscal (S/N) :"
1321:             .Top       = 270
1322:             .Left      = 771
1323:             .Width     = 174
1324:             .Height    = 15
1325:             .FontName  = "Tahoma"
1326:             .FontSize  = 8
1327:             .BackStyle = 0
1328:             .Visible   = .T.
1329:         ENDWITH
1330: 
1331:         *-- txt_4c_Gergia1 - cgergia1s char(1)
1332:         loc_oPage1.AddObject("txt_4c_Gergia1", "TextBox")
1333:         WITH loc_oPage1.txt_4c_Gergia1
1334:             .Top       = 265
1335:             .Left      = 948
1336:             .Width     = 20
1337:             .Height    = 23
1338:             .MaxLength = 1
1339:             .Value     = ""
1340:             .FontName  = "Tahoma"
1341:             .FontSize  = 8
1342:             .Visible   = .T.
1343:         ENDWITH
1344: 
1345:         *-- === SECAO IPI ===
1346: 
1347:         *-- Label: IPI
1348:         loc_oPage1.AddObject("lbl_4c_Label8", "Label")
1349:         WITH loc_oPage1.lbl_4c_Label8
1350:             .Caption   = "I P I :"
1351:             .Top       = 267
1352:             .Left      = 103
1353:             .Width     = 29
1354:             .Height    = 15
1355:             .FontName  = "Tahoma"
1356:             .FontSize  = 8
1357:             .BackStyle = 0
1358:             .Visible   = .T.
1359:         ENDWITH
1360: 
1361:         *-- cmbIpi - ipis char(1) T/I/O
1362:         loc_oPage1.AddObject("cbo_4c_CmbIpi", "ComboBox")
1363:         WITH loc_oPage1.cbo_4c_CmbIpi
1364:             .Top           = 263
1365:             .Left          = 136
1366:             .Width         = 82
1367:             .Height        = 23
1368:             .RowSourceType = 1
1369:             .RowSource     = "T,I,O"
1370:             .Style         = 2
1371:             .Value         = "T"
1372:             .FontName      = "Tahoma"
1373:             .FontSize      = 8
1374:             .Visible       = .T.
1375:         ENDWITH
1376: 
1377:         *-- Label: IPI Importacao
1378:         loc_oPage1.AddObject("lbl_4c_Label7", "Label")
1379:         WITH loc_oPage1.lbl_4c_Label7
1380:             .Caption   = "IPI Importa" + CHR(231) + CHR(227) + "o :"
1381:             .Top       = 267
1382:             .Left      = 296
1383:             .Width     = 81
1384:             .Height    = 15
1385:             .FontName  = "Tahoma"
1386:             .FontSize  = 8
1387:             .BackStyle = 0
1388:             .Visible   = .T.
1389:         ENDWITH
1390: 
1391:         *-- cmbIpiI - ipiimpors char(1) S/N
1392:         loc_oPage1.AddObject("cbo_4c_CmbIpiI", "ComboBox")
1393:         WITH loc_oPage1.cbo_4c_CmbIpiI
1394:             .Top           = 263
1395:             .Left          = 380
1396:             .Width         = 82
1397:             .Height        = 23
1398:             .RowSourceType = 1
1399:             .RowSource     = "S,N"
1400:             .Style         = 2
1401:             .Value         = "N"
1402:             .FontName      = "Tahoma"
1403:             .FontSize      = 8
1404:             .Visible       = .T.
1405:         ENDWITH
1406: 
1407:         *-- Label: Codigo IPI Sit. Trib.
1408:         loc_oPage1.AddObject("lbl_4c_Label30", "Label")
1409:         WITH loc_oPage1.lbl_4c_Label30
1410:             .Caption   = "C" + CHR(243) + "digo IPI Sit. Trib.:"
1411:             .Top       = 269
1412:             .Left      = 583
1413:             .Width     = 100
1414:             .Height    = 15
1415:             .FontName  = "Tahoma"
1416:             .FontSize  = 8
1417:             .BackStyle = 0
1418:             .Visible   = .T.
1419:         ENDWITH
1420: 
1421:         *-- txt_4c_IPICST - ipicst char(2)
1422:         loc_oPage1.AddObject("txt_4c_IPICST", "TextBox")
1423:         WITH loc_oPage1.txt_4c_IPICST
1424:             .Top       = 266
1425:             .Left      = 691
1426:             .Width     = 26
1427:             .Height    = 23
1428:             .MaxLength = 2
1429:             .Value     = ""
1430:             .FontName  = "Tahoma"
1431:             .FontSize  = 8
1432:             .Visible   = .T.
1433:         ENDWITH
1434: 
1435:         *-- Label: Aliquota IPI
1436:         loc_oPage1.AddObject("lbl_4c_Label15", "Label")
1437:         WITH loc_oPage1.lbl_4c_Label15
1438:             .Caption   = "Al" + CHR(237) + "quota :"
1439:             .Top       = 293
1440:             .Left      = 84
1441:             .Width     = 48
1442:             .Height    = 15
1443:             .FontName  = "Tahoma"
1444:             .FontSize  = 8
1445:             .BackStyle = 0
1446:             .Visible   = .T.
1447:         ENDWITH
1448: 
1449:         *-- txt_4c_Aliqs - aliqipis numeric(4,2)
1450:         loc_oPage1.AddObject("txt_4c_Aliqs", "TextBox")
1451:         WITH loc_oPage1.txt_4c_Aliqs
1452:             .Top       = 289
1453:             .Left      = 136
1454:             .Width     = 82
1455:             .Height    = 23
1456:             .Value     = 0
1457:             .Format    = "N"
1458:             .InputMask = "99.99"
1459:             .FontName  = "Tahoma"
1460:             .FontSize  = 8
1461:             .Visible   = .T.
1462:         ENDWITH
1463: 
1464:         *-- Label: Retira IPI do Valor
1465:         loc_oPage1.AddObject("lbl_4c_Label32", "Label")
1466:         WITH loc_oPage1.lbl_4c_Label32
1467:             .Caption   = "Retira IPI do $ :"
1468:             .Top       = 293
1469:             .Left      = 298
1470:             .Width     = 79
1471:             .Height    = 15
1472:             .FontName  = "Tahoma"
1473:             .FontSize  = 8
1474:             .BackStyle = 0
1475:             .Visible   = .T.
1476:         ENDWITH
1477: 
1478:         *-- Combo7 - pontedescs numeric(1,0)
1479:         loc_oPage1.AddObject("cbo_4c_Combo7", "ComboBox")
1480:         WITH loc_oPage1.cbo_4c_Combo7
1481:             .Top           = 289
1482:             .Left          = 380
1483:             .Width         = 82
1484:             .Height        = 23
1485:             .RowSourceType = 1
1486:             .RowSource     = "0,1"
1487:             .Style         = 2
1488:             .Value         = "0"
1489:             .FontName      = "Tahoma"
1490:             .FontSize      = 8
1491:             .Visible       = .T.
1492:         ENDWITH
1493: 
1494:         *-- Label: Nao Creditado
1495:         loc_oPage1.AddObject("lbl_4c_Label20", "Label")
1496:         WITH loc_oPage1.lbl_4c_Label20
1497:             .Caption   = "N" + CHR(227) + "o Creditado :"
1498:             .Top       = 319
1499:             .Left      = 54
1500:             .Width     = 78
1501:             .Height    = 15
1502:             .FontName  = "Tahoma"
1503:             .FontSize  = 8
1504:             .BackStyle = 0
1505:             .Visible   = .T.
1506:         ENDWITH
1507: 
1508:         *-- Combo1 - ipincreds numeric(1,0)
1509:         loc_oPage1.AddObject("cbo_4c_Combo1", "ComboBox")
1510:         WITH loc_oPage1.cbo_4c_Combo1
1511:             .Top           = 315
1512:             .Left          = 136
1513:             .Width         = 82
1514:             .Height        = 23
1515:             .RowSourceType = 1
1516:             .RowSource     = "0,1"
1517:             .Style         = 2
1518:             .Value         = "0"
1519:             .FontName      = "Tahoma"
1520:             .FontSize      = 8
1521:             .Visible       = .T.
1522:         ENDWITH
1523: 
1524:         *-- Label: Acresc. na Base
1525:         loc_oPage1.AddObject("lbl_4c_Label17", "Label")
1526:         WITH loc_oPage1.lbl_4c_Label17
1527:             .Caption   = "Acr" + CHR(233) + "sc. na Base :"
1528:             .Top       = 319
1529:             .Left      = 291
1530:             .Width     = 86
1531:             .Height    = 15
1532:             .FontName  = "Tahoma"
1533:             .FontSize  = 8
1534:             .BackStyle = 0
1535:             .Visible   = .T.
1536:         ENDWITH
1537: 
1538:         *-- Combo2 - acresipis char(1) S/N
1539:         loc_oPage1.AddObject("cbo_4c_Combo2", "ComboBox")
1540:         WITH loc_oPage1.cbo_4c_Combo2
1541:             .Top           = 315
1542:             .Left          = 380
1543:             .Width         = 82
1544:             .Height        = 23
1545:             .RowSourceType = 1
1546:             .RowSource     = "S,N"
1547:             .Style         = 2
1548:             .Value         = "N"
1549:             .FontName      = "Tahoma"
1550:             .FontSize      = 8
1551:             .Visible       = .T.
1552:         ENDWITH
1553: 
1554:         *-- Label: Base de Calculo IPI
1555:         loc_oPage1.AddObject("lbl_4c_Label5", "Label")
1556:         WITH loc_oPage1.lbl_4c_Label5
1557:             .Caption   = "Base de C" + CHR(225) + "lculo :"
1558:             .Top       = 345
1559:             .Left      = 48
1560:             .Width     = 84
1561:             .Height    = 15
1562:             .FontName  = "Tahoma"
1563:             .FontSize  = 8
1564:             .BackStyle = 0
1565:             .Visible   = .T.
1566:         ENDWITH
1567: 
1568:         *-- CmbBIPI - bcipis char(1) (base calculo IPI)
1569:         loc_oPage1.AddObject("cbo_4c_CmbBIPI", "ComboBox")
1570:         WITH loc_oPage1.cbo_4c_CmbBIPI
1571:             .Top           = 341
1572:             .Left          = 136
1573:             .Width         = 196
1574:             .Height        = 24
1575:             .RowSourceType = 1
1576:             .RowSource     = "F,P,T,O"
1577:             .Style         = 2
1578:             .Value         = "P"
1579:             .FontName      = "Tahoma"
1580:             .FontSize      = 8
1581:             .Visible       = .T.
1582:         ENDWITH
1583: 
1584:         *-- Label: % (pbcipis)
1585:         loc_oPage1.AddObject("lbl_4c_Label9", "Label")
1586:         WITH loc_oPage1.lbl_4c_Label9
1587:             .Caption   = "%"
1588:             .Top       = 322
1589:             .Left      = 463
1590:             .Width     = 13
1591:             .Height    = 15
1592:             .FontName  = "Tahoma"
1593:             .FontSize  = 8
1594:             .BackStyle = 0
1595:             .Visible   = .T.
1596:         ENDWITH
1597: 
1598:         *-- txt_4c_BcIPI - pbcipis numeric(5,2)
1599:         loc_oPage1.AddObject("txt_4c_BcIPI", "TextBox")
1600:         WITH loc_oPage1.txt_4c_BcIPI
1601:             .Top       = 341
1602:             .Left      = 380
1603:             .Width     = 82
1604:             .Height    = 23
1605:             .Value     = 0
1606:             .Format    = "N"
1607:             .InputMask = "999.99"
1608:             .FontName  = "Tahoma"
1609:             .FontSize  = 8
1610:             .Visible   = .T.
1611:         ENDWITH
1612: 
1613:         *-- Label: IPI Sobre (frete/seguro/despesas)
1614:         loc_oPage1.AddObject("lbl_4c_Label16", "Label")
1615:         WITH loc_oPage1.lbl_4c_Label16
1616:             .Caption   = "IPI Sobre :"
1617:             .Top       = 395
1618:             .Left      = 75
1619:             .Width     = 54
1620:             .Height    = 15
1621:             .FontName  = "Tahoma"
1622:             .FontSize  = 8
1623:             .BackStyle = 0
1624:             .Visible   = .T.
1625:         ENDWITH
1626: 
1627:         *-- chk_4c_ObjFreteIPI - frtipis numeric(1,0)
1628:         loc_oPage1.AddObject("chk_4c_ObjFreteIPI", "CheckBox")
1629:         WITH loc_oPage1.chk_4c_ObjFreteIPI
1630:             .Caption   = "Frete"
1631:             .Top       = 395
1632:             .Left      = 137
1633:             .Width     = 44
1634:             .Height    = 15
1635:             .FontName  = "Tahoma"
1636:             .FontSize  = 8
1637:             .BackStyle = 0
1638:             .Value     = 0
1639:             .Visible   = .T.
1640:         ENDWITH
1641: 
1642:         *-- chk_4c_ObjSegIPI - segipis numeric(1,0)
1643:         loc_oPage1.AddObject("chk_4c_ObjSegIPI", "CheckBox")
1644:         WITH loc_oPage1.chk_4c_ObjSegIPI
1645:             .Caption   = "Seguro"
1646:             .Top       = 395
1647:             .Left      = 188
1648:             .Width     = 52
1649:             .Height    = 15
1650:             .FontName  = "Tahoma"
1651:             .FontSize  = 8
1652:             .BackStyle = 0
1653:             .Value     = 0
1654:             .Visible   = .T.
1655:         ENDWITH
1656: 
1657:         *-- chk_4c_ObjDespIPI - desipis numeric(1,0)
1658:         loc_oPage1.AddObject("chk_4c_ObjDespIPI", "CheckBox")
1659:         WITH loc_oPage1.chk_4c_ObjDespIPI
1660:             .Caption   = "Despesas Acess" + CHR(243) + "rias"
1661:             .Top       = 395
1662:             .Left      = 255
1663:             .Width     = 118
1664:             .Height    = 15
1665:             .FontName  = "Tahoma"
1666:             .FontSize  = 8
1667:             .BackStyle = 0
1668:             .Value     = 0
1669:             .Visible   = .T.
1670:         ENDWITH
1671: 
1672:         *-- Label: Calcula IPI Importacao Origem=2
1673:         loc_oPage1.AddObject("lbl_4c_Label18", "Label")
1674:         WITH loc_oPage1.lbl_4c_Label18
1675:             .Caption   = "Calcula IPI Importa" + CHR(231) + CHR(227) + "o Para Origem Mercadoria=2 :"
1676:             .Top       = 371
1677:             .Left      = 125
1678:             .Width     = 250
1679:             .Height    = 15
1680:             .FontName  = "Tahoma"
1681:             .FontSize  = 8
1682:             .BackStyle = 0
1683:             .Visible   = .T.
1684:         ENDWITH
1685: 
1686:         *-- Combo8 - ipiom2s char(1) S/N
1687:         loc_oPage1.AddObject("cbo_4c_Combo8", "ComboBox")
1688:         WITH loc_oPage1.cbo_4c_Combo8
1689:             .Top           = 367
1690:             .Left          = 380
1691:             .Width         = 82
1692:             .Height        = 23
1693:             .RowSourceType = 1
1694:             .RowSource     = "S,N"
1695:             .Style         = 2

*-- Linhas 1702 a 2117:
1702:         *-- === SECAO NF-e: PIS / COFINS / ISSQN / II ===
1703: 
1704:         *-- Label: Codigo PIS Sit. Trib.
1705:         loc_oPage1.AddObject("lbl_4c_Label33", "Label")
1706:         WITH loc_oPage1.lbl_4c_Label33
1707:             .Caption   = "C" + CHR(243) + "digo PIS Sit. Trib.:"
1708:             .Top       = 295
1709:             .Left      = 581
1710:             .Width     = 102
1711:             .Height    = 15
1712:             .FontName  = "Tahoma"
1713:             .FontSize  = 8
1714:             .BackStyle = 0
1715:             .Visible   = .T.
1716:         ENDWITH
1717: 
1718:         *-- txt_4c_PISCST - piscst char(2)
1719:         loc_oPage1.AddObject("txt_4c_PISCST", "TextBox")
1720:         WITH loc_oPage1.txt_4c_PISCST
1721:             .Top       = 291
1722:             .Left      = 691
1723:             .Width     = 26
1724:             .Height    = 23
1725:             .MaxLength = 2
1726:             .Value     = ""
1727:             .FontName  = "Tahoma"
1728:             .FontSize  = 8
1729:             .Visible   = .T.
1730:         ENDWITH
1731: 
1732:         *-- Label: Aliquota do PIS
1733:         loc_oPage1.AddObject("lbl_4c_Label39", "Label")
1734:         WITH loc_oPage1.lbl_4c_Label39
1735:             .Caption   = "Al" + CHR(237) + "quota do PIS :"
1736:             .Top       = 295
1737:             .Left      = 829
1738:             .Width     = 82
1739:             .Height    = 15
1740:             .FontName  = "Tahoma"
1741:             .FontSize  = 8
1742:             .BackStyle = 0
1743:             .Visible   = .T.
1744:         ENDWITH
1745: 
1746:         *-- txt_4c_AliqPIS - aliqpis numeric(5,2)
1747:         loc_oPage1.AddObject("txt_4c_AliqPIS", "TextBox")
1748:         WITH loc_oPage1.txt_4c_AliqPIS
1749:             .Top       = 291
1750:             .Left      = 916
1751:             .Width     = 52
1752:             .Height    = 23
1753:             .Value     = 0
1754:             .Format    = "N"
1755:             .InputMask = "999.99"
1756:             .FontName  = "Tahoma"
1757:             .FontSize  = 8
1758:             .Visible   = .T.
1759:         ENDWITH
1760: 
1761:         *-- Label: % (PIS)
1762:         loc_oPage1.AddObject("lbl_4c_Label40", "Label")
1763:         WITH loc_oPage1.lbl_4c_Label40
1764:             .Caption   = "%"
1765:             .Top       = 295
1766:             .Left      = 971
1767:             .Width     = 14
1768:             .Height    = 15
1769:             .FontName  = "Tahoma"
1770:             .FontSize  = 8
1771:             .BackStyle = 0
1772:             .Visible   = .T.
1773:         ENDWITH
1774: 
1775:         *-- Label: Codigo COFINS Sit. Trib.
1776:         loc_oPage1.AddObject("lbl_4c_Label34", "Label")
1777:         WITH loc_oPage1.lbl_4c_Label34
1778:             .Caption   = "C" + CHR(243) + "digo COFINS Sit. Trib.:"
1779:             .Top       = 319
1780:             .Left      = 559
1781:             .Width     = 124
1782:             .Height    = 15
1783:             .FontName  = "Tahoma"
1784:             .FontSize  = 8
1785:             .BackStyle = 0
1786:             .Visible   = .T.
1787:         ENDWITH
1788: 
1789:         *-- txt_4c_COFCST - cofcst char(2)
1790:         loc_oPage1.AddObject("txt_4c_COFCST", "TextBox")
1791:         WITH loc_oPage1.txt_4c_COFCST
1792:             .Top       = 315
1793:             .Left      = 691
1794:             .Width     = 26
1795:             .Height    = 23
1796:             .MaxLength = 2
1797:             .Value     = ""
1798:             .FontName  = "Tahoma"
1799:             .FontSize  = 8
1800:             .Visible   = .T.
1801:         ENDWITH
1802: 
1803:         *-- Label: Aliquota do COFINS
1804:         loc_oPage1.AddObject("lbl_4c_Label41", "Label")
1805:         WITH loc_oPage1.lbl_4c_Label41
1806:             .Caption   = "Al" + CHR(237) + "quota do COFINS :"
1807:             .Top       = 319
1808:             .Left      = 807
1809:             .Width     = 104
1810:             .Height    = 15
1811:             .FontName  = "Tahoma"
1812:             .FontSize  = 8
1813:             .BackStyle = 0
1814:             .Visible   = .T.
1815:         ENDWITH
1816: 
1817:         *-- txt_4c_AliqCofins - aliqcofins numeric(5,2)
1818:         loc_oPage1.AddObject("txt_4c_AliqCofins", "TextBox")
1819:         WITH loc_oPage1.txt_4c_AliqCofins
1820:             .Top       = 315
1821:             .Left      = 916
1822:             .Width     = 52
1823:             .Height    = 23
1824:             .Value     = 0
1825:             .Format    = "N"
1826:             .InputMask = "999.99"
1827:             .FontName  = "Tahoma"
1828:             .FontSize  = 8
1829:             .Visible   = .T.
1830:         ENDWITH
1831: 
1832:         *-- Label: % (COFINS)
1833:         loc_oPage1.AddObject("lbl_4c_Label42", "Label")
1834:         WITH loc_oPage1.lbl_4c_Label42
1835:             .Caption   = "%"
1836:             .Top       = 319
1837:             .Left      = 971
1838:             .Width     = 14
1839:             .Height    = 15
1840:             .FontName  = "Tahoma"
1841:             .FontSize  = 8
1842:             .BackStyle = 0
1843:             .Visible   = .T.
1844:         ENDWITH
1845: 
1846:         *-- Label: Codigo ISSQN Lista Serv.
1847:         loc_oPage1.AddObject("lbl_4c_Label35", "Label")
1848:         WITH loc_oPage1.lbl_4c_Label35
1849:             .Caption   = "C" + CHR(243) + "digo ISSQN Lista Serv.:"
1850:             .Top       = 343
1851:             .Left      = 556
1852:             .Width     = 127
1853:             .Height    = 15
1854:             .FontName  = "Tahoma"
1855:             .FontSize  = 8
1856:             .BackStyle = 0
1857:             .Visible   = .T.
1858:         ENDWITH
1859: 
1860:         *-- txt_4c_ISSQNL - issqnl char(5)
1861:         loc_oPage1.AddObject("txt_4c_ISSQNL", "TextBox")
1862:         WITH loc_oPage1.txt_4c_ISSQNL
1863:             .Top       = 339
1864:             .Left      = 691
1865:             .Width     = 40
1866:             .Height    = 23
1867:             .MaxLength = 5
1868:             .Value     = ""
1869:             .FontName  = "Tahoma"
1870:             .FontSize  = 8
1871:             .Visible   = .T.
1872:         ENDWITH
1873: 
1874:         *-- Label: Aliquota do ISSQN
1875:         loc_oPage1.AddObject("lbl_4c_Label44", "Label")
1876:         WITH loc_oPage1.lbl_4c_Label44
1877:             .Caption   = "Al" + CHR(237) + "quota do ISSQN :"
1878:             .Top       = 343
1879:             .Left      = 814
1880:             .Width     = 97
1881:             .Height    = 15
1882:             .FontName  = "Tahoma"
1883:             .FontSize  = 8
1884:             .BackStyle = 0
1885:             .Visible   = .T.
1886:         ENDWITH
1887: 
1888:         *-- txt_4c_AliqISSQN - aliqissqn numeric(5,2)
1889:         loc_oPage1.AddObject("txt_4c_AliqISSQN", "TextBox")
1890:         WITH loc_oPage1.txt_4c_AliqISSQN
1891:             .Top       = 339
1892:             .Left      = 916
1893:             .Width     = 52
1894:             .Height    = 23
1895:             .Value     = 0
1896:             .Format    = "N"
1897:             .InputMask = "999.99"
1898:             .FontName  = "Tahoma"
1899:             .FontSize  = 8
1900:             .Visible   = .T.
1901:         ENDWITH
1902: 
1903:         *-- Label: % (ISSQN)
1904:         loc_oPage1.AddObject("lbl_4c_Label45", "Label")
1905:         WITH loc_oPage1.lbl_4c_Label45
1906:             .Caption   = "%"
1907:             .Top       = 343
1908:             .Left      = 971
1909:             .Width     = 14
1910:             .Height    = 15
1911:             .FontName  = "Tahoma"
1912:             .FontSize  = 8
1913:             .BackStyle = 0
1914:             .Visible   = .T.
1915:         ENDWITH
1916: 
1917:         *-- Label: Codigo de Trib. do ISSQN
1918:         loc_oPage1.AddObject("lbl_4c_Label43", "Label")
1919:         WITH loc_oPage1.lbl_4c_Label43
1920:             .Caption   = "C" + CHR(243) + "digo de Trib. do ISSQN:"
1921:             .Top       = 369
1922:             .Left      = 555
1923:             .Width     = 128
1924:             .Height    = 15
1925:             .FontName  = "Tahoma"
1926:             .FontSize  = 8
1927:             .BackStyle = 0
1928:             .Visible   = .T.
1929:         ENDWITH
1930: 
1931:         *-- Fwoption1 - ctissqn numeric(1,0), 5 buttons (0-4)
1932:         loc_oPage1.AddObject("obj_4c_Fwoption1", "OptionGroup")
1933:         WITH loc_oPage1.obj_4c_Fwoption1
1934:             .Top         = 368
1935:             .Left        = 686
1936:             .Width       = 297
1937:             .Height      = 34
1938:             .ButtonCount = 5
1939:             .BackStyle   = 0
1940:             .Value       = 1
1941:             .Visible     = .T.
1942: 
1943:             WITH .Buttons(1)
1944:                 .Caption   = "0"
1945:                 .Width     = 55
1946:                 .Height    = 17
1947:                 .Left      = 0
1948:                 .Top       = 0
1949:                 .BackStyle = 0
1950:                 .Visible   = .T.
1951:             ENDWITH
1952: 
1953:             WITH .Buttons(2)
1954:                 .Caption   = "1"
1955:                 .Width     = 55
1956:                 .Height    = 17
1957:                 .Left      = 57
1958:                 .Top       = 0
1959:                 .BackStyle = 0
1960:                 .FontName  = "Tahoma"
1961:                 .FontSize  = 8
1962:                 .Visible   = .T.
1963:             ENDWITH
1964: 
1965:             WITH .Buttons(3)
1966:                 .Caption   = "2"
1967:                 .Width     = 55
1968:                 .Height    = 17
1969:                 .Left      = 114
1970:                 .Top       = 0
1971:                 .BackStyle = 0
1972:                 .FontName  = "Tahoma"
1973:                 .FontSize  = 8
1974:                 .Visible   = .T.
1975:             ENDWITH
1976: 
1977:             WITH .Buttons(4)
1978:                 .Caption   = "3"
1979:                 .Width     = 55
1980:                 .Height    = 17
1981:                 .Left      = 171
1982:                 .Top       = 0
1983:                 .BackStyle = 0
1984:                 .FontName  = "Tahoma"
1985:                 .FontSize  = 8
1986:                 .Visible   = .T.
1987:             ENDWITH
1988: 
1989:             WITH .Buttons(5)
1990:                 .Caption   = "4"
1991:                 .Width     = 55
1992:                 .Height    = 17
1993:                 .Left      = 228
1994:                 .Top       = 0
1995:                 .BackStyle = 0
1996:                 .FontName  = "Tahoma"
1997:                 .FontSize  = 8
1998:                 .Visible   = .T.
1999:             ENDWITH
2000:         ENDWITH
2001: 
2002:         *-- Label: Informa Retencao de Trib.
2003:         loc_oPage1.AddObject("lbl_4c_Label46", "Label")
2004:         WITH loc_oPage1.lbl_4c_Label46
2005:             .Caption   = "Informa Reten" + CHR(231) + CHR(227) + "o de Trib.:"
2006:             .Top       = 404
2007:             .Left      = 550
2008:             .Width     = 133
2009:             .Height    = 15
2010:             .FontName  = "Tahoma"
2011:             .FontSize  = 8
2012:             .BackStyle = 0
2013:             .Visible   = .T.
2014:         ENDWITH
2015: 
2016:         *-- Fwoption2 - rettribs numeric(1,0), 2 buttons Sim/Nao
2017:         loc_oPage1.AddObject("obj_4c_Fwoption2", "OptionGroup")
2018:         WITH loc_oPage1.obj_4c_Fwoption2
2019:             .Top         = 399
2020:             .Left        = 686
2021:             .Width       = 95
2022:             .Height      = 25
2023:             .ButtonCount = 2
2024:             .BackStyle   = 0
2025:             .Value       = 2
2026:             .Visible     = .T.
2027: 
2028:             WITH .Buttons(1)
2029:                 .Caption   = "Sim"
2030:                 .Width     = 44
2031:                 .Height    = 17
2032:                 .Left      = 0
2033:                 .Top       = 0
2034:                 .BackStyle = 0
2035:                 .Visible   = .T.
2036:             ENDWITH
2037: 
2038:             WITH .Buttons(2)
2039:                 .Caption   = "N" + CHR(227) + "o"
2040:                 .Width     = 44
2041:                 .Height    = 17
2042:                 .Left      = 46
2043:                 .Top       = 0
2044:                 .BackStyle = 0
2045:                 .FontName  = "Tahoma"
2046:                 .FontSize  = 8
2047:                 .Visible   = .T.
2048:             ENDWITH
2049:         ENDWITH
2050: 
2051:         *-- Label: Aliquota do II
2052:         loc_oPage1.AddObject("lbl_4c_Label47", "Label")
2053:         WITH loc_oPage1.lbl_4c_Label47
2054:             .Caption   = "Al" + CHR(237) + "quota do II :"
2055:             .Top       = 404
2056:             .Left      = 839
2057:             .Width     = 74
2058:             .Height    = 15
2059:             .FontName  = "Tahoma"
2060:             .FontSize  = 8
2061:             .BackStyle = 0
2062:             .Visible   = .T.
2063:         ENDWITH
2064: 
2065:         *-- txt_4c_AliqII - aliqii numeric(5,2)
2066:         loc_oPage1.AddObject("txt_4c_AliqII", "TextBox")
2067:         WITH loc_oPage1.txt_4c_AliqII
2068:             .Top       = 400
2069:             .Left      = 916
2070:             .Width     = 52
2071:             .Height    = 23
2072:             .Value     = 0
2073:             .Format    = "N"
2074:             .InputMask = "999.99"
2075:             .FontName  = "Tahoma"
2076:             .FontSize  = 8
2077:             .Visible   = .T.
2078:         ENDWITH
2079: 
2080:         *-- Label: % (II)
2081:         loc_oPage1.AddObject("lbl_4c_Label48", "Label")
2082:         WITH loc_oPage1.lbl_4c_Label48
2083:             .Caption   = "%"
2084:             .Top       = 404
2085:             .Left      = 971
2086:             .Width     = 13
2087:             .Height    = 15
2088:             .FontName  = "Tahoma"
2089:             .FontSize  = 8
2090:             .BackStyle = 0
2091:             .Visible   = .T.
2092:         ENDWITH
2093: 
2094:         *-- Label: Enquadramento IPI
2095:         loc_oPage1.AddObject("lbl_4c_Label50", "Label")
2096:         WITH loc_oPage1.lbl_4c_Label50
2097:             .Caption   = "Enquadramento IPI:"
2098:             .Top       = 427
2099:             .Left      = 583
2100:             .Width     = 99
2101:             .Height    = 15
2102:             .FontName  = "Tahoma"
2103:             .FontSize  = 8
2104:             .BackStyle = 0
2105:             .Visible   = .T.
2106:         ENDWITH
2107: 
2108:         *-- txt_4c_Enqipi - ipienq char(3)
2109:         loc_oPage1.AddObject("txt_4c_Enqipi", "TextBox")
2110:         WITH loc_oPage1.txt_4c_Enqipi
2111:             .Top       = 424
2112:             .Left      = 691
2113:             .Width     = 26
2114:             .Height    = 23
2115:             .MaxLength = 3
2116:             .Value     = ""
2117:             .FontName  = "Tahoma"

*-- Linhas 2140 a 2971:
2140:         *-- Separador secoes
2141:         loc_oPg2.AddObject("shp_4c_Shp03", "Shape")
2142:         WITH loc_oPg2.shp_4c_Shp03
2143:             .Top         = 211
2144:             .Left        = 5
2145:             .Width       = 984
2146:             .Height      = 1
2147:             .BackColor   = RGB(128, 128, 128)
2148:             .BorderColor = RGB(128, 128, 128)
2149:             .Visible     = .T.
2150:         ENDWITH
2151: 
2152:         *-- Label: Integracao Contabil (titulo secao)
2153:         loc_oPg2.AddObject("lbl_4c_Label7", "Label")
2154:         WITH loc_oPg2.lbl_4c_Label7
2155:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
2156:             .Top       = 6
2157:             .Left      = 15
2158:             .Width     = 114
2159:             .Height    = 15
2160:             .FontName  = "Tahoma"
2161:             .FontSize  = 8
2162:             .FontBold  = .T.
2163:             .BackStyle = 0
2164:             .Visible   = .T.
2165:         ENDWITH
2166: 
2167:         *-- Label: Valor Contabil
2168:         loc_oPg2.AddObject("lbl_4c_Label10", "Label")
2169:         WITH loc_oPg2.lbl_4c_Label10
2170:             .Caption   = "Valor Cont" + CHR(225) + "bil :"
2171:             .Top       = 34
2172:             .Left      = 82
2173:             .Width     = 75
2174:             .Height    = 15
2175:             .FontName  = "Tahoma"
2176:             .FontSize  = 8
2177:             .BackStyle = 0
2178:             .Visible   = .T.
2179:         ENDWITH
2180: 
2181:         *-- Label: DB / CR (Valor Contabil)
2182:         loc_oPg2.AddObject("lbl_4c_Label13", "Label")
2183:         WITH loc_oPg2.lbl_4c_Label13
2184:             .Caption   = "DB"
2185:             .Top       = 34
2186:             .Left      = 243
2187:             .Width     = 15
2188:             .Height    = 15
2189:             .FontName  = "Tahoma"
2190:             .FontSize  = 8
2191:             .BackStyle = 0
2192:             .Visible   = .T.
2193:         ENDWITH
2194: 
2195:         loc_oPg2.AddObject("lbl_4c_Label14", "Label")
2196:         WITH loc_oPg2.lbl_4c_Label14
2197:             .Caption   = "CR"
2198:             .Top       = 34
2199:             .Left      = 344
2200:             .Width     = 16
2201:             .Height    = 15
2202:             .FontName  = "Tahoma"
2203:             .FontSize  = 8
2204:             .BackStyle = 0
2205:             .Visible   = .T.
2206:         ENDWITH
2207: 
2208:         *-- txt_4c_Vrcds - contvcds char(9)
2209:         loc_oPg2.AddObject("txt_4c_Vrcds", "TextBox")
2210:         WITH loc_oPg2.txt_4c_Vrcds
2211:             .Top       = 30
2212:             .Left      = 162
2213:             .Width     = 73
2214:             .Height    = 24
2215:             .MaxLength = 9
2216:             .Value     = ""
2217:             .FontName  = "Tahoma"
2218:             .FontSize  = 8
2219:             .Visible   = .T.
2220:         ENDWITH
2221: 
2222:         *-- txt_4c_Vrccs - contvccs char(9)
2223:         loc_oPg2.AddObject("txt_4c_Vrccs", "TextBox")
2224:         WITH loc_oPg2.txt_4c_Vrccs
2225:             .Top       = 30
2226:             .Left      = 265
2227:             .Width     = 73
2228:             .Height    = 24
2229:             .MaxLength = 9
2230:             .Value     = ""
2231:             .FontName  = "Tahoma"
2232:             .FontSize  = 8
2233:             .Visible   = .T.
2234:         ENDWITH
2235: 
2236:         *-- Label: IPI
2237:         loc_oPg2.AddObject("lbl_4c_Label11", "Label")
2238:         WITH loc_oPg2.lbl_4c_Label11
2239:             .Caption   = "IPI :"
2240:             .Top       = 60
2241:             .Left      = 134
2242:             .Width     = 23
2243:             .Height    = 15
2244:             .FontName  = "Tahoma"
2245:             .FontSize  = 8
2246:             .BackStyle = 0
2247:             .Visible   = .T.
2248:         ENDWITH
2249: 
2250:         *-- Label: DB / CR (IPI)
2251:         loc_oPg2.AddObject("lbl_4c_Label15", "Label")
2252:         WITH loc_oPg2.lbl_4c_Label15
2253:             .Caption   = "DB"
2254:             .Top       = 60
2255:             .Left      = 243
2256:             .Width     = 15
2257:             .Height    = 15
2258:             .FontName  = "Tahoma"
2259:             .FontSize  = 8
2260:             .BackStyle = 0
2261:             .Visible   = .T.
2262:         ENDWITH
2263: 
2264:         loc_oPg2.AddObject("lbl_4c_Label16", "Label")
2265:         WITH loc_oPg2.lbl_4c_Label16
2266:             .Caption   = "CR"
2267:             .Top       = 60
2268:             .Left      = 344
2269:             .Width     = 16
2270:             .Height    = 15
2271:             .FontName  = "Tahoma"
2272:             .FontSize  = 8
2273:             .BackStyle = 0
2274:             .Visible   = .T.
2275:         ENDWITH
2276: 
2277:         *-- txt_4c_Ipids - contipds char(9)
2278:         loc_oPg2.AddObject("txt_4c_Ipids", "TextBox")
2279:         WITH loc_oPg2.txt_4c_Ipids
2280:             .Top       = 56
2281:             .Left      = 162
2282:             .Width     = 73
2283:             .Height    = 24
2284:             .MaxLength = 9
2285:             .Value     = ""
2286:             .FontName  = "Tahoma"
2287:             .FontSize  = 8
2288:             .Visible   = .T.
2289:         ENDWITH
2290: 
2291:         *-- txt_4c_Ipics - contipcs char(9)
2292:         loc_oPg2.AddObject("txt_4c_Ipics", "TextBox")
2293:         WITH loc_oPg2.txt_4c_Ipics
2294:             .Top       = 56
2295:             .Left      = 265
2296:             .Width     = 73
2297:             .Height    = 24
2298:             .MaxLength = 9
2299:             .Value     = ""
2300:             .FontName  = "Tahoma"
2301:             .FontSize  = 8
2302:             .Visible   = .T.
2303:         ENDWITH
2304: 
2305:         *-- Label: ICMS
2306:         loc_oPg2.AddObject("lbl_4c_Label12", "Label")
2307:         WITH loc_oPg2.lbl_4c_Label12
2308:             .Caption   = "ICMS :"
2309:             .Top       = 86
2310:             .Left      = 123
2311:             .Width     = 34
2312:             .Height    = 15
2313:             .FontName  = "Tahoma"
2314:             .FontSize  = 8
2315:             .BackStyle = 0
2316:             .Visible   = .T.
2317:         ENDWITH
2318: 
2319:         *-- Label: DB / CR (ICMS)
2320:         loc_oPg2.AddObject("lbl_4c_Label17", "Label")
2321:         WITH loc_oPg2.lbl_4c_Label17
2322:             .Caption   = "DB"
2323:             .Top       = 86
2324:             .Left      = 243
2325:             .Width     = 15
2326:             .Height    = 15
2327:             .FontName  = "Tahoma"
2328:             .FontSize  = 8
2329:             .BackStyle = 0
2330:             .Visible   = .T.
2331:         ENDWITH
2332: 
2333:         loc_oPg2.AddObject("lbl_4c_Label18", "Label")
2334:         WITH loc_oPg2.lbl_4c_Label18
2335:             .Caption   = "CR"
2336:             .Top       = 86
2337:             .Left      = 344
2338:             .Width     = 16
2339:             .Height    = 15
2340:             .FontName  = "Tahoma"
2341:             .FontSize  = 8
2342:             .BackStyle = 0
2343:             .Visible   = .T.
2344:         ENDWITH
2345: 
2346:         *-- txt_4c_Icmds - conticds char(9)
2347:         loc_oPg2.AddObject("txt_4c_Icmds", "TextBox")
2348:         WITH loc_oPg2.txt_4c_Icmds
2349:             .Top       = 82
2350:             .Left      = 162
2351:             .Width     = 73
2352:             .Height    = 24
2353:             .MaxLength = 9
2354:             .Value     = ""
2355:             .FontName  = "Tahoma"
2356:             .FontSize  = 8
2357:             .Visible   = .T.
2358:         ENDWITH
2359: 
2360:         *-- txt_4c_Icmcs - conticcs char(9)
2361:         loc_oPg2.AddObject("txt_4c_Icmcs", "TextBox")
2362:         WITH loc_oPg2.txt_4c_Icmcs
2363:             .Top       = 82
2364:             .Left      = 265
2365:             .Width     = 73
2366:             .Height    = 24
2367:             .MaxLength = 9
2368:             .Value     = ""
2369:             .FontName  = "Tahoma"
2370:             .FontSize  = 8
2371:             .Visible   = .T.
2372:         ENDWITH
2373: 
2374:         *-- Label: Conta de Frete
2375:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
2376:         WITH loc_oPg2.lbl_4c_Label3
2377:             .Caption   = "Conta de Frete :"
2378:             .Top       = 112
2379:             .Left      = 75
2380:             .Width     = 82
2381:             .Height    = 15
2382:             .FontName  = "Tahoma"
2383:             .FontSize  = 8
2384:             .BackStyle = 0
2385:             .Visible   = .T.
2386:         ENDWITH
2387: 
2388:         *-- txt_4c_ContFrt - contfrt char(9)
2389:         loc_oPg2.AddObject("txt_4c_ContFrt", "TextBox")
2390:         WITH loc_oPg2.txt_4c_ContFrt
2391:             .Top       = 108
2392:             .Left      = 162
2393:             .Width     = 73
2394:             .Height    = 24
2395:             .MaxLength = 9
2396:             .Value     = ""
2397:             .FontName  = "Tahoma"
2398:             .FontSize  = 8
2399:             .Visible   = .T.
2400:         ENDWITH
2401: 
2402:         *-- Label: Conta de Seguro
2403:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
2404:         WITH loc_oPg2.lbl_4c_Label4
2405:             .Caption   = "Conta de Seguro :"
2406:             .Top       = 138
2407:             .Left      = 67
2408:             .Width     = 90
2409:             .Height    = 15
2410:             .FontName  = "Tahoma"
2411:             .FontSize  = 8
2412:             .BackStyle = 0
2413:             .Visible   = .T.
2414:         ENDWITH
2415: 
2416:         *-- txt_4c_ContSeg - contseg char(9)
2417:         loc_oPg2.AddObject("txt_4c_ContSeg", "TextBox")
2418:         WITH loc_oPg2.txt_4c_ContSeg
2419:             .Top       = 134
2420:             .Left      = 162
2421:             .Width     = 73
2422:             .Height    = 24
2423:             .MaxLength = 9
2424:             .Value     = ""
2425:             .FontName  = "Tahoma"
2426:             .FontSize  = 8
2427:             .Visible   = .T.
2428:         ENDWITH
2429: 
2430:         *-- Label: Conta de Despesas
2431:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
2432:         WITH loc_oPg2.lbl_4c_Label5
2433:             .Caption   = "Conta de Despesas :"
2434:             .Top       = 164
2435:             .Left      = 55
2436:             .Width     = 102
2437:             .Height    = 15
2438:             .FontName  = "Tahoma"
2439:             .FontSize  = 8
2440:             .BackStyle = 0
2441:             .Visible   = .T.
2442:         ENDWITH
2443: 
2444:         *-- txt_4c_ContDa - contda char(9)
2445:         loc_oPg2.AddObject("txt_4c_ContDa", "TextBox")
2446:         WITH loc_oPg2.txt_4c_ContDa
2447:             .Top       = 160
2448:             .Left      = 162
2449:             .Width     = 73
2450:             .Height    = 24
2451:             .MaxLength = 9
2452:             .Value     = ""
2453:             .FontName  = "Tahoma"
2454:             .FontSize  = 8
2455:             .Visible   = .T.
2456:         ENDWITH
2457: 
2458:         *-- Label: Descricao na Integracao
2459:         loc_oPg2.AddObject("lbl_4c_Label21", "Label")
2460:         WITH loc_oPg2.lbl_4c_Label21
2461:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o :"
2462:             .Top       = 31
2463:             .Left      = 511
2464:             .Width     = 126
2465:             .Height    = 15
2466:             .FontName  = "Tahoma"
2467:             .FontSize  = 8
2468:             .BackStyle = 0
2469:             .Visible   = .T.
2470:         ENDWITH
2471: 
2472:         *-- cbo_4c_Combo2 - pontedescs numeric(1,0): ListIndex 1=Sim-Descricao, 2=Nao-Nenhuma, 3=Sim-Obs.
2473:         loc_oPg2.AddObject("cbo_4c_Combo2", "ComboBox")
2474:         WITH loc_oPg2.cbo_4c_Combo2
2475:             .Top           = 27
2476:             .Left          = 642
2477:             .Width         = 199
2478:             .Height        = 25
2479:             .RowSourceType = 1
2480:             .RowSource     = "Sim-Descri" + CHR(231) + CHR(227) + "o CFOP,N" + CHR(227) + "o-Nenhuma,Sim-Obs. Opera" + CHR(231) + CHR(227) + "o"
2481:             .Style         = 2
2482:             .Value         = "N" + CHR(227) + "o-Nenhuma"
2483:             .FontName      = "Tahoma"
2484:             .FontSize      = 8
2485:             .Visible       = .T.
2486:         ENDWITH
2487: 
2488:         *-- Label: Pega Conta Contabil da NF
2489:         loc_oPg2.AddObject("lbl_4c_Label8", "Label")
2490:         WITH loc_oPg2.lbl_4c_Label8
2491:             .Caption   = "Pega Conta Cont" + CHR(225) + "bil da NF :"
2492:             .Top       = 57
2493:             .Left      = 499
2494:             .Width     = 138
2495:             .Height    = 15
2496:             .FontName  = "Tahoma"
2497:             .FontSize  = 8
2498:             .BackStyle = 0
2499:             .Visible   = .T.
2500:         ENDWITH
2501: 
2502:         *-- cbo_4c_CmbFixa - contconts char(1): S=Sim(NF), N=Nao(CFOP), C=C.C.
2503:         loc_oPg2.AddObject("cbo_4c_CmbFixa", "ComboBox")
2504:         WITH loc_oPg2.cbo_4c_CmbFixa
2505:             .Top           = 53
2506:             .Left          = 642
2507:             .Width         = 132
2508:             .Height        = 25
2509:             .RowSourceType = 1
2510:             .RowSource     = "Sim (NF),N" + CHR(227) + "o (CFOP),C.C."
2511:             .Style         = 2
2512:             .Value         = "N" + CHR(227) + "o (CFOP)"
2513:             .FontName      = "Tahoma"
2514:             .FontSize      = 8
2515:             .Visible       = .T.
2516:         ENDWITH
2517: 
2518:         *-- Label: Agrupa CFO na Integracao
2519:         loc_oPg2.AddObject("lbl_4c_Label29", "Label")
2520:         WITH loc_oPg2.lbl_4c_Label29
2521:             .Caption   = "Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o :"
2522:             .Top       = 84
2523:             .Left      = 498
2524:             .Width     = 139
2525:             .Height    = 15
2526:             .FontName  = "Tahoma"
2527:             .FontSize  = 8
2528:             .BackStyle = 0
2529:             .Visible   = .T.
2530:         ENDWITH
2531: 
2532:         *-- obj_4c_OptAgrupas - agrupas numeric(1,0), 2 buttons Sim/Nao
2533:         loc_oPg2.AddObject("obj_4c_OptAgrupas", "OptionGroup")
2534:         WITH loc_oPg2.obj_4c_OptAgrupas
2535:             .Top         = 79
2536:             .Left        = 638
2537:             .Width       = 94
2538:             .Height      = 27
2539:             .ButtonCount = 2
2540:             .BackStyle   = 0
2541:             .Value       = 2
2542:             .Visible     = .T.
2543: 
2544:             WITH .Buttons(1)
2545:                 .Caption   = "Sim"
2546:                 .Width     = 43
2547:                 .Height    = 17
2548:                 .Left      = 0
2549:                 .Top       = 0
2550:                 .BackStyle = 0
2551:                 .Visible   = .T.
2552:             ENDWITH
2553: 
2554:             WITH .Buttons(2)
2555:                 .Caption   = "N" + CHR(227) + "o"
2556:                 .Width     = 43
2557:                 .Height    = 17
2558:                 .Left      = 45
2559:                 .Top       = 0
2560:                 .BackStyle = 0
2561:                 .FontName  = "Tahoma"
2562:                 .FontSize  = 8
2563:                 .Visible   = .T.
2564:             ENDWITH
2565:         ENDWITH
2566: 
2567:         *-- Label: Integracao Zerada
2568:         loc_oPg2.AddObject("lbl_4c_Label30", "Label")
2569:         WITH loc_oPg2.lbl_4c_Label30
2570:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
2571:             .Top       = 108
2572:             .Left      = 538
2573:             .Width     = 99
2574:             .Height    = 15
2575:             .FontName  = "Tahoma"
2576:             .FontSize  = 8
2577:             .BackStyle = 0
2578:             .Visible   = .T.
2579:         ENDWITH
2580: 
2581:         *-- obj_4c_OptZeradas - zeradas numeric(1,0), 2 buttons Sim/Nao
2582:         loc_oPg2.AddObject("obj_4c_OptZeradas", "OptionGroup")
2583:         WITH loc_oPg2.obj_4c_OptZeradas
2584:             .Top         = 103
2585:             .Left        = 638
2586:             .Width       = 94
2587:             .Height      = 27
2588:             .ButtonCount = 2
2589:             .BackStyle   = 0
2590:             .Value       = 2
2591:             .Visible     = .T.
2592: 
2593:             WITH .Buttons(1)
2594:                 .Caption   = "Sim"
2595:                 .Width     = 43
2596:                 .Height    = 17
2597:                 .Left      = 0
2598:                 .Top       = 0
2599:                 .BackStyle = 0
2600:                 .Visible   = .T.
2601:             ENDWITH
2602: 
2603:             WITH .Buttons(2)
2604:                 .Caption   = "N" + CHR(227) + "o"
2605:                 .Width     = 43
2606:                 .Height    = 17
2607:                 .Left      = 45
2608:                 .Top       = 0
2609:                 .BackStyle = 0
2610:                 .FontName  = "Tahoma"
2611:                 .FontSize  = 8
2612:                 .Visible   = .T.
2613:             ENDWITH
2614:         ENDWITH
2615: 
2616:         *-- Label: Data Lancamento Contabil
2617:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
2618:         WITH loc_oPg2.lbl_4c_Label1
2619:             .Caption   = "Data Lan" + CHR(231) + "amento Contabil :"
2620:             .Top       = 132
2621:             .Left      = 502
2622:             .Width     = 135
2623:             .Height    = 15
2624:             .FontName  = "Tahoma"
2625:             .FontSize  = 8
2626:             .BackStyle = 0
2627:             .Visible   = .T.
2628:         ENDWITH
2629: 
2630:         *-- obj_4c_Fwoption1 - dtintfis numeric(1,0): 1=Data Integracao, 2=Data N.F.
2631:         loc_oPg2.AddObject("obj_4c_Fwoption1", "OptionGroup")
2632:         WITH loc_oPg2.obj_4c_Fwoption1
2633:             .Top         = 127
2634:             .Left        = 638
2635:             .Width       = 192
2636:             .Height      = 25
2637:             .ButtonCount = 2
2638:             .BackStyle   = 0
2639:             .Value       = 1
2640:             .Visible     = .T.
2641: 
2642:             WITH .Buttons(1)
2643:                 .Caption   = "Data Integra" + CHR(231) + CHR(227) + "o"
2644:                 .Width     = 97
2645:                 .Height    = 17
2646:                 .Left      = 0
2647:                 .Top       = 0
2648:                 .BackStyle = 0
2649:                 .Visible   = .T.
2650:             ENDWITH
2651: 
2652:             WITH .Buttons(2)
2653:                 .Caption   = "Data N.F."
2654:                 .Width     = 65
2655:                 .Height    = 17
2656:                 .Left      = 122
2657:                 .Top       = 0
2658:                 .BackStyle = 0
2659:                 .FontName  = "Tahoma"
2660:                 .FontSize  = 8
2661:                 .Visible   = .T.
2662:             ENDWITH
2663:         ENDWITH
2664: 
2665:         *-- Label: Utilizar variacao de CFOP na Integracao
2666:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
2667:         WITH loc_oPg2.lbl_4c_Label2
2668:             .Caption   = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
2669:             .Top       = 156
2670:             .Left      = 427
2671:             .Width     = 210
2672:             .Height    = 15
2673:             .FontName  = "Tahoma"
2674:             .FontSize  = 8
2675:             .BackStyle = 0
2676:             .Visible   = .T.
2677:         ENDWITH
2678: 
2679:         *-- obj_4c_Optutilvars - utilvars numeric(1,0), 2 buttons Sim/Nao
2680:         loc_oPg2.AddObject("obj_4c_Optutilvars", "OptionGroup")
2681:         WITH loc_oPg2.obj_4c_Optutilvars
2682:             .Top         = 150
2683:             .Left        = 638
2684:             .Width       = 94
2685:             .Height      = 27
2686:             .ButtonCount = 2
2687:             .BackStyle   = 0
2688:             .Value       = 2
2689:             .Visible     = .T.
2690: 
2691:             WITH .Buttons(1)
2692:                 .Caption   = "Sim"
2693:                 .Width     = 43
2694:                 .Height    = 17
2695:                 .Left      = 0
2696:                 .Top       = 0
2697:                 .BackStyle = 0
2698:                 .Visible   = .T.
2699:             ENDWITH
2700: 
2701:             WITH .Buttons(2)
2702:                 .Caption   = "N" + CHR(227) + "o"
2703:                 .Width     = 43
2704:                 .Height    = 17
2705:                 .Left      = 45
2706:                 .Top       = 0
2707:                 .BackStyle = 0
2708:                 .FontName  = "Tahoma"
2709:                 .FontSize  = 8
2710:                 .Visible   = .T.
2711:             ENDWITH
2712:         ENDWITH
2713: 
2714:         *-- Label: Integracao Fiscal (titulo secao)
2715:         loc_oPg2.AddObject("lbl_4c_Label35", "Label")
2716:         WITH loc_oPg2.lbl_4c_Label35
2717:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Fiscal"
2718:             .Top       = 217
2719:             .Left      = 18
2720:             .Width     = 99
2721:             .Height    = 15
2722:             .FontName  = "Tahoma"
2723:             .FontSize  = 8
2724:             .FontBold  = .T.
2725:             .BackStyle = 0
2726:             .Visible   = .T.
2727:         ENDWITH
2728: 
2729:         *-- Label: Integrar Valor Contabil
2730:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
2731:         WITH loc_oPg2.lbl_4c_Label6
2732:             .Caption   = "Integrar Valor Cont" + CHR(225) + "bil :"
2733:             .Top       = 239
2734:             .Left      = 114
2735:             .Width     = 118
2736:             .Height    = 15
2737:             .FontName  = "Tahoma"
2738:             .FontSize  = 8
2739:             .BackStyle = 0
2740:             .Visible   = .T.
2741:         ENDWITH
2742: 
2743:         *-- obj_4c_Fwoption2 - intvlrcont numeric(1,0), 2 buttons Sim/Nao
2744:         loc_oPg2.AddObject("obj_4c_Fwoption2", "OptionGroup")
2745:         WITH loc_oPg2.obj_4c_Fwoption2
2746:             .Top         = 233
2747:             .Left        = 231
2748:             .Width       = 94
2749:             .Height      = 27
2750:             .ButtonCount = 2
2751:             .BackStyle   = 0
2752:             .Value       = 2
2753:             .Visible     = .T.
2754: 
2755:             WITH .Buttons(1)
2756:                 .Caption   = "Sim"
2757:                 .Width     = 43
2758:                 .Height    = 17
2759:                 .Left      = 0
2760:                 .Top       = 0
2761:                 .BackStyle = 0
2762:                 .Visible   = .T.
2763:             ENDWITH
2764: 
2765:             WITH .Buttons(2)
2766:                 .Caption   = "N" + CHR(227) + "o"
2767:                 .Width     = 43
2768:                 .Height    = 17
2769:                 .Left      = 45
2770:                 .Top       = 0
2771:                 .BackStyle = 0
2772:                 .FontName  = "Tahoma"
2773:                 .FontSize  = 8
2774:                 .Visible   = .T.
2775:             ENDWITH
2776:         ENDWITH
2777: 
2778:         *-- Label: Integrar Valores Icms
2779:         loc_oPg2.AddObject("lbl_4c_Label33", "Label")
2780:         WITH loc_oPg2.lbl_4c_Label33
2781:             .Caption   = "Integrar Valores Icms :"
2782:             .Top       = 259
2783:             .Left      = 120
2784:             .Width     = 112
2785:             .Height    = 15
2786:             .FontName  = "Tahoma"
2787:             .FontSize  = 8
2788:             .BackStyle = 0
2789:             .Visible   = .T.
2790:         ENDWITH
2791: 
2792:         *-- obj_4c_Fwoption3 - intvlricms numeric(1,0), 2 buttons Sim/Nao
2793:         loc_oPg2.AddObject("obj_4c_Fwoption3", "OptionGroup")
2794:         WITH loc_oPg2.obj_4c_Fwoption3
2795:             .Top         = 253
2796:             .Left        = 231
2797:             .Width       = 94
2798:             .Height      = 27
2799:             .ButtonCount = 2
2800:             .BackStyle   = 0
2801:             .Value       = 2
2802:             .Visible     = .T.
2803: 
2804:             WITH .Buttons(1)
2805:                 .Caption   = "Sim"
2806:                 .Width     = 43
2807:                 .Height    = 17
2808:                 .Left      = 0
2809:                 .Top       = 0
2810:                 .BackStyle = 0
2811:                 .Visible   = .T.
2812:             ENDWITH
2813: 
2814:             WITH .Buttons(2)
2815:                 .Caption   = "N" + CHR(227) + "o"
2816:                 .Width     = 43
2817:                 .Height    = 17
2818:                 .Left      = 45
2819:                 .Top       = 0
2820:                 .BackStyle = 0
2821:                 .FontName  = "Tahoma"
2822:                 .FontSize  = 8
2823:                 .Visible   = .T.
2824:             ENDWITH
2825:         ENDWITH
2826: 
2827:         *-- Label: Integrar Valores Ipi
2828:         loc_oPg2.AddObject("lbl_4c_Label34", "Label")
2829:         WITH loc_oPg2.lbl_4c_Label34
2830:             .Caption   = "Integrar Valores Ipi :"
2831:             .Top       = 278
2832:             .Left      = 130
2833:             .Width     = 102
2834:             .Height    = 15
2835:             .FontName  = "Tahoma"
2836:             .FontSize  = 8
2837:             .BackStyle = 0
2838:             .Visible   = .T.
2839:         ENDWITH
2840: 
2841:         *-- obj_4c_Fwoption4 - intvlripi numeric(1,0), 2 buttons Sim/Nao
2842:         loc_oPg2.AddObject("obj_4c_Fwoption4", "OptionGroup")
2843:         WITH loc_oPg2.obj_4c_Fwoption4
2844:             .Top         = 272
2845:             .Left        = 231
2846:             .Width       = 94
2847:             .Height      = 27
2848:             .ButtonCount = 2
2849:             .BackStyle   = 0
2850:             .Value       = 2
2851:             .Visible     = .T.
2852: 
2853:             WITH .Buttons(1)
2854:                 .Caption   = "Sim"
2855:                 .Width     = 43
2856:                 .Height    = 17
2857:                 .Left      = 0
2858:                 .Top       = 0
2859:                 .BackStyle = 0
2860:                 .Visible   = .T.
2861:             ENDWITH
2862: 
2863:             WITH .Buttons(2)
2864:                 .Caption   = "N" + CHR(227) + "o"
2865:                 .Width     = 43
2866:                 .Height    = 17
2867:                 .Left      = 45
2868:                 .Top       = 0
2869:                 .BackStyle = 0
2870:                 .FontName  = "Tahoma"
2871:                 .FontSize  = 8
2872:                 .Visible   = .T.
2873:             ENDWITH
2874:         ENDWITH
2875: 
2876:         *-- Label: Movimentacao Fisica de Estoque
2877:         loc_oPg2.AddObject("lbl_4c_Label38", "Label")
2878:         WITH loc_oPg2.lbl_4c_Label38
2879:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
2880:             .Top       = 298
2881:             .Left      = 68
2882:             .Width     = 164
2883:             .Height    = 15
2884:             .FontName  = "Tahoma"
2885:             .FontSize  = 8
2886:             .BackStyle = 0
2887:             .Visible   = .T.
2888:         ENDWITH
2889: 
2890:         *-- obj_4c_Fwoption5 - indmov numeric(1,0), 2 buttons Sim/Nao
2891:         loc_oPg2.AddObject("obj_4c_Fwoption5", "OptionGroup")
2892:         WITH loc_oPg2.obj_4c_Fwoption5
2893:             .Top         = 292
2894:             .Left        = 231
2895:             .Width       = 94
2896:             .Height      = 27
2897:             .ButtonCount = 2
2898:             .BackStyle   = 0
2899:             .Value       = 2
2900:             .Visible     = .T.
2901: 
2902:             WITH .Buttons(1)
2903:                 .Caption   = "Sim"
2904:                 .Width     = 43
2905:                 .Height    = 17
2906:                 .Left      = 0
2907:                 .Top       = 0
2908:                 .BackStyle = 0
2909:                 .Visible   = .T.
2910:             ENDWITH
2911: 
2912:             WITH .Buttons(2)
2913:                 .Caption   = "N" + CHR(227) + "o"
2914:                 .Width     = 43
2915:                 .Height    = 17
2916:                 .Left      = 45
2917:                 .Top       = 0
2918:                 .BackStyle = 0
2919:                 .FontName  = "Tahoma"
2920:                 .FontSize  = 8
2921:                 .Visible   = .T.
2922:             ENDWITH
2923:         ENDWITH
2924: 
2925:         *-- Label: Indicacao de Pagamento
2926:         loc_oPg2.AddObject("lbl_4c_Label39", "Label")
2927:         WITH loc_oPg2.lbl_4c_Label39
2928:             .Caption   = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
2929:             .Top       = 318
2930:             .Left      = 105
2931:             .Width     = 127
2932:             .Height    = 15
2933:             .FontName  = "Tahoma"
2934:             .FontSize  = 8
2935:             .BackStyle = 0
2936:             .Visible   = .T.
2937:         ENDWITH
2938: 
2939:         *-- obj_4c_Fwoption6 - indpagto numeric(1,0), 2 buttons Sim/Nao
2940:         loc_oPg2.AddObject("obj_4c_Fwoption6", "OptionGroup")
2941:         WITH loc_oPg2.obj_4c_Fwoption6
2942:             .Top         = 312
2943:             .Left        = 231
2944:             .Width       = 94
2945:             .Height      = 27
2946:             .ButtonCount = 2
2947:             .BackStyle   = 0
2948:             .Value       = 2
2949:             .Visible     = .T.
2950: 
2951:             WITH .Buttons(1)
2952:                 .Caption   = "Sim"
2953:                 .Width     = 43
2954:                 .Height    = 17
2955:                 .Left      = 0
2956:                 .Top       = 0
2957:                 .BackStyle = 0
2958:                 .Visible   = .T.
2959:             ENDWITH
2960: 
2961:             WITH .Buttons(2)
2962:                 .Caption   = "N" + CHR(227) + "o"
2963:                 .Width     = 43
2964:                 .Height    = 17
2965:                 .Left      = 45
2966:                 .Top       = 0
2967:                 .BackStyle = 0
2968:                 .FontName  = "Tahoma"
2969:                 .FontSize  = 8
2970:                 .Visible   = .T.
2971:             ENDWITH

*-- Linhas 3004 a 3014:
3004:                     loc_oGrid.Column2.Width = 400
3005: 
3006:                     *-- Re-definir captions APOS RecordSource (VFP auto-bind reseta para nome do campo)
3007:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
3008:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3009:                     loc_oGrid.Column3.Header1.Caption = ""
3010: 
3011:                     *-- situas=1 Ativo (preto), situas!=1 Inativo (vermelho)
3012:                     loc_oGrid.SetAll("DynamicForeColor", ;
3013:                         "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(255,0,0))", "Column")
3014: 

*-- Linhas 3260 a 3268:
3260:             loc_oBO.this_nInclicms   = ALLTRIM(loc_oPage1.cbo_4c_Combo3.Value)
3261:             loc_oBO.this_nIcmsdscs   = ALLTRIM(loc_oPage1.cbo_4c_Combo10.Value)
3262:             loc_oBO.this_nIcmsincs   = ALLTRIM(loc_oPage1.cbo_4c_Combo6.Value)
3263:             loc_oBO.this_nIncicmnfs  = IIF(loc_oPage1.chk_4c_Fwcheckbox1.Value, 1, 0)
3264:             loc_oBO.this_cCgergia1s  = ALLTRIM(loc_oPage1.txt_4c_Gergia1.Value)
3265:             loc_oBO.this_nFrticms    = IIF(loc_oPage1.chk_4c_ObjFreteICM.Value, 1, 0)
3266:             loc_oBO.this_nSegicms    = IIF(loc_oPage1.chk_4c_ObjSegIcm.Value, 1, 0)
3267:             loc_oBO.this_nDesicms    = IIF(loc_oPage1.chk_4c_ObjDespIcm.Value, 1, 0)
3268: 

*-- Linhas 3368 a 3376:
3368:             loc_oPage1.cbo_4c_Combo3.Value       = LTRIM(STR(loc_oBO.this_nInclicms, 1))
3369:             loc_oPage1.cbo_4c_Combo10.Value      = LTRIM(STR(loc_oBO.this_nIcmsdscs, 1))
3370:             loc_oPage1.cbo_4c_Combo6.Value       = LTRIM(STR(loc_oBO.this_nIcmsincs, 1))
3371:             loc_oPage1.chk_4c_Fwcheckbox1.Value  = IIF(loc_oBO.this_nIncicmnfs = 1, 1, 0)
3372:             loc_oPage1.txt_4c_Gergia1.Value      = loc_oBO.this_cCgergia1s
3373:             loc_oPage1.chk_4c_ObjFreteICM.Value  = IIF(loc_oBO.this_nFrticms = 1, 1, 0)
3374:             loc_oPage1.chk_4c_ObjSegIcm.Value    = IIF(loc_oBO.this_nSegicms = 1, 1, 0)
3375:             loc_oPage1.chk_4c_ObjDespIcm.Value   = IIF(loc_oBO.this_nDesicms = 1, 1, 0)
3376: 

*-- Linhas 3534 a 3542:
3534:                 CASE VARTYPE(loc_oCtrl.Value) = "N"
3535:                     loc_oCtrl.Value = 0
3536:                 CASE VARTYPE(loc_oCtrl.Value) = "L"
3537:                     loc_oCtrl.Value = .F.
3538:                 CASE VARTYPE(loc_oCtrl.Value) = "D"
3539:                     loc_oCtrl.Value = {}
3540:                 ENDCASE
3541:             ENDIF
3542:             IF VARTYPE(loc_oCtrl) = "O" AND PEMSTATUS(loc_oCtrl, "ControlCount", 5)

*-- Linhas 3568 a 3576:
3568:             loc_oCtrl = par_oContainer.Controls(loc_nI)
3569:             IF VARTYPE(loc_oCtrl) = "O"
3570:                 loc_cBase = UPPER(loc_oCtrl.BaseClass)
3571:                 IF INLIST(loc_cBase, "TEXTBOX", "EDITBOX", "COMBOBOX", "CHECKBOX", ;
3572:                         "SPINNER", "OPTIONGROUP")
3573:                     IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
3574:                         loc_oCtrl.Enabled = par_lHabilitar
3575:                     ENDIF
3576:                 ENDIF

*-- Linhas 3807 a 3815:
3807:             loc_oCntSalva  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
3808:             loc_lEditavel  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3809:             IF VARTYPE(loc_oCntSalva) = "O"
3810:                 loc_oCntSalva.cmd_4c_Salvar.Enabled = loc_lEditavel
3811:             ENDIF
3812:         CATCH TO loc_oErro
3813:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
3814:         ENDTRY
3815:     ENDPROC


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*==============================================================================
* cfoBO.prg - Business Object para Cadastro de CFOP
* Tabela: SigCdCfo
* Chave: codigos
*==============================================================================

DEFINE CLASS cfoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdCfo (mapeados diretamente do schema)
    *--------------------------------------------------------------------------

    *-- Identificacao e descricao
    this_cCodigos    = ""    && codigos     char(10)  PK
    this_cDescricaos = ""    && descricaos  char(60)  Descricao nota fiscal
    this_cDesc2s     = ""    && desc2s      char(60)  Descricao consulta

    *-- Operacao e tipo
    this_cOperacaos  = ""    && operacaos   char(1)   E=Entrada S=Saida
    this_nTipos      = 0     && tipos       numeric(1,0)
    this_nNdigitos   = 0     && ndigitos    numeric(2,0)  Digitos para NF

    *-- ICMS
    this_cIcms       = ""    && icms        char(1)   T=Tributado I=Isento O=Outros N=N.Tributa
    this_cSittribs   = ""    && sittribs    char(3)   Situacao tributaria ICMS
    this_nAliqivcs   = 0     && aliqivcs    numeric(4,2)  Aliquota venda consumidor
    this_nInclicms   = 0     && inclicms    numeric(1,0)  Incluir ICMS na base
    this_nIcmsdscs   = 0     && icmsdscs    numeric(1,0)  ICMS incluso no preco
    this_nIcmsincs   = 0     && icmsincs    numeric(1,0)  Integrar valores ICMS
    this_nIncicmnfs  = 0     && incicmnfs   numeric(1,0)  Incluir ICMS no total da NF
    this_cCgergia1s  = ""    && cgergia1s   char(1)   Destaca ICMS na NF S/N
    this_nFrticms    = 0     && frticms     numeric(1,0)  Frete compoe base ICMS
    this_nSegicms    = 0     && segicms     numeric(1,0)  Seguro compoe base ICMS
    this_nDesicms    = 0     && desicms     numeric(1,0)  Despesas compoe base ICMS

    *-- Substituicao tributaria ICMS
    this_cSubtribs   = ""    && subtribs    char(1)   Substituicao tributaria S/N
    this_nPbcsts     = 0     && pbcsts      numeric(5,2)  % base ST
    this_cCfosts     = ""    && cfosts      char(10)  CFOP subst. tributaria
    this_cCoddests   = ""    && coddests    char(10)  CFOP destino
    this_nTransps    = 0     && transps     numeric(1,0)  CFOP transporte

    *-- IPI
    this_cIpis       = ""    && ipis        char(1)   T=Tributado I=Isento O=Outros
    this_cIpi_icms   = ""    && ipi_icms    char(1)   IPI sobre ICMS
    this_nInclipis   = 0     && inclipis    numeric(1,0)  Incluir IPI na base
    this_nPbcipis    = 0     && pbcipis     numeric(5,2)  % base IPI
    this_cBcipis     = ""    && bcipis      char(1)   Base de calculo IPI
    this_nAliqipis   = 0     && aliqipis    numeric(4,2)  Aliquota IPI
    this_cAcresipis  = ""    && acresipis   char(1)   Acrescenta na base
    this_cIpiimpors  = ""    && ipiimpors   char(1)   IPI importacao
    this_cIpiom2s    = ""    && ipiom2s     char(1)   IPI calc. p/ origem mercadoria=2
    this_nFrtipis    = 0     && frtipis     numeric(1,0)  Frete compoe base IPI
    this_nSegipis    = 0     && segipis     numeric(1,0)  Seguro compoe base IPI
    this_nDesipis    = 0     && desipis     numeric(1,0)  Despesas compoe base IPI
    this_nIpincreds  = 0     && ipincreds   numeric(1,0)  IPI nao creditado
    this_nPontedescs = 0     && pontedescs  numeric(1,0)  Retira IPI do valor
    this_cIpicst     = ""    && ipicst      char(2)   Codigo IPI sit. tributaria NF-e
    this_cIpienq     = ""    && ipienq      char(3)   Enquadramento IPI
    this_cUnitimps   = ""    && unitimps    char(1)   Inibe valor unitario NF importacao

    *-- PIS / COFINS / ISSQN / II
    this_cPiscst     = ""    && piscst      char(2)   Codigo PIS sit. tributaria
    this_cCofcst     = ""    && cofcst      char(2)   Codigo COFINS sit. tributaria
    this_cIssqnl     = ""    && issqnl      char(5)   Codigo ISSQN lista servicos
    this_nAliqpis    = 0     && aliqpis     numeric(5,2)  Aliquota PIS
    this_nAliqcofins = 0     && aliqcofins  numeric(5,2)  Aliquota COFINS
    this_nAliqissqn  = 0     && aliqissqn   numeric(5,2)  Aliquota ISSQN
    this_nAliqii     = 0     && aliqii      numeric(5,2)  Aliquota II
    this_nCtissqn    = 0     && ctissqn     numeric(1,0)  Codigo tributacao ISSQN
    this_nRettribs   = 0     && rettribs    numeric(1,0)  Informa retencao de tributos

    *-- Contribuinte / Situacao
    this_cContribs   = ""    && contribs    char(1)   S=Sim N=Nao O=Outros
    this_nSituas     = 0     && situas      numeric(1,0)  0=Ativo 1=Inativo
    this_cCfost60s   = ""    && cfost60s    char(10)  CFOP ST60
    this_nSomaicmfrete = 0   && somaicmfrete numeric(1,0)
    this_cMotdeson   = ""    && motdeson    char(2)   Motivo desoneracao ICMS

    *-- Integracao Contabil - Contas DB/CR
    this_cContconts  = ""    && contconts   char(1)   Pega conta contabil da NF
    this_cContvcds   = ""    && contvcds    char(9)   Conta valor contabil DB
    this_cContvccs   = ""    && contvccs    char(9)   Conta valor contabil CR
    this_cContipds   = ""    && contipds    char(9)   Conta IPI DB
    this_cContipcs   = ""    && contipcs    char(9)   Conta IPI CR
    this_cConticds   = ""    && conticds    char(9)   Conta ICMS DB
    this_cConticcs   = ""    && conticcs    char(9)   Conta ICMS CR
    this_cContfrt    = ""    && contfrt     char(9)   Conta frete
    this_cContseg    = ""    && contseg     char(9)   Conta seguro
    this_cContda     = ""    && contda      char(9)   Conta despesas acessorias

    *-- Integracao Contabil - Opcoes
    this_nAgrupas    = 0     && agrupas     numeric(1,0)  Agrupa CFO na integracao
    this_nZeradas    = 0     && zeradas     numeric(1,0)  Integracao zerada
    this_nIntvlrcont = 0     && intvlrcont  numeric(1,0)  Integrar valor contabil
    this_nIntvlricms = 0     && intvlricms  numeric(1,0)  Integrar valores ICMS
    this_nIntvlripi  = 0     && intvlripi   numeric(1,0)  Integrar valores IPI
    this_nUtilvars   = 0     && utilvars    numeric(1,0)  Utilizar variacao CFOP
    this_nIndmov     = 0     && indmov      numeric(1,0)  Movimentacao fisica estoque
    this_nIndpagto   = 0     && indpagto    numeric(1,0)  Indicacao pagamento
    this_nTiporecs   = 0     && tiporecs    numeric(1,0)  Data lancamento contabil
    this_nObspads    = 0     && obspads     numeric(3,0)  Observacao padrao
    this_nDtintfis   = 0     && dtintfis    numeric(1,0)  Integracao fiscal

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCfo"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos      = TratarNulo(codigos,      "C")
                THIS.this_cDescricaos   = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s       = TratarNulo(desc2s,       "C")
                THIS.this_cOperacaos    = TratarNulo(operacaos,    "C")
                THIS.this_nTipos        = TratarNulo(tipos,        "N")
                THIS.this_nNdigitos     = TratarNulo(ndigitos,     "N")
                THIS.this_cIcms         = TratarNulo(icms,         "C")
                THIS.this_cSittribs     = TratarNulo(sittribs,     "C")
                THIS.this_nAliqivcs     = TratarNulo(aliqivcs,     "N")
                THIS.this_nInclicms     = TratarNulo(inclicms,     "N")
                THIS.this_nIcmsdscs     = TratarNulo(icmsdscs,     "N")
                THIS.this_nIcmsincs     = TratarNulo(icmsincs,     "N")
                THIS.this_nIncicmnfs    = TratarNulo(incicmnfs,    "N")
                THIS.this_cCgergia1s    = TratarNulo(cgergia1s,    "C")
                THIS.this_nFrticms      = TratarNulo(frticms,      "N")
                THIS.this_nSegicms      = TratarNulo(segicms,      "N")
                THIS.this_nDesicms      = TratarNulo(desicms,      "N")
                THIS.this_cSubtribs     = TratarNulo(subtribs,     "C")
                THIS.this_nPbcsts       = TratarNulo(pbcsts,       "N")
                THIS.this_cCfosts       = TratarNulo(cfosts,       "C")
                THIS.this_cCoddests     = TratarNulo(coddests,     "C")
                THIS.this_nTransps      = TratarNulo(transps,      "N")
                THIS.this_cIpis         = TratarNulo(ipis,         "C")
                THIS.this_cIpi_icms     = TratarNulo(ipi_icms,     "C")
                THIS.this_nInclipis     = TratarNulo(inclipis,     "N")
                THIS.this_nPbcipis      = TratarNulo(pbcipis,      "N")
                THIS.this_cBcipis       = TratarNulo(bcipis,       "C")
                THIS.this_nAliqipis     = TratarNulo(aliqipis,     "N")
                THIS.this_cAcresipis    = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors    = TratarNulo(ipiimpors,    "C")
                THIS.this_cIpiom2s      = TratarNulo(ipiom2s,      "C")
                THIS.this_nFrtipis      = TratarNulo(frtipis,      "N")
                THIS.this_nSegipis      = TratarNulo(segipis,      "N")
                THIS.this_nDesipis      = TratarNulo(desipis,      "N")
                THIS.this_nIpincreds    = TratarNulo(ipincreds,    "N")
                THIS.this_nPontedescs   = TratarNulo(pontedescs,   "N")
                THIS.this_cIpicst       = TratarNulo(ipicst,       "C")
                THIS.this_cIpienq       = TratarNulo(ipienq,       "C")
                THIS.this_cUnitimps     = TratarNulo(unitimps,     "C")
                THIS.this_cPiscst       = TratarNulo(piscst,       "C")
                THIS.this_cCofcst       = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl       = TratarNulo(issqnl,       "C")
                THIS.this_nAliqpis      = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqcofins   = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqissqn    = TratarNulo(aliqissqn,    "N")
                THIS.this_nAliqii       = TratarNulo(aliqii,       "N")
                THIS.this_nCtissqn      = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs     = TratarNulo(rettribs,     "N")
                THIS.this_cContribs     = TratarNulo(contribs,     "C")
                THIS.this_nSituas       = TratarNulo(situas,       "N")
                THIS.this_cCfost60s     = TratarNulo(cfost60s,     "C")
                THIS.this_nSomaicmfrete = TratarNulo(somaicmfrete, "N")
                THIS.this_cMotdeson     = TratarNulo(motdeson,     "C")
                THIS.this_cContconts    = TratarNulo(contconts,    "C")
                THIS.this_cContvcds     = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs     = TratarNulo(contvccs,     "C")
                THIS.this_cContipds     = TratarNulo(contipds,     "C")
                THIS.this_cContipcs     = TratarNulo(contipcs,     "C")
                THIS.this_cConticds     = TratarNulo(conticds,     "C")
                THIS.this_cConticcs     = TratarNulo(conticcs,     "C")
                THIS.this_cContfrt      = TratarNulo(contfrt,      "C")
                THIS.this_cContseg      = TratarNulo(contseg,      "C")
                THIS.this_cContda       = TratarNulo(contda,       "C")
                THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas      = TratarNulo(zeradas,      "N")
                THIS.this_nIntvlrcont   = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms   = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi    = TratarNulo(intvlripi,    "N")
                THIS.this_nUtilvars     = TratarNulo(utilvars,     "N")
                THIS.this_nIndmov       = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto     = TratarNulo(indpagto,     "N")
                THIS.this_nTiporecs     = TratarNulo(tiporecs,     "N")
                THIS.this_nObspads      = TratarNulo(obspads,      "N")
                THIS.this_nDtintfis     = TratarNulo(dtintfis,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, ;
                "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cCols, loc_cVals, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cCols = "codigos, descricaos, desc2s, operacaos, tipos, ndigitos," + ;
                " icms, sittribs, aliqivcs, inclicms, icmsdscs, icmsincs, incicmnfs, cgergia1s," + ;
                " frticms, segicms, desicms, subtribs, pbcsts, cfosts, coddests, transps," + ;
                " ipis, ipi_icms, inclipis, pbcipis, bcipis, aliqipis, acresipis, ipiimpors," + ;
                " ipiom2s, frtipis, segipis, desipis, ipincreds, pontedescs, ipicst, ipienq," + ;
                " unitimps, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn, aliqii," + ;
                " ctissqn, rettribs, contribs, situas, cfost60s, somaicmfrete, motdeson," + ;
                " contconts, contvcds, contvccs, contipds, contipcs, conticds, conticcs," + ;
                " contfrt, contseg, contda, agrupas, zeradas, intvlrcont, intvlricms," + ;
                " intvlripi, utilvars, indmov, indpagto, tiporecs, obspads, dtintfis"

            loc_cVals = EscaparSQL(THIS.this_cCodigos) + ", " + ;
                EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                EscaparSQL(THIS.this_cIcms) + ", " + ;
                EscaparSQL(THIS.this_cSittribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                EscaparSQL(THIS.this_cCfosts) + ", " + ;
                EscaparSQL(THIS.this_cCoddests) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                EscaparSQL(THIS.this_cIpi_icms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                EscaparSQL(THIS.this_cBcipis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpicst) + ", " + ;
                EscaparSQL(THIS.this_cIpienq) + ", " + ;
                EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                EscaparSQL(THIS.this_cPiscst) + ", " + ;
                EscaparSQL(THIS.this_cCofcst) + ", " + ;
                EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                EscaparSQL(THIS.this_cContribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                EscaparSQL(THIS.this_cContconts) + ", " + ;
                EscaparSQL(THIS.this_cContvcds) + ", " + ;
                EscaparSQL(THIS.this_cContvccs) + ", " + ;
                EscaparSQL(THIS.this_cContipds) + ", " + ;
                EscaparSQL(THIS.this_cContipcs) + ", " + ;
                EscaparSQL(THIS.this_cConticds) + ", " + ;
                EscaparSQL(THIS.this_cConticcs) + ", " + ;
                EscaparSQL(THIS.this_cContfrt) + ", " + ;
                EscaparSQL(THIS.this_cContseg) + ", " + ;
                EscaparSQL(THIS.this_cContda) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObspads, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDtintfis, 0)

            loc_cSQL = "INSERT INTO SigCdCfo (" + loc_cCols + ") VALUES (" + loc_cVals + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_cSet, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSet = "descricaos = "  + EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                "desc2s = "             + EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                "operacaos = "          + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                "tipos = "              + FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                "ndigitos = "           + FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                "icms = "               + EscaparSQL(THIS.this_cIcms) + ", " + ;
                "sittribs = "           + EscaparSQL(THIS.this_cSittribs) + ", " + ;
                "aliqivcs = "           + FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                "inclicms = "           + FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                "icmsdscs = "           + FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                "icmsincs = "           + FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                "incicmnfs = "          + FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                "cgergia1s = "          + EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                "frticms = "            + FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                "segicms = "            + FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                "desicms = "            + FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                "subtribs = "           + EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                "pbcsts = "             + FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                "cfosts = "             + EscaparSQL(THIS.this_cCfosts) + ", " + ;
                "coddests = "           + EscaparSQL(THIS.this_cCoddests) + ", " + ;
                "transps = "            + FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                "ipis = "               + EscaparSQL(THIS.this_cIpis) + ", " + ;
                "ipi_icms = "           + EscaparSQL(THIS.this_cIpi_icms) + ", " + ;
                "inclipis = "           + FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                "pbcipis = "            + FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                "bcipis = "             + EscaparSQL(THIS.this_cBcipis) + ", " + ;
                "aliqipis = "           + FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                "acresipis = "          + EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                "ipiimpors = "          + EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                "ipiom2s = "            + EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                "frtipis = "            + FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                "segipis = "            + FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                "desipis = "            + FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                "ipincreds = "          + FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                "pontedescs = "         + FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                "ipicst = "             + EscaparSQL(THIS.this_cIpicst) + ", " + ;
                "ipienq = "             + EscaparSQL(THIS.this_cIpienq) + ", " + ;
                "unitimps = "           + EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                "piscst = "             + EscaparSQL(THIS.this_cPiscst) + ", " + ;
                "cofcst = "             + EscaparSQL(THIS.this_cCofcst) + ", " + ;
                "issqnl = "             + EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                "aliqpis = "            + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                "aliqcofins = "         + FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                "aliqissqn = "          + FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                "aliqii = "             + FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                "ctissqn = "            + FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                "rettribs = "           + FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                "contribs = "           + EscaparSQL(THIS.this_cContribs) + ", " + ;
                "situas = "             + FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                "cfost60s = "           + EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                "somaicmfrete = "       + FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                "motdeson = "           + EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                "contconts = "          + EscaparSQL(THIS.this_cContconts) + ", " + ;
                "contvcds = "           + EscaparSQL(THIS.this_cContvcds) + ", " + ;
                "contvccs = "           + EscaparSQL(THIS.this_cContvccs) + ", " + ;
                "contipds = "           + EscaparSQL(THIS.this_cContipds) + ", " + ;
                "contipcs = "           + EscaparSQL(THIS.this_cContipcs) + ", " + ;
                "conticds = "           + EscaparSQL(THIS.this_cConticds) + ", " + ;
                "conticcs = "           + EscaparSQL(THIS.this_cConticcs) + ", " + ;
                "contfrt = "            + EscaparSQL(THIS.this_cContfrt) + ", " + ;
                "contseg = "            + EscaparSQL(THIS.this_cContseg) + ", " + ;
                "contda = "             + EscaparSQL(THIS.this_cContda) + ", " + ;
                "agrupas = "            + FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                "zeradas = "            + FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                "intvlrcont = "         + FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                "intvlricms = "         + FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                "intvlripi = "          + FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                "utilvars = "           + FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                "indmov = "             + FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                "indpagto = "           + FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                "tiporecs = "           + FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                "obspads = "            + FormatarNumeroSQL(THIS.this_nObspads, 0) + ", " + ;
                "dtintfis = "           + FormatarNumeroSQL(THIS.this_nDtintfis, 0)

            loc_cSQL = "UPDATE SigCdCfo SET " + loc_cSet + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCfo WHERE codigos = " + ;
                EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descricaos, desc2s, operacaos, situas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), ;
                        desc2s C(60), operacaos C(1), situas N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT codigos, descricaos, desc2s, operacaos, situas" + ;
                " FROM SigCdCfo"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

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
                    MostrarErro("Erro ao buscar CFOPs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOPs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, desc2s, operacaos, tipos, ndigitos," + ;
                " icms, sittribs, aliqivcs, inclicms, icmsdscs, icmsincs, incicmnfs, cgergia1s," + ;
                " frticms, segicms, desicms, subtribs, pbcsts, cfosts, coddests, transps," + ;
                " ipis, ipi_icms, inclipis, pbcipis, bcipis, aliqipis, acresipis, ipiimpors," + ;
                " ipiom2s, frtipis, segipis, desipis, ipincreds, pontedescs, ipicst, ipienq," + ;
                " unitimps, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn, aliqii," + ;
                " ctissqn, rettribs, contribs, situas, cfost60s, somaicmfrete, motdeson," + ;
                " contconts, contvcds, contvccs, contipds, contipcs, conticds, conticcs," + ;
                " contfrt, contseg, contda, agrupas, zeradas, intvlrcont, intvlricms," + ;
                " intvlripi, utilvars, indmov, indpagto, tiporecs, obspads, dtintfis" + ;
                " FROM SigCdCfo WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da nota fiscal obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE

