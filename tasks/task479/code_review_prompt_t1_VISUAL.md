# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 216: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 269: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 292: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 338: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 360: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 383: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 406: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 429: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOCO.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (952 linhas total):

*-- Linhas 47 a 55:
47: 
48:         TRY
49:             *-- Caption com acento (CHR(234)=e-circumflexo em "Ocorrencias")
50:             THIS.Caption = "Cadastro de Ocorr" + CHR(234) + "ncias"
51: 
52:             *-- Criar instancia do BO
53:             THIS.this_oBusinessObject = CREATEOBJECT("OCOBO")
54: 
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 62 a 71:
62:                 *-- Propagar Caption para labels do cabecalho
63:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
64:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho) = "O"
65:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
66:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
67:                     ENDIF
68:                 ENDIF
69: 
70:                 THIS.pgf_4c_Paginas.Visible = .T.
71:                 THIS.pgf_4c_Paginas.ActivePage = 1

*-- Linhas 94 a 117:
94:             *-- PageFrame externo com Top=-29 para ocultar abas
95:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
96:             WITH THIS.pgf_4c_Paginas
97:                 .Top       = -29
98:                 .Left      = 0
99:                 .Width     = 1000
100:                 .Height    = 629
101:                 .PageCount = 2
102:                 .Tabs      = .F.
103:                 .Visible   = .T.
104: 
105:                 *-- Fundo das paginas
106:                 .Page1.BackColor = RGB(100, 100, 100)
107:                 .Page2.BackColor = RGB(100, 100, 100)
108:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:                 .Page1.Caption   = "Lista"
111:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:                 .Page2.Caption   = "Dados"
113:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:             ENDWITH
115: 
116:             *-- Configurar conteudo das paginas
117:             THIS.ConfigurarPaginaListaBase()

*-- Linhas 139 a 176:
139:             *-- Container Cabecalho (compensacao PageFrame.Top: +29)
140:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
141:             WITH loc_oPagina.cnt_4c_Cabecalho
142:                 .Top         = 2 + 29
143:                 .Left        = 0
144:                 .Width       = THIS.Width
145:                 .Height      = 80
146:                 .BackColor   = RGB(100, 100, 100)
147:                 .BorderWidth = 0
148:                 .Visible     = .T.
149: 
150:                 .AddObject("lbl_4c_Sombra", "Label")
151:                 WITH .lbl_4c_Sombra
152:                     .Top       = 15
153:                     .Left      = 10
154:                     .Width     = THIS.Width
155:                     .Height    = 40
156:                     .Caption   = THIS.Caption
157:                     .FontName  = "Tahoma"
158:                     .FontSize  = 16
159:                     .FontBold  = .T.
160:                     .ForeColor = RGB(0, 0, 0)
161:                     .BackStyle = 0
162:                     .Visible   = .T.
163:                 ENDWITH
164: 
165:                 .AddObject("lbl_4c_Titulo", "Label")
166:                 WITH .lbl_4c_Titulo
167:                     .Top       = 18
168:                     .Left      = 10
169:                     .Width     = THIS.Width
170:                     .Height    = 46
171:                     .Caption   = THIS.Caption
172:                     .FontName  = "Tahoma"
173:                     .FontSize  = 16
174:                     .FontBold  = .T.
175:                     .ForeColor = RGB(255, 255, 255)
176:                     .BackStyle = 0

*-- Linhas 182 a 222:
182:             *-- Conteudo dos botoes sera adicionado na Fase 4
183:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
184:             WITH loc_oPagina.cnt_4c_Botoes
185:                 .Top         = 0 + 29
186:                 .Left        = 542
187:                 .Width       = 390
188:                 .Height      = 85
189:                 .BackColor   = RGB(53, 53, 53)
190:                 .BackStyle   = 1
191:                 .BorderWidth = 0
192:                 .Visible     = .T.
193:             ENDWITH
194: 
195:             *-- Container Saida - padrao canonico (prevalece sobre PILAR 1)
196:             *-- cnt_4c_Saida eh flutuante/transparente, Left=917, Width=90
197:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
198:             WITH loc_oPagina.cnt_4c_Saida
199:                 .Top         = 29
200:                 .Left        = 917
201:                 .Width       = 90
202:                 .Height      = 85
203:                 .BackStyle   = 0
204:                 .BorderWidth = 0
205:                 .Visible     = .T.
206: 
207:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
208:                 WITH .cmd_4c_Encerrar
209:                     .Left            = 917
210:                     .Top             = 5
211:                     .Width           = 90
212:                     .Height          = 75
213:                     .Caption         = "Encerrar"
214:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
215:                     .PicturePosition = 13
216:                     .FontName        = "Comic Sans MS"
217:                     .FontSize        = 8
218:                     .FontBold        = .T.
219:                     .FontItalic      = .T.
220:                     .ForeColor       = RGB(90, 90, 90)
221:                     .BackColor       = RGB(255, 255, 255)
222:                     .SpecialEffect   = 0

