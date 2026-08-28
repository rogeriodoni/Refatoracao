# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 192: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 216: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 240: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 264: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 288: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 362: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMun.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1097 linhas total):

*-- Linhas 50 a 63:
50:                     "FormMun.InicializarForm")
51:             ELSE
52:                 *-- Caption com acentuacao correta (nunca acentos literais em .PRG)
53:                 THIS.Caption = "Cadastro de C" + CHR(243) + "digo de Munic" + CHR(237) + "pios"
54: 
55:                 THIS.ConfigurarPageFrame()
56: 
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
59: 
60:                 THIS.pgf_4c_Paginas.Visible   = .T.
61:                 THIS.pgf_4c_Paginas.ActivePage = 1
62:                 THIS.this_cModoAtual = "LISTA"
63: 

*-- Linhas 87 a 198:
87: 
88:         WITH THIS.pgf_4c_Paginas
89:             .PageCount = 2
90:             .Top       = -29
91:             .Left      = 0
92:             .Width     = THIS.Width
93:             .Height    = THIS.Height + 29
94:             .Tabs      = .F.
95:             .Visible   = .T.
96: 
97:             .Page1.Caption   = "Lista"
98:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page1.BackColor = RGB(255, 255, 255)
100: 
101:             .Page2.Caption   = "Dados"
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:             .Page2.BackColor = RGB(255, 255, 255)
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()
107:         THIS.ConfigurarPaginaDados()
108:     ENDPROC
109: 
110:     *==========================================================================
111:     * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e Grid
112:     * Original: cntSombra.Top=1, Grupo_op.Top=-1 (Left=538), Grade.Top=88
113:     * Compensacao PageFrame (+29): Top original + 29
114:     *==========================================================================
115:     PROTECTED PROCEDURE ConfigurarPaginaLista()
116:         LOCAL loc_oPagina
117:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
118: 
119:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
120:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121: 
122:         *-- Container Cabecalho (cntSombra no legado)
123:         *-- Original: cntSombra.Top=1, Left=-1, Width=1008, Height=80
124:         *-- Com compensacao +29: Top=30
125:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
126:         WITH loc_oPagina.cnt_4c_Cabecalho
127:             .Top         = 30
128:             .Left        = 0
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133:             .Visible     = .T.
134:         ENDWITH
135: 
136:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
137:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
138:             .Caption   = ""
139:             .Top       = 15
140:             .Left      = 10
141:             .Width     = THIS.Width - 20
142:             .Height    = 46
143:             .FontName  = "Tahoma"
144:             .FontSize  = 16
145:             .FontBold  = .T.
146:             .ForeColor = RGB(0, 0, 0)
147:             .BackStyle = 0
148:             .AutoSize  = .F.
149:             .Visible   = .T.
150:         ENDWITH
151: 
152:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
153:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
154:             .Caption   = ""
155:             .Top       = 18
156:             .Left      = 10
157:             .Width     = THIS.Width - 20
158:             .Height    = 46
159:             .FontName  = "Tahoma"
160:             .FontSize  = 16
161:             .FontBold  = .T.
162:             .ForeColor = RGB(255, 255, 255)
163:             .BackStyle = 0
164:             .AutoSize  = .F.
165:             .Visible   = .T.
166:         ENDWITH
167: 
168:         *-- Container botoes CRUD (Grupo_op no legado)
169:         *-- Original: Grupo_op.Top=-1, Left=538, Width=389, Height=85
170:         *-- Com compensacao +29: Top=28
171:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
172:         WITH loc_oPagina.cnt_4c_Botoes
173:             .Top         = 28
174:             .Left        =  542
175:             .Width       = 389
176:             .Height      = 85
177:             .BackStyle   = 0
178:             .BorderWidth = 0
179:             .Visible     = .T.
180:         ENDWITH
181: 
182:         *-- Botao Incluir
183:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
184:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
185:             .Caption         = "Incluir"
186:             .Top             = 5
187:             .Left            = 5
188:             .Width           = 75
189:             .Height          = 75
190:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
191:             .PicturePosition = 13
192:             .FontName        = "Comic Sans MS"
193:             .FontSize        = 8
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .ForeColor       = RGB(90, 90, 90)
197:             .BackColor       = RGB(255, 255, 255)
198:             .Themes          = .F.

