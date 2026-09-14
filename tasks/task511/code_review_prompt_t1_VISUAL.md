# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 183: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 208: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 258: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 283: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 319: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 409: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 433: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formrgr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1822 linhas total):

*-- Linhas 2 a 10:
2: * Formrgr.prg - Formulario de Cadastro de Regras de E-Commerce
3: * Migrado de: SIGCDRGR.SCX (frmcadastro)
4: * Tabelas: SigCdRGR (cabecalho), SigCdRga (regras - grid Page2)
5: * DataSession = 2 (private); compensacao PageFrame +27 (Pagina.Top=-27 original)
6: *==============================================================================
7: 
8: DEFINE CLASS Formrgr AS FormBase
9: 
10:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY: exatos do original)

*-- Linhas 50 a 59:
50:                 SET DELETED ON
51:                 THIS.ConfigurarPageFrame()
52: 
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Visible  = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual = "LISTA"
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 75 a 101:
75: 
76:     *===========================================================================
77:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
78:     * Pagina.Top = -27 no original; compensacao +27 em controles das Pages
79:     *===========================================================================
80:     PROTECTED PROCEDURE ConfigurarPageFrame()
81:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .PageCount = 2
85:             .Top       = -27
86:             .Left      = 0
87:             .Width     = THIS.Width
88:             .Height    = THIS.Height + 27
89:             .Tabs      = .F.
90:             .Visible   = .T.
91: 
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(255, 255, 255)
95: 
96:             .Page2.Caption   = "Dados"
97:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page2.BackColor = RGB(255, 255, 255)
99:         ENDWITH
100: 
101:         THIS.ConfigurarPaginaLista()

*-- Linhas 115 a 152:
115:         *-- Container Cabecalho (cntSombra no legado: Top=2; +27 compensacao = 29)
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 29
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption   = THIS.Caption
130:             .Top       = 15
131:             .Left      = 10
132:             .Width     = 769
133:             .Height    = 40
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .AutoSize  = .F.
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = THIS.Caption
146:             .Top       = 18
147:             .Left      = 10
148:             .Width     = 769
149:             .Height    = 46
150:             .FontName  = "Tahoma"
151:             .FontSize  = 16
152:             .FontBold  = .T.

