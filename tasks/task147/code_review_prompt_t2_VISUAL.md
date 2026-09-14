# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [FONTNAME-ERRADO] Linha 742: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 759: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 779: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 797: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 815: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 833: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 851: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 869: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 887: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp6.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3953 linhas total):

*-- Linhas 74 a 94:
74:         loc_cEmpresaInicial = ""
75: 
76:         TRY
77:             THIS.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de Ind" + CHR(250) + "stria"
78: 
79:             THIS.this_oBusinessObject = CREATEOBJECT("sigpdmp6BO")
80: 
81:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
82:                 MostrarErro("Erro ao criar sigpdmp6BO", "Erro Cr" + CHR(237) + "tico")
83:             ELSE
84:                 THIS.ConfigurarPageFrame()
85:                 THIS.ConfigurarPaginaLista()
86:                 THIS.ConfigurarPaginaDados()
87: 
88:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
89:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
90: 
91:                 *-- Inicializar empresa no filtro
92:                 loc_cEmpresaInicial = THIS.this_cPEmps
93:                 IF EMPTY(loc_cEmpresaInicial) AND VARTYPE(go_4c_Sistema) = "O"
94:                     loc_cEmpresaInicial = go_4c_Sistema.cCodEmpresa

*-- Linhas 115 a 415:
115:     *--------------------------------------------------------------------------
116:     * ConfigurarPageFrame - Configura PageFrame principal com 2 paginas
117:     * Top=-29 oculta abas do PageFrame; todos os controles nas Pages: Top += 29
118:     * Legado: Pagina.Top=-29, Left=-1, Width=1005, Height=635
119:     *--------------------------------------------------------------------------
120:     PROTECTED PROCEDURE ConfigurarPageFrame()
121:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
122: 
123:         WITH THIS.pgf_4c_Paginas
124:             .Top       = -29
125:             .Left      = -1
126:             .Width     = 1005
127:             .Height    = 631   && 635-4: Tabs=.F. via AddObject adiciona +4 ao Page.Height em runtime
128:             .PageCount = 2
129:             .Tabs      = .F.
130:             .Visible   = .T.
131:         ENDWITH
132: 
133:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
134:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
135:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
136: 
137:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
138:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
139:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
140:     ENDPROC
141: 
142:     *--------------------------------------------------------------------------
143:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, legenda,
144:     *   botao Fecha Lote, grade principal
145:     * Compensacao PageFrame.Top=-29: todos os controles Top += 29
146:     *--------------------------------------------------------------------------
147:     PROTECTED PROCEDURE ConfigurarPaginaLista()
148:         LOCAL loc_oPagina
149:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
150: 
151:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
152: 
153:         *-- Container de cabecalho (fundo cinza medio com titulo)
154:         *-- Legado: cntSombra.Top=2->31; Width=1100; BackColor do framework=RGB(100,100,100)
155:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
156:         WITH loc_oPagina.cnt_4c_Cabecalho
157:             .Top         = 31
158:             .Left        = 0
159:             .Width       = 1003
160:             .Height      = 80
161:             .BackStyle   = 1
162:             .BackColor   = RGB(100, 100, 100)
163:             .BorderWidth = 0
164:             .Visible     = .T.
165:         ENDWITH
166: 
167:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
168:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
169:             .Caption   = THIS.Caption
170:             .Top       = 15
171:             .Left      = 10
172:             .Width     = 769
173:             .Height    = 40
174:             .FontName  = "Tahoma"
175:             .FontSize  = 16
176:             .FontBold  = .T.
177:             .ForeColor = RGB(0, 0, 0)
178:             .BackStyle = 0
179:             .Visible   = .T.
180:         ENDWITH
181: 
182:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
183:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
184:             .Caption   = THIS.Caption
185:             .Top       = 18
186:             .Left      = 10
187:             .Width     = 769
188:             .Height    = 46
189:             .FontName  = "Tahoma"
190:             .FontSize  = 16
191:             .FontBold  = .T.
192:             .ForeColor = RGB(255, 255, 255)
193:             .BackStyle = 0
194:             .Visible   = .T.
195:         ENDWITH
196: 
197:         *-- Container de botoes CRUD (lado direito) - TRANSPARENTE
198:         *-- Legado: Grupo_op.Left=545, Top=-1+29=28, Width=385, Height=85
199:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
200:         WITH loc_oPagina.cnt_4c_Botoes
201:             .Top         = 28
202:             .Left        =  542
203:             .Width       = 385
204:             .Height      = 85
205:             .BackStyle   = 0
206:             .BorderWidth = 0
207:             .Visible     = .T.
208:         ENDWITH
209: 
210:         *-- Botao Incluir (Inserir no legado): Left=5
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
213:             .Top       = 5
214:             .Left      = 5
215:             .Width     = 75
216:             .Height    = 75
217:             .FontName  = "Tahoma"
218:             .FontSize  = 8
219:             .Caption   = "Incluir"
220:             .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
221:             .ForeColor = RGB(90, 90, 90)
222:             .BackColor = RGB(255, 255, 255)
223:             .Themes          = .F.
224:             .PicturePosition = 13
225:             .Visible         = .T.
226:         ENDWITH
227: 
228:         *-- Botao Visualizar (Consultar no legado): Left=80
229:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
230:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
231:             .Top       = 5
232:             .Left      = 80
233:             .Width     = 75
234:             .Height    = 75
235:             .FontName  = "Tahoma"
236:             .FontSize  = 8
237:             .Caption   = "Visualizar"
238:             .Picture   = gc_4c_CaminhoIcones + "cadastro_consultar_60.jpg"
239:             .ForeColor = RGB(90, 90, 90)
240:             .BackColor = RGB(255, 255, 255)
241:             .Themes          = .F.
242:             .PicturePosition = 13
243:             .Visible         = .T.
244:         ENDWITH
245: 
246:         *-- Botao Alterar: Left=155
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
249:             .Top       = 5
250:             .Left      = 155
251:             .Width     = 75
252:             .Height    = 75
253:             .FontName  = "Tahoma"
254:             .FontSize  = 8
255:             .Caption   = "Alterar"
256:             .Picture   = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
257:             .ForeColor = RGB(90, 90, 90)
258:             .BackColor = RGB(255, 255, 255)
259:             .Themes          = .F.
260:             .PicturePosition = 13
261:             .Visible         = .T.
262:         ENDWITH
263: 
264:         *-- Botao Excluir: Left=230
265:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
266:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
267:             .Top       = 5
268:             .Left      = 230
269:             .Width     = 75
270:             .Height    = 75
271:             .FontName  = "Tahoma"
272:             .FontSize  = 8
273:             .Caption   = "Excluir"
274:             .Picture   = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
275:             .ForeColor = RGB(90, 90, 90)
276:             .BackColor = RGB(255, 255, 255)
277:             .Themes          = .F.
278:             .PicturePosition = 13
279:             .Visible         = .T.
280:         ENDWITH
281: 
282:         *-- Botao Buscar (Procurar no legado): Left=305
283:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
284:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
285:             .Top       = 5
286:             .Left      = 305
287:             .Width     = 75
288:             .Height    = 75
289:             .FontName  = "Tahoma"
290:             .FontSize  = 8
291:             .Caption   = "Buscar"
292:             .Picture   = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
293:             .ForeColor = RGB(90, 90, 90)
294:             .BackColor = RGB(255, 255, 255)
295:             .Themes          = .F.
296:             .PicturePosition = 13
297:             .Visible         = .T.
298:         ENDWITH
299: 
300:         *-- Container de saida (padrao canonico Left=917)
301:         *-- Legado: Grupo_Saida.Left=920, Top=-1+29=28; canonico prevalece (CLAUDE.md regra #10)
302:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
303:         WITH loc_oPagina.cnt_4c_Saida
304:             .Top         = 28
305:             .Left        = 917
306:             .Width       = 90
307:             .Height      = 85
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
314:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
315:             .Top       = 5
316:             .Left      = 5
317:             .Width     = 75
318:             .Height    = 75
319:             .FontName  = "Tahoma"
320:             .FontSize  = 8
321:             .Caption   = "Encerrar"
322:             .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
323:             .ForeColor = RGB(90, 90, 90)
324:             .BackColor = RGB(255, 255, 255)
325:             .Themes          = .F.
326:             .PicturePosition = 13
327:             .Visible         = .T.
328:         ENDWITH
329: 
330:         *-- Container de filtros por periodo (Cnt_periodo no legado)
331:         *-- Legado: Top=85+29=114, Left=12, Width=412, Height=64, BackStyle=0
332:         loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
333:         WITH loc_oPagina.cnt_4c_Periodo
334:             .Top         = 114
335:             .Left        = 12
336:             .Width       = 412
337:             .Height      = 64
338:             .BackStyle   = 0
339:             .BorderWidth = 1
340:             .BorderColor = RGB(90, 90, 90)
341:             .Visible     = .T.
342:         ENDWITH
343: 
344:         *-- Label Empresa
345:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Empresa", "Label")
346:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Empresa
347:             .Caption   = "\<Empresa : "
348:             .Top       = 10
349:             .Left      = 12
350:             .AutoSize  = .T.
351:             .FontName  = "Tahoma"
352:             .FontBold  = .T.
353:             .FontSize  = 8
354:             .BackStyle = 0
355:             .ForeColor = RGB(90, 90, 90)
356:             .Visible   = .T.
357:         ENDWITH
358: 
359:         *-- Campo Empresa (Get_cd_empresa): MaxLength=3, Width=35
360:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_Cd_empresa", "TextBox")
361:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_Cd_empresa
362:             .Top           = 6
363:             .Left          = 74
364:             .Width         = 35
365:             .Height        = 23
366:             .MaxLength     = 3
367:             .SpecialEffect = 1
368:             .ForeColor     = RGB(0, 0, 0)
369:             .BorderColor   = RGB(100, 100, 100)
370:             .Value         = ""
371:             .Visible       = .T.
372:         ENDWITH
373: 
374:         *-- Label Periodo
375:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Periodo", "Label")
376:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Periodo
377:             .Caption   = "\<Per" + CHR(237) + "odo : "
378:             .Top       = 37
379:             .Left      = 18
380:             .Width     = 54
381:             .Height    = 15
382:             .AutoSize  = .T.
383:             .FontName  = "Tahoma"
384:             .FontBold  = .T.
385:             .FontSize  = 8
386:             .BackStyle = 0
387:             .ForeColor = RGB(90, 90, 90)
388:             .Visible   = .T.
389:         ENDWITH
390: 
391:         *-- Label "ate"
392:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Ate", "Label")
393:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Ate
394:             .Caption   = "at" + CHR(233)
395:             .Top       = 36
396:             .Left      = 159
397:             .AutoSize  = .T.
398:             .FontName  = "Tahoma"
399:             .FontBold  = .T.
400:             .FontSize  = 8
401:             .BackStyle = 0
402:             .ForeColor = RGB(90, 90, 90)
403:             .Visible   = .T.
404:         ENDWITH
405: 
406:         *-- Data inicial (Dt_inicial): Format=K, value=date
407:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_Dt_inicial", "TextBox")
408:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_inicial
409:             .Top           = 33
410:             .Left          = 74
411:             .Width         = 80
412:             .Height        = 22
413:             .Format        = "K"
414:             .SpecialEffect = 1
415:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 422 a 431:
422:         *-- Data final (Dt_final): Format=K, value=date
423:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_Dt_final", "TextBox")
424:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_final
425:             .Top           = 33
426:             .Left          = 187
427:             .Width         = 80
428:             .Height        = 22
429:             .Format        = "K"
430:             .SpecialEffect = 1
431:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 439 a 460:
439:         *-- Legado: Top=124+29=153, Left=669, Width=283, Height=25
440:         loc_oPagina.AddObject("cnt_4c_Legenda", "Container")
441:         WITH loc_oPagina.cnt_4c_Legenda
442:             .Top         = 153
443:             .Left        = 669
444:             .Width       = 283
445:             .Height      = 25
446:             .BackStyle   = 0
447:             .BorderWidth = 0
448:             .Visible     = .T.
449:         ENDWITH
450: 
451:         *-- Botao1: Lancamento com Retrabalho (vermelho) Left=5
452:         loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao1", "TextBox")
453:         WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao1
454:             .Top           = 1
455:             .Left          = 5
456:             .Width         = 27
457:             .Height        = 22
458:             .BackColor     = RGB(255, 0, 0)
459:             .SpecialEffect = 1
460:             .BorderStyle   = 0

*-- Linhas 468 a 477:
468:         *-- Botao2: Operacao Baixada/Finalizada (azul) Left=32
469:         loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao2", "TextBox")
470:         WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao2
471:             .Top           = 1
472:             .Left          = 32
473:             .Width         = 27
474:             .Height        = 22
475:             .BackColor     = RGB(0, 0, 255)
476:             .SpecialEffect = 1
477:             .BorderStyle   = 0

*-- Linhas 485 a 494:
485:         *-- Botao4: Operacao Baixada com Retrabalho (magenta) Left=60
486:         loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao4", "TextBox")
487:         WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao4
488:             .Top           = 1
489:             .Left          = 60
490:             .Width         = 27
491:             .Height        = 22
492:             .BackColor     = RGB(255, 0, 255)
493:             .SpecialEffect = 1
494:             .BorderStyle   = 0

*-- Linhas 502 a 511:
502:         *-- Botao7: Lancamento com a conformidade (marrom) Left=88
503:         loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao7", "TextBox")
504:         WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao7
505:             .Top           = 1
506:             .Left          = 88
507:             .Width         = 27
508:             .Height        = 22
509:             .BackColor     = RGB(128, 0, 0)
510:             .SpecialEffect = 1
511:             .BorderStyle   = 0

*-- Linhas 519 a 528:
519:         *-- Botao8: Operacao Baixada c/ a conformidade (azul escuro) Left=115
520:         loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao8", "TextBox")
521:         WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao8
522:             .Top           = 1
523:             .Left          = 115
524:             .Width         = 27
525:             .Height        = 22
526:             .BackColor     = RGB(0, 0, 160)
527:             .SpecialEffect = 1
528:             .BorderStyle   = 0

*-- Linhas 536 a 545:
536:         *-- Botao3: Origem e Destino processados balanco (verde claro) Left=143
537:         loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao3", "TextBox")
538:         WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao3
539:             .Top           = 1
540:             .Left          = 143
541:             .Width         = 27
542:             .Height        = 22
543:             .BackColor     = RGB(220, 255, 220)
544:             .SpecialEffect = 1
545:             .BorderStyle   = 0

*-- Linhas 553 a 562:
553:         *-- Botao5: Origem processada balanco (laranja claro) Left=170
554:         loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao5", "TextBox")
555:         WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao5
556:             .Top           = 1
557:             .Left          = 170
558:             .Width         = 27
559:             .Height        = 22
560:             .BackColor     = RGB(255, 209, 164)
561:             .SpecialEffect = 1
562:             .BorderStyle   = 0

*-- Linhas 570 a 579:
570:         *-- Botao6: Destino processado balanco (amarelo claro) Left=198
571:         loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao6", "TextBox")
572:         WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao6
573:             .Top           = 1
574:             .Left          = 198
575:             .Width         = 27
576:             .Height        = 22
577:             .BackColor     = RGB(255, 255, 196)
578:             .SpecialEffect = 1
579:             .BorderStyle   = 0

*-- Linhas 587 a 596:
587:         *-- Botao9: Baixada Retrabalho e a conformidade (rosa) Left=226
588:         loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao9", "TextBox")
589:         WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao9
590:             .Top           = 1
591:             .Left          = 226
592:             .Width         = 27
593:             .Height        = 22
594:             .BackColor     = RGB(255, 0, 128)
595:             .SpecialEffect = 1
596:             .BorderStyle   = 0

*-- Linhas 604 a 613:
604:         *-- Botao10: Retrabalho e a conformidade (roxo) Left=253
605:         loc_oPagina.cnt_4c_Legenda.AddObject("txt_4c_Botao10", "TextBox")
606:         WITH loc_oPagina.cnt_4c_Legenda.txt_4c_Botao10
607:             .Top           = 1
608:             .Left          = 253
609:             .Width         = 27
610:             .Height        = 22
611:             .BackColor     = RGB(128, 0, 128)
612:             .SpecialEffect = 1
613:             .BorderStyle   = 0

*-- Linhas 620 a 650:
620: 
621:         *-- Botao Fecha Lote
622:         *-- Legado: Top=4+29=33, Left=475, Caption="Fecha lote", Picture=geral_palete_60.jpg
623:         loc_oPagina.AddObject("cmd_4c_Cmdfechalote", "CommandButton")
624:         WITH loc_oPagina.cmd_4c_Cmdfechalote
625:             .Top       = 33
626:             .Left      = 475
627:             .Width     = 75
628:             .Height    = 75
629:             .FontName  = "Tahoma"
630:             .FontSize  = 8
631:             .Caption   = "Fecha lote"
632:             .Picture   = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
633:             .ForeColor = RGB(90, 90, 90)
634:             .BackColor = RGB(255, 255, 255)
635:             .Themes          = .F.
636:             .PicturePosition = 13
637:             .Visible         = .T.
638:         ENDWITH
639: 
640:         *-- Grade principal de movimentos
641:         *-- Legado: Grade.Top=153+29=182, Left=12, Width=940, Height=442
642:         loc_oPagina.AddObject("grd_4c_Grade", "Grid")
643:         WITH loc_oPagina.grd_4c_Grade
644:             .Top          = 182
645:             .Left         = 12
646:             .Width        = 940
647:             .Height       = 442
648:             .RecordSource = ""
649:             .RecordMark   = .F.
650:             .DeleteMark   = .F.

*-- Linhas 659 a 673:
659:         THIS.FormatarGridLista()
660: 
661:         *-- BINDEVENTs: botoes CRUD (handlers PUBLIC por regra CLAUDE.md #3)
662:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
663:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
664:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
665:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
666:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
667:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
668:         BINDEVENT(loc_oPagina.cmd_4c_Cmdfechalote,             "Click", THIS, "CmdFechaLoteClick")
669: 
670:         *-- BINDEVENTs: filtros de periodo
671:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Cd_empresa, "KeyPress", THIS, "FiltroEmpresaLostFocus")
672:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_inicial, "KeyPress", THIS, "FiltroDtInicialLostFocus")
673:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_final,   "KeyPress", THIS, "FiltroDtFinalLostFocus")

