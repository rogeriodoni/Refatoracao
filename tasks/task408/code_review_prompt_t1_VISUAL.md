# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [FONTNAME-ERRADO] Linha 186: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 211: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 236: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 261: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 286: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 402: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 427: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEsp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1098 linhas total):

*-- Linhas 41 a 59:
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             THIS.Caption = "Cadastro de Esp" + CHR(233) + "cies"
45:             THIS.this_oBusinessObject = CREATEOBJECT("EspBO")
46: 
47:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
48:                 MostrarErro("Erro ao criar EspBO" + CHR(13) + ;
49:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
50:                     "FormEsp.InicializarForm")
51:             ELSE
52:                 THIS.ConfigurarPageFrame()
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Visible  = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual = "LISTA"
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 85 a 115:
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .PageCount = 2
88:             .Top       = -29
89:             .Left      = 0
90:             .Width     = loc_nFormWidth
91:             .Height    = loc_nFormHeight + 29
92:             .Tabs      = .F.
93:             .Visible   = .T.
94: 
95:             .Page1.Caption   = "Lista"
96:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
97:             .Page1.BackColor = RGB(255, 255, 255)
98: 
99:             .Page2.Caption   = "Dados"
100:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
101:             .Page2.BackColor = RGB(255, 255, 255)
102:         ENDWITH
103: 
104:         THIS.ConfigurarPaginaLista()
105:         THIS.ConfigurarPaginaDados()
106:     ENDPROC
107: 
108:     *==========================================================================
109:     * ConfigurarPaginaLista - Configura Page1 com containers base
110:     * Legado: cntSombra.Top=1, Grupo_op.Top=-1, Grupo_Saida.Top=-1 (Left=918)
111:     * Compensacao PageFrame: +29 em todos os Tops
112:     * Canonical Saida: Left=917 (CLAUDE.md regra #10 prevalece sobre legado)
113:     *==========================================================================
114:     PROTECTED PROCEDURE ConfigurarPaginaLista()
115:         LOCAL loc_oPagina, loc_oGrid, loc_nFormWidth

*-- Linhas 123 a 160:
123:         *-- Compensado: Top=1+29=30. Width=THIS.Width (canonical: nao subtrair por cnt_4c_Saida)
124:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH loc_oPagina.cnt_4c_Cabecalho
126:             .Top         = 30
127:             .Left        = -1
128:             .Width       = loc_nFormWidth
129:             .Height      = 80
130:             .BackColor   = RGB(100, 100, 100)
131:             .BorderWidth = 0
132:             .Visible     = .T.
133:         ENDWITH
134: 
135:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
136:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
137:             .Caption   = THIS.Caption
138:             .Top       = 15
139:             .Left      = 10
140:             .Width     = 769
141:             .Height    = 40
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .ForeColor = RGB(0, 0, 0)
146:             .BackStyle = 0
147:             .AutoSize  = .F.
148:             .Visible   = .T.
149:         ENDWITH
150: 
151:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
152:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
153:             .Caption   = THIS.Caption
154:             .Top       = 18
155:             .Left      = 10
156:             .Width     = 769
157:             .Height    = 46
158:             .FontName  = "Tahoma"
159:             .FontSize  = 16
160:             .FontBold  = .T.

*-- Linhas 168 a 192:
168:         *-- Compensado: Top=-1+29=28
169:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
170:         WITH loc_oPagina.cnt_4c_Botoes
171:             .Top         = 28
172:             .Left        =  542
173:             .Width       = 385
174:             .Height      = 85
175:             .BackStyle   = 0
176:             .BorderWidth = 0
177:             .Visible     = .T.
178:         ENDWITH
179: 
180:         *-- Botao Incluir
181:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
182:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
183:             .Caption         = "Incluir"
184:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
185:             .PicturePosition = 13
186:             .Top             = 5
187:             .Left            = 5
188:             .Width           = 75
189:             .Height          = 75
190:             .FontName        = "Comic Sans MS"
191:             .FontBold        = .T.
192:             .FontItalic      = .T.

*-- Linhas 200 a 217:
200:             .AutoSize        = .F.
201:             .Visible         = .T.
202:         ENDWITH
203:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
204: 
205:         *-- Botao Visualizar
206:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
207:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
208:             .Caption         = "Visualizar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 80
213:             .Width           = 75
214:             .Height          = 75
215:             .FontName        = "Comic Sans MS"
216:             .FontBold        = .T.
217:             .FontItalic      = .T.

*-- Linhas 225 a 242:
225:             .AutoSize        = .F.
226:             .Visible         = .T.
227:         ENDWITH
228:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
229: 
230:         *-- Botao Alterar
231:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
232:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
233:             .Caption         = "Alterar"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 155
238:             .Width           = 75
239:             .Height          = 75
240:             .FontName        = "Comic Sans MS"
241:             .FontBold        = .T.
242:             .FontItalic      = .T.

*-- Linhas 250 a 267:
250:             .AutoSize        = .F.
251:             .Visible         = .T.
252:         ENDWITH
253:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
254: 
255:         *-- Botao Excluir
256:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
257:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
258:             .Caption         = "Excluir"
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
260:             .PicturePosition = 13
261:             .Top             = 5
262:             .Left            = 230
263:             .Width           = 75
264:             .Height          = 75
265:             .FontName        = "Comic Sans MS"
266:             .FontBold        = .T.
267:             .FontItalic      = .T.

*-- Linhas 275 a 292:
275:             .AutoSize        = .F.
276:             .Visible         = .T.
277:         ENDWITH
278:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
279: 
280:         *-- Botao Buscar
281:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
282:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
283:             .Caption         = "Buscar"
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
285:             .PicturePosition = 13
286:             .Top             = 5
287:             .Left            = 305
288:             .Width           = 75
289:             .Height          = 75
290:             .FontName        = "Comic Sans MS"
291:             .FontBold        = .T.
292:             .FontItalic      = .T.

*-- Linhas 300 a 329:
300:             .AutoSize        = .F.
301:             .Visible         = .T.
302:         ENDWITH
303:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
304: 
305:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10 prevalece sobre legado)
306:         *-- Legado: Grupo_Saida.Left=918, Top=-1. Canonico: Left=917, Top=29, Width=90
307:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
308:         WITH loc_oPagina.cnt_4c_Saida
309:             .Top         = 29
310:             .Left        = 917
311:             .Width       = 90
312:             .Height      = 85
313:             .BackStyle   = 0
314:             .BorderWidth = 0
315:             .Visible     = .T.
316:         ENDWITH
317: 
318:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
319:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
320:             .Caption         = "Encerrar"
321:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
322:             .PicturePosition = 13
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .FontName        = "Tahoma"
328:             .FontBold        = .T.
329:             .FontItalic      = .T.