*-- Linhas 159 a 344:
159:         *-- Container Botoes CRUD (Grupo_op no legado: Left=542, Top=27 canonico)
160:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
161:         WITH loc_oPagina.cnt_4c_Botoes
162:             .Top         = 27
163:             .Left        = 542
164:             .Width       = 390
165:             .Height      = 85
166:             .BackStyle   = 0
167:             .BorderWidth = 0
168:             .Visible     = .T.
169:         ENDWITH
170: 
171:         loc_oBotoes = loc_oPagina.cnt_4c_Botoes
172: 
173:         *-- Botao Incluir (Left=5)
174:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
175:         WITH loc_oBotoes.cmd_4c_Incluir
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
190:             .SpecialEffect   = 0
191:             .MousePointer    = 15
192:             .WordWrap        = .T.
193:             .AutoSize        = .F.
194:             .Visible         = .T.
195:         ENDWITH
196:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
197: 
198:         *-- Botao Visualizar (Left=80)
199:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oBotoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .FontName        = "Comic Sans MS"
209:             .FontSize        = 8
210:             .FontBold        = .T.
211:             .FontItalic      = .T.
212:             .ForeColor       = RGB(90, 90, 90)
213:             .BackColor       = RGB(255, 255, 255)
214:             .Themes          = .F.
215:             .SpecialEffect   = 0
216:             .MousePointer    = 15
217:             .WordWrap        = .T.
218:             .AutoSize        = .F.
219:             .Visible         = .T.
220:         ENDWITH
221:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
222: 
223:         *-- Botao Alterar (Left=155)
224:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
225:         WITH loc_oBotoes.cmd_4c_Alterar
226:             .Caption         = "Alterar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 155
231:             .Width           = 75
232:             .Height          = 75
233:             .FontName        = "Comic Sans MS"
234:             .FontSize        = 8
235:             .FontBold        = .T.
236:             .FontItalic      = .T.
237:             .ForeColor       = RGB(90, 90, 90)
238:             .BackColor       = RGB(255, 255, 255)
239:             .Themes          = .F.
240:             .SpecialEffect   = 0
241:             .MousePointer    = 15
242:             .WordWrap        = .T.
243:             .AutoSize        = .F.
244:             .Visible         = .T.
245:         ENDWITH
246:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
247: 
248:         *-- Botao Excluir (Left=230)
249:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
250:         WITH loc_oBotoes.cmd_4c_Excluir
251:             .Caption         = "Excluir"
252:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253:             .PicturePosition = 13
254:             .Top             = 5
255:             .Left            = 230
256:             .Width           = 75
257:             .Height          = 75
258:             .FontName        = "Comic Sans MS"
259:             .FontSize        = 8
260:             .FontBold        = .T.
261:             .FontItalic      = .T.
262:             .ForeColor       = RGB(90, 90, 90)
263:             .BackColor       = RGB(255, 255, 255)
264:             .Themes          = .F.
265:             .SpecialEffect   = 0
266:             .MousePointer    = 15
267:             .WordWrap        = .T.
268:             .AutoSize        = .F.
269:             .Visible         = .T.
270:         ENDWITH
271:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
272: 
273:         *-- Botao Buscar (Left=305)
274:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
275:         WITH loc_oBotoes.cmd_4c_Buscar
276:             .Caption         = "Buscar"
277:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
278:             .PicturePosition = 13
279:             .Top             = 5
280:             .Left            = 305
281:             .Width           = 75
282:             .Height          = 75
283:             .FontName        = "Comic Sans MS"
284:             .FontSize        = 8
285:             .FontBold        = .T.
286:             .FontItalic      = .T.
287:             .ForeColor       = RGB(90, 90, 90)
288:             .BackColor       = RGB(255, 255, 255)
289:             .Themes          = .F.
290:             .SpecialEffect   = 0
291:             .MousePointer    = 15
292:             .WordWrap        = .T.
293:             .AutoSize        = .F.
294:             .Visible         = .T.
295:         ENDWITH
296:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
297: 
298:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md #10)
299:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
300:         WITH loc_oPagina.cnt_4c_Saida
301:             .Top         = 27
302:             .Left        = 917
303:             .Width       = 90
304:             .Height      = 85
305:             .BackStyle   = 0
306:             .BorderWidth = 0
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
311:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
312:             .Caption         = "Encerrar"
313:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
314:             .PicturePosition = 13
315:             .Top             = 5
316:             .Left            = 5
317:             .Width           = 75
318:             .Height          = 75
319:             .FontName        = "Comic Sans MS"
320:             .FontSize        = 8
321:             .FontBold        = .T.
322:             .FontItalic      = .T.
323:             .ForeColor       = RGB(90, 90, 90)
324:             .BackColor       = RGB(255, 255, 255)
325:             .Themes          = .F.
326:             .SpecialEffect   = 0
327:             .MousePointer    = 15
328:             .WordWrap        = .T.
329:             .AutoSize        = .F.
330:             .Visible         = .T.
331:         ENDWITH
332:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
333: 
334:         *-- Grid de lista SigCdRGR (Top=115 = 88+27 compensacao PageFrame)
335:         *-- Width=880 para nao sobrepor cnt_4c_Saida (Left=917)
336:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
337:         WITH loc_oPagina.grd_4c_Lista
338:             .Top                = 115
339:             .Left               = 26
340:             .Width              = 880
341:             .Height             = 478
342:             .ColumnCount        = 2
343:             .FontName           = "Verdana"
344:             .FontSize           = 8

