# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 169: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 192: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 215: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 238: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 261: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 295: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 369: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 393: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGACGCT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1877 linhas total):

*-- Linhas 45 a 64:
45:         loc_lSucesso = .F.
46: 
47:         TRY
48:             THIS.Caption = "Acesso  Lan" + CHR(231) + "amentos"
49: 
50:             THIS.this_oBusinessObject = CREATEOBJECT("SIGACGCTBO")
51: 
52:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
53:                 MostrarErro("Erro ao criar Business Object SIGACGCTBO", "Erro Cr" + CHR(237) + "tico")
54:             ELSE
55:                 THIS.ConfigurarPageFrame()
56:                 THIS.ConfigurarPaginaLista()
57:                 THIS.ConfigurarPaginaDados()
58: 
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60: 
61:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
62:                     IF !THIS.CarregarLista()
63:                         *-- Falha ao carregar nao impede abertura
64:                     ENDIF

*-- Linhas 81 a 141:
81: 
82:     *==========================================================================
83:     * ConfigurarPageFrame - Configura PageFrame principal
84:     * PageFrame.Top = -29 (oculta abas), compensar +29 nos containers
85:     *==========================================================================
86:     PROTECTED PROCEDURE ConfigurarPageFrame()
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .Top       = -29
91:             .Left      = 0
92:             .Width     = 1003
93:             .Height    = 629
94:             .PageCount = 2
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
106:     ENDPROC
107: 
108:     *==========================================================================
109:     * ConfigurarPaginaLista - Configura Page1 (Lista)
110:     * Compensacao PageFrame.Top=-29: todos os controles Top += 29
111:     * cntSombra.Top=2 -> 31 | Grupo_Op.Top=0 -> 29 | Grupo_Saida can?nico
112:     *==========================================================================
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPagina
115:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
116: 
117:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
118:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
119: 
120:         *-- Container de cabecalho (cntSombra: Top=2 -> 31)
121:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
122:         WITH loc_oPagina.cnt_4c_Cabecalho
123:             .Top         = 31
124:             .Left        = 0
125:             .Width       = 1003
126:             .Height      = 80
127:             .BackStyle   = 0
128:             .BorderWidth = 0
129:             .Visible     = .T.
130:         ENDWITH
131: 
132:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
133:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
134:             .Caption   = "Acesso  Lan" + CHR(231) + "amentos"
135:             .Top       = 20
136:             .Left      = 20
137:             .Width     = 400
138:             .Height    = 30
139:             .FontName  = "Tahoma"
140:             .FontSize  = 14
141:             .FontBold  = .T.