*-- Linhas 681 a 703:
681:     *   Boleto/Documento), busca OP, container de dados principais (cntDados),
682:     *   botao de apontamentos em aberto, shapes decorativos, campos Documento e Aceite
683:     * Fase 5: primeiros 50% dos campos
684:     * Compensacao PageFrame.Top=-29: controles Top += 29
685:     *--------------------------------------------------------------------------
686:     PROTECTED PROCEDURE ConfigurarPaginaDados()
687:         LOCAL loc_oPagina
688:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
689: 
690:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
691: 
692:         *-- Faixa de titulo no topo (TxtCaption no legado)
693:         *-- Legado: Top=1+29=30, Left=-3, Width=1301, Height=19
694:         loc_oPagina.AddObject("lbl_4c_TxtCaption", "Label")
695:         WITH loc_oPagina.lbl_4c_TxtCaption
696:             .Caption   = "     Movimenta" + CHR(231) + CHR(227) + "o"
697:             .Top       = 30
698:             .Left      = -3
699:             .Width     = 1301
700:             .Height    = 19
701:             .FontName  = "Tahoma"
702:             .FontBold  = .T.
703:             .BackStyle = 1

*-- Linhas 710 a 908:
710:         *-- Legado: Top=14+29=43, Left=12, Width=432, Height=30
711:         loc_oPagina.AddObject("shp_4c_ShpBtnGs", "Shape")
712:         WITH loc_oPagina.shp_4c_ShpBtnGs
713:             .Top         = 43
714:             .Left        = 12
715:             .Width       = 432
716:             .Height      = 30
717:             .BackStyle   = 0
718:             .BorderStyle = 0
719:             .BorderColor = RGB(36, 84, 155)
720:             .Visible     = .T.
721:         ENDWITH
722: 
723:         *-- Container de botoes de acao (Salvar / Cancelar)
724:         *-- Legado: Grupo_Salva.Left=843, Top=22+29=51, Width=160, Height=85
725:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
726:         WITH loc_oPagina.cnt_4c_BotoesAcao
727:             .Top         = 51
728:             .Left        = 843
729:             .Width       = 160
730:             .Height      = 85
731:             .BackStyle   = 0
732:             .BorderWidth = 0
733:             .Visible     = .T.
734:         ENDWITH
735: 
736:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
737:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
738:             .Top             = 5
739:             .Left            = 5
740:             .Width           = 75
741:             .Height          = 75
742:             .FontName        = "Comic Sans MS"
743:             .FontSize        = 8
744:             .Caption         = "Salvar"
745:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
746:             .PicturePosition = 13
747:             .ForeColor       = RGB(90, 90, 90)
748:             .BackColor       = RGB(255, 255, 255)
749:             .Themes          = .F.
750:             .Visible         = .T.
751:         ENDWITH
752: 
753:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
754:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
755:             .Top             = 5
756:             .Left            = 80
757:             .Width           = 75
758:             .Height          = 75
759:             .FontName        = "Comic Sans MS"
760:             .FontSize        = 8
761:             .Caption         = "Encerrar"
762:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
763:             .PicturePosition = 13
764:             .ForeColor       = RGB(90, 90, 90)
765:             .BackColor       = RGB(255, 255, 255)
766:             .Themes          = .F.
767:             .Visible         = .T.
768:         ENDWITH
769: 
770:         *-- Botoes de acao operacionais (fwbtng no legado)
771:         *-- Todos: Top=24+29=53, Height=40 (fwbtng), FontName="Comic Sans MS"
772:         *-- Operacao (Movimento): Left=3
773:         loc_oPagina.AddObject("cmd_4c_Operacao", "CommandButton")
774:         WITH loc_oPagina.cmd_4c_Operacao
775:             .Top             = 53
776:             .Left            = 3
777:             .Width           = 75
778:             .Height          = 40
779:             .FontName        = "Comic Sans MS"
780:             .FontSize        = 8
781:             .Caption         = "M\<ovimento"
782:             .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
783:             .PicturePosition = 13
784:             .ForeColor       = RGB(90, 90, 90)
785:             .BackColor       = RGB(255, 255, 255)
786:             .Themes          = .F.
787:             .Visible         = .T.
788:         ENDWITH
789: 
790:         *-- Componentes: Left=78
791:         loc_oPagina.AddObject("cmd_4c_Componentes", "CommandButton")
792:         WITH loc_oPagina.cmd_4c_Componentes
793:             .Top             = 53
794:             .Left            = 78
795:             .Width           = 75
796:             .Height          = 40
797:             .FontName        = "Comic Sans MS"
798:             .FontSize        = 8
799:             .Caption         = "\<Componente"
800:             .Picture         = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
801:             .PicturePosition = 13
802:             .ForeColor       = RGB(90, 90, 90)
803:             .BackColor       = RGB(255, 255, 255)
804:             .Themes          = .F.
805:             .Visible         = .T.
806:         ENDWITH
807: 
808:         *-- Etiquetas: Left=153
809:         loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
810:         WITH loc_oPagina.cmd_4c_Etiquetas
811:             .Top             = 53
812:             .Left            = 153
813:             .Width           = 75
814:             .Height          = 40
815:             .FontName        = "Comic Sans MS"
816:             .FontSize        = 8
817:             .Caption         = "\<Etiquetas"
818:             .Picture         = gc_4c_CaminhoIcones + "geral_etiqueta_qr_60.jpg"
819:             .PicturePosition = 13
820:             .ForeColor       = RGB(90, 90, 90)
821:             .BackColor       = RGB(255, 255, 255)
822:             .Themes          = .F.
823:             .Visible         = .T.
824:         ENDWITH
825: 
826:         *-- Servicos: Left=228
827:         loc_oPagina.AddObject("cmd_4c_Servicos", "CommandButton")
828:         WITH loc_oPagina.cmd_4c_Servicos
829:             .Top             = 53
830:             .Left            = 228
831:             .Width           = 75
832:             .Height          = 40
833:             .FontName        = "Comic Sans MS"
834:             .FontSize        = 8
835:             .Caption         = "\<Servi" + CHR(231) + "os"
836:             .Picture         = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
837:             .PicturePosition = 13
838:             .ForeColor       = RGB(90, 90, 90)
839:             .BackColor       = RGB(255, 255, 255)
840:             .Themes          = .F.
841:             .Visible         = .T.
842:         ENDWITH
843: 
844:         *-- EtqCompo (Etq. Compo.): Left=303
845:         loc_oPagina.AddObject("cmd_4c_EtqCompo", "CommandButton")
846:         WITH loc_oPagina.cmd_4c_EtqCompo
847:             .Top             = 53
848:             .Left            = 303
849:             .Width           = 75
850:             .Height          = 40
851:             .FontName        = "Comic Sans MS"
852:             .FontSize        = 8
853:             .Caption         = "Etq. Compo."
854:             .Picture         = gc_4c_CaminhoIcones + "geral_etiqueta_60.jpg"
855:             .PicturePosition = 13
856:             .ForeColor       = RGB(90, 90, 90)
857:             .BackColor       = RGB(255, 255, 255)
858:             .Themes          = .F.
859:             .Visible         = .T.
860:         ENDWITH
861: 
862:         *-- Boleto: Left=378
863:         loc_oPagina.AddObject("cmd_4c_Boleto", "CommandButton")
864:         WITH loc_oPagina.cmd_4c_Boleto
865:             .Top             = 53
866:             .Left            = 378
867:             .Width           = 75
868:             .Height          = 40
869:             .FontName        = "Comic Sans MS"
870:             .FontSize        = 8
871:             .Caption         = "\<Boleto"
872:             .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
873:             .PicturePosition = 13
874:             .ForeColor       = RGB(90, 90, 90)
875:             .BackColor       = RGB(255, 255, 255)
876:             .Themes          = .F.
877:             .Visible         = .T.
878:         ENDWITH
879: 
880:         *-- Documento: Left=453
881:         loc_oPagina.AddObject("cmd_4c_Documento", "CommandButton")
882:         WITH loc_oPagina.cmd_4c_Documento
883:             .Top             = 53
884:             .Left            = 453
885:             .Width           = 75
886:             .Height          = 40
887:             .FontName        = "Comic Sans MS"
888:             .FontSize        = 8
889:             .Caption         = "\<Documento"
890:             .Picture         = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
891:             .PicturePosition = 13
892:             .ForeColor       = RGB(90, 90, 90)
893:             .BackColor       = RGB(255, 255, 255)
894:             .Themes          = .F.
895:             .Visible         = .T.
896:         ENDWITH
897: 
898:         *-- Campo busca OP (get_buscaop no legado)
899:         *-- Legado: Top=22+29=51, Left=718, Width=50, Height=23, InputMask="999999"
900:         loc_oPagina.AddObject("txt_4c_Buscaop", "TextBox")
901:         WITH loc_oPagina.txt_4c_Buscaop
902:             .Top           = 51
903:             .Left          = 718
904:             .Width         = 50
905:             .Height        = 23
906:             .FontBold      = .T.
907:             .Alignment     = 3
908:             .Value         = 0