*-- Linhas 371 a 542:
371: 
372:     *===========================================================================
373:     * ConfigurarPaginaDados - Page2: campos do cabecalho SigCdRGR + grid SigCdRga
374:     * Compensacao PageFrame: pgf_4c_Paginas.Top=-27 -> todos os Tops +27
375:     *===========================================================================
376:     PROTECTED PROCEDURE ConfigurarPaginaDados()
377:         LOCAL loc_oPagina, loc_oGrd, loc_oCmdGrp1, loc_oCmdGrp2
378:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
379: 
380:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
381:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
382: 
383:         *-- Container Salvar/Cancelar (Grupo_Salva: Left=638, Top=8+27=35)
384:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
385:         WITH loc_oPagina.cnt_4c_Salva
386:             .Top         = 35
387:             .Left        = 638
388:             .Width       = 160
389:             .Height      = 85
390:             .BackStyle = 1
391:             .BackColor = RGB(255, 255, 255)
392:             .BorderWidth = 0
393:             .Visible     = .T.
394:         ENDWITH
395: 
396:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
397:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
398:             .Caption         = "Salvar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
400:             .PicturePosition = 13
401:             .Top             = 5
402:             .Left            = 5
403:             .Width           = 75
404:             .Height          = 75
405:             .FontName        = "Comic Sans MS"
406:             .FontSize        = 8
407:             .FontBold        = .T.
408:             .FontItalic      = .T.
409:             .ForeColor       = RGB(90, 90, 90)
410:             .BackColor       = RGB(255, 255, 255)
411:             .Themes          = .F.
412:             .SpecialEffect   = 0
413:             .MousePointer    = 15
414:             .WordWrap        = .T.
415:             .AutoSize        = .F.
416:             .Visible         = .T.
417:         ENDWITH
418:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
419: 
420:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
421:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
422:             .Caption         = "Encerrar"
423:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
424:             .PicturePosition = 13
425:             .Top             = 5
426:             .Left            = 80
427:             .Width           = 75
428:             .Height          = 75
429:             .FontName        = "Comic Sans MS"
430:             .FontSize        = 8
431:             .FontBold        = .T.
432:             .FontItalic      = .T.
433:             .ForeColor       = RGB(90, 90, 90)
434:             .BackColor       = RGB(255, 255, 255)
435:             .Themes          = .F.
436:             .SpecialEffect   = 0
437:             .MousePointer    = 15
438:             .WordWrap        = .T.
439:             .AutoSize        = .F.
440:             .Visible         = .T.
441:         ENDWITH
442:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
443: 
444:         *-- Label + TextBox Codigo (getCodigo: Top=54+27=81, Left=227, Width=82)
445:         loc_oPagina.AddObject("lbl_4c_LblGrupo", "Label")
446:         WITH loc_oPagina.lbl_4c_LblGrupo
447:             .Caption   = "C" + CHR(243) + "digo :"
448:             .Top       = 85
449:             .Left      = 181
450:             .Width     = 42
451:             .Height    = 17
452:             .FontName  = "Tahoma"
453:             .FontSize  = 8
454:             .AutoSize  = .F.
455:             .BackStyle = 0
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
460:         WITH loc_oPagina.txt_4c_Codigo
461:             .Value     = ""
462:             .Top       = 81
463:             .Left      = 227
464:             .Width     = 82
465:             .Height    = 23
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .MaxLength = 10
469:             .ReadOnly  = .F.
470:             .Visible   = .T.
471:         ENDWITH
472: 
473:         *-- CheckBox Inativa (Check1: Top=58+27=85, Left=320)
474:         loc_oPagina.AddObject("chk_4c_Check1", "CheckBox")
475:         WITH loc_oPagina.chk_4c_Check1
476:             .Caption   = "Inativa"
477:             .Value     = 0
478:             .Top       = 85
479:             .Left      = 320
480:             .Width     = 52
481:             .Height    = 15
482:             .FontName  = "Tahoma"
483:             .FontSize  = 8
484:             .Visible   = .T.
485:         ENDWITH
486: 
487:         *-- Label + TextBox Descricao (GetDescricao: Top=80+27=107, Left=227, Width=351)
488:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
489:         WITH loc_oPagina.lbl_4c_Label6
490:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
491:             .Top       = 110
492:             .Left      = 168
493:             .Width     = 55
494:             .Height    = 17
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .AutoSize  = .F.
498:             .BackStyle = 0
499:             .Visible   = .T.
500:         ENDWITH
501: 
502:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
503:         WITH loc_oPagina.txt_4c_Descricao
504:             .Value     = ""
505:             .Top       = 107
506:             .Left      = 227
507:             .Width     = 351
508:             .Height    = 21
509:             .FontName  = "Tahoma"
510:             .FontSize  = 8
511:             .MaxLength = 40
512:             .ReadOnly  = .F.
513:             .Visible   = .T.
514:         ENDWITH
515:         *-- LostFocus: se descricao preenchida e modo edicao, insere linha vazia na grade
516:         BINDEVENT(loc_oPagina.txt_4c_Descricao, "KeyPress", THIS, "DescricaoLostFocus")
517: 
518:         *-- Label + TextBox Valor (getValor: Top=104+27=131, Left=227, Width=105)
519:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
520:         WITH loc_oPagina.lbl_4c_Label2
521:             .Caption   = "Valor acima de :"
522:             .Top       = 136
523:             .Left      = 145
524:             .Width     = 78
525:             .Height    = 17
526:             .FontName  = "Tahoma"
527:             .FontSize  = 8
528:             .AutoSize  = .F.
529:             .BackStyle = 0
530:             .Visible   = .T.
531:         ENDWITH
532: 
533:         loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
534:         WITH loc_oPagina.txt_4c_Valor
535:             .Value     = 0
536:             .Top       = 131
537:             .Left      = 227
538:             .Width     = 105
539:             .Height    = 21
540:             .FontName  = "Tahoma"
541:             .FontSize  = 8
542:             .Format    = "N"