*-- Linhas 147 a 316:
147:         *-- Container de botoes CRUD (Grupo_Op: Left=544, Top=0 -> 29)
148:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
149:         WITH loc_oPagina.cnt_4c_Botoes
150:             .Top         = 29
151:             .Left        =  542
152:             .Width       = 390
153:             .Height      = 85
154:             .BackStyle   = 0
155:             .BorderWidth = 0
156:             .Visible     = .T.
157:         ENDWITH
158: 
159:         *-- Botao Incluir (Left=5)
160:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
161:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
162:             .Caption         = "Incluir"
163:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
164:             .PicturePosition = 13
165:             .Top             = 5
166:             .Left            = 5
167:             .Width           = 75
168:             .Height          = 75
169:             .FontName        = "Comic Sans MS"
170:             .FontSize        = 8
171:             .FontBold        = .T.
172:             .FontItalic      = .T.
173:             .Themes          = .F.
174:             .SpecialEffect   = 0
175:             .BackColor       = RGB(255, 255, 255)
176:             .ForeColor       = RGB(90, 90, 90)
177:             .WordWrap        = .T.
178:             .Visible         = .T.
179:         ENDWITH
180:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
181: 
182:         *-- Botao Visualizar (Left=80)
183:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
184:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
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
196:             .Themes          = .F.
197:             .SpecialEffect   = 0
198:             .BackColor       = RGB(255, 255, 255)
199:             .ForeColor       = RGB(90, 90, 90)
200:             .WordWrap        = .T.
201:             .Visible         = .T.
202:         ENDWITH
203:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
204: 
205:         *-- Botao Alterar (Left=155)
206:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
207:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
208:             .Caption         = "Alterar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 155
213:             .Width           = 75
214:             .Height          = 75
215:             .FontName        = "Comic Sans MS"
216:             .FontSize        = 8
217:             .FontBold        = .T.
218:             .FontItalic      = .T.
219:             .Themes          = .F.
220:             .SpecialEffect   = 0
221:             .BackColor       = RGB(255, 255, 255)
222:             .ForeColor       = RGB(90, 90, 90)
223:             .WordWrap        = .T.
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
227: 
228:         *-- Botao Excluir (Left=230)
229:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
230:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
231:             .Caption         = "Excluir"
232:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
233:             .PicturePosition = 13
234:             .Top             = 5
235:             .Left            = 230
236:             .Width           = 75
237:             .Height          = 75
238:             .FontName        = "Comic Sans MS"
239:             .FontSize        = 8
240:             .FontBold        = .T.
241:             .FontItalic      = .T.
242:             .Themes          = .F.
243:             .SpecialEffect   = 0
244:             .BackColor       = RGB(255, 255, 255)
245:             .ForeColor       = RGB(90, 90, 90)
246:             .WordWrap        = .T.
247:             .Visible         = .T.
248:         ENDWITH
249:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
250: 
251:         *-- Botao Buscar (Left=305)
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
254:             .Caption         = "Buscar"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
256:             .PicturePosition = 13
257:             .Top             = 5
258:             .Left            = 305
259:             .Width           = 75
260:             .Height          = 75
261:             .FontName        = "Comic Sans MS"
262:             .FontSize        = 8
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .Themes          = .F.
266:             .SpecialEffect   = 0
267:             .BackColor       = RGB(255, 255, 255)
268:             .ForeColor       = RGB(90, 90, 90)
269:             .WordWrap        = .T.
270:             .Visible         = .T.
271:         ENDWITH
272:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
273: 
274:         *-- Container canonico de saida (Grupo_Saida: Left=917, Top=0 -> 29)
275:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
276:         WITH loc_oPagina.cnt_4c_Saida
277:             .Top         = 29
278:             .Left        = 917
279:             .Width       = 90
280:             .Height      = 85
281:             .BackStyle   = 0
282:             .BorderWidth = 0
283:             .Visible     = .T.
284:         ENDWITH
285: 
286:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
287:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
288:             .Caption         = "Encerrar"
289:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
290:             .PicturePosition = 13
291:             .Width           = 75
292:             .Height          = 75
293:             .Left            = 5
294:             .Top             = 5
295:             .FontName        = "Comic Sans MS"
296:             .FontSize        = 8
297:             .FontBold        = .T.
298:             .FontItalic      = .T.
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .BackColor       = RGB(255, 255, 255)
302:             .ForeColor       = RGB(90, 90, 90)
303:             .Visible         = .T.
304:         ENDWITH
305:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
306: 
307:         *-- Grid de lista (Grade: Top=117, Left=26, Width=890, Height=455)
308:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
309:         WITH loc_oPagina.grd_4c_Lista
310:             .Top                = 117
311:             .Left               = 26
312:             .Width              = 890
313:             .Height             = 455
314:             .ColumnCount        = 5
315:             .FontName           = "Verdana"
316:             .FontSize           = 8