*-- Linhas 916 a 928:
916: 
917:         *-- Label "Industrializa??o" (Say6 no legado)
918:         *-- Legado: Top=26+29=55, Left=599, Width=116, Height=15, Alignment=1
919:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
920:         WITH loc_oPagina.lbl_4c_Label6
921:             .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o :"
922:             .Top       = 55
923:             .Left      = 599
924:             .Width     = 116
925:             .Height    = 15
926:             .AutoSize  = .F.
927:             .Alignment = 1
928:             .FontName  = "Tahoma"

*-- Linhas 935 a 993:
935: 
936:         *-- Botao de apontamentos em aberto
937:         *-- Legado: Top=50+29=79, Left=771, Width=40, Height=40
938:         loc_oPagina.AddObject("cmd_4c_Bot_Pendentes", "CommandButton")
939:         WITH loc_oPagina.cmd_4c_Bot_Pendentes
940:             .Top         = 79
941:             .Left        = 771
942:             .Width       = 40
943:             .Height      = 40
944:             .FontName    = "Verdana"
945:             .FontSize    = 8
946:             .WordWrap    = .T.
947:             .Picture     = gc_4c_CaminhoIcones + "geral_pendencia_26.jpg"
948:             .Caption     = ""
949:             .ToolTipText = "Pend" + CHR(234) + "ncias"
950:             .ForeColor   = RGB(36, 84, 155)
951:             .BackColor   = RGB(255, 255, 255)
952:             .Themes      = .F.
953:             .Visible     = .T.
954:         ENDWITH
955: 
956:         *-- Container principal de dados (cntDados no legado)
957:         *-- Legado: Top=150+29=179, Left=12, Width=571, Height=75
958:         loc_oPagina.AddObject("cnt_4c_Dados", "Container")
959:         WITH loc_oPagina.cnt_4c_Dados
960:             .Top         = 179
961:             .Left        = 12
962:             .Width       = 571
963:             .Height      = 75
964:             .BackStyle   = 1
965:             .BackColor   = RGB(255, 255, 255)
966:             .BorderWidth = 1
967:             .BorderColor = RGB(136, 189, 188)
968:             .Visible     = .T.
969:         ENDWITH
970: 
971:         *-- Linha horizontal dentro de cntDados (Line1)
972:         loc_oPagina.cnt_4c_Dados.AddObject("lin_4c_Line1", "Line")
973:         WITH loc_oPagina.cnt_4c_Dados.lin_4c_Line1
974:             .Top         = 22
975:             .Left        = 11
976:             .Width       = 356
977:             .Height      = 0
978:             .BorderWidth = 2
979:             .BorderColor = RGB(90, 90, 90)
980:             .Visible     = .T.
981:         ENDWITH
982: 
983:         *-- Label "Codigo" (Say2 no legado cntDados)
984:         loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label2", "Label")
985:         WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label2
986:             .Caption   = "C" + CHR(243) + "digo "
987:             .Top       = 7
988:             .Left      = 11
989:             .AutoSize  = .T.
990:             .FontBold  = .T.
991:             .FontName  = "Tahoma"
992:             .FontSize  = 8
993:             .BackStyle = 0