*-- Linhas 570 a 579:
570:         loc_oPagina.grd_4c_Dados.ColumnCount  = 9
571: 
572:         WITH loc_oPagina.grd_4c_Dados
573:             .Top                = 156
574:             .Left               = 11
575:             .Width              = 739
576:             .Height             = 371
577:             .FontName           = "Verdana"
578:             .FontSize           = 8
579:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 597 a 742:
597:             .Column1.ControlSource   = "csSigCdRga.Empresa"
598:             .Column1.Width           = 60
599:             .Column1.Alignment       = 0
600:             .Column1.Header1.Caption = "Empresa"
601: 
602:             .Column2.ControlSource   = "csSigCdRga.Grupo"
603:             .Column2.Width           = 95
604:             .Column2.Alignment       = 0
605:             .Column2.Header1.Caption = "Grupo"
606: 
607:             .Column3.ControlSource   = "csSigCdRga.Conta"
608:             .Column3.Width           = 85
609:             .Column3.Alignment       = 0
610:             .Column3.Header1.Caption = "Conta"
611: 
612:             .Column4.ControlSource   = "csSigCdRga.Colecao"
613:             .Column4.Width           = 140
614:             .Column4.Alignment       = 0
615:             .Column4.Header1.Caption = "Grupo de Venda"
616: 
617:             .Column5.ControlSource   = "csSigCdRga.Quantidade"
618:             .Column5.Width           = 65
619:             .Column5.Alignment       = 2
620:             .Column5.Header1.Caption = "Qtde. Min."
621: 
622:             .Column6.ControlSource   = "csSigCdRga.Prioridade"
623:             .Column6.Width           = 70
624:             .Column6.Alignment       = 2
625:             .Column6.Header1.Caption = "Prior."
626: 
627:             .Column7.ControlSource   = "csSigCdRga.GrupoPr"
628:             .Column7.Width           = 105
629:             .Column7.Alignment       = 0
630:             .Column7.Header1.Caption = "Grupo de Produto"
631: 
632:             .Column8.ControlSource   = "csSigCdRga.Zerar"
633:             .Column8.Width           = 50
634:             .Column8.Alignment       = 1
635:             .Column8.Header1.Caption = "Zerar"
636: 
637:             .Column9.ControlSource   = "csSigCdRga.Ordem"
638:             .Column9.Width           = 50
639:             .Column9.Alignment       = 1
640:             .Column9.Header1.Caption = "Ordem"
641:         ENDWITH
642: 
643:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeRegraAfterRowColChange")
644: 
645:         *-- CommandGroup Mover linhas (Commandgroup1: Top=200+27=227, Left=748, W=50, H=90)
646:         loc_oPagina.AddObject("obj_4c_Commandgroup1", "CommandGroup")
647:         WITH loc_oPagina.obj_4c_Commandgroup1
648:             .Top         = 227
649:             .Left        = 748
650:             .Width       = 50
651:             .Height      = 90
652:             .BackStyle   = 0
653:             .BorderWidth = 0
654:             .ButtonCount = 2
655:             .Visible     = .T.
656:         ENDWITH
657: 
658:         loc_oCmdGrp1 = loc_oPagina.obj_4c_Commandgroup1
659:         WITH loc_oCmdGrp1.Buttons(1)
660:             .Caption  = "^"
661:             .Top      = 0
662:             .Left     = 0
663:             .Width    = 50
664:             .Height   = 45
665:             .FontName = "Tahoma"
666:             .FontSize = 14
667:             .FontBold = .T.
668:         ENDWITH
669:         WITH loc_oCmdGrp1.Buttons(2)
670:             .Caption  = "v"
671:             .Top      = 45
672:             .Left     = 0
673:             .Width    = 50
674:             .Height   = 45
675:             .FontName = "Tahoma"
676:             .FontSize = 14
677:             .FontBold = .T.
678:         ENDWITH
679:         BINDEVENT(loc_oCmdGrp1.Buttons(1), "Click", THIS, "CmdMoveUpClick")
680:         BINDEVENT(loc_oCmdGrp1.Buttons(2), "Click", THIS, "CmdMoveDownClick")
681: 
682:         *-- CommandGroup Inserir/Deletar linhas (cmdInsFtc: Top=287+27=314, Left=748, W=50, H=90)
683:         loc_oPagina.AddObject("obj_4c_CmdInsFtc", "CommandGroup")
684:         WITH loc_oPagina.obj_4c_CmdInsFtc
685:             .Top         = 314
686:             .Left        = 748
687:             .Width       = 50
688:             .Height      = 90
689:             .BackStyle   = 0
690:             .BorderWidth = 0
691:             .ButtonCount = 2
692:             .Visible     = .T.
693:         ENDWITH
694: 
695:         loc_oCmdGrp2 = loc_oPagina.obj_4c_CmdInsFtc
696:         WITH loc_oCmdGrp2.Buttons(1)
697:             .Caption  = "+"
698:             .Top      = 0
699:             .Left     = 0
700:             .Width    = 50
701:             .Height   = 45
702:             .FontName = "Tahoma"
703:             .FontSize = 14
704:             .FontBold = .T.
705:         ENDWITH
706:         WITH loc_oCmdGrp2.Buttons(2)
707:             .Caption  = "-"
708:             .Top      = 45
709:             .Left     = 0
710:             .Width    = 50
711:             .Height   = 45
712:             .FontName = "Tahoma"
713:             .FontSize = 14
714:             .FontBold = .T.
715:         ENDWITH
716:         BINDEVENT(loc_oCmdGrp2.Buttons(1), "Click", THIS, "CmdInsRowClick")
717:         BINDEVENT(loc_oCmdGrp2.Buttons(2), "Click", THIS, "CmdDelRowClick")
718: 
719:         *-- Shape1 - separador horizontal acima da area de observacao (Top=503+27=530)
720:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
721:         WITH loc_oPagina.shp_4c_Shape1
722:             .Top           = 530
723:             .Left          = 7
724:             .Width         = 780
725:             .Height        = 2
726:             .BackStyle     = 0
727:             .BorderWidth   = 2
728:             .SpecialEffect = 0
729:             .Visible       = .T.
730:         ENDWITH
731: 
732:         *-- Label Observacao (Say1: Top=519+27=546, Left=88)
733:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
734:         WITH loc_oPagina.lbl_4c_Label1
735:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
736:             .Top       = 546
737:             .Left      = 88
738:             .Width     = 65
739:             .Height    = 17
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .AutoSize  = .T.

