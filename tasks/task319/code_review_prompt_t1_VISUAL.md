# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 343: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 365: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 388: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprpdf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1068 linhas total):

*-- Linhas 87 a 100:
87:                 THIS.TornarControlesVisiveis(THIS)
88: 
89:                 *-- Bindar eventos dos botoes e controles
90:                 BINDEVENT(THIS.cmd_4c_CmdGetFile,    "Click", THIS, "CmdGetFileClick")
91:                 BINDEVENT(THIS.chk_4c_Chk_EMAIL,     "Click", THIS, "ChkEmailClick")
92:                 BINDEVENT(THIS.obj_4c_OptArquivo,    "Click", THIS, "OptArquivoClick")
93:                 BINDEVENT(THIS.cmd_4c_Cmd_GerarPDF,  "Click", THIS, "CmdGerarPDFClick")
94:                 BINDEVENT(THIS.cmd_4c_Cmd_SAIR,      "Click", THIS, "CmdSairClick")
95:                 BINDEVENT(THIS.cmd_4c_BtnPastasA,    "Click", THIS, "BtnPastasAClick")
96: 
97:                 loc_lSucesso = .T.
98:             ELSE
99:                 MsgErro("Falha ao criar sigprpdfBO.", "Erro")
100:             ENDIF

*-- Linhas 115 a 123:
115:         THIS.FontName   = "Tahoma"
116:         THIS.FontSize   = 8
117:         THIS.ShowTips   = .T.
118:         THIS.Caption    = "Gera" + CHR(231) + CHR(227) + "o de PDF e E-mail"
119: 
120:         IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
121:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
122:         ENDIF
123:     ENDPROC

*-- Linhas 131 a 183:
131:         TRY
132:             THIS.AddObject("cnt_4c_Sombra", "Container")
133:             WITH THIS.cnt_4c_Sombra
134:                 .Top        = 0
135:                 .Left       = 0
136:                 .Width      = 1100
137:                 .Height     = 80
138:                 .BorderWidth = 0
139:                 .BackStyle  = 1
140:                 .BackColor  = RGB(100, 100, 100)
141:                 .Visible    = .T.
142:             ENDWITH
143: 
144:             loc_oCab = THIS.cnt_4c_Sombra
145: 
146:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
147:             WITH loc_oCab.lbl_4c_LblSombra
148:                 .Top       = 18
149:                 .Left      = 10
150:                 .Width     = 769
151:                 .Height    = 40
152:                 .AutoSize  = .F.
153:                 .FontBold  = .T.
154:                 .FontName  = "Tahoma"
155:                 .FontSize  = 18
156:                 .BackStyle = 0
157:                 .ForeColor = RGB(0, 0, 0)
158:                 .WordWrap  = .T.
159:                 .Alignment = 0
160:                 .Caption   = THIS.Caption
161:                 .Visible   = .T.
162:             ENDWITH
163: 
164:             loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
165:             WITH loc_oCab.lbl_4c_LblTitulo
166:                 .Top       = 17
167:                 .Left      = 10
168:                 .Width     = 769
169:                 .Height    = 46
170:                 .AutoSize  = .F.
171:                 .FontBold  = .T.
172:                 .FontName  = "Tahoma"
173:                 .FontSize  = 18
174:                 .BackStyle = 0
175:                 .ForeColor = RGB(255, 255, 255)
176:                 .WordWrap  = .T.
177:                 .Alignment = 0
178:                 .Caption   = THIS.Caption
179:                 .Visible   = .T.
180:             ENDWITH
181: 
182:         CATCH TO loc_oErro
183:             MsgErro(loc_oErro.Message, "Erro ConfigurarCabecalho")