*-- Linhas 204 a 222:
204:         ENDWITH
205: 
206:         *-- Botao Visualizar
207:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
208:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
209:             .Caption         = "Visualizar"
210:             .Top             = 5
211:             .Left            = 80
212:             .Width           = 75
213:             .Height          = 75
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
215:             .PicturePosition = 13
216:             .FontName        = "Comic Sans MS"
217:             .FontSize        = 8
218:             .FontBold        = .T.
219:             .FontItalic      = .T.
220:             .ForeColor       = RGB(90, 90, 90)
221:             .BackColor       = RGB(255, 255, 255)
222:             .Themes          = .F.

*-- Linhas 228 a 246:
228:         ENDWITH
229: 
230:         *-- Botao Alterar
231:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
232:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
233:             .Caption         = "Alterar"
234:             .Top             = 5
235:             .Left            = 155
236:             .Width           = 75
237:             .Height          = 75
238:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
239:             .PicturePosition = 13
240:             .FontName        = "Comic Sans MS"
241:             .FontSize        = 8
242:             .FontBold        = .T.
243:             .FontItalic      = .T.
244:             .ForeColor       = RGB(90, 90, 90)
245:             .BackColor       = RGB(255, 255, 255)
246:             .Themes          = .F.

*-- Linhas 252 a 270:
252:         ENDWITH
253: 
254:         *-- Botao Excluir
255:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
256:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
257:             .Caption         = "Excluir"
258:             .Top             = 5
259:             .Left            = 230
260:             .Width           = 75
261:             .Height          = 75
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
263:             .PicturePosition = 13
264:             .FontName        = "Comic Sans MS"
265:             .FontSize        = 8
266:             .FontBold        = .T.
267:             .FontItalic      = .T.
268:             .ForeColor       = RGB(90, 90, 90)
269:             .BackColor       = RGB(255, 255, 255)
270:             .Themes          = .F.

*-- Linhas 276 a 312:
276:         ENDWITH
277: 
278:         *-- Botao Buscar
279:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
280:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
281:             .Caption         = "Buscar"
282:             .Top             = 5
283:             .Left            = 305
284:             .Width           = 75
285:             .Height          = 75
286:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
287:             .PicturePosition = 13
288:             .FontName        = "Comic Sans MS"
289:             .FontSize        = 8
290:             .FontBold        = .T.
291:             .FontItalic      = .T.
292:             .ForeColor       = RGB(90, 90, 90)
293:             .BackColor       = RGB(255, 255, 255)
294:             .Themes          = .F.
295:             .SpecialEffect   = 0
296:             .MousePointer    = 15
297:             .WordWrap        = .T.
298:             .AutoSize        = .F.
299:             .Visible         = .T.
300:         ENDWITH
301: 
302:         *-- Grid principal (Grade no legado: Grade.Top=88 + compensacao +29 = 117)
303:         *-- Colunas: Codigos (60px), Descs (290px) - do Init original
304:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
305:         WITH loc_oPagina.grd_4c_Lista
306:             .Top                = 117
307:             .Left               = 26
308:             .Width              = 890
309:             .Height             = 498
310:             .FontName           = "Verdana"
311:             .FontSize           = 8
312:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 329 a 368:
329:         WITH loc_oPagina.grd_4c_Lista.Column1
330:             .Width           = 60
331:             .Alignment       = 0
332:             .Header1.Caption = "C" + CHR(243) + "digo"
333:         ENDWITH
334:         WITH loc_oPagina.grd_4c_Lista.Column2
335:             .Width           = 290
336:             .Alignment       = 0
337:             .Header1.Caption = "Munic" + CHR(237) + "pio"
338:         ENDWITH
339: 
340:         *-- Container Saida - PADRAO CANONICO (prevalece sobre PILAR 1)
341:         *-- Original: Grupo_Saida.Top=-1, Left=918. Canonico: Left=917, Width=90
342:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
343:         WITH loc_oPagina.cnt_4c_Saida
344:             .Top         = 29
345:             .Left        = 917
346:             .Width       = 90
347:             .Height      = 85
348:             .BackStyle   = 0
349:             .BorderWidth = 0
350:             .Visible     = .T.
351:         ENDWITH
352: 
353:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
354:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
355:             .Caption         = "Encerrar"
356:             .Top             = 5
357:             .Left            = 5
358:             .Width           = 75
359:             .Height          = 75
360:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
361:             .PicturePosition = 13
362:             .FontName        = "Comic Sans MS"
363:             .FontSize        = 8
364:             .FontBold        = .T.
365:             .FontItalic      = .T.
366:             .ForeColor       = RGB(90, 90, 90)
367:             .BackColor       = RGB(255, 255, 255)
368:             .Themes          = .F.