*-- Linhas 249 a 298:
249:             *-- Container Botoes Acao (Salvar/Cancelar) - compensacao +29
250:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
251:             WITH loc_oPagina.cnt_4c_BotoesAcao
252:                 .Top         = 4 + 29
253:                 .Left        = 842
254:                 .Width       = 160
255:                 .Height      = 85
256:                 .BackStyle   = 0
257:                 .BorderWidth = 0
258:                 .Visible     = .T.
259: 
260:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
261:                 WITH .cmd_4c_Confirmar
262:                     .Left            = 5
263:                     .Top             = 5
264:                     .Width           = 75
265:                     .Height          = 75
266:                     .Caption         = "Confirmar"
267:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
268:                     .PicturePosition = 13
269:                     .FontName        = "Comic Sans MS"
270:                     .FontSize        = 8
271:                     .FontBold        = .T.
272:                     .FontItalic      = .T.
273:                     .ForeColor       = RGB(90, 90, 90)
274:                     .BackColor       = RGB(255, 255, 255)
275:                     .SpecialEffect   = 0
276:                     .MousePointer    = 15
277:                     .WordWrap        = .T.
278:                     .AutoSize        = .F.
279:                     .Enabled         = .T.
280:                     .Visible         = .T.
281:                 ENDWITH
282: 
283:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
284:                 WITH .cmd_4c_Cancelar
285:                     .Left            = 80
286:                     .Top             = 5
287:                     .Width           = 75
288:                     .Height          = 75
289:                     .Caption         = "Encerrar"
290:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
291:                     .PicturePosition = 13
292:                     .FontName        = "Comic Sans MS"
293:                     .FontSize        = 8
294:                     .FontBold        = .T.
295:                     .FontItalic      = .T.
296:                     .ForeColor       = RGB(90, 90, 90)
297:                     .BackColor       = RGB(255, 255, 255)
298:                     .Themes          = .F.