*-- Linhas 193 a 236:
193:         TRY
194:             THIS.AddObject("obj_4c_OptArquivo", "OptionGroup")
195:             WITH THIS.obj_4c_OptArquivo
196:                 .Top         = -2
197:                 .Left        = 420
198:                 .Width       = 161
199:                 .Height      = 85
200:                 .TabIndex    = 1
201:                 .Themes      = .T.
202:                 .ButtonCount = 2
203:                 .Value       = 1
204:                 .Visible     = .T.
205: 
206:                 WITH .Buttons(1)
207:                     .Caption    = "PDF"
208:                     .Height     = 75
209:                     .Left       = 5
210:                     .Top        = 5
211:                     .Width      = 75
212:                     .Style      = 1
213:                     .FontBold   = .T.
214:                     .FontItalic = .T.
215:                     .ForeColor  = RGB(90, 90, 90)
216:                     .BackColor  = RGB(255, 255, 255)
217:                     .BackStyle  = 0
218:                     .Picture    = gc_4c_CaminhoIcones + "pdf_60.png"
219:                 ENDWITH
220: 
221:                 WITH .Buttons(2)
222:                     .Caption    = "Excel"
223:                     .Height     = 75
224:                     .Left       = 81
225:                     .Top        = 5
226:                     .Width      = 75
227:                     .Style      = 1
228:                     .FontBold   = .T.
229:                     .FontItalic = .T.
230:                     .FontName   = "Comic Sans MS"
231:                     .FontSize   = 8
232:                     .ForeColor  = RGB(90, 90, 90)
233:                     .BackColor  = RGB(255, 255, 255)
234:                     .BackStyle  = 0
235:                     .Picture    = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
236:                 ENDWITH

*-- Linhas 248 a 275:
248:         LOCAL loc_oErro
249: 
250:         TRY
251:             THIS.AddObject("lbl_4c_Lbl_SalvarEm", "Label")
252:             WITH THIS.lbl_4c_Lbl_SalvarEm
253:                 .Top       = 109
254:                 .Left      = 150
255:                 .Width     = 53
256:                 .Height    = 15
257:                 .AutoSize  = .T.
258:                 .FontName  = "Tahoma"
259:                 .FontSize  = 8
260:                 .BackStyle = 0
261:                 .ForeColor = RGB(90, 90, 90)
262:                 .Caption   = "Salvar em:"
263:                 .TabIndex  = 4
264:                 .Visible   = .T.
265:             ENDWITH
266: 
267:             THIS.AddObject("txt_4c_TxtNomeArqSaida", "TextBox")
268:             WITH THIS.txt_4c_TxtNomeArqSaida
269:                 .Top               = 105
270:                 .Left              = 205
271:                 .Width             = 383
272:                 .Height            = 23
273:                 .FontName          = "Tahoma"
274:                 .FontSize          = 8
275:                 .ReadOnly          = .T.

*-- Linhas 281 a 317:
281:                 .Visible           = .T.
282:             ENDWITH
283: 
284:             THIS.AddObject("cmd_4c_CmdGetFile", "CommandButton")
285:             WITH THIS.cmd_4c_CmdGetFile
286:                 .Top        = 104
287:                 .Left       = 589
288:                 .Width      = 30
289:                 .Height     = 25
290:                 .FontBold   = .T.
291:                 .FontItalic = .T.
292:                 .FontName   = "Tahoma"
293:                 .FontSize   = 8
294:                 .Caption    = ". . ."
295:                 .ForeColor  = RGB(90, 90, 90)
296:                 .BackColor  = RGB(255, 255, 255)
297:                 .Themes     = .F.
298:                 .TabIndex   = 6
299:                 .Visible    = .T.
300:             ENDWITH
301: 
302:             THIS.AddObject("cmd_4c_BtnPastasA", "CommandButton")
303:             WITH THIS.cmd_4c_BtnPastasA
304:                 .Top             = 100
305:                 .Left            = 619
306:                 .Width           = 40
307:                 .Height          = 32
308:                 .FontBold        = .T.
309:                 .FontItalic      = .T.
310:                 .FontName        = "Tahoma"
311:                 .FontSize        = 8
312:                 .Caption         = ""
313:                 .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
314:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
315:                 .PicturePosition = 13
316:                 .ForeColor       = RGB(90, 90, 90)
317:                 .Themes          = .T.