*-- Linhas 337 a 353:
337:             .AutoSize        = .F.
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Grid de listagem (Grade no legado: Top=121, Left=12, Width=971, Height=470)
343:         *-- Compensado: Top=121+29=150. Width ajustado para nao sobrepor cnt_4c_Saida (Left=917)
344:         *-- Colunas: Especies (150) e Descs (290) conforme layout original
345:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
346:         loc_oGrid = loc_oPagina.grd_4c_Lista
347:         loc_oGrid.Top         = 150
348:         loc_oGrid.Left        = 12
349:         loc_oGrid.Width       = 900
350:         loc_oGrid.Height      = 470
351:         loc_oGrid.ColumnCount = 2
352:         WITH loc_oGrid
353:             .FontName           = "Verdana"

*-- Linhas 371 a 408:
371: 
372:     *==========================================================================
373:     * ConfigurarPaginaDados - Configura Page2: botoes + campos (Fases 5-6)
374:     * Legado: Grupo_Salva.Left=836, Top=-6, Width=161, Height=85
375:     * Compensacao PageFrame: +29 em todos os Tops
376:     *==========================================================================
377:     PROTECTED PROCEDURE ConfigurarPaginaDados()
378:         LOCAL loc_oPagina
379:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
380: 
381:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
382:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
383: 
384:         *-- Container BotoesAcao (Grupo_Salva: Left=836, Top=-6; compensado: Top=23)
385:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
386:         WITH loc_oPagina.cnt_4c_BotoesAcao
387:             .Top         = 23
388:             .Left        = 836
389:             .Width       = 161
390:             .Height      = 85
391:             .BackStyle   = 0
392:             .BorderWidth = 0
393:             .Visible     = .T.
394:         ENDWITH
395: 
396:         *-- Botao Confirmar (Salva: Left=5, Top=5)
397:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
398:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
399:             .Caption         = "Confirmar"
400:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
401:             .PicturePosition = 13
402:             .Top             = 5
403:             .Left            = 5
404:             .Width           = 75
405:             .Height          = 75
406:             .FontName        = "Comic Sans MS"
407:             .FontBold        = .T.
408:             .FontItalic      = .T.