*-- Linhas 334 a 494:
334: 
335:     *==========================================================================
336:     * ConfigurarPaginaDados - Configura Page2 (Dados)
337:     * Compensacao PageFrame.Top=-29: todos os controles Top += 29
338:     * Fase 5/8: Botoes + Secao Usuario + Secao Grupo Contabil
339:     *==========================================================================
340:     PROTECTED PROCEDURE ConfigurarPaginaDados()
341:         LOCAL loc_oPagina
342:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
343: 
344:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
345:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
346: 
347:         *-- Container de botoes de acao (Grupo_Salva: Left=842, Top=4 -> 33)
348:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
349:         WITH loc_oPagina.cnt_4c_BotoesAcao
350:             .Top         = 33
351:             .Left        = 842
352:             .Width       = 160
353:             .Height      = 85
354:             .BackStyle   = 0
355:             .BorderWidth = 0
356:             .Visible     = .T.
357:         ENDWITH
358: 
359:         *-- Botao Confirmar (Salvar)
360:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
361:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
362:             .Caption         = "Confirmar"
363:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
364:             .PicturePosition = 13
365:             .Top             = 5
366:             .Left            = 5
367:             .Width           = 75
368:             .Height          = 75
369:             .FontName        = "Comic Sans MS"
370:             .FontSize        = 8
371:             .FontBold        = .T.
372:             .FontItalic      = .T.
373:             .Themes          = .F.
374:             .SpecialEffect   = 0
375:             .BackColor       = RGB(255, 255, 255)
376:             .ForeColor       = RGB(90, 90, 90)
377:             .WordWrap        = .T.
378:             .Enabled         = .F.
379:             .Visible         = .T.
380:         ENDWITH
381:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
382: 
383:         *-- Botao Cancelar
384:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
385:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
386:             .Caption         = "Encerrar"
387:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
388:             .PicturePosition = 13
389:             .Top             = 5
390:             .Left            = 80
391:             .Width           = 75
392:             .Height          = 75
393:             .FontName        = "Comic Sans MS"
394:             .FontSize        = 8
395:             .FontBold        = .T.
396:             .FontItalic      = .T.
397:             .Themes          = .F.
398:             .SpecialEffect   = 0
399:             .BackColor       = RGB(255, 255, 255)
400:             .ForeColor       = RGB(90, 90, 90)
401:             .WordWrap        = .T.
402:             .Visible         = .T.
403:         ENDWITH
404:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
405: 
406:         *======================================================================
407:         * SECAO USUARIO
408:         * Say2("Usuario"): top=105+29=134 | Shape1: top=122+29=151
409:         * Get_Grupo: top=126+29=155 | Get_Usuario: top=150+29=179
410:         *======================================================================
411: 
412:         *-- Shape1 - separador horizontal da secao Usuario (top=122+29=151)
413:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
414:         WITH loc_oPagina.shp_4c_Shape1
415:             .Top         = 151
416:             .Left        = 159
417:             .Width       = 151
418:             .Height      = 2
419:             .BackColor   = RGB(90, 90, 90)
420:             .BorderColor = RGB(90, 90, 90)
421:             .Visible     = .T.
422:         ENDWITH
423: 
424:         *-- Label "Usuario" - titulo da secao (Say2: top=105+29=134)
425:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
426:         WITH loc_oPagina.lbl_4c_Label2
427:             .Caption   = "Usu" + CHR(225) + "rio"
428:             .Top       = 134
429:             .Left      = 166
430:             .AutoSize  = .T.
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .FontBold  = .T.
434:             .BackStyle = 0
435:             .ForeColor = RGB(90, 90, 90)
436:             .Visible   = .T.
437:         ENDWITH
438: 
439:         *-- Label "Grupo :" para campo txt_4c_Grupo (Say1: top=129+29=158)
440:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
441:         WITH loc_oPagina.lbl_4c_Label1
442:             .Caption   = "Grupo : "
443:             .Top       = 158
444:             .Left      = 175
445:             .AutoSize  = .T.
446:             .FontName  = "Tahoma"
447:             .FontSize  = 8
448:             .BackStyle = 0
449:             .ForeColor = RGB(90, 90, 90)
450:             .Visible   = .T.
451:         ENDWITH
452: 
453:         *-- TextBox Get_Grupo (txt_4c_Grupo: top=126+29=155, left=223, width=80)
454:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
455:         WITH loc_oPagina.txt_4c_Grupo
456:             .Value     = ""
457:             .Top       = 155
458:             .Left      = 223
459:             .Width     = 80
460:             .Height    = 23
461:             .FontName  = "Tahoma"
462:             .FontSize  = 8
463:             .ForeColor = RGB(90, 90, 90)
464:             .BackColor = RGB(255, 255, 255)
465:             .Enabled   = .F.
466:             .Visible   = .T.
467:         ENDWITH
468:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoAcess")
469: 
470:         *-- Label "Nome :" para campo txt_4c_Usuario (Say3: top=154+29=183)
471:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
472:         WITH loc_oPagina.lbl_4c_Label3
473:             .Caption   = "Nome : "
474:             .Top       = 183
475:             .Left      = 177
476:             .AutoSize  = .T.
477:             .FontName  = "Tahoma"
478:             .FontSize  = 8
479:             .BackStyle = 0
480:             .ForeColor = RGB(90, 90, 90)
481:             .Visible   = .T.
482:         ENDWITH
483: 
484:         *-- TextBox Get_Usuario (txt_4c_Usuario: top=150+29=179, left=223, width=80)
485:         loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
486:         WITH loc_oPagina.txt_4c_Usuario
487:             .Value     = ""
488:             .Top       = 179
489:             .Left      = 223
490:             .Width     = 80
491:             .Height    = 23
492:             .FontName  = "Tahoma"
493:             .FontSize  = 8
494:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 507 a 558:
507:         *-- Shape3 - separador horizontal da secao Grupo Contabil (top=212+29=241)
508:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
509:         WITH loc_oPagina.shp_4c_Shape3
510:             .Top         = 241
511:             .Left        = 161
512:             .Width       = 301
513:             .Height      = 2
514:             .BackColor   = RGB(90, 90, 90)
515:             .BorderColor = RGB(90, 90, 90)
516:             .Visible     = .T.
517:         ENDWITH
518: 
519:         *-- Label "Grupo Contabil" - titulo da secao (Say7: top=195+29=224)
520:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
521:         WITH loc_oPagina.lbl_4c_Label7
522:             .Caption   = "Grupo Cont" + CHR(225) + "bil"
523:             .Top       = 224
524:             .Left      = 166
525:             .AutoSize  = .T.
526:             .FontName  = "Tahoma"
527:             .FontSize  = 8
528:             .FontBold  = .T.
529:             .BackStyle = 0
530:             .ForeColor = RGB(90, 90, 90)
531:             .Visible   = .T.
532:         ENDWITH
533: 
534:         *-- Label "Grupo :" para campo txt_4c_GrContab (Say8: top=219+29=248)
535:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
536:         WITH loc_oPagina.lbl_4c_Label8
537:             .Caption   = "Grupo : "
538:             .Top       = 248
539:             .Left      = 175
540:             .AutoSize  = .T.
541:             .FontName  = "Tahoma"
542:             .FontSize  = 8
543:             .BackStyle = 0
544:             .ForeColor = RGB(90, 90, 90)
545:             .Visible   = .T.
546:         ENDWITH
547: 
548:         *-- TextBox Get_GrContab - codigo (txt_4c_GrContab: top=216+29=245, left=223, width=79)
549:         loc_oPagina.AddObject("txt_4c_GrContab", "TextBox")
550:         WITH loc_oPagina.txt_4c_GrContab
551:             .Value     = ""
552:             .Top       = 245
553:             .Left      = 223
554:             .Width     = 79
555:             .Height    = 23
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 566 a 575:
566:         loc_oPagina.AddObject("txt_4c_DGrContab", "TextBox")
567:         WITH loc_oPagina.txt_4c_DGrContab
568:             .Value     = ""
569:             .Top       = 245
570:             .Left      = 303
571:             .Width     = 150
572:             .Height    = 23
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8
575:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 590 a 641:
590:         *-- Shape2 - separador horizontal da secao Conta Corrente (top=282+29=311)
591:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
592:         WITH loc_oPagina.shp_4c_Shape2
593:             .Top         = 311
594:             .Left        = 159
595:             .Width       = 513
596:             .Height      = 2
597:             .BackColor   = RGB(90, 90, 90)
598:             .BorderColor = RGB(90, 90, 90)
599:             .Visible     = .T.
600:         ENDWITH
601: 
602:         *-- Label "Conta Corrente" - titulo da secao (Say6: top=265+29=294)
603:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
604:         WITH loc_oPagina.lbl_4c_Label6
605:             .Caption   = "Conta Corrente"
606:             .Top       = 294
607:             .Left      = 166
608:             .AutoSize  = .T.
609:             .FontName  = "Tahoma"
610:             .FontSize  = 8
611:             .FontBold  = .T.
612:             .BackStyle = 0
613:             .ForeColor = RGB(90, 90, 90)
614:             .Visible   = .T.
615:         ENDWITH
616: 
617:         *-- Label "Grupo :" para campo txt_4c_GrConta (Say4: top=290+29=319)
618:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
619:         WITH loc_oPagina.lbl_4c_Label4
620:             .Caption   = "Grupo : "
621:             .Top       = 319
622:             .Left      = 175
623:             .AutoSize  = .T.
624:             .FontName  = "Tahoma"
625:             .FontSize  = 8
626:             .BackStyle = 0
627:             .ForeColor = RGB(90, 90, 90)
628:             .Visible   = .T.
629:         ENDWITH
630: 
631:         *-- TextBox Get_GrConta - codigo (txt_4c_GrConta: top=288+29=317, left=223, width=79)
632:         loc_oPagina.AddObject("txt_4c_GrConta", "TextBox")
633:         WITH loc_oPagina.txt_4c_GrConta
634:             .Value     = ""
635:             .Top       = 317
636:             .Left      = 223
637:             .Width     = 79
638:             .Height    = 23
639:             .FontName  = "Tahoma"
640:             .FontSize  = 8
641:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 649 a 689:
649:         loc_oPagina.AddObject("txt_4c_DGrConta", "TextBox")
650:         WITH loc_oPagina.txt_4c_DGrConta
651:             .Value     = ""
652:             .Top       = 317
653:             .Left      = 303
654:             .Width     = 150
655:             .Height    = 23
656:             .FontName  = "Tahoma"
657:             .FontSize  = 8
658:             .ForeColor = RGB(90, 90, 90)
659:             .BackColor = RGB(255, 255, 255)
660:             .Enabled   = .F.
661:             .Visible   = .T.
662:         ENDWITH
663:         BINDEVENT(loc_oPagina.txt_4c_DGrConta, "KeyPress", THIS, "ValidarDGrConta")
664: 
665:         *-- Label "Conta :" para campo txt_4c_CdConta (Say5: top=311+29=340)
666:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
667:         WITH loc_oPagina.lbl_4c_Label5
668:             .Caption   = "Conta : "
669:             .Top       = 340
670:             .Left      = 176
671:             .AutoSize  = .T.
672:             .FontName  = "Tahoma"
673:             .FontSize  = 8
674:             .BackStyle = 0
675:             .ForeColor = RGB(90, 90, 90)
676:             .Visible   = .T.
677:         ENDWITH
678: 
679:         *-- TextBox Get_CdConta - codigo da conta (txt_4c_CdConta: top=312+29=341, left=223, width=79)
680:         loc_oPagina.AddObject("txt_4c_CdConta", "TextBox")
681:         WITH loc_oPagina.txt_4c_CdConta
682:             .Value     = ""
683:             .Top       = 341
684:             .Left      = 223
685:             .Width     = 79
686:             .Height    = 23
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 697 a 706:
697:         loc_oPagina.AddObject("txt_4c_DCONTA", "TextBox")
698:         WITH loc_oPagina.txt_4c_DCONTA
699:             .Value     = ""
700:             .Top       = 341
701:             .Left      = 303
702:             .Width     = 360
703:             .Height    = 23
704:             .FontName  = "Tahoma"
705:             .FontSize  = 8
706:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 737 a 749:
737:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.grcontas"
738:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cdcontas"
739: 
740:                         loc_oGrid.Column1.Header1.Caption = "Grupo Acesso"
741:                         loc_oGrid.Column2.Header1.Caption = "Usu" + CHR(225) + "rio Acesso"
742:                         loc_oGrid.Column3.Header1.Caption = "Gr. Cont" + CHR(225) + "bil"
743:                         loc_oGrid.Column4.Header1.Caption = "Gr. Conta"
744:                         loc_oGrid.Column5.Header1.Caption = "Conta"
745: 
746:                         loc_oGrid.Column1.Width = 100
747:                         loc_oGrid.Column2.Width = 140
748:                         loc_oGrid.Column3.Width = 120
749:                         loc_oGrid.Column4.Width = 100