*-- Linhas 999 a 1008:
999:         *-- Legado: Top=28, Left=11, Width=81, Height=23, InputMask="9999999999"
1000:         loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_Codigo", "TextBox")
1001:         WITH loc_oPagina.cnt_4c_Dados.txt_4c_Codigo
1002:             .Top           = 28
1003:             .Left          = 11
1004:             .Width         = 81
1005:             .Height        = 23
1006:             .FontBold      = .T.
1007:             .FontName      = "Tahoma"
1008:             .FontSize      = 8

*-- Linhas 1015 a 1027:
1015:         ENDWITH
1016: 
1017:         *-- Label "Data" (Say3 no legado cntDados)
1018:         loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label3", "Label")
1019:         WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label3
1020:             .Caption   = "Data "
1021:             .Top       = 7
1022:             .Left      = 98
1023:             .AutoSize  = .T.
1024:             .FontBold  = .T.
1025:             .FontName  = "Tahoma"
1026:             .FontSize  = 8
1027:             .BackStyle = 0

*-- Linhas 1033 a 1059:
1033:         *-- Legado: Top=28, Left=98, Format="K"
1034:         loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_Dt_data", "TextBox")
1035:         WITH loc_oPagina.cnt_4c_Dados.txt_4c_Dt_data
1036:             .Top           = 28
1037:             .Left          = 98
1038:             .Width         = 80
1039:             .Height        = 22
1040:             .FontName      = "Tahoma"
1041:             .Format        = "K"
1042:             .Value         = {}
1043:             .SpecialEffect = 1
1044:             .ForeColor     = RGB(0, 0, 0)
1045:             .BorderColor   = RGB(100, 100, 100)
1046:             .Visible       = .T.
1047:         ENDWITH
1048: 
1049:         *-- Label "Lote" (Say4 no legado cntDados)
1050:         loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label4", "Label")
1051:         WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label4
1052:             .Caption   = "Lote"
1053:             .Top       = 7
1054:             .Left      = 185
1055:             .AutoSize  = .T.
1056:             .FontBold  = .T.
1057:             .FontName  = "Tahoma"
1058:             .FontSize  = 8
1059:             .BackStyle = 0

*-- Linhas 1065 a 1074:
1065:         *-- Legado: Top=28, Left=184, Width=81, Height=23, MaxLength=10
1066:         loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_Lote", "TextBox")
1067:         WITH loc_oPagina.cnt_4c_Dados.txt_4c_Lote
1068:             .Top           = 28
1069:             .Left          = 184
1070:             .Width         = 81
1071:             .Height        = 23
1072:             .FontBold      = .T.
1073:             .FontName      = "Tahoma"
1074:             .Value         = 0

*-- Linhas 1080 a 1092:
1080:         ENDWITH
1081: 
1082:         *-- Label "Peso Total" (lblTotPeso no legado) - inicia oculto
1083:         loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_LblTotPeso", "Label")
1084:         WITH loc_oPagina.cnt_4c_Dados.lbl_4c_LblTotPeso
1085:             .Caption   = "Peso Total"
1086:             .Top       = 7
1087:             .Left      = 271
1088:             .AutoSize  = .T.
1089:             .FontBold  = .T.
1090:             .FontName  = "Tahoma"
1091:             .FontSize  = 8
1092:             .BackStyle = 0

*-- Linhas 1098 a 1107:
1098:         *-- Legado: Top=28, Left=271, Width=81, InputMask="999,999.999", Alignment=3
1099:         loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_TotPeso", "TextBox")
1100:         WITH loc_oPagina.cnt_4c_Dados.txt_4c_TotPeso
1101:             .Top           = 28
1102:             .Left          = 271
1103:             .Width         = 81
1104:             .Height        = 23
1105:             .Alignment     = 3
1106:             .Value         = 0
1107:             .InputMask     = "999,999.999"

*-- Linhas 1115 a 1167:
1115:         *-- Legado: Top=190+29=219, Left=774, Width=89, Height=34
1116:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
1117:         WITH loc_oPagina.shp_4c_Shape3
1118:             .Top           = 219
1119:             .Left          = 774
1120:             .Width         = 89
1121:             .Height        = 34
1122:             .BackStyle     = 0
1123:             .SpecialEffect = 1
1124:             .BorderColor   = RGB(90, 90, 90)
1125:             .Visible       = .T.
1126:         ENDWITH
1127: 
1128:         *-- Shape decorativo atras da area Aceite (Shape4 no legado)
1129:         *-- Legado: Top=189+29=218, Left=869, Width=89, Height=34
1130:         loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
1131:         WITH loc_oPagina.shp_4c_Shape4
1132:             .Top           = 218
1133:             .Left          = 869
1134:             .Width         = 89
1135:             .Height        = 34
1136:             .BackStyle     = 0
1137:             .SpecialEffect = 1
1138:             .BorderColor   = RGB(90, 90, 90)
1139:             .Visible       = .T.
1140:         ENDWITH
1141: 
1142:         *-- Label "Documento" (Say4 solto na Page2 no legado)
1143:         *-- Legado: Top=175+29=204, Left=774
1144:         loc_oPagina.AddObject("lbl_4c_Label4Docu", "Label")
1145:         WITH loc_oPagina.lbl_4c_Label4Docu
1146:             .Caption   = "Documento"
1147:             .Top       = 204
1148:             .Left      = 774
1149:             .AutoSize  = .T.
1150:             .FontBold  = .T.
1151:             .FontName  = "Tahoma"
1152:             .BackStyle = 0
1153:             .ForeColor = RGB(90, 90, 90)
1154:             .Visible   = .T.
1155:         ENDWITH
1156: 
1157:         *-- Campo Documento (Get_Docu no legado) ? docus
1158:         *-- Legado: Top=196+29=225, Left=778, Width=81, Height=23, MaxLength=10
1159:         loc_oPagina.AddObject("txt_4c_Docu", "TextBox")
1160:         WITH loc_oPagina.txt_4c_Docu
1161:             .Top           = 225
1162:             .Left          = 778
1163:             .Width         = 81
1164:             .Height        = 23
1165:             .FontBold      = .T.
1166:             .Value         = ""
1167:             .MaxLength     = 10

*-- Linhas 1173 a 1199:
1173: 
1174:         *-- Label "Aceite" (Say5 no legado)
1175:         *-- Legado: Top=174+29=203, Left=869
1176:         loc_oPagina.AddObject("lbl_4c_Label5Ace", "Label")
1177:         WITH loc_oPagina.lbl_4c_Label5Ace
1178:             .Caption   = "Aceite"
1179:             .Top       = 203
1180:             .Left      = 869
1181:             .AutoSize  = .T.
1182:             .FontBold  = .T.
1183:             .FontName  = "Tahoma"
1184:             .BackStyle = 0
1185:             .ForeColor = RGB(90, 90, 90)
1186:             .Visible   = .T.
1187:         ENDWITH
1188: 
1189:         *-- Campo Aceite (fwget1 no legado) ? naceites
1190:         *-- Legado: Top=195+29=224, Left=873, Width=81, Height=23, MaxLength=10
1191:         loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
1192:         WITH loc_oPagina.txt_4c_Fwget1
1193:             .Top           = 224
1194:             .Left          = 873
1195:             .Width         = 81
1196:             .Height        = 23
1197:             .FontBold      = .T.
1198:             .Value         = 0
1199:             .MaxLength     = 10

*-- Linhas 1210 a 1307:
1210:         *-- =====================================================================
1211:         loc_oPagina.AddObject("cnt_4c_Origem", "Container")
1212:         WITH loc_oPagina.cnt_4c_Origem
1213:             .Top         = 260
1214:             .Left        = 12
1215:             .Width       = 571
1216:             .Height      = 75
1217:             .BackStyle   = 1
1218:             .BackColor   = RGB(255, 255, 255)
1219:             .BorderWidth = 1
1220:             .BorderColor = RGB(136, 189, 188)
1221:             .Visible     = .T.
1222:         ENDWITH
1223: 
1224:         loc_oPagina.cnt_4c_Origem.AddObject("lin_4c_Line1", "Line")
1225:         WITH loc_oPagina.cnt_4c_Origem.lin_4c_Line1
1226:             .Top         = 22
1227:             .Left        = 11
1228:             .Width       = 340
1229:             .Height      = 0
1230:             .BorderWidth = 2
1231:             .BorderColor = RGB(90, 90, 90)
1232:         ENDWITH
1233: 
1234:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Say1", "Label")
1235:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Say1
1236:             .Caption   = "Origem"
1237:             .Top       = 6
1238:             .Left      = 11
1239:             .AutoSize  = .T.
1240:             .FontBold  = .T.
1241:             .FontName  = "Tahoma"
1242:             .FontSize  = 8
1243:             .BackStyle = 0
1244:             .ForeColor = RGB(90, 90, 90)
1245:         ENDWITH
1246: 
1247:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Say4", "Label")
1248:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Say4
1249:             .Caption   = "Origem"
1250:             .Top       = 23
1251:             .Left      = 18
1252:             .AutoSize  = .T.
1253:             .FontBold  = .T.
1254:             .FontName  = "Tahoma"
1255:             .FontSize  = 8
1256:             .BackStyle = 0
1257:             .ForeColor = RGB(90, 90, 90)
1258:         ENDWITH
1259: 
1260:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Say5", "Label")
1261:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Say5
1262:             .Caption   = "Grupo"
1263:             .Top       = 27
1264:             .Left      = 11
1265:             .AutoSize  = .T.
1266:             .FontBold  = .T.
1267:             .FontName  = "Tahoma"
1268:             .FontSize  = 8
1269:             .BackStyle = 0
1270:             .ForeColor = RGB(90, 90, 90)
1271:         ENDWITH
1272: 
1273:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Say2", "Label")
1274:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Say2
1275:             .Caption   = "Conta"
1276:             .Top       = 27
1277:             .Left      = 96
1278:             .AutoSize  = .T.
1279:             .FontBold  = .T.
1280:             .FontName  = "Tahoma"
1281:             .FontSize  = 8
1282:             .BackStyle = 0
1283:             .ForeColor = RGB(90, 90, 90)
1284:         ENDWITH
1285: 
1286:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Say3", "Label")
1287:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Say3
1288:             .Caption   = "Nome"
1289:             .Top       = 27
1290:             .Left      = 180
1291:             .AutoSize  = .T.
1292:             .FontBold  = .T.
1293:             .FontName  = "Tahoma"
1294:             .FontSize  = 8
1295:             .BackStyle = 0
1296:             .ForeColor = RGB(90, 90, 90)
1297:         ENDWITH
1298: 
1299:         loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_GrupoOrig", "TextBox")
1300:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOrig
1301:             .Top           = 42
1302:             .Left          = 11
1303:             .Width         = 80
1304:             .Height        = 23
1305:             .FontBold      = .T.
1306:             .FontName      = "Tahoma"
1307:             .FontSize      = 8