*-- Linhas 749 a 806:
749:         loc_oPagina.AddObject("edt_4c_Observacao", "EditBox")
750:         WITH loc_oPagina.edt_4c_Observacao
751:             .Value         = ""
752:             .Top           = 541
753:             .Left          = 157
754:             .Width         = 465
755:             .Height        = 80
756:             .FontName      = "Verdana"
757:             .FontSize      = 8
758:             .SpecialEffect = 1
759:             .ReadOnly      = .F.
760:             .Visible       = .T.
761:         ENDWITH
762: 
763:         *-- Area de Auditoria (Data/Usuario - READ ONLY)
764:         *-- Label "Data / Usuario" (Say20: Top=511+27=538, Left=626)
765:         loc_oPagina.AddObject("lbl_4c_Label20", "Label")
766:         WITH loc_oPagina.lbl_4c_Label20
767:             .Caption   = "Data / Usu" + CHR(225) + "rio"
768:             .Top       = 538
769:             .Left      = 626
770:             .Width     = 71
771:             .Height    = 17
772:             .FontName  = "Tahoma"
773:             .FontSize  = 8
774:             .AutoSize  = .T.
775:             .BackStyle = 0
776:             .ForeColor = RGB(90, 90, 90)
777:             .Visible   = .T.
778:         ENDWITH
779: 
780:         *-- Label "Inclusao" (Say24: Top=530+27=557, Left=626)
781:         loc_oPagina.AddObject("lbl_4c_Label24", "Label")
782:         WITH loc_oPagina.lbl_4c_Label24
783:             .Caption   = "Inclus" + CHR(227) + "o"
784:             .Top       = 557
785:             .Left      = 626
786:             .Width     = 42
787:             .Height    = 15
788:             .FontName  = "Tahoma"
789:             .FontSize  = 8
790:             .AutoSize  = .T.
791:             .BackStyle = 0
792:             .ForeColor = RGB(90, 90, 90)
793:             .Visible   = .T.
794:         ENDWITH
795: 
796:         *-- Label "Alteracao" (Say25: Top=530+27=557, Left=707)
797:         loc_oPagina.AddObject("lbl_4c_Label25", "Label")
798:         WITH loc_oPagina.lbl_4c_Label25
799:             .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
800:             .Top       = 557
801:             .Left      = 707
802:             .Width     = 48
803:             .Height    = 15
804:             .FontName  = "Tahoma"
805:             .FontSize  = 8
806:             .AutoSize  = .T.