*-- Linhas 326 a 395:
326:     ENDPROC
327: 
328:     *--------------------------------------------------------------------------
329:     * ConfigurarBotoesAcao - Checkbox Email, botao Gravar/Enviar e Encerrar
330:     *--------------------------------------------------------------------------
331:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
332:         LOCAL loc_oErro
333: 
334:         TRY
335:             THIS.AddObject("chk_4c_Chk_EMAIL", "CheckBox")
336:             WITH THIS.chk_4c_Chk_EMAIL
337:                 .Top        = 3
338:                 .Left       = 575
339:                 .Width      = 75
340:                 .Height     = 75
341:                 .FontBold   = .T.
342:                 .FontItalic = .T.
343:                 .FontName   = "Comic Sans MS"
344:                 .FontSize   = 8
345:                 .Caption    = "Email"
346:                 .Style      = 1
347:                 .Value      = 0
348:                 .Alignment  = 0
349:                 .Picture    = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
350:                 .ForeColor  = RGB(90, 90, 90)
351:                 .BackColor  = RGB(255, 255, 255)
352:                 .Themes     = .F.
353:                 .TabIndex   = 2
354:                 .Visible    = .T.
355:             ENDWITH
356: 
357:             THIS.AddObject("cmd_4c_Cmd_GerarPDF", "CommandButton")
358:             WITH THIS.cmd_4c_Cmd_GerarPDF
359:                 .Top             = 3
360:                 .Left            = 650
361:                 .Width           = 75
362:                 .Height          = 75
363:                 .FontBold        = .T.
364:                 .FontItalic      = .T.
365:                 .FontName        = "Comic Sans MS"
366:                 .FontSize        = 8
367:                 .Caption         = "   Gravar"
368:                 .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
369:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
370:                 .PicturePosition = 13
371:                 .Alignment       = 6
372:                 .WordWrap        = .F.
373:                 .ForeColor       = RGB(90, 90, 90)
374:                 .BackColor       = RGB(255, 255, 255)
375:                 .Themes          = .T.
376:                 .TabIndex        = 3
377:                 .Visible         = .T.
378:             ENDWITH
379: 
380:             THIS.AddObject("cmd_4c_Cmd_SAIR", "CommandButton")
381:             WITH THIS.cmd_4c_Cmd_SAIR
382:                 .Top             = 3
383:                 .Left            = 725
384:                 .Width           = 75
385:                 .Height          = 75
386:                 .FontBold        = .T.
387:                 .FontItalic      = .T.
388:                 .FontName        = "Comic Sans MS"
389:                 .FontSize        = 8
390:                 .Caption         = "Encerrar"
391:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
392:                 .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
393:                 .Cancel          = .T.
394:                 .ForeColor       = RGB(90, 90, 90)
395:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 413 a 452:
413:         TRY
414:             THIS.AddObject("cnt_4c_CtnSaida_Email", "Container")
415:             WITH THIS.cnt_4c_CtnSaida_Email
416:                 .Top        = 148
417:                 .Left       = 155
418:                 .Width      = 480
419:                 .Height     = 185
420:                 .BackStyle  = 0
421:                 .BorderWidth = 0
422:                 .TabIndex   = 7
423:                 .Visible    = .F.
424:             ENDWITH
425: 
426:             loc_oCtn = THIS.cnt_4c_CtnSaida_Email
427: 
428:             loc_oCtn.AddObject("lbl_4c_Label1", "Label")
429:             WITH loc_oCtn.lbl_4c_Label1
430:                 .Top       = 8
431:                 .Left      = 47
432:                 .Width     = 19
433:                 .Height    = 15
434:                 .AutoSize  = .T.
435:                 .FontName  = "Tahoma"
436:                 .FontSize  = 8
437:                 .BackStyle = 0
438:                 .ForeColor = RGB(90, 90, 90)
439:                 .Caption   = "De:"
440:                 .TabIndex  = 1
441:                 .Visible   = .T.
442:             ENDWITH
443: 
444:             loc_oCtn.AddObject("txt_4c_TxtEmail_EnviarDE", "TextBox")
445:             WITH loc_oCtn.txt_4c_TxtEmail_EnviarDE
446:                 .Top               = 5
447:                 .Left              = 68
448:                 .Width             = 404
449:                 .Height            = 23
450:                 .FontName          = "Tahoma"
451:                 .FontSize          = 8
452:                 .ReadOnly          = .T.