*-- Linhas 374 a 429:
374:         ENDWITH
375: 
376:         *-- BINDEVENTs dos botoes CRUD e Encerrar (PUBLIC - obrigatorio para BINDEVENT)
377:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
378:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
379:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
380:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
381:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
382:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
383: 
384:         THIS.TornarControlesVisiveis(loc_oPagina)
385:     ENDPROC
386: 
387:     *==========================================================================
388:     * ConfigurarPaginaDados - Configura Page2: container de acoes e campos
389:     * Original: Grupo_Salva.Top=9, Left=817. Com compensacao +29: Top=38
390:     *==========================================================================
391:     PROTECTED PROCEDURE ConfigurarPaginaDados()
392:         LOCAL loc_oPagina
393:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
394: 
395:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
396:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
397: 
398:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
399:         *-- Original: Grupo_Salva.Top=9, Left=817, Width=160, Height=85
400:         *-- Com compensacao +29: Top=38
401:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
402:         WITH loc_oPagina.cnt_4c_Salva
403:             .Top         = 38
404:             .Left        = 817
405:             .Width       = 160
406:             .Height      = 85
407:             .BackStyle = 1
408:             .BackColor = RGB(255, 255, 255)
409:             .BorderWidth = 0
410:             .Visible     = .T.
411:         ENDWITH
412: 
413:         *-- Botao Confirmar (Salvar)
414:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
415:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
416:             .Caption         = "Confirmar"
417:             .Top             = 5
418:             .Left            = 5
419:             .Width           = 75
420:             .Height          = 75
421:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
422:             .PicturePosition = 13
423:             .FontName        = "Comic Sans MS"
424:             .FontSize        = 8
425:             .FontBold        = .T.
426:             .FontItalic      = .T.
427:             .ForeColor       = RGB(90, 90, 90)
428:             .BackColor       = RGB(255, 255, 255)
429:             .Themes          = .F.

*-- Linhas 435 a 453:
435:         ENDWITH
436: 
437:         *-- Botao Cancelar
438:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
439:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
440:             .Caption         = "Encerrar"
441:             .Top             = 5
442:             .Left            = 80
443:             .Width           = 75
444:             .Height          = 75
445:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
446:             .PicturePosition = 13
447:             .FontName        = "Comic Sans MS"
448:             .FontSize        = 8
449:             .FontBold        = .T.
450:             .FontItalic      = .T.
451:             .ForeColor       = RGB(90, 90, 90)
452:             .BackColor       = RGB(255, 255, 255)
453:             .Themes          = .F.