*-- Linhas 326 a 435:
326:         TRY
327:             *-- Botoes CRUD no cnt_4c_Botoes (ja criado em ConfigurarPaginaListaBase)
328:             WITH loc_oPagina.cnt_4c_Botoes
329:                 .AddObject("cmd_4c_Incluir", "CommandButton")
330:                 WITH .cmd_4c_Incluir
331:                     .Caption         = "Incluir"
332:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
333:                     .PicturePosition = 13
334:                     .Left            = 5
335:                     .Top             = 5
336:                     .Width           = 75
337:                     .Height          = 75
338:                     .FontName        = "Comic Sans MS"
339:                     .FontSize        = 8
340:                     .FontBold        = .T.
341:                     .FontItalic      = .T.
342:                     .ForeColor       = RGB(90, 90, 90)
343:                     .BackColor       = RGB(255, 255, 255)
344:                     .SpecialEffect   = 0
345:                     .MousePointer    = 15
346:                     .WordWrap        = .T.
347:                     .AutoSize        = .F.
348:                     .Visible         = .T.
349:                 ENDWITH
350: 
351:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
352:                 WITH .cmd_4c_Visualizar
353:                     .Caption         = "Visualizar"
354:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
355:                     .PicturePosition = 13
356:                     .Left            = 80
357:                     .Top             = 5
358:                     .Width           = 75
359:                     .Height          = 75
360:                     .FontName        = "Comic Sans MS"
361:                     .FontSize        = 8
362:                     .FontBold        = .T.
363:                     .FontItalic      = .T.
364:                     .ForeColor       = RGB(90, 90, 90)
365:                     .BackColor       = RGB(255, 255, 255)
366:                     .Themes          = .F.
367:                     .SpecialEffect   = 0
368:                     .MousePointer    = 15
369:                     .WordWrap        = .T.
370:                     .AutoSize        = .F.
371:                     .Visible         = .T.
372:                 ENDWITH
373: 
374:                 .AddObject("cmd_4c_Alterar", "CommandButton")
375:                 WITH .cmd_4c_Alterar
376:                     .Caption         = "Alterar"
377:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
378:                     .PicturePosition = 13
379:                     .Left            = 155
380:                     .Top             = 5
381:                     .Width           = 75
382:                     .Height          = 75
383:                     .FontName        = "Comic Sans MS"
384:                     .FontSize        = 8
385:                     .FontBold        = .T.
386:                     .FontItalic      = .T.
387:                     .ForeColor       = RGB(90, 90, 90)
388:                     .BackColor       = RGB(255, 255, 255)
389:                     .Themes          = .F.
390:                     .SpecialEffect   = 0
391:                     .MousePointer    = 15
392:                     .WordWrap        = .T.
393:                     .AutoSize        = .F.
394:                     .Visible         = .T.
395:                 ENDWITH
396: 
397:                 .AddObject("cmd_4c_Excluir", "CommandButton")
398:                 WITH .cmd_4c_Excluir
399:                     .Caption         = "Excluir"
400:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
401:                     .PicturePosition = 13
402:                     .Left            = 230
403:                     .Top             = 5
404:                     .Width           = 75
405:                     .Height          = 75
406:                     .FontName        = "Comic Sans MS"
407:                     .FontSize        = 8
408:                     .FontBold        = .T.
409:                     .FontItalic      = .T.
410:                     .ForeColor       = RGB(90, 90, 90)
411:                     .BackColor       = RGB(255, 255, 255)
412:                     .Themes          = .F.
413:                     .SpecialEffect   = 0
414:                     .MousePointer    = 15
415:                     .WordWrap        = .T.
416:                     .AutoSize        = .F.
417:                     .Visible         = .T.
418:                 ENDWITH
419: 
420:                 .AddObject("cmd_4c_Buscar", "CommandButton")
421:                 WITH .cmd_4c_Buscar
422:                     .Caption         = "Buscar"
423:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
424:                     .PicturePosition = 13
425:                     .Left            = 305
426:                     .Top             = 5
427:                     .Width           = 75
428:                     .Height          = 75
429:                     .FontName        = "Comic Sans MS"
430:                     .FontSize        = 8
431:                     .FontBold        = .T.
432:                     .FontItalic      = .T.
433:                     .ForeColor       = RGB(90, 90, 90)
434:                     .BackColor       = RGB(255, 255, 255)
435:                     .Themes          = .F.

*-- Linhas 442 a 461:
442:             ENDWITH
443: 
444:             *-- BINDEVENT botoes CRUD (metodos PUBLIC, sem PROTECTED)
445:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
446:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
447:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
448:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
449:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
450:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
451: 
452:             *-- Grid de listagem (Top = original 101 + compensacao PageFrame 29 = 130)
453:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
454:             loc_oGrid = loc_oPagina.grd_4c_Lista
455:             loc_oGrid.Top  = 130
456:             loc_oGrid.Left = 29
457:             WITH loc_oGrid
458:                 .Width              = 890
459:                 .Height             = 451
460:                 .FontName           = "Verdana"
461:                 .FontSize           = 8

*-- Linhas 493 a 506:
493: 
494:         TRY
495:             *-- Label "Codigo : " - top original 209 + compensacao 29 = 238
496:             *-- Original: Say1.Left=372, ForeColor=90,90,90; textbox at Left=419 (gap 47px)
497:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
498:             WITH loc_oPagina.lbl_4c_Label1
499:                 .Caption   = "C" + CHR(243) + "digo : "
500:                 .Top       = 238
501:                 .Left      = 372
502:                 .Width     = 45
503:                 .Height    = 17
504:                 .FontName  = "Tahoma"
505:                 .FontSize  = 8
506:                 .FontBold  = .F.

*-- Linhas 515 a 542:
515:             loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
516:             WITH loc_oPagina.txt_4c_Codigo
517:                 .Value         = ""
518:                 .Top           = 235
519:                 .Left          = 419
520:                 .Width         = 24
521:                 .Height        = 22
522:                 .FontName      = "Tahoma"
523:                 .FontSize      = 8
524:                 .MaxLength     = 20
525:                 .SpecialEffect = 0
526:                 .BorderStyle   = 1
527:                 .Enabled       = .T.
528:                 .Visible       = .T.
529:             ENDWITH
530: 
531:             *-- Label "Descricao : " - top original 235 + compensacao 29 = 264
532:             *-- Original: Say2.Left=359, ForeColor=90,90,90; textbox at Left=419 (gap 60px)
533:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
534:             WITH loc_oPagina.lbl_4c_Label2
535:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
536:                 .Top       = 264
537:                 .Left      = 359
538:                 .Width     = 60
539:                 .Height    = 17
540:                 .FontName  = "Tahoma"
541:                 .FontSize  = 8
542:                 .FontBold  = .F.