*-- Linhas 916 a 928:
916:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.grcontas"
917:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cdcontas"
918: 
919:                 loc_oGrid.Column1.Header1.Caption = "Grupo Acesso"
920:                 loc_oGrid.Column2.Header1.Caption = "Usu" + CHR(225) + "rio Acesso"
921:                 loc_oGrid.Column3.Header1.Caption = "Gr. Cont" + CHR(225) + "bil"
922:                 loc_oGrid.Column4.Header1.Caption = "Gr. Conta"
923:                 loc_oGrid.Column5.Header1.Caption = "Conta"
924: 
925:                 THIS.FormatarGridLista(loc_oGrid)
926:             ENDIF
927:         CATCH TO loc_oErro
928:             MsgErro("Erro em BtnBuscarClick: " + loc_oErro.Message, "Erro")

*-- Linhas 1186 a 1198:
1186:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1187: 
1188:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1189:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1190:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1191:             ENDIF
1192:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1193:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1194:             ENDIF
1195:         ENDIF
1196:     ENDPROC
1197: 
1198:     *==========================================================================


### BO (C:\4c\projeto\app\classes\SIGACGCTBO.prg):
*==============================================================================
* SIGACGCTBO.prg - Business Object: Acesso Lancamentos
* Tabela: SigSyAgc
* PK: cIdChaves (gerada por fUniqueIds)
*==============================================================================