*-- Linhas 1314 a 1323:
1314: 
1315:         loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_ContaOrig", "TextBox")
1316:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_ContaOrig
1317:             .Top           = 42
1318:             .Left          = 96
1319:             .Width         = 80
1320:             .Height        = 23
1321:             .FontBold      = .T.
1322:             .FontName      = "Tahoma"
1323:             .FontSize      = 8

*-- Linhas 1330 a 1339:
1330: 
1331:         loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_DcontaOrig", "TextBox")
1332:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_DcontaOrig
1333:             .Top           = 42
1334:             .Left          = 180
1335:             .Width         = 302
1336:             .Height        = 23
1337:             .FontBold      = .T.
1338:             .FontName      = "Tahoma"
1339:             .FontSize      = 8

*-- Linhas 1351 a 1448:
1351:         *-- =====================================================================
1352:         loc_oPagina.AddObject("cnt_4c_Destino", "Container")
1353:         WITH loc_oPagina.cnt_4c_Destino
1354:             .Top         = 340
1355:             .Left        = 12
1356:             .Width       = 571
1357:             .Height      = 75
1358:             .BackStyle   = 1
1359:             .BackColor   = RGB(255, 255, 255)
1360:             .BorderWidth = 1
1361:             .BorderColor = RGB(136, 189, 188)
1362:             .Visible     = .T.
1363:         ENDWITH
1364: 
1365:         loc_oPagina.cnt_4c_Destino.AddObject("lin_4c_Line1", "Line")
1366:         WITH loc_oPagina.cnt_4c_Destino.lin_4c_Line1
1367:             .Top         = 22
1368:             .Left        = 11
1369:             .Width       = 340
1370:             .Height      = 0
1371:             .BorderWidth = 2
1372:             .BorderColor = RGB(90, 90, 90)
1373:         ENDWITH
1374: 
1375:         loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Say1", "Label")
1376:         WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Say1
1377:             .Caption   = "Destino"
1378:             .Top       = 6
1379:             .Left      = 11
1380:             .AutoSize  = .T.
1381:             .FontBold  = .T.
1382:             .FontName  = "Tahoma"
1383:             .FontSize  = 8
1384:             .BackStyle = 0
1385:             .ForeColor = RGB(90, 90, 90)
1386:         ENDWITH
1387: 
1388:         loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Say4", "Label")
1389:         WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Say4
1390:             .Caption   = "Destino"
1391:             .Top       = 18
1392:             .Left      = 52
1393:             .AutoSize  = .T.
1394:             .FontBold  = .T.
1395:             .FontName  = "Tahoma"
1396:             .FontSize  = 8
1397:             .BackStyle = 0
1398:             .ForeColor = RGB(90, 90, 90)
1399:         ENDWITH
1400: 
1401:         loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Say5", "Label")
1402:         WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Say5
1403:             .Caption   = "Grupo"
1404:             .Top       = 27
1405:             .Left      = 11
1406:             .AutoSize  = .T.
1407:             .FontBold  = .T.
1408:             .FontName  = "Tahoma"
1409:             .FontSize  = 8
1410:             .BackStyle = 0
1411:             .ForeColor = RGB(90, 90, 90)
1412:         ENDWITH
1413: 
1414:         loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Say2", "Label")
1415:         WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Say2
1416:             .Caption   = "Conta"
1417:             .Top       = 27
1418:             .Left      = 96
1419:             .AutoSize  = .T.
1420:             .FontBold  = .T.
1421:             .FontName  = "Tahoma"
1422:             .FontSize  = 8
1423:             .BackStyle = 0
1424:             .ForeColor = RGB(90, 90, 90)
1425:         ENDWITH
1426: 
1427:         loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Say3", "Label")
1428:         WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Say3
1429:             .Caption   = "Nome"
1430:             .Top       = 27
1431:             .Left      = 180
1432:             .AutoSize  = .T.
1433:             .FontBold  = .T.
1434:             .FontName  = "Tahoma"
1435:             .FontSize  = 8
1436:             .BackStyle = 0
1437:             .ForeColor = RGB(90, 90, 90)
1438:         ENDWITH
1439: 
1440:         loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_GrupoDest", "TextBox")
1441:         WITH loc_oPagina.cnt_4c_Destino.txt_4c_GrupoDest
1442:             .Top           = 42
1443:             .Left          = 11
1444:             .Width         = 80
1445:             .Height        = 23
1446:             .FontBold      = .T.
1447:             .FontName      = "Tahoma"
1448:             .FontSize      = 8

*-- Linhas 1455 a 1464:
1455: 
1456:         loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_ContaDest", "TextBox")
1457:         WITH loc_oPagina.cnt_4c_Destino.txt_4c_ContaDest
1458:             .Top           = 42
1459:             .Left          = 96
1460:             .Width         = 80
1461:             .Height        = 23
1462:             .FontBold      = .T.
1463:             .FontName      = "Tahoma"
1464:             .FontSize      = 8

*-- Linhas 1471 a 1480:
1471: 
1472:         loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_DcontaDest", "TextBox")
1473:         WITH loc_oPagina.cnt_4c_Destino.txt_4c_DcontaDest
1474:             .Top           = 42
1475:             .Left          = 180
1476:             .Width         = 302
1477:             .Height        = 23
1478:             .FontBold      = .T.
1479:             .FontName      = "Tahoma"
1480:             .FontSize      = 8

*-- Linhas 1492 a 1589:
1492:         *-- =====================================================================
1493:         loc_oPagina.AddObject("cnt_4c_Responsavel", "Container")
1494:         WITH loc_oPagina.cnt_4c_Responsavel
1495:             .Top         = 419
1496:             .Left        = 12
1497:             .Width       = 571
1498:             .Height      = 75
1499:             .BackStyle   = 1
1500:             .BackColor   = RGB(255, 255, 255)
1501:             .BorderWidth = 1
1502:             .BorderColor = RGB(136, 189, 188)
1503:             .Visible     = .T.
1504:         ENDWITH
1505: 
1506:         loc_oPagina.cnt_4c_Responsavel.AddObject("lin_4c_Line1", "Line")
1507:         WITH loc_oPagina.cnt_4c_Responsavel.lin_4c_Line1
1508:             .Top         = 22
1509:             .Left        = 11
1510:             .Width       = 340
1511:             .Height      = 0
1512:             .BorderWidth = 2
1513:             .BorderColor = RGB(90, 90, 90)
1514:         ENDWITH
1515: 
1516:         loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Say1", "Label")
1517:         WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Say1
1518:             .Caption   = "Respons" + CHR(225) + "vel"
1519:             .Top       = 6
1520:             .Left      = 11
1521:             .AutoSize  = .T.
1522:             .FontBold  = .T.
1523:             .FontName  = "Tahoma"
1524:             .FontSize  = 8
1525:             .BackStyle = 0
1526:             .ForeColor = RGB(90, 90, 90)
1527:         ENDWITH
1528: 
1529:         loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Say4", "Label")
1530:         WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Say4
1531:             .Caption   = "Respons" + CHR(225) + "vel"
1532:             .Top       = 28
1533:             .Left      = 48
1534:             .AutoSize  = .T.
1535:             .FontBold  = .T.
1536:             .FontName  = "Tahoma"
1537:             .FontSize  = 8
1538:             .BackStyle = 0
1539:             .ForeColor = RGB(90, 90, 90)
1540:         ENDWITH
1541: 
1542:         loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Say5", "Label")
1543:         WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Say5
1544:             .Caption   = "Grupo"
1545:             .Top       = 27
1546:             .Left      = 11
1547:             .AutoSize  = .T.
1548:             .FontBold  = .T.
1549:             .FontName  = "Tahoma"
1550:             .FontSize  = 8
1551:             .BackStyle = 0
1552:             .ForeColor = RGB(90, 90, 90)
1553:         ENDWITH
1554: 
1555:         loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Say2", "Label")
1556:         WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Say2
1557:             .Caption   = "Conta"
1558:             .Top       = 27
1559:             .Left      = 96
1560:             .AutoSize  = .T.
1561:             .FontBold  = .T.
1562:             .FontName  = "Tahoma"
1563:             .FontSize  = 8
1564:             .BackStyle = 0
1565:             .ForeColor = RGB(90, 90, 90)
1566:         ENDWITH
1567: 
1568:         loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Say3", "Label")
1569:         WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Say3
1570:             .Caption   = "Nome"
1571:             .Top       = 27
1572:             .Left      = 180
1573:             .AutoSize  = .T.
1574:             .FontBold  = .T.
1575:             .FontName  = "Tahoma"
1576:             .FontSize  = 8
1577:             .BackStyle = 0
1578:             .ForeColor = RGB(90, 90, 90)
1579:         ENDWITH
1580: 
1581:         loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_GrupoResp", "TextBox")
1582:         WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_GrupoResp
1583:             .Top           = 42
1584:             .Left          = 11
1585:             .Width         = 80
1586:             .Height        = 23
1587:             .FontBold      = .T.
1588:             .FontName      = "Tahoma"
1589:             .FontSize      = 8