*-- Linhas 459 a 581:
459:                 .Visible           = .T.
460:             ENDWITH
461: 
462:             loc_oCtn.AddObject("lbl_4c_Lbl_EmailPara", "Label")
463:             WITH loc_oCtn.lbl_4c_Lbl_EmailPara
464:                 .Top       = 38
465:                 .Left      = 38
466:                 .Width     = 28
467:                 .Height    = 15
468:                 .AutoSize  = .T.
469:                 .FontName  = "Tahoma"
470:                 .FontSize  = 8
471:                 .BackStyle = 0
472:                 .ForeColor = RGB(90, 90, 90)
473:                 .Caption   = "Para:"
474:                 .TabIndex  = 3
475:                 .Visible   = .T.
476:             ENDWITH
477: 
478:             loc_oCtn.AddObject("obj_4c_TxtEmail_EnviarPara", "EditBox")
479:             WITH loc_oCtn.obj_4c_TxtEmail_EnviarPara
480:                 .Top           = 35
481:                 .Left          = 68
482:                 .Width         = 404
483:                 .Height        = 23
484:                 .FontName      = "Tahoma"
485:                 .FontSize      = 8
486:                 .ScrollBars    = 0
487:                 .SpecialEffect = 1
488:                 .BorderColor   = RGB(100, 100, 100)
489:                 .Value         = ""
490:                 .TabIndex      = 4
491:                 .Visible       = .T.
492:             ENDWITH
493: 
494:             loc_oCtn.AddObject("lbl_4c_LblEmail_CC", "Label")
495:             WITH loc_oCtn.lbl_4c_LblEmail_CC
496:                 .Top       = 68
497:                 .Left      = 46
498:                 .Width     = 20
499:                 .Height    = 15
500:                 .AutoSize  = .T.
501:                 .FontName  = "Tahoma"
502:                 .FontSize  = 8
503:                 .BackStyle = 0
504:                 .ForeColor = RGB(90, 90, 90)
505:                 .Caption   = "CC:"
506:                 .TabIndex  = 5
507:                 .Visible   = .T.
508:             ENDWITH
509: 
510:             loc_oCtn.AddObject("obj_4c_TxtEmail_CC", "EditBox")
511:             WITH loc_oCtn.obj_4c_TxtEmail_CC
512:                 .Top           = 65
513:                 .Left          = 68
514:                 .Width         = 404
515:                 .Height        = 23
516:                 .FontName      = "Tahoma"
517:                 .FontSize      = 8
518:                 .ScrollBars    = 0
519:                 .SpecialEffect = 1
520:                 .BorderColor   = RGB(100, 100, 100)
521:                 .Value         = ""
522:                 .TabIndex      = 6
523:                 .Visible       = .T.
524:             ENDWITH
525: 
526:             loc_oCtn.AddObject("lbl_4c_LblEmail_Assunto", "Label")
527:             WITH loc_oCtn.lbl_4c_LblEmail_Assunto
528:                 .Top       = 99
529:                 .Left      = 21
530:                 .Width     = 45
531:                 .Height    = 15
532:                 .AutoSize  = .T.
533:                 .FontName  = "Tahoma"
534:                 .FontSize  = 8
535:                 .BackStyle = 0
536:                 .ForeColor = RGB(90, 90, 90)
537:                 .Caption   = "Assunto:"
538:                 .TabIndex  = 7
539:                 .Visible   = .T.
540:             ENDWITH
541: 
542:             loc_oCtn.AddObject("txt_4c_TxtEmail_Assunto", "TextBox")
543:             WITH loc_oCtn.txt_4c_TxtEmail_Assunto
544:                 .Top           = 95
545:                 .Left          = 68
546:                 .Width         = 404
547:                 .Height        = 23
548:                 .FontName      = "Tahoma"
549:                 .FontSize      = 8
550:                 .SpecialEffect = 1
551:                 .BorderColor   = RGB(100, 100, 100)
552:                 .Value         = ""
553:                 .TabIndex      = 8
554:                 .Visible       = .T.
555:             ENDWITH
556: 
557:             loc_oCtn.AddObject("lbl_4c_LblEmail_Corpo", "Label")
558:             WITH loc_oCtn.lbl_4c_LblEmail_Corpo
559:                 .Top       = 127
560:                 .Left      = 32
561:                 .Width     = 34
562:                 .Height    = 15
563:                 .AutoSize  = .T.
564:                 .FontName  = "Tahoma"
565:                 .FontSize  = 8
566:                 .BackStyle = 0
567:                 .ForeColor = RGB(90, 90, 90)
568:                 .Caption   = "Texto:"
569:                 .TabIndex  = 9
570:                 .Visible   = .T.
571:             ENDWITH
572: 
573:             loc_oCtn.AddObject("obj_4c_EdtEmail_Corpo", "EditBox")
574:             WITH loc_oCtn.obj_4c_EdtEmail_Corpo
575:                 .Top           = 125
576:                 .Left          = 68
577:                 .Width         = 404
578:                 .Height        = 53
579:                 .FontName      = "Tahoma"
580:                 .FontSize      = 8
581:                 .SpecialEffect = 1