*-- Linhas 812 a 835:
812:         *-- Shape3 - separador linha auditoria (Top=526+27=553, Left=626)
813:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
814:         WITH loc_oPagina.shp_4c_Shape3
815:             .Top           = 553
816:             .Left          = 626
817:             .Width         = 161
818:             .Height        = 2
819:             .BackStyle     = 0
820:             .BorderWidth   = 2
821:             .SpecialEffect = 0
822:             .Visible       = .T.
823:         ENDWITH
824: 
825:         *-- Data Inclusao READ ONLY (Get_DtIncs: Top=545+27=572, Left=626, Width=79)
826:         loc_oPagina.AddObject("txt_4c_DtIncs", "TextBox")
827:         WITH loc_oPagina.txt_4c_DtIncs
828:             .Value         = {}
829:             .Top           = 572
830:             .Left          = 626
831:             .Width         = 79
832:             .Height        = 23
833:             .FontName      = "Tahoma"
834:             .FontSize      = 8
835:             .MaxLength     = 8

*-- Linhas 844 a 853:
844:         loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
845:         WITH loc_oPagina.txt_4c_Usuario
846:             .Value         = ""
847:             .Top           = 596
848:             .Left          = 626
849:             .Width         = 79
850:             .Height        = 23
851:             .MaxLength     = 10
852:             .FontName      = "Tahoma"
853:             .FontSize      = 8

*-- Linhas 862 a 871:
862:         loc_oPagina.AddObject("txt_4c_DataAlts", "TextBox")
863:         WITH loc_oPagina.txt_4c_DataAlts
864:             .Value         = {}
865:             .Top           = 572
866:             .Left          = 707
867:             .Width         = 79
868:             .Height        = 23
869:             .FontName      = "Tahoma"
870:             .FontSize      = 8
871:             .MaxLength     = 8

*-- Linhas 880 a 889:
880:         loc_oPagina.AddObject("txt_4c_UsuaAlts", "TextBox")
881:         WITH loc_oPagina.txt_4c_UsuaAlts
882:             .Value         = ""
883:             .Top           = 596
884:             .Left          = 707
885:             .Width         = 79
886:             .Height        = 23
887:             .MaxLength     = 10
888:             .FontName      = "Tahoma"
889:             .FontSize      = 8

*-- Linhas 921 a 930:
921:                     .Column1.ControlSource  = "cursor_4c_Dados.codigo"
922:                     .Column2.ControlSource  = "cursor_4c_Dados.descricao"
923: 
924:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
925:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o."
926: 
927:                     .Column1.Width     = 100
928:                     .Column2.Width     = 250
929:                     .Column1.Alignment = 0
930:                     .Column2.Alignment = 0

*-- Linhas 1295 a 1304:
1295:         loc_lEdicao = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
1296:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1297: 
1298:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
1299:         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1300:     ENDPROC
1301: 
1302:     *===========================================================================
1303:     * CarregarGradeRegra - ZAP + SQLEXEC + APPEND para preservar colunas do grid
1304:     * NAO chama rgrBO.CarregarLinhasRegra() pois ela recriar o cursor (Problem 34)


### BO (C:\4c\projeto\app\classes\rgrBO.prg):
*==============================================================================
* rgrBO.prg - Business Object para Regras de E-Commerce
* Tabela principal : SigCdRGR
* Tabela detalhe   : SigCdRga (gerenciada via cursor csSigCdRga)
* Form relacionado : Formrgr.prg
*==============================================================================