*-- Linhas 551 a 574:
551:             loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
552:             WITH loc_oPagina.txt_4c_Descricao
553:                 .Value         = ""
554:                 .Top           = 261
555:                 .Left          = 419
556:                 .Width         = 220
557:                 .Height        = 22
558:                 .FontName      = "Tahoma"
559:                 .FontSize      = 8
560:                 .MaxLength     = 100
561:                 .SpecialEffect = 0
562:                 .BorderStyle   = 1
563:                 .Enabled       = .T.
564:                 .Visible       = .T.
565:             ENDWITH
566: 
567:             *-- BINDEVENT botoes Page2
568:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
569:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
570: 
571:             THIS.TornarControlesVisiveis(loc_oPagina)
572: 
573:         CATCH TO loException
574:             MostrarErro(loException, "FormOCO.ConfigurarPaginaDados")

*-- Linhas 606 a 617:
606:                     *-- Reconfigurar colunas apos RecordSource (VFP reseta headers)
607:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.cods"
608:                     loc_oGrid.Column1.Width           = 150
609:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
610:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descs"
611:                     loc_oGrid.Column2.Width           = 220
612:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
613:                     THIS.FormatarGridLista(loc_oGrid)
614:                     loc_oGrid.Refresh()
615:                     loc_lResultado = .T.
616:                 ENDIF
617:             ENDIF

*-- Linhas 725 a 746:
725:         loc_lNaLista = (THIS.this_cModoAtual = "LISTA")
726: 
727:         TRY
728:             IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir) = "O"
729:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lNaLista
730:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lNaLista
731:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lNaLista
732:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lNaLista
733:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lNaLista
734:             ENDIF
735: 
736:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar) = "O"
737:                 *-- Confirmar: habilitado somente em INCLUIR/ALTERAR
738:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
739:                     INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
740:                 *-- Cancelar: sempre habilitado quando em Page2
741:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
742:             ENDIF
743:         CATCH TO loException
744:             MostrarErro(loException, "FormOCO.AjustarBotoesPorModo")
745:         ENDTRY
746:     ENDPROC

*-- Linhas 781 a 789:
781:                     THIS.HabilitarCampos(.F.)
782:                     THIS.AjustarBotoesPorModo()
783:                     THIS.pgf_4c_Paginas.ActivePage = 2
784:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
785:                 ELSE
786:                     MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
787:                 ENDIF
788:             ENDIF
789:         CATCH TO loException


### BO (C:\4c\projeto\app\classes\OCOBO.prg):
*====================================================================
* OCOBO.prg
*
* Business Object para Ocorrencias (Cadastro de Ocorrencias)
* Tabela: SigCcCCo
* Migrado de: SIGCDOCO.SCX
*====================================================================

DEFINE CLASS OCOBO AS BusinessBase

    *-- Propriedades da entidade
    this_cCodigo    = ""    && cods  - Codigo da ocorrencia (PK)
    this_cDescricao = ""    && descs - Descricao da ocorrencia

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCcCCo"
            THIS.this_cCampoChave = "cods"
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao inicializar OCOBO: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
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
                THIS.this_cCodigo    = TratarNulo(cods,  "C")
                THIS.this_cDescricao = TratarNulo(descs, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "OCOBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Replica validacoes do original (Salva.Click em SIGCDOCO)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF THIS.this_lNovoRegistro
            IF EMPTY(THIS.this_cCodigo)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo.")
                loc_lValido = .F.
            ENDIF

            IF loc_lValido AND THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado...")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("A descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode estar vazia.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se cods ja existe na tabela
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCcCCo" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "OCOBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCcCCo
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCcCCo (cods, descs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir ocorr" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "OCOBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCcCCo
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCcCCo
                SET descs = <<EscaparSQL(THIS.this_cDescricao)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar ocorr" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "OCOBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCcCCo
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCcCCo WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir ocorr" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "OCOBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, descs
    * Colunas do grid: Codigos (150px), Descricao (220px) - per original
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(20), descs C(100))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, descs FROM SigCcCCo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY cods"

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
                        MostrarErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "OCOBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cods)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs FROM SigCcCCo" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Ocorr" + CHR(234) + "ncia n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar ocorr" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "OCOBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