DEFINE CLASS SIGACGCTBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (nao persistidas - configuradas no Init)
    *--------------------------------------------------------------------------
    this_cTabela     = "SigSyAgc"
    this_cCampoChave = "cIdChaves"

    *--------------------------------------------------------------------------
    * Campos da tabela SigSyAgc
    *--------------------------------------------------------------------------
    this_cIdChaves = ""    && PK (gerada por fUniqueIds)
    this_cGrAcess  = ""    && Grupo Acesso (FK -> SigCdAcG.Grupos)
    this_cUsuAcess = ""    && Usuario Acesso (FK -> SigCdUsu.Usuarios)
    this_cGrContbs = ""    && Grupo Contabil (FK -> SigCdGcr.Codigos)
    this_cGrContas = ""    && Grupo Conta Corrente (FK -> SigCdGcr.Codigos)
    this_cCdContas = ""    && Codigo Conta Corrente (FK -> SigCdCli.Iclis)

    *--------------------------------------------------------------------------
    * Campos de exibicao (nao persistidos na tabela - preenchidos via lookup)
    *--------------------------------------------------------------------------
    this_cDGrContb   = ""  && Descricao Grupo Contabil (SigCdGcr.Descrs)
    this_cDGrConta   = ""  && Descricao Grupo Conta Corrente (SigCdGcr.Descrs)
    this_cDConta     = ""  && Descricao Conta Corrente (SigCdCli.RClis)

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigSyAgc"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Para auditoria (override do BusinessBase)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros da tabela para o grid
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                       " grcontas, cdcontas" + ;
                       " FROM SigSyAgc" + ;
                       " ORDER BY gracess, usuacess"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                           " grcontas, cdcontas" + ;
                           " FROM SigSyAgc" + ;
                           " WHERE gracess LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " OR usuacess LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " ORDER BY gracess, usuacess"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar acessos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo PK (cIdChaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                       " grcontas, cdcontas" + ;
                       " FROM SigSyAgc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de um cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
            THIS.this_cGrAcess  = TratarNulo(gracess,   "C")
            THIS.this_cUsuAcess = TratarNulo(usuacess,  "C")
            THIS.this_cGrContbs = TratarNulo(grcontbs,  "C")
            THIS.this_cGrContas = TratarNulo(grcontas,  "C")
            THIS.this_cCdContas = TratarNulo(cdcontas,  "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDescricoes - Busca descricoes dos campos de lookup
    *==========================================================================
    PROCEDURE CarregarDescricoes()
        LOCAL loc_lResultado, loc_nRes
        loc_lResultado = .T.

        TRY
            IF USED("cursor_4c_Desc")
                USE IN cursor_4c_Desc
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContbs))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrContbs)), "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDGrContb = TratarNulo(Descrs, "C")
                ELSE
                    THIS.this_cDGrContb = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDGrContb = ""
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContas))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrContas)), "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDGrConta = TratarNulo(Descrs, "C")
                ELSE
                    THIS.this_cDGrConta = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDGrConta = ""
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContas)) AND !EMPTY(ALLTRIM(THIS.this_cCdContas))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT RClis FROM SigCdCli" + ;
                    " WHERE Grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ;
                    " AND IClis = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas)), ;
                    "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDConta = TratarNulo(RClis, "C")
                ELSE
                    THIS.this_cDConta = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDConta = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDescricoes: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigSyAgc (PROTECTED - chamado pelo Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cPK
        loc_lResultado = .F.

        TRY
            loc_cPK = fUniqueIds()
            THIS.this_cIdChaves = loc_cPK

            loc_cSQL = "INSERT INTO SigSyAgc" + ;
                       " (cIdChaves, gracess, usuacess, grcontbs, grcontas, cdcontas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCdContas)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigSyAgc (PROTECTED - chamado pelo Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigSyAgc SET" + ;
                       " gracess  = " + EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + "," + ;
                       " usuacess = " + EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + "," + ;
                       " grcontbs = " + EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + "," + ;
                       " grcontas = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + "," + ;
                       " cdcontas = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas)) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE na tabela SigSyAgc (PROTECTED - chamado por Excluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigSyAgc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com a mesma chave composta
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_cSQL = "SELECT cIdChaves FROM SigSyAgc" + ;
                       " WHERE GrAcess  = " + EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + ;
                       " AND   UsuAcess = " + EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + ;
                       " AND   GrContbs = " + EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + ;
                       " AND   GrContas = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ;
                       " AND   CdContas = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas))

            IF !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + ;
                    " AND cIdChaves <> " + EscaparSQL(THIS.this_cIdChaves)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0
                loc_lDuplicado = (RECCOUNT("cursor_4c_Dup") > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_lResultado = loc_lDuplicado
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicidade: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