*-- Linhas 416 a 433:
416:             .AutoSize        = .F.
417:             .Visible         = .T.
418:         ENDWITH
419:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
420: 
421:         *-- Botao Cancelar (Cancelar: Left=81, Top=5)
422:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
423:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
424:             .Caption         = "Encerrar"
425:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
426:             .PicturePosition = 13
427:             .Top             = 5
428:             .Left            = 81
429:             .Width           = 75
430:             .Height          = 75
431:             .FontName        = "Comic Sans MS"
432:             .FontBold        = .T.
433:             .FontItalic      = .T.

*-- Linhas 441 a 456:
441:             .AutoSize        = .F.
442:             .Visible         = .T.
443:         ENDWITH
444:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
445: 
446:         *-- Label Codigo (Say1: Top=136, Left=278, Width=42, Height=15; compensado Top=165)
447:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
448:         WITH loc_oPagina.lbl_4c_Label1
449:             .Caption   = "C" + CHR(243) + "digo :"
450:             .Top       = 165
451:             .Left      = 278
452:             .Width     = 42
453:             .Height    = 15
454:             .FontName  = "Tahoma"
455:             .FontSize  = 8
456:             .FontBold  = .F.

*-- Linhas 465 a 474:
465:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
466:         WITH loc_oPagina.txt_4c_Codigo
467:             .Value         = ""
468:             .Top           = 162
469:             .Left          = 323
470:             .Width         = 52
471:             .Height        = 23
472:             .MaxLength     = 6
473:             .Format        = "K!"
474:             .SpecialEffect = 1

*-- Linhas 480 a 492:
480:         ENDWITH
481: 
482:         *-- Label Descricao (Say2: Top=162, Left=265, Width=55, Height=15; compensado Top=191)
483:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
484:         WITH loc_oPagina.lbl_4c_Label2
485:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
486:             .Top       = 191
487:             .Left      = 265
488:             .Width     = 55
489:             .Height    = 15
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .FontBold  = .F.

*-- Linhas 501 a 510:
501:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
502:         WITH loc_oPagina.txt_4c_Descricao
503:             .Value         = ""
504:             .Top           = 187
505:             .Left          = 323
506:             .Width         = 290
507:             .Height        = 25
508:             .MaxLength     = 40
509:             .Format        = "K!"
510:             .SpecialEffect = 1

*-- Linhas 516 a 528:
516:         ENDWITH
517: 
518:         *-- Label Integracao Contabil (Say3: Top=190, Left=216, Width=104, Height=15; compensado Top=219)
519:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
520:         WITH loc_oPagina.lbl_4c_Label3
521:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil :"
522:             .Top       = 219
523:             .Left      = 216
524:             .Width     = 104
525:             .Height    = 15
526:             .FontName  = "Tahoma"
527:             .FontSize  = 8
528:             .FontBold  = .F.