*-- Linhas 1596 a 1605:
1596: 
1597:         loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_ContaResp", "TextBox")
1598:         WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_ContaResp
1599:             .Top           = 42
1600:             .Left          = 96
1601:             .Width         = 80
1602:             .Height        = 23
1603:             .FontBold      = .T.
1604:             .FontName      = "Tahoma"
1605:             .FontSize      = 8

*-- Linhas 1612 a 1621:
1612: 
1613:         loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_DcontaResp", "TextBox")
1614:         WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_DcontaResp
1615:             .Top           = 42
1616:             .Left          = 180
1617:             .Width         = 302
1618:             .Height        = 23
1619:             .FontBold      = .T.
1620:             .FontName      = "Tahoma"
1621:             .FontSize      = 8

*-- Linhas 1633 a 1642:
1633:         *-- =====================================================================
1634:         loc_oPagina.AddObject("grd_4c_GradeOperacao", "Grid")
1635:         WITH loc_oPagina.grd_4c_GradeOperacao
1636:             .Top         = 79
1637:             .Left        = 598
1638:             .Width       = 171
1639:             .Height      = 182
1640:             .ColumnCount = 2
1641:             .ReadOnly    = .T.
1642:             .Visible     = .F.

*-- Linhas 1649 a 1691:
1649:             .FontName        = "Courier New"
1650:             .Width           = 94
1651:             .InputMask       = "999999999999"
1652:             .Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
1653:         ENDWITH
1654: 
1655:         WITH loc_oPagina.grd_4c_GradeOperacao.Column2
1656:             .ControlSource   = "TmpOperacao.TmpMins"
1657:             .FontName        = "Courier New"
1658:             .Width           = 45
1659:             .InputMask       = "99999"
1660:             .Header1.Caption = "Temp/Min"
1661:         ENDWITH
1662: 
1663:         *-- =====================================================================
1664:         *-- CAMPO CODIGO DE OBSERVACAO (get_codobs no legado)
1665:         *-- Legado: Top=234+29=263, Left=690, Width=32, Height=23, InputMask="999"
1666:         *-- Label: Top=238+29=267, Left=599 (Say3 no legado)
1667:         *-- BO: this_cCodObs
1668:         *-- =====================================================================
1669:         loc_oPagina.AddObject("lbl_4c_LblObs", "Label")
1670:         WITH loc_oPagina.lbl_4c_LblObs
1671:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1672:             .Top       = 267
1673:             .Left      = 599
1674:             .AutoSize  = .T.
1675:             .FontBold  = .T.
1676:             .FontName  = "Tahoma"
1677:             .FontSize  = 8
1678:             .BackStyle = 0
1679:             .ForeColor = RGB(90, 90, 90)
1680:             .Visible   = .T.
1681:         ENDWITH
1682: 
1683:         loc_oPagina.AddObject("txt_4c_Codobs", "TextBox")
1684:         WITH loc_oPagina.txt_4c_Codobs
1685:             .Top           = 263
1686:             .Left          = 690
1687:             .Width         = 32
1688:             .Height        = 23
1689:             .FontBold      = .T.
1690:             .FontName      = "Tahoma"
1691:             .FontSize      = 8

*-- Linhas 1702 a 1748:
1702:         *-- BO: this_cObss
1703:         loc_oPagina.AddObject("edt_4c_Mmobs", "EditBox")
1704:         WITH loc_oPagina.edt_4c_Mmobs
1705:             .Top    = 288
1706:             .Left   = 597
1707:             .Width  = 397
1708:             .Height = 205
1709:             .FontName  = "Tahoma"
1710:             .FontSize  = 8
1711:             .Visible   = .T.
1712:         ENDWITH
1713: 
1714:         *-- Botao Componentes OPs (btnCompoOp no legado)
1715:         *-- Legado: Top=481+29=510, Left=17
1716:         loc_oPagina.AddObject("cmd_4c_BtnCompoOp", "CommandButton")
1717:         WITH loc_oPagina.cmd_4c_BtnCompoOp
1718:             .Top         = 510
1719:             .Left        = 17
1720:             .Width       = 100
1721:             .Height      = 27
1722:             .FontName    = "Tahoma"
1723:             .FontSize    = 8
1724:             .Caption     = "Compo. OPs"
1725:             .ForeColor   = RGB(36, 84, 155)
1726:             .BackColor   = RGB(255, 255, 255)
1727:             .Themes      = .F.
1728:             .Visible     = .T.
1729:         ENDWITH
1730: 
1731:         *-- BINDEVENTs: botoes Salvar/Cancelar
1732:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1733:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1734: 
1735:         *-- BINDEVENTs: botoes de acao operacionais
1736:         BINDEVENT(loc_oPagina.cmd_4c_Operacao,       "Click", THIS, "BtnOperacaoClick")
1737:         BINDEVENT(loc_oPagina.cmd_4c_Componentes,    "Click", THIS, "BtnComponentesClick")
1738:         BINDEVENT(loc_oPagina.cmd_4c_Etiquetas,      "Click", THIS, "BtnEtiquetasClick")
1739:         BINDEVENT(loc_oPagina.cmd_4c_Servicos,       "Click", THIS, "BtnServicosClick")
1740:         BINDEVENT(loc_oPagina.cmd_4c_EtqCompo,       "Click", THIS, "BtnEtqCompoClick")
1741:         BINDEVENT(loc_oPagina.cmd_4c_Boleto,         "Click", THIS, "BtnBoletoClick")
1742:         BINDEVENT(loc_oPagina.cmd_4c_Documento,      "Click", THIS, "BtnDocumentoClick")
1743:         BINDEVENT(loc_oPagina.cmd_4c_Bot_Pendentes,  "Click", THIS, "BtnPendentesClick")
1744: 
1745:         *-- BINDEVENTs: campos de dados
1746:         BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_Dt_data,  "KeyPress", THIS, "DtDataLostFocus")
1747:         BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_Lote,     "KeyPress", THIS, "LoteLostFocus")
1748:         BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_TotPeso,  "KeyPress", THIS, "TotPesoLostFocus")

*-- Linhas 1773 a 1785:
1773:         *-- BINDEVENTs: codigo observacao e botao CompoOp
1774:         BINDEVENT(loc_oPagina.txt_4c_Codobs,     "KeyPress", THIS, "CodobsLostFocus")
1775:         BINDEVENT(loc_oPagina.txt_4c_Codobs,     "KeyPress",  THIS, "TeclaCodobsKP")
1776:         BINDEVENT(loc_oPagina.cmd_4c_BtnCompoOp, "Click",     THIS, "BtnEtqCompoClick")
1777: 
1778:         THIS.TornarControlesVisiveis(loc_oPagina)
1779:         *-- Restaurar lblTotPeso para oculto (TornarControlesVisiveis seta .T. em tudo)
1780:         loc_oPagina.cnt_4c_Dados.lbl_4c_LblTotPeso.Visible = .F.
1781:         *-- GradeOperacao sempre oculta inicialmente (controle operacional)
1782:         loc_oPagina.grd_4c_GradeOperacao.Visible = .F.
1783:     ENDPROC
1784: 
1785:     *--------------------------------------------------------------------------

*-- Linhas 1826 a 1918:
1826:             .Width         = 70
1827:             .Resizable     = .F.
1828:             .Movable       = .F.
1829:             .Header1.Caption   = "C" + CHR(243) + "digo"
1830:             .Header1.Alignment = 2
1831:             .Header1.FontName  = "Tahoma"
1832:             .Header1.FontBold  = .T.
1833:             .Header1.FontSize  = 8
1834:         ENDWITH
1835: 
1836:         WITH loc_oGrade.Column2
1837:             .ControlSource = "cursor_4c_Dados.datas"
1838:             .Width         = 82
1839:             .Resizable     = .F.
1840:             .Movable       = .F.
1841:             .Header1.Caption   = "Data"
1842:             .Header1.Alignment = 2
1843:             .Header1.FontName  = "Tahoma"
1844:             .Header1.FontBold  = .T.
1845:             .Header1.FontSize  = 8
1846:         ENDWITH
1847: 
1848:         WITH loc_oGrade.Column3
1849:             .ControlSource = "cursor_4c_Dados.totpesos"
1850:             .Width         = 80
1851:             .Resizable     = .F.
1852:             .Movable       = .F.
1853:             .Header1.Caption   = "Total de Peso"
1854:             .Header1.Alignment = 2
1855:             .Header1.FontName  = "Tahoma"
1856:             .Header1.FontBold  = .T.
1857:             .Header1.FontSize  = 8
1858:         ENDWITH
1859: 
1860:         WITH loc_oGrade.Column4
1861:             .ControlSource = "cursor_4c_Dados.nlotes"
1862:             .Width         = 70
1863:             .Resizable     = .F.
1864:             .Movable       = .F.
1865:             .Header1.Caption   = "Lote"
1866:             .Header1.Alignment = 2
1867:             .Header1.FontName  = "Tahoma"
1868:             .Header1.FontBold  = .T.
1869:             .Header1.FontSize  = 8
1870:         ENDWITH
1871: 
1872:         WITH loc_oGrade.Column5
1873:             .ControlSource = "cursor_4c_Dados.grupoos"
1874:             .Width         = 80
1875:             .Resizable     = .F.
1876:             .Movable       = .F.
1877:             .Header1.Caption   = "Gr. Origem"
1878:             .Header1.Alignment = 2
1879:             .Header1.FontName  = "Tahoma"
1880:             .Header1.FontBold  = .T.
1881:             .Header1.FontSize  = 8
1882:         ENDWITH
1883: 
1884:         WITH loc_oGrade.Column6
1885:             .ControlSource = "cursor_4c_Dados.contaos"
1886:             .Width         = 80
1887:             .Resizable     = .F.
1888:             .Movable       = .F.
1889:             .Header1.Caption   = "Ct. Origem"
1890:             .Header1.Alignment = 2
1891:             .Header1.FontName  = "Tahoma"
1892:             .Header1.FontBold  = .T.
1893:             .Header1.FontSize  = 8
1894:         ENDWITH
1895: 
1896:         WITH loc_oGrade.Column7
1897:             .ControlSource = "cursor_4c_Dados.grupods"
1898:             .Width         = 80
1899:             .Resizable     = .F.
1900:             .Movable       = .F.
1901:             .Header1.Caption   = "Gr. Destino"
1902:             .Header1.Alignment = 2
1903:             .Header1.FontName  = "Tahoma"
1904:             .Header1.FontBold  = .T.
1905:             .Header1.FontSize  = 8
1906:         ENDWITH
1907: 
1908:         WITH loc_oGrade.Column8
1909:             .ControlSource = "cursor_4c_Dados.contads"
1910:             .Width         = 80
1911:             .Resizable     = .F.
1912:             .Movable       = .F.
1913:             .Header1.Caption   = "Ct. Destino"
1914:             .Header1.Alignment = 2
1915:             .Header1.FontName  = "Tahoma"
1916:             .Header1.FontBold  = .T.
1917:             .Header1.FontSize  = 8
1918:         ENDWITH