*-- Linhas 459 a 478:
459:         ENDWITH
460: 
461:         *-- BINDEVENTs dos botoes de Page2 (PUBLIC - obrigatorio para BINDEVENT)
462:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
463:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
464: 
465:         *-- ====== CAMPOS DA PAGE2 - PARTE 1/2 ======
466:         *-- Coordenadas originais do SCX + compensacao PageFrame (+29 no Top)
467: 
468:         *-- lbl_4c_Label2: "Codigo :" - Original: Top=133, Left=302, Width=42, Height=15
469:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
470:         WITH loc_oPagina.lbl_4c_Label2
471:             .Caption   = "C" + CHR(243) + "digo :"
472:             .Top       = 162
473:             .Left      = 302
474:             .Width     = 42
475:             .Height    = 15
476:             .FontName  = "Tahoma"
477:             .FontSize  = 8
478:             .FontBold  = .F.

*-- Linhas 487 a 512:
487:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
488:         WITH loc_oPagina.txt_4c_Codigos
489:             .Value         = ""
490:             .Top           = 158
491:             .Left          = 347
492:             .Width         = 60
493:             .Height        = 25
494:             .FontName      = "Tahoma"
495:             .FontSize      = 8
496:             .InputMask     = "9999999"
497:             .MaxLength     = 7
498:             .SpecialEffect = 1
499:             .Visible       = .T.
500:         ENDWITH
501: 
502:         *-- lbl_4c_Label5 (Say5): "Cod. da UF no IBGE :" - Original: Top=133, Left=504
503:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
504:         WITH loc_oPagina.lbl_4c_Label5
505:             .Caption   = "C" + CHR(243) + "d. da UF no IBGE :"
506:             .Top       = 162
507:             .Left      = 504
508:             .Width     = 104
509:             .Height    = 15
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .FontBold  = .F.

*-- Linhas 521 a 547:
521:         loc_oPagina.AddObject("txt_4c_UFIBGES", "TextBox")
522:         WITH loc_oPagina.txt_4c_UFIBGES
523:             .Value         = 0
524:             .Top           = 157
525:             .Left          = 613
526:             .Width         = 24
527:             .Height        = 25
528:             .FontName      = "Tahoma"
529:             .FontSize      = 8
530:             .InputMask     = "99"
531:             .MaxLength     = 2
532:             .SpecialEffect = 1
533:             .Visible       = .T.
534:         ENDWITH
535: 
536:         *-- lbl_4c_Label1: "Descricao :" - Original: Top=160, Left=289, Width=55, Height=15
537:         *-- Com compensacao +29: Top=189
538:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
539:         WITH loc_oPagina.lbl_4c_Label1
540:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
541:             .Top       = 189
542:             .Left      = 289
543:             .Width     = 55
544:             .Height    = 15
545:             .FontName  = "Tahoma"
546:             .FontSize  = 8
547:             .FontBold  = .F.

*-- Linhas 557 a 566:
557:         loc_oPagina.AddObject("txt_4c_Descs", "TextBox")
558:         WITH loc_oPagina.txt_4c_Descs
559:             .Value         = ""
560:             .Top           = 186
561:             .Left          = 347
562:             .Width         = 290
563:             .Height        = 23
564:             .FontName      = "Tahoma"
565:             .FontSize      = 8
566:             .MaxLength     = 40

*-- Linhas 599 a 609:
599: 
600:                     *-- Problema 32: redefinir cabecalhos apos RecordSource (auto-bind reseta)
601:                     loc_oGrid.Column1.Width           = 60
602:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
603:                     loc_oGrid.Column2.Width           = 290
604:                     loc_oGrid.Column2.Header1.Caption = "Munic" + CHR(237) + "pio"
605: 
606:                     THIS.FormatarGridLista(loc_oGrid)
607:                     loc_oGrid.Refresh()
608:                     loc_lResultado = .T.
609:                 ENDIF