*-- Linhas 543 a 577:
543:             .Enabled     = .F.
544:             .Visible     = .T.
545:             WITH .Buttons(1)
546:                 .Caption   = "Com Provis" + CHR(227) + "o"
547:                 .Left      = 5
548:                 .Top       = 5
549:                 .AutoSize  = .T.
550:                 .ForeColor = RGB(90, 90, 90)
551:                 .Themes    = .F.
552:             ENDWITH
553:             WITH .Buttons(2)
554:                 .Caption   = "Sem Provis" + CHR(227) + "o"
555:                 .Left      = 110
556:                 .Top       = 5
557:                 .AutoSize  = .T.
558:                 .FontName  = "Tahoma"
559:                 .FontSize  = 8
560:                 .ForeColor = RGB(90, 90, 90)
561:                 .Themes    = .F.
562:             ENDWITH
563:         ENDWITH
564:         loc_oPagina.opt_4c_OptProvs.Top  = 214
565:         loc_oPagina.opt_4c_OptProvs.Left = 319
566: 
567:         *-- Label Obrigatorio Dados Bancarios (Say4: Top=214, Left=175, Width=145, Height=15; compensado Top=243)
568:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
569:         WITH loc_oPagina.lbl_4c_Label4
570:             .Caption   = "Obrigat" + CHR(243) + "rio Dados Banc" + CHR(225) + "rios :"
571:             .Top       = 243
572:             .Left      = 175
573:             .Width     = 145
574:             .Height    = 15
575:             .FontName  = "Tahoma"
576:             .FontSize  = 8
577:             .FontBold  = .F.

*-- Linhas 592 a 619:
592:             .Enabled     = .F.
593:             .Visible     = .T.
594:             WITH .Buttons(1)
595:                 .Caption   = "Sim"
596:                 .Left      = 5
597:                 .Top       = 5
598:                 .AutoSize  = .T.
599:                 .ForeColor = RGB(90, 90, 90)
600:                 .Themes    = .F.
601:             ENDWITH
602:             WITH .Buttons(2)
603:                 .Caption   = "N" + CHR(227) + "o"
604:                 .Left      = 58
605:                 .Top       = 5
606:                 .AutoSize  = .T.
607:                 .FontName  = "Tahoma"
608:                 .FontSize  = 8
609:                 .ForeColor = RGB(90, 90, 90)
610:                 .Themes    = .F.
611:             ENDWITH
612:         ENDWITH
613:         loc_oPagina.opt_4c_OptObrigs.Top  = 238
614:         loc_oPagina.opt_4c_OptObrigs.Left = 319
615: 
616:         THIS.TornarControlesVisiveis(loc_oPagina)
617:     ENDPROC
618: 
619:     *==========================================================================

*-- Linhas 638 a 647:
638:                     loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descs"
639:                     loc_oGrid.Column1.Width            = 150
640:                     loc_oGrid.Column2.Width            = 290
641:                     loc_oGrid.Column1.Header1.Caption  = "Esp" + CHR(233) + "cie"
642:                     loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
643:                     THIS.FormatarGridLista(loc_oGrid)
644:                     loc_lResultado = .T.
645:                 ENDIF
646:             ENDIF
647:         CATCH TO loc_oErro

*-- Linhas 1003 a 1012:
1003:             ENDIF
1004: 
1005:             IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1006:                 IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1007:                     loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHabDados
1008:                 ENDIF
1009:             ENDIF
1010:         CATCH TO loc_oErro
1011:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1012:         ENDTRY