*-- Linhas 1992 a 2013:
1992:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1993:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1994: 
1995:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEhLista
1996:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEhLista AND loc_lTemRegistro
1997:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEhLista AND loc_lTemRegistro
1998:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEhLista AND loc_lTemRegistro
1999:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEhLista
2000:         loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lEhLista
2001: 
2002:         IF PEMSTATUS(loc_oPg1, "cmd_4c_Cmdfechalote", 5)
2003:             loc_oPg1.cmd_4c_Cmdfechalote.Enabled = loc_lEhLista AND loc_lTemRegistro
2004:         ENDIF
2005: 
2006:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2007:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
2008:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
2009:             ENDIF
2010:         ENDIF
2011:     ENDPROC
2012: 
2013:     *--------------------------------------------------------------------------

*-- Linhas 2597 a 2608:
2597:                 loc_oPg2.edt_4c_Mmobs.ReadOnly = .T.
2598:             ENDIF
2599:             *-- Botoes de acao habilitados conforme modo (nao VISUALIZAR)
2600:             IF PEMSTATUS(loc_oPg2, "cmd_4c_Operacao", 5)
2601:                 loc_oPg2.cmd_4c_Operacao.Enabled    = par_lHabilitar
2602:                 loc_oPg2.cmd_4c_Componentes.Enabled = par_lHabilitar
2603:                 loc_oPg2.cmd_4c_Etiquetas.Enabled   = par_lHabilitar
2604:             ENDIF
2605:         CATCH TO loc_oErro
2606:             MostrarErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
2607:         ENDTRY
2608:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigpdmp6BO.prg):
*==============================================================================
* sigpdmp6BO.prg - Business Object para Movimentacao de Industria
* Tabela principal: SigCdNec | PK: cidchaves (char 20, gerado por fUniqueIds)
* Chave composta: empdnps = emps(3) + dopps(20) + str(numps,10) -> char(33)
*==============================================================================