*-- Linhas 904 a 913:
904: 
905:         *-- Botao Confirmar habilitado somente quando campos editaveis
906:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Salva", 5)
907:             IF PEMSTATUS(loc_oPagina.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
908:                 loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lHabilitar
909:             ENDIF
910:         ENDIF
911:     ENDPROC
912: 
913:     *==========================================================================

*-- Linhas 1037 a 1070:
1037:         *-- Page1: botoes CRUD habilitados apenas em modo LISTA
1038:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1039:             WITH loc_oPg1.cnt_4c_Botoes
1040:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir",    5)
1041:                     .cmd_4c_Incluir.Enabled    = loc_lLista
1042:                 ENDIF
1043:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1044:                     .cmd_4c_Visualizar.Enabled = loc_lLista
1045:                 ENDIF
1046:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar",    5)
1047:                     .cmd_4c_Alterar.Enabled    = loc_lLista
1048:                 ENDIF
1049:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir",    5)
1050:                     .cmd_4c_Excluir.Enabled    = loc_lLista
1051:                 ENDIF
1052:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar",     5)
1053:                     .cmd_4c_Buscar.Enabled     = loc_lLista
1054:                 ENDIF
1055:                 .Visible     = .T.
1056:             ENDWITH
1057:         ENDIF
1058: 
1059:         *-- Page2: Confirmar habilitado so em INCLUIR/ALTERAR; Cancelar sempre ativo em Page2
1060:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1061:             IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1062:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdita
1063:             ENDIF
1064:             IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1065:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = (loc_lEdita OR loc_lVisualiza)
1066:             ENDIF
1067:         ENDIF
1068:     ENDPROC
1069: 
1070:     *==========================================================================


### BO (C:\4c\projeto\app\classes\MunBO.prg):
*==============================================================================
* MunBO.prg - Business Object para Cadastro de Municípios
* Tabela: SigCdMun
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS MunBO AS BusinessBase

    *-- Propriedades da tabela SigCdMun
    this_cCidChaves = ""     && cidchaves char(20) - chave interna PK do banco
    this_cCodigos   = ""     && codigos char(7) - código do município (negócio)
    this_cDescs     = ""     && descs char(40) - nome do município
    this_nUFIBGES   = 0      && ufibges numeric(2,0) - código da UF no IBGE

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMun"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave interna para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCodigos   = TratarNulo(codigos,   "C")
            THIS.this_cDescs     = TratarNulo(descs,     "C")
            THIS.this_nUFIBGES   = TratarNulo(ufibges,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os municípios (PUBLIC - chamado pelo Form)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, ufibges, cidchaves" + ;
                       " FROM SigCdMun" + ;
                       " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar municípios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega município por código de negócio (codigos)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, ufibges, cidchaves" + ;
                       " FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdMun (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = SYS(2015) + SYS(2015)
                THIS.this_cCidChaves = LEFT(THIS.this_cCidChaves, 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdMun (codigos, descs, ufibges, cidchaves) VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescs))   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUFIBGES)   + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdMun (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMun SET" + ;
                       " descs = "   + EscaparSQL(ALLTRIM(THIS.this_cDescs))   + "," + ;
                       " ufibges = " + FormatarNumeroSQL(THIS.this_nUFIBGES)   + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdMun (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicidade - Verifica se código já cadastrado
    * Para INSERT: verifica se codigos existe
    * Para UPDATE: verifica se outro registro tem o mesmo codigos
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        *-- codigos nao pode ser alterado no UPDATE, entao duplicidade so eh possivel em INSERT
        IF !THIS.this_lNovoRegistro
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT codigos FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DupMun")
                TABLEREVERT(.T., "cursor_4c_DupMun")
                USE IN cursor_4c_DupMun
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupMun")

            IF loc_nResult >= 0
                loc_lResultado = (RECCOUNT("cursor_4c_DupMun") > 0)
            ENDIF

            IF USED("cursor_4c_DupMun")
                USE IN cursor_4c_DupMun
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.ValidarDuplicidade")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