*-- Linhas 701 a 713:
701:             THIS.LockScreen = .T.
702: 
703:             IF THIS.chk_4c_Chk_EMAIL.Value = 1
704:                 THIS.cmd_4c_Cmd_GerarPDF.Caption = "Enviar Email"
705:                 THIS.Height = THIS.this_nAlturaBase + THIS.cnt_4c_CtnSaida_Email.Height
706:                 THIS.cnt_4c_CtnSaida_Email.Visible = .T.
707:             ELSE
708:                 THIS.cmd_4c_Cmd_GerarPDF.Caption = "\<Gravar"
709:                 THIS.Height = THIS.this_nAlturaBase
710:                 THIS.cnt_4c_CtnSaida_Email.Visible = .F.
711:             ENDIF
712: 
713:             THIS.Refresh()

*-- Linhas 750 a 758:
750: 
751:             IF EMPTY(loc_cArquivo)
752:                 MsgAviso("Selecione um nome para o arquivo!", "Aten" + CHR(231) + CHR(227) + "o")
753:                 THIS.cmd_4c_CmdGetFile.SetFocus()
754:                 loc_lContinuar = .F.
755:             ENDIF
756: 
757:             IF loc_lContinuar
758:                 loc_lEnviarEmail = (THIS.chk_4c_Chk_EMAIL.Value = 1)

*-- Linhas 1007 a 1018:
1007:         loc_lEnabled = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1008: 
1009:         THIS.obj_4c_OptArquivo.Enabled     = loc_lEnabled
1010:         THIS.cmd_4c_CmdGetFile.Enabled     = loc_lEnabled
1011:         THIS.chk_4c_Chk_EMAIL.Enabled      = loc_lEnabled
1012:         THIS.cmd_4c_Cmd_GerarPDF.Enabled   = loc_lEnabled
1013:         THIS.cmd_4c_BtnPastasA.Enabled     = loc_lEnabled
1014: 
1015:         loc_oCtn = THIS.cnt_4c_CtnSaida_Email
1016:         loc_oCtn.obj_4c_TxtEmail_EnviarPara.Enabled = loc_lEnabled
1017:         loc_oCtn.obj_4c_TxtEmail_CC.Enabled         = loc_lEnabled
1018:         loc_oCtn.txt_4c_TxtEmail_Assunto.Enabled    = loc_lEnabled