DEFINE CLASS sigpdmp6BO AS BusinessBase

    *-- Identificacao e Chave
    this_cCidChaves  = ""    && cidchaves  CHAR(20) - PK (gerado por fUniqueIds)
    this_cEmpDnPs    = ""    && empdnps    CHAR(33) - Chave composta (emps+dopps+str(numps,10))

    *-- Campos da chave composta
    this_cEmps       = ""    && emps       CHAR(3)  - Empresa
    this_cDopps      = ""    && dopps      CHAR(20) - Codigo da operacao/documento
    this_nNumps      = 0     && numps      NUMERIC(10,0) - Numero do movimento

    *-- Datas
    this_tDatars     = {}    && datars     DATETIME - Data/hora do registro
    this_dDatas      = {}    && datas      DATETIME - Data do movimento
    this_tDataTrans  = {}    && datatrans  DATETIME - Data de transferencia

    *-- Origem
    this_cGrupoos    = ""    && grupoos    CHAR(10) - Grupo de conta corrente de origem
    this_cContaos    = ""    && contaos    CHAR(10) - Conta de origem

    *-- Destino
    this_cGrupods    = ""    && grupods    CHAR(10) - Grupo de conta corrente de destino
    this_cContads    = ""    && contads    CHAR(10) - Conta de destino
    this_cEmpds      = ""    && empds      CHAR(3)  - Empresa de destino

    *-- Vendedor
    this_cGrVends    = ""    && grvends    CHAR(10) - Grupo do vendedor
    this_cVends      = ""    && vends      CHAR(10) - Vendedor

    *-- Pesos e Totais
    this_nTotPesos   = 0     && totpesos   NUMERIC(11,3) - Peso total
    this_nPesoLancs  = 0     && pesolancs  NUMERIC(11,3) - Peso lancado

    *-- Lotes e OPs
    this_nNLotes     = 0     && nlotes     NUMERIC(10,0) - Numero do lote (0=sem lote)
    this_nNAceites   = 0     && naceites   NUMERIC(10,0) - Numero de aceites
    this_nNops       = 0     && nops       NUMERIC(10,0) - Numero da OP

    *-- Transacao e Local
    this_nNTrans     = 0     && ntrans     NUMERIC(6,0)  - Numero de transacao
    this_cLocals     = ""    && locals     CHAR(10) - Local
    this_cJobs       = ""    && jobs       CHAR(10) - Job

    *-- Documento e Observacao
    this_cDocus      = ""    && docus      CHAR(10) - Numero do documento
    this_nCodObs     = 0     && codobs     NUMERIC(3,0) - Codigo de observacao
    this_cObss       = ""    && obss       TEXT     - Texto de observacao

    *-- Nao Conformidade
    this_lNConforms  = .F.   && nconforms  BIT      - Nao conforme (flag)
    this_cCodNConfs  = ""    && codnconfs  CHAR(10) - Codigo de nao conformidade

    *-- Balancos
    this_nNumBals    = 0     && numbals    NUMERIC(6,0) - Numero do balanco
    this_nNumBalds   = 0     && numbalds   NUMERIC(6,0) - Numero do balanco destino

    *-- Usuarios
    this_cUsuars     = ""    && usuars     CHAR(10) - Usuario que lancou
    this_cUsuLibs    = ""    && usulibs    CHAR(10) - Usuario que liberou
    this_cUsuConfs   = ""    && usuconfs   CHAR(10) - Usuario que confirmou

    *-- Flags bit
    this_lRetrabs    = .F.   && retrabs    BIT - Retrabalho
    this_lChksubn    = .F.   && chksubn    BIT - Subnivel/lote fechado
    this_lProcbals   = .F.   && procbals   BIT - Processado no balancete
    this_lProcdbal   = .F.   && procdbal   BIT - Processado no balancete 2
    this_lImprs      = .F.   && imprs      BIT - Impresso
    this_lAutos      = .F.   && autos      BIT - Processamento automatico
    this_lLccs       = .F.   && lccs       BIT - LCC (Lote Controle Cliente)
    this_nChkBaixa   = 0     && chkbaixa   NUMERIC(1,0) - Flag baixa

    *-- Liberacao (char, nao bit)
    this_cLibProds   = ""    && libprods   CHAR(10) - Liberado para producao

    *-- Descricoes lookup (nao armazenadas)
    this_cNomeContaOs  = ""  && Nome da conta de origem (lookup SigCdCli)
    this_cNomeContads  = ""  && Nome da conta de destino (lookup SigCdCli)
    this_cNomeVends    = ""  && Nome do vendedor (lookup SigCdCli)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdNec"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpDnPs    = TratarNulo(empdnps,    "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cDopps      = TratarNulo(dopps,      "C")
                THIS.this_nNumps      = TratarNulo(numps,      "N")
                THIS.this_dDatas      = TratarNulo(datas,      "D")
                THIS.this_tDatars     = TratarNulo(datars,     "T")
                THIS.this_tDataTrans  = TratarNulo(datatrans,  "T")
                THIS.this_cGrupoos    = TratarNulo(grupoos,    "C")
                THIS.this_cContaos    = TratarNulo(contaos,    "C")
                THIS.this_cGrupods    = TratarNulo(grupods,    "C")
                THIS.this_cContads    = TratarNulo(contads,    "C")
                THIS.this_cEmpds      = TratarNulo(empds,      "C")
                THIS.this_cGrVends    = TratarNulo(grvends,    "C")
                THIS.this_cVends      = TratarNulo(vends,      "C")
                THIS.this_nTotPesos   = TratarNulo(totpesos,   "N")
                THIS.this_nPesoLancs  = TratarNulo(pesolancs,  "N")
                THIS.this_nNLotes     = TratarNulo(nlotes,     "N")
                THIS.this_nNAceites   = TratarNulo(naceites,   "N")
                THIS.this_nNops       = TratarNulo(nops,       "N")
                THIS.this_nNTrans     = TratarNulo(ntrans,     "N")
                THIS.this_cLocals     = TratarNulo(locals,     "C")
                THIS.this_cJobs       = TratarNulo(jobs,       "C")
                THIS.this_cDocus      = TratarNulo(docus,      "C")
                THIS.this_nCodObs     = TratarNulo(codobs,     "N")
                THIS.this_cObss       = TratarNulo(obss,       "C")
                THIS.this_lNConforms  = ConverterParaLogico(nconforms)
                THIS.this_cCodNConfs  = TratarNulo(codnconfs,  "C")
                THIS.this_nNumBals    = TratarNulo(numbals,    "N")
                THIS.this_nNumBalds   = TratarNulo(numbalds,   "N")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_cUsuLibs    = TratarNulo(usulibs,    "C")
                THIS.this_cUsuConfs   = TratarNulo(usuconfs,   "C")
                THIS.this_lRetrabs    = ConverterParaLogico(retrabs)
                THIS.this_lChksubn    = ConverterParaLogico(chksubn)
                THIS.this_lProcbals   = ConverterParaLogico(procbals)
                THIS.this_lProcdbal   = ConverterParaLogico(procdbal)
                THIS.this_lImprs      = ConverterParaLogico(imprs)
                THIS.this_lAutos      = ConverterParaLogico(autos)
                THIS.this_lLccs       = ConverterParaLogico(lccs)
                THIS.this_nChkBaixa   = TratarNulo(chkbaixa,  "N")
                THIS.this_cLibProds   = TratarNulo(libprods,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentos em cursor_4c_Dados
    * par_cFiltro: clausula WHERE sem a palavra WHERE (vazio = sem filtro)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.cidchaves, n.empdnps, n.emps, n.dopps, n.numps," + ;
                       " n.datas, n.datars, n.grupoos, n.contaos, n.grupods, n.contads," + ;
                       " n.grvends, n.vends, n.usuars, n.codobs, n.docus, n.nlotes," + ;
                       " n.naceites, n.nops, n.totpesos, n.pesolancs," + ;
                       " n.retrabs, n.chksubn, n.nconforms, n.imprs, n.autos," + ;
                       " n.lccs, n.libprods, n.codnconfs, n.jobs, n.locals," + ;
                       " n.empds, n.chkbaixa" + ;
                       " FROM SigCdNec n"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY n.datas DESC, n.numps DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos de ind" + CHR(250) + "stria:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorPeriodo - Busca movimentos por empresa, operacao e periodo
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorPeriodo(par_cEmps, par_cDopp, par_dDtI, par_dDtF)
        LOCAL loc_cFiltro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cFiltro = "n.emps = " + EscaparSQL(par_cEmps)

            IF !EMPTY(ALLTRIM(par_cDopp))
                loc_cFiltro = loc_cFiltro + " AND n.dopps = " + EscaparSQL(par_cDopp)
            ENDIF

            IF !EMPTY(par_dDtI)
                loc_cFiltro = loc_cFiltro + " AND CONVERT(date, n.datas) >= " + ;
                    "CONVERT(date, " + FormatarDataSQL(par_dDtI) + ")"
            ENDIF

            IF !EMPTY(par_dDtF)
                loc_cFiltro = loc_cFiltro + " AND CONVERT(date, n.datas) <= " + ;
                    "CONVERT(date, " + FormatarDataSQL(par_dDtF) + ")"
            ENDIF

            loc_lSucesso = THIS.Buscar(loc_cFiltro)

        CATCH TO loc_oErro
            MsgErro("Erro em BuscarPorPeriodo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.cidchaves, n.empdnps, n.emps, n.dopps, n.numps," + ;
                       " n.datas, n.datars, n.datatrans, n.grupoos, n.contaos," + ;
                       " n.grupods, n.contads, n.empds, n.grvends, n.vends," + ;
                       " n.usuars, n.codobs, n.obss, n.docus, n.nlotes, n.naceites," + ;
                       " n.nops, n.ntrans, n.locals, n.jobs, n.totpesos, n.pesolancs," + ;
                       " n.retrabs, n.chksubn, n.nconforms, n.codnconfs," + ;
                       " n.procbals, n.procdbal, n.imprs, n.autos, n.lccs," + ;
                       " n.libprods, n.numbals, n.numbalds," + ;
                       " n.usulibs, n.chkbaixa, n.usuconfs" + ;
                       " FROM SigCdNec n" + ;
                       " WHERE n.cidchaves = " + EscaparSQL(par_cCidChaves)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorEmpDnPs - Carrega pelo empdnps (chave composta alternativa)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorEmpDnPs(par_cEmpDnPs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdNec WHERE empdnps = " + ;
                       EscaparSQL(par_cEmpDnPs)

            IF USED("cursor_4c_ChaveBusca")
                USE IN cursor_4c_ChaveBusca
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChaveBusca")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChaveBusca") > 0
                SELECT cursor_4c_ChaveBusca
                loc_cCidChaves = ALLTRIM(cursor_4c_ChaveBusca.cidchaves)
                IF USED("cursor_4c_ChaveBusca")
                    USE IN cursor_4c_ChaveBusca
                ENDIF
                loc_lSucesso = THIS.CarregarPorCodigo(loc_cCidChaves)
            ELSE
                IF USED("cursor_4c_ChaveBusca")
                    USE IN cursor_4c_ChaveBusca
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorEmpDnPs:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNec (PROTECTED)
    * Nota: cidchaves deve ser gerado antes (via fUniqueIds ou equivalente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Monta chave composta empdnps
            THIS.this_cEmpDnPs = PADR(ALLTRIM(THIS.this_cEmps), 3)  + ;
                                  PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                                  STR(THIS.this_nNumps, 10)

            *-- Usuario logado
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            loc_cSQL = "INSERT INTO SigCdNec" + ;
                       " (cidchaves, empdnps, emps, dopps, numps," + ;
                       "  datas, grupoos, contaos, grupods, contads, empds," + ;
                       "  grvends, vends, usuars, codobs, docus," + ;
                       "  nlotes, naceites, nops, ntrans, locals, jobs," + ;
                       "  totpesos, pesolancs, retrabs, chksubn," + ;
                       "  nconforms, codnconfs, procbals, procdbal," + ;
                       "  imprs, autos, lccs, libprods, chkbaixa)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)            + ", " + ;
                       EscaparSQL(THIS.this_cEmpDnPs)              + ", " + ;
                       EscaparSQL(THIS.this_cEmps)                 + ", " + ;
                       EscaparSQL(THIS.this_cDopps)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps)          + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                       EscaparSQL(THIS.this_cGrupoos)              + ", " + ;
                       EscaparSQL(THIS.this_cContaos)              + ", " + ;
                       EscaparSQL(THIS.this_cGrupods)              + ", " + ;
                       EscaparSQL(THIS.this_cContads)              + ", " + ;
                       EscaparSQL(THIS.this_cEmpds)                + ", " + ;
                       EscaparSQL(THIS.this_cGrVends)              + ", " + ;
                       EscaparSQL(THIS.this_cVends)                + ", " + ;
                       EscaparSQL(THIS.this_cUsuars)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodObs)         + ", " + ;
                       EscaparSQL(THIS.this_cDocus)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNLotes)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNAceites)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops)           + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNTrans)         + ", " + ;
                       EscaparSQL(THIS.this_cLocals)               + ", " + ;
                       EscaparSQL(THIS.this_cJobs)                 + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotPesos)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesoLancs)      + ", " + ;
                       IIF(THIS.this_lRetrabs,   "1", "0")          + ", " + ;
                       IIF(THIS.this_lChksubn,   "1", "0")          + ", " + ;
                       IIF(THIS.this_lNConforms, "1", "0")          + ", " + ;
                       EscaparSQL(THIS.this_cCodNConfs)            + ", " + ;
                       IIF(THIS.this_lProcbals,  "1", "0")          + ", " + ;
                       IIF(THIS.this_lProcdbal,  "1", "0")          + ", " + ;
                       IIF(THIS.this_lImprs,     "1", "0")          + ", " + ;
                       IIF(THIS.this_lAutos,     "1", "0")          + ", " + ;
                       IIF(THIS.this_lLccs,      "1", "0")          + ", " + ;
                       EscaparSQL(THIS.this_cLibProds)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkBaixa)       + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Salvar obss (TEXT) separadamente se preenchido
                IF !EMPTY(ALLTRIM(THIS.this_cObss))
                    THIS.AtualizarObss()
                ENDIF
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNec (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET" + ;
                       "  datas     = " + FormatarDataSQL(THIS.this_dDatas)    + ", " + ;
                       "  grupoos   = " + EscaparSQL(THIS.this_cGrupoos)       + ", " + ;
                       "  contaos   = " + EscaparSQL(THIS.this_cContaos)       + ", " + ;
                       "  grupods   = " + EscaparSQL(THIS.this_cGrupods)       + ", " + ;
                       "  contads   = " + EscaparSQL(THIS.this_cContads)       + ", " + ;
                       "  empds     = " + EscaparSQL(THIS.this_cEmpds)         + ", " + ;
                       "  grvends   = " + EscaparSQL(THIS.this_cGrVends)       + ", " + ;
                       "  vends     = " + EscaparSQL(THIS.this_cVends)         + ", " + ;
                       "  codobs    = " + FormatarNumeroSQL(THIS.this_nCodObs) + ", " + ;
                       "  docus     = " + EscaparSQL(THIS.this_cDocus)         + ", " + ;
                       "  nlotes    = " + FormatarNumeroSQL(THIS.this_nNLotes) + ", " + ;
                       "  naceites  = " + FormatarNumeroSQL(THIS.this_nNAceites) + ", " + ;
                       "  nops      = " + FormatarNumeroSQL(THIS.this_nNops)   + ", " + ;
                       "  totpesos  = " + FormatarNumeroSQL(THIS.this_nTotPesos) + ", " + ;
                       "  pesolancs = " + FormatarNumeroSQL(THIS.this_nPesoLancs) + ", " + ;
                       "  retrabs   = " + IIF(THIS.this_lRetrabs, "1", "0")   + ", " + ;
                       "  chksubn   = " + IIF(THIS.this_lChksubn, "1", "0")   + ", " + ;
                       "  nconforms = " + IIF(THIS.this_lNConforms, "1", "0") + ", " + ;
                       "  codnconfs = " + EscaparSQL(THIS.this_cCodNConfs)    + ", " + ;
                       "  imprs     = " + IIF(THIS.this_lImprs, "1", "0")     + ", " + ;
                       "  autos     = " + IIF(THIS.this_lAutos, "1", "0")     + ", " + ;
                       "  lccs      = " + IIF(THIS.this_lLccs, "1", "0")      + ", " + ;
                       "  libprods  = " + EscaparSQL(THIS.this_cLibProds)     + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Atualizar obss (TEXT) separadamente
                THIS.AtualizarObss()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarObss - Salva campo TEXT obss separadamente
    * Campos TEXT/NTEXT exigem UPDATE separado em alguns cenarios ODBC
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarObss()
        LOCAL loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET obss = " + EscaparSQL(THIS.this_cObss) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdNec (PROTECTED)
    * Exclui apenas o cabecalho. A logica do form deve excluir SigCdNei,
    * SigMvHst, SigMvCab e demais tabelas filhas antes de chamar Excluir().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens do movimento (SigCdNei) antes do cabecalho
            loc_cSQL = "DELETE FROM SigCdNei WHERE empdnps = " + EscaparSQL(THIS.this_cEmpDnPs)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens do movimento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM SigCdNec WHERE cidchaves = " + ;
                           EscaparSQL(THIS.this_cCidChaves)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir movimento:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