*-- Linhas 1065 a 1086:
1065: 
1066:         TRY
1067:             IF PEMSTATUS(loc_oPagina1, "cnt_4c_Botoes", 5)
1068:                 IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1069:                     loc_oPagina1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1070:                 ENDIF
1071:                 IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1072:                     loc_oPagina1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1073:                 ENDIF
1074:                 IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1075:                     loc_oPagina1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1076:                 ENDIF
1077:             ENDIF
1078: 
1079:             IF PEMSTATUS(loc_oPagina2, "cnt_4c_BotoesAcao", 5)
1080:                 IF PEMSTATUS(loc_oPagina2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1081:                     loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
1082:                         INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1083:                 ENDIF
1084:             ENDIF
1085:         CATCH TO loc_oErro
1086:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")


### BO (C:\4c\projeto\app\classes\EspBO.prg):
*==============================================================================
* EspBO.prg - Business Object para Cadastro de Especies
* Tabela: SigCdEsp
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS EspBO AS BusinessBase

    *-- Propriedades de configuracao da tabela
    this_cTabela      = "SigCdEsp"
    this_cCampoChave  = "especies"

    *-- Propriedades de dados (mapeiam colunas de SigCdEsp)
    this_cEspecies    = ""    && char(6) - PK
    this_cDescs       = ""    && char(40)
    this_nProvs       = 1     && numeric(1,0) - 1=Com Provisao, 2=Sem Provisao
    this_nObrigs      = 1     && numeric(1,0) - 1=Sim, 2=Nao

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEsp"
        THIS.this_cCampoChave = "especies"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEspecies
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEspecies = TratarNulo(especies, "C")
            THIS.this_cDescs    = TratarNulo(descs,    "C")
            THIS.this_nProvs    = TratarNulo(provs,    "N")
            THIS.this_nObrigs   = TratarNulo(obrigs,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de registros em cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                       " FROM SigCdEsp" + ;
                       " ORDER BY especies"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                           " FROM SigCdEsp" + ;
                           " WHERE especies LIKE " + EscaparSQL(par_cFiltro + "%") + ;
                           " ORDER BY especies"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar esp" + CHR(233) + "cies:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo da especie
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                       " FROM SigCdEsp" + ;
                       " WHERE especies = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdEsp (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdEsp (especies, descs, provs, obrigs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEspecies) + ", " + ;
                       EscaparSQL(THIS.this_cDescs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nProvs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nObrigs) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir esp" + CHR(233) + "cie:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdEsp (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdEsp SET" + ;
                       " descs  = " + EscaparSQL(THIS.this_cDescs)          + ", " + ;
                       " provs  = " + FormatarNumeroSQL(THIS.this_nProvs)   + ", " + ;
                       " obrigs = " + FormatarNumeroSQL(THIS.this_nObrigs)  + ;
                       " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar esp" + CHR(233) + "cie:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdEsp (PROTECTED - chamado por Excluir)
    * Valida uso em SigMvCcr (EspecieNfs) e SigCdOpe (Especies) antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Verificar uso em SigMvCcr
            loc_cSQL = "SELECT TOP 1 cIdChaves FROM SigMvCcr" + ;
                       " WHERE EspecieNfs = " + EscaparSQL(THIS.this_cEspecies)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMvCcr")
                TABLEREVERT(.T., "cursor_4c_ChkMvCcr")
                USE IN cursor_4c_ChkMvCcr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCcr")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkMvCcr") > 0
                MsgAviso("A Esp" + CHR(233) + "cie Est" + CHR(225) + " Em Uso Nos T" + ;
                         CHR(237) + "tulos e N" + CHR(227) + "o Pode Ser Exclu" + ;
                         CHR(237) + "da!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Verificar uso em SigCdOpe
                loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe" + ;
                           " WHERE Especies = " + EscaparSQL(THIS.this_cEspecies)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkOpe")
                    TABLEREVERT(.T., "cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpe")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkOpe") > 0
                    SELECT cursor_4c_ChkOpe
                    GO TOP
                    MsgAviso("A Esp" + CHR(233) + "cie Est" + CHR(225) + " Em Uso Na Opera" + ;
                             CHR(231) + CHR(227) + "o " + CHR(34) + ;
                             ALLTRIM(cursor_4c_ChkOpe.Dopes) + CHR(34) + ;
                             " e N" + CHR(227) + "o Pode Ser Exclu" + CHR(237) + "da!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    *-- Sem dependencias - executar exclusao
                    loc_cSQL = "DELETE FROM SigCdEsp" + ;
                               " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado > 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao excluir esp" + CHR(233) + "cie:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF
            ENDIF

            IF USED("cursor_4c_ChkMvCcr")
                USE IN cursor_4c_ChkMvCcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    FUNCTION Validar()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cEspecies))
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND THIS.this_nProvs = 0
            MsgAviso("Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + ;
                     "bil Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 especies FROM SigCdEsp" + ;
                       " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkDup")
                TABLEREVERT(.T., "cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkDup") > 0
                loc_lExiste = .T.
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF USED("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