DEFINE CLASS rgrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - SigCdRGR (cabecalho da regra)
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""   && cidchaves  char(20) - chave interna (fUniqueIds)
    this_cCodigo     = ""   && codigo     char(10) - codigo da regra (chave visivel)
    this_cDescricao  = ""   && descricao  char(40) - descricao
    this_dDatas      = {}   && datas      datetime - data de inclusao
    this_dDtaAlts    = {}   && dtaalts    datetime - data de alteracao
    this_cObservacao = ""   && observacao text     - observacao
    this_cUsaAlts    = ""   && usualts    char(10) - usuario que alterou
    this_cUsuIncs    = ""   && usuincs    char(10) - usuario que incluiu
    this_nInativas   = 0    && inativas   numeric(1,0) - 0=ativo / 1=inativo
    this_nValor      = 0    && valor      numeric(12,2)- valor minimo do pedido

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdRGR"
        THIS.this_cCampoChave = "Codigo"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave interna para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de regras para o Grid da Page1
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.codigo, a.descricao," + ;
                       " a.inativas, a.valor" + ;
                       " FROM SigCdRGR a" + ;
                       " ORDER BY a.codigo"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar regras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar regras:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro RGR pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.codigo, a.descricao, a.datas," + ;
                       " a.dtaalts, a.observacao, a.usualts, a.usuincs," + ;
                       " a.inativas, a.valor" + ;
                       " FROM SigCdRGR a" + ;
                       " WHERE a.codigo = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCodigo     = TratarNulo(codigo,     "C")
            THIS.this_cDescricao  = TratarNulo(descricao,  "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_dDtaAlts    = TratarNulo(dtaalts,    "D")
            THIS.this_cObservacao = TratarNulo(observacao,  "")
            THIS.this_cUsaAlts    = TratarNulo(usualts,    "C")
            THIS.this_cUsuIncs    = TratarNulo(usuincs,    "C")
            THIS.this_nInativas   = TratarNulo(inativas,   "N")
            THIS.this_nValor      = TratarNulo(valor,      "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLinhasRegra - Popula cursor csSigCdRga com linhas do servidor
    *--------------------------------------------------------------------------
    FUNCTION CarregarLinhasRegra(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("csSigCdRga")
                USE IN csSigCdRga
            ENDIF

            SET NULL ON
            CREATE CURSOR csSigCdRga ( ;
                cIdChaves  C(20), ;
                Codigo     C(10), ;
                Empresa    C(3),  ;
                Grupo      C(10), ;
                Conta      C(10), ;
                Colecao    C(20), ;
                Quantidade N(3,0),;
                Prioridade N(3,0),;
                GrupoPr    C(3),  ;
                Zerar      C(1),  ;
                Ordem      C(1)   ;
            )
            SET NULL OFF

            IF NOT EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.cidchaves, a.codigo, a.empresa, a.grupo," + ;
                           " a.conta, a.colecao, a.quantidade, a.prioridade," + ;
                           " a.grupopr, a.zerar, a.ordem" + ;
                           " FROM SigCdRga a" + ;
                           " WHERE a.codigo = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                           " ORDER BY a.prioridade"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_LinhasRgr")
                    TABLEREVERT(.T., "cursor_4c_LinhasRgr")
                    USE IN cursor_4c_LinhasRgr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhasRgr")
                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_LinhasRgr") > 0
                        SELECT cursor_4c_LinhasRgr
                        GO TOP
                        SCAN
                            SELECT csSigCdRga
                            APPEND BLANK
                            REPLACE cIdChaves  WITH ALLTRIM(cursor_4c_LinhasRgr.cidchaves)
                            REPLACE Codigo     WITH ALLTRIM(cursor_4c_LinhasRgr.codigo)
                            REPLACE Empresa    WITH ALLTRIM(cursor_4c_LinhasRgr.empresa)
                            REPLACE Grupo      WITH ALLTRIM(cursor_4c_LinhasRgr.grupo)
                            REPLACE Conta      WITH ALLTRIM(cursor_4c_LinhasRgr.conta)
                            REPLACE Colecao    WITH ALLTRIM(cursor_4c_LinhasRgr.colecao)
                            REPLACE Quantidade WITH cursor_4c_LinhasRgr.quantidade
                            REPLACE Prioridade WITH cursor_4c_LinhasRgr.prioridade
                            REPLACE GrupoPr    WITH ALLTRIM(cursor_4c_LinhasRgr.grupopr)
                            REPLACE Zerar      WITH ALLTRIM(cursor_4c_LinhasRgr.zerar)
                            REPLACE Ordem      WITH ALLTRIM(cursor_4c_LinhasRgr.ordem)
                            SELECT cursor_4c_LinhasRgr
                        ENDSCAN
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar linhas de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_LinhasRgr")
                    USE IN cursor_4c_LinhasRgr
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            SELECT csSigCdRga
            GO TOP
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar linhas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhasRegra - Insere linhas validas do csSigCdRga no SigCdRga
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION InserirLinhasRegra()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChaveRga
        loc_lSucesso = .T.

        IF NOT USED("csSigCdRga")
            RETURN .T.
        ENDIF

        TRY
            SELECT csSigCdRga
            GO TOP
            SCAN
                IF EMPTY(ALLTRIM(csSigCdRga.Empresa))    AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Grupo))      AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Conta))      AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Colecao))    AND ;
                   EMPTY(ALLTRIM(csSigCdRga.GrupoPr))    AND ;
                   csSigCdRga.Quantidade = 0
                    LOOP
                ENDIF

                IF EMPTY(ALLTRIM(csSigCdRga.cIdChaves))
                    loc_cChaveRga = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
                ELSE
                    loc_cChaveRga = ALLTRIM(csSigCdRga.cIdChaves)
                ENDIF

                loc_cSQL = "INSERT INTO SigCdRga" + ;
                           " (cidchaves, codigo, empresa, grupo, conta, colecao," + ;
                           "  quantidade, prioridade, grupopr, zerar, ordem)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cChaveRga) + "," + ;
                           EscaparSQL(THIS.this_cCodigo) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Empresa)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Grupo)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Conta)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Colecao)) + "," + ;
                           FormatarNumeroSQL(csSigCdRga.Quantidade) + "," + ;
                           FormatarNumeroSQL(csSigCdRga.Prioridade) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.GrupoPr)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Zerar)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Ordem)) + ")"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_InsRga")
                    TABLEREVERT(.T., "cursor_4c_InsRga")
                    USE IN cursor_4c_InsRga
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRga")
                IF USED("cursor_4c_InsRga")
                    USE IN cursor_4c_InsRga
                ENDIF

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir linha de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir linhas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRGR + SigCdRga (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigCdRGR" + ;
                       " (cidchaves, codigo, descricao, datas," + ;
                       "  observacao, usuincs, usualts, inativas, valor, dtaalts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cObservacao) + "," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       EscaparSQL("") + "," + ;
                       FormatarNumeroSQL(THIS.this_nInativas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                       "NULL)"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_InsRgr")
                TABLEREVERT(.T., "cursor_4c_InsRgr")
                USE IN cursor_4c_InsRgr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRgr")
            IF USED("cursor_4c_InsRgr")
                USE IN cursor_4c_InsRgr
            ENDIF

            IF loc_nResultado >= 0
                loc_lSucesso = THIS.InserirLinhasRegra()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdRGR + DELETE/INSERT SigCdRga (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdRGR SET" + ;
                       " descricao = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " observacao = " + EscaparSQL(THIS.this_cObservacao) + "," + ;
                       " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       " inativas = " + FormatarNumeroSQL(THIS.this_nInativas) + "," + ;
                       " valor = " + FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                       " dtaalts = GETDATE()" + ;
                       " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_UpdRgr")
                TABLEREVERT(.T., "cursor_4c_UpdRgr")
                USE IN cursor_4c_UpdRgr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRgr")
            IF USED("cursor_4c_UpdRgr")
                USE IN cursor_4c_UpdRgr
            ENDIF

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdRga WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DelRga")
                    TABLEREVERT(.T., "cursor_4c_DelRga")
                    USE IN cursor_4c_DelRga
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRga")
                IF USED("cursor_4c_DelRga")
                    USE IN cursor_4c_DelRga
                ENDIF

                IF loc_nResultado >= 0
                    loc_lSucesso = THIS.InserirLinhasRegra()
                    IF loc_lSucesso
                        loc_cSQL = "UPDATE SigPrdWb SET qtds = 0 WHERE codregra = " + ;
                                   EscaparSQL(THIS.this_cCodigo)
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_UpdWb")
                            TABLEREVERT(.T., "cursor_4c_UpdWb")
                            USE IN cursor_4c_UpdWb
                        ENDIF

                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdWb")
                        IF USED("cursor_4c_UpdWb")
                            USE IN cursor_4c_UpdWb
                        ENDIF
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir linhas antigas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigCdRga + SigCdRGR (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRga WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelRga")
                TABLEREVERT(.T., "cursor_4c_DelRga")
                USE IN cursor_4c_DelRga
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRga")
            IF USED("cursor_4c_DelRga")
                USE IN cursor_4c_DelRga
            ENDIF

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdRGR WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DelRgr")
                    TABLEREVERT(.T., "cursor_4c_DelRgr")
                    USE IN cursor_4c_DelRgr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgr")
                IF USED("cursor_4c_DelRgr")
                    USE IN cursor_4c_DelRgr
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir linhas de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("csSigCdRga")
            USE IN csSigCdRga
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