### BO (C:\4c\projeto\app\classes\sigprpdfBO.prg):
*==============================================================================
* sigprpdfBO.prg - Business Object: Gera????o de PDF/XLS e E-mail
* Herda de: BusinessBase
* Tipo: OPERACIONAL (auxiliar modal - sem CRUD)
* Tabela: SigCdEmp (somente leitura para config. de email)
*==============================================================================
DEFINE CLASS sigprpdfBO AS BusinessBase

    *-- Configuracao da entidade (sem tabela de CRUD)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Diretorio e arquivo de saida
    this_cDiretorio     = ""
    this_cArquivoSaida  = ""
    this_nTipoArquivo   = 1

    *-- Disponibilidade do PDFCreator (verificado via registry)
    this_lPdfDisponivel = .F.

    *-- Dados de email da empresa (vindos de SigCdEmp)
    this_cEmailEmpresaDe = ""
    this_cSmtpServidor   = ""
    this_cSmtpSenha      = ""
    this_cSmtpPasta      = ""
    this_nSmtpPorta      = 0

    *-- Dados do email a enviar
    this_lEnviarEmail   = .F.
    this_cEmailPara     = ""
    this_cEmailCC       = ""
    this_cEmailAssunto  = ""
    this_cEmailCorpo    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        this_cTabela     = ""
        this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmailEmpresa()
    *-- Busca configuracoes de email da empresa em SigCdEmp
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, pastas, PadPortas " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF USED("cursor_4c_EmailEmp")
                USE IN cursor_4c_EmailEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmailEmp") < 1
                MsgErro("Falha ao carregar dados de email da empresa.", "Erro")
            ELSE
                IF RECCOUNT("cursor_4c_EmailEmp") > 0
                    SELECT cursor_4c_EmailEmp
                    THIS.this_cEmailEmpresaDe = LOWER(ALLTRIM(NVL(PadEmails, "")))
                    THIS.this_cSmtpServidor   = LOWER(ALLTRIM(NVL(PadServs,  "")))
                    THIS.this_cSmtpSenha      = ALLTRIM(NVL(PadSenhas, ""))
                    THIS.this_cSmtpPasta      = ALLTRIM(NVL(pastas,    ""))
                    THIS.this_nSmtpPorta      = NVL(PadPortas, 0)
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarParaSalvar()
    *-- Valida campos obrigatorios antes de gravar
    *--------------------------------------------------------------------------
        LOCAL loc_lOk

        loc_lOk = .T.

        IF EMPTY(THIS.this_cArquivoSaida)
            MsgAviso("Selecione um nome para o arquivo!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarParaEmail()
    *-- Valida campos obrigatorios do email antes de enviar
    *--------------------------------------------------------------------------
        LOCAL loc_lOk

        loc_lOk = .T.

        IF EMPTY(THIS.this_cEmailEmpresaDe)
            MsgAviso("O campo 'DE:' n" + CHR(227) + "o foi preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        IF loc_lOk AND EMPTY(THIS.this_cEmailPara)
            MsgAviso("O campo 'PARA:' n" + CHR(227) + "o foi preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE MontarObjetoEmail(par_cArquivoAnexo)
    *-- Monta e retorna objeto CUSTOM com dados do email para o form pai usar
    *-- par_cArquivoAnexo: caminho completo do arquivo a ser anexado
    *-- Retorna objeto CUSTOM ou .NULL. em caso de erro
    *--------------------------------------------------------------------------
        LOCAL loc_oEmail, loc_oErro

        loc_oEmail = .NULL.

        TRY
            IF !THIS.ValidarParaEmail()
                loc_lResultado = .NULL.
            ENDIF

            loc_oEmail = CREATEOBJECT("CUSTOM")

            loc_oEmail.AddProperty("cSmtpServer",    THIS.this_cSmtpServidor)
            loc_oEmail.AddProperty("nSmtpServerPort", THIS.this_nSmtpPorta)
            loc_oEmail.AddProperty("cSendUserName",  THIS.this_cEmailEmpresaDe)
            loc_oEmail.AddProperty("cSendPassWord",  THIS.this_cSmtpSenha)
            loc_oEmail.AddProperty("cFrom",          THIS.this_cEmailEmpresaDe)
            loc_oEmail.AddProperty("cTO",            THIS.this_cEmailPara)
            loc_oEmail.AddProperty("cCC",            THIS.this_cEmailCC)
            loc_oEmail.AddProperty("cAssunto",       THIS.this_cEmailAssunto)
            loc_oEmail.AddProperty("cCorpo",         THIS.this_cEmailCorpo)
            loc_oEmail.AddProperty("cAnexo",         par_cArquivoAnexo)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_oEmail = .NULL.
        ENDTRY

        RETURN loc_oEmail
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ResolverExtensao(par_cCaminho, par_nTipoArquivo)
    *-- Garante que o caminho tem a extensao correta (.pdf ou .xls)
    *-- par_cCaminho: caminho do arquivo (pode estar sem extensao)
    *-- par_nTipoArquivo: 1=PDF, 2=XLS
    *-- Retorna: caminho com extensao correta
    *--------------------------------------------------------------------------
        LOCAL loc_cExt, loc_cCaminho

        loc_cExt    = IIF(par_nTipoArquivo = 1, "PDF", "XLS")
        loc_cCaminho = ALLTRIM(par_cCaminho)

        IF !EMPTY(loc_cCaminho)
            IF !(UPPER(JUSTEXT(loc_cCaminho)) $ loc_cExt)
                loc_cCaminho = FORCEEXT(loc_cCaminho, LEFT(loc_cExt, 3))
            ENDIF
        ENDIF

        RETURN loc_cCaminho
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *-- Carrega config de email da empresa a partir do cursor (TmpEmpMail/cursor_4c_EmailEmp)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmailEmpresaDe = LOWER(ALLTRIM(NVL(PadEmails, "")))
            THIS.this_cSmtpServidor   = LOWER(ALLTRIM(NVL(PadServs,  "")))
            THIS.this_cSmtpSenha      = ALLTRIM(NVL(PadSenhas, ""))
            THIS.this_cSmtpPasta      = ALLTRIM(NVL(pastas, ""))
            THIS.this_nSmtpPorta      = NVL(PadPortas, 0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *-- Form auxiliar sem tabela de CRUD - sem chave primaria
    *--------------------------------------------------------------------------
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *-- Compatibilidade BusinessBase.Salvar() - delega para ValidarParaSalvar
    *--------------------------------------------------------------------------
        RETURN THIS.ValidarParaSalvar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AbrirPasta(par_cDiretorio)
    *-- Abre o diretorio no Windows Explorer
    *--------------------------------------------------------------------------
        LOCAL loc_oApp, loc_oErro

        TRY
            IF !EMPTY(par_cDiretorio)
                IF !DIRECTORY(par_cDiretorio)
                    MsgAviso("Diret" + CHR(243) + "rio n" + CHR(227) + "o Localizado", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_oApp = CREATEOBJECT("Shell.Application")
                    loc_oApp.Open(par_cDiretorio)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
    *-- Modo GRAVAR: prepara arquivo de saida SEM envio de email.
    *-- Form OPERACIONAL auxiliar (sem tabela de CRUD): "Inserir" representa
    *-- a acao de gerar o arquivo de saida (PDF/XLS) pela primeira vez.
    *-- Valida os dados, resolve extensao do arquivo e marca envio de email
    *-- como .F. para que o form pai use apenas o caminho do arquivo.
    *-- Retorna: .T. sucesso, .F. falha (ver ObterMensagemErro em BusinessBase)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !THIS.ValidarParaSalvar()
                loc_lResultado = .F.
            ELSE
                THIS.this_cArquivoSaida = THIS.ResolverExtensao( ;
                    THIS.this_cArquivoSaida, THIS.this_nTipoArquivo)

                THIS.this_lEnviarEmail = .F.
                THIS.this_cEmailPara    = ""
                THIS.this_cEmailCC      = ""
                THIS.this_cEmailAssunto = ""
                THIS.this_cEmailCorpo   = ""

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar arquivo")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *-- Modo ENVIAR EMAIL: prepara arquivo de saida COM anexo em email.
    *-- Form OPERACIONAL auxiliar (sem tabela de CRUD): "Atualizar" representa
    *-- a acao de re-gerar/atualizar o arquivo com envio por email anexado.
    *-- Valida arquivo E dados de email antes de sinalizar sucesso.
    *-- Retorna: .T. sucesso, .F. falha
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !THIS.ValidarParaSalvar()
                loc_lResultado = .F.
            ELSE
                THIS.this_cArquivoSaida = THIS.ResolverExtensao( ;
                    THIS.this_cArquivoSaida, THIS.this_nTipoArquivo)

                IF !THIS.ValidarParaEmail()
                    loc_lResultado = .F.
                ELSE
                    THIS.this_lEnviarEmail = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar envio de email")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

