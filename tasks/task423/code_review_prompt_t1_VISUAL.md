# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 291: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 313: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 336: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 544: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 566: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFpb.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1120 linhas total):

*-- Linhas 133 a 150:
133:         TRY
134:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
135:             WITH THIS.pgf_4c_Paginas
136:                 .Top         = -29
137:                 .Left        = 0
138:                 .Width       = THIS.Width
139:                 .Height      = THIS.Height + 29
140:                 .PageCount   = 2
141:                 .Tabs        = .F.
142:                 .BorderWidth = 0
143: 
144:                 .Page1.Caption = "Lista"
145:                 .Page2.Caption = "Dados"
146:             ENDWITH
147:         CATCH TO loc_oErro
148:             MsgErro(loc_oErro.Message + CHR(13) + ;
149:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
150:                 "Procedure: " + loc_oErro.Procedure, "FormFpb.ConfigurarPageFrame")

*-- Linhas 165 a 199:
165:             *-- Page1: cabecalho escuro (topo)
166:             loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
167:             WITH loc_oPag1.cnt_4c_Cabecalho
168:                 .Top         = 0 + 29
169:                 .Left        = 0
170:                 .Width       = THIS.Width
171:                 .Height      = 80
172:                 .BorderWidth = 0
173:                 .BackStyle   = 1
174:                 .BackColor   = RGB(100, 100, 100)
175:                 .Visible     = .T.
176:             ENDWITH
177: 
178:             *-- Page1: container de botoes (fase 4 populara com Inserir/Excluir/Sair)
179:             loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
180:             WITH loc_oPag1.cnt_4c_Botoes
181:                 .Top         = 0 + 29
182:                 .Left        =  542
183:                 .Width       = 229
184:                 .Height      = 85
185:                 .BorderWidth = 0
186:                 .BackStyle   = 0
187:                 .Visible     = .T.
188:             ENDWITH
189: 
190:             *-- Page2: container de botoes de acao (fase 6 populara com Salvar/Cancelar)
191:             loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
192:             WITH loc_oPag2.cnt_4c_BotoesAcao
193:                 .Top         = 4 + 29
194:                 .Left        = 550
195:                 .Width       = 170
196:                 .Height      = 85
197:                 .BorderWidth = 0
198:                 .BackStyle   = 0
199:                 .Visible     = .T.

*-- Linhas 247 a 376:
247: 
248:             *-- Labels no cabecalho escuro (sombra + titulo)
249:             loc_oCab = loc_oPag.cnt_4c_Cabecalho
250:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
251:             WITH loc_oCab.lbl_4c_Sombra
252:                 .AutoSize   = .F.
253:                 .FontBold   = .T.
254:                 .FontName   = "Tahoma"
255:                 .FontSize   = 18
256:                 .BackStyle  = 0
257:                 .Caption    = THIS.Caption
258:                 .Height     = 40
259:                 .Left       = 10
260:                 .Top        = 18
261:                 .Width      = 769
262:                 .ForeColor  = RGB(0, 0, 0)
263:             ENDWITH
264: 
265:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
266:             WITH loc_oCab.lbl_4c_Titulo
267:                 .AutoSize   = .F.
268:                 .FontBold   = .T.
269:                 .FontName   = "Tahoma"
270:                 .FontSize   = 18
271:                 .BackStyle  = 0
272:                 .Caption    = THIS.Caption
273:                 .Height     = 46
274:                 .Left       = 10
275:                 .Top        = 17
276:                 .Width      = 769
277:                 .ForeColor  = RGB(255, 255, 255)
278:             ENDWITH
279: 
280:             *-- Botoes: Inserir / Excluir / Encerrar no container direito
281:             loc_oCnt = loc_oPag.cnt_4c_Botoes
282: 
283:             loc_oCnt.AddObject("cmd_4c_Inserir", "CommandButton")
284:             WITH loc_oCnt.cmd_4c_Inserir
285:                 .Left            = 0
286:                 .Top             = 5
287:                 .Width           = 75
288:                 .Height          = 75
289:                 .Caption         = "Inserir"
290:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
291:                 .FontName        = "Comic Sans MS"
292:                 .FontBold        = .T.
293:                 .FontItalic      = .T.
294:                 .FontSize        = 8
295:                 .ForeColor       = RGB(90, 90, 90)
296:                 .BackColor       = RGB(255, 255, 255)
297:                 .Themes          = .F.
298:                 .SpecialEffect   = 0
299:                 .PicturePosition = 13
300:                 .MousePointer    = 15
301:                 .WordWrap        = .T.
302:             ENDWITH
303:             BINDEVENT(loc_oCnt.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")
304: 
305:             loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
306:             WITH loc_oCnt.cmd_4c_Excluir
307:                 .Left            = 75
308:                 .Top             = 5
309:                 .Width           = 75
310:                 .Height          = 75
311:                 .Caption         = "Excluir"
312:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
313:                 .FontName        = "Comic Sans MS"
314:                 .FontBold        = .T.
315:                 .FontItalic      = .T.
316:                 .FontSize        = 8
317:                 .ForeColor       = RGB(90, 90, 90)
318:                 .BackColor       = RGB(255, 255, 255)
319:                 .Themes          = .F.
320:                 .SpecialEffect   = 0
321:                 .PicturePosition = 13
322:                 .MousePointer    = 15
323:                 .WordWrap        = .T.
324:             ENDWITH
325:             BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
326: 
327:             loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
328:             WITH loc_oCnt.cmd_4c_Encerrar
329:                 .Left            = 150
330:                 .Top             = 5
331:                 .Width           = 75
332:                 .Height          = 75
333:                 .Caption         = "Encerrar"
334:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
335:                 .Cancel          = .T.
336:                 .FontName        = "Comic Sans MS"
337:                 .FontBold        = .T.
338:                 .FontItalic      = .T.
339:                 .FontSize        = 8
340:                 .ForeColor       = RGB(90, 90, 90)
341:                 .BackColor       = RGB(255, 255, 255)
342:                 .Themes          = .F.
343:                 .SpecialEffect   = 0
344:                 .PicturePosition = 13
345:                 .MousePointer    = 15
346:                 .WordWrap        = .T.
347:             ENDWITH
348:             BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
349: 
350:             *-- Label exibindo a condicao de pagamento ativa
351:             loc_oPag.AddObject("lbl_4c_CondicaoPag", "Label")
352:             WITH loc_oPag.lbl_4c_CondicaoPag
353:                 .AutoSize  = .T.
354:                 .FontBold  = .T.
355:                 .FontName  = "Tahoma"
356:                 .FontSize  = 8
357:                 .BackStyle = 0
358:                 .Caption   = "[ " + ALLTRIM(THIS.this_cFpags) + " ]"
359:                 .Height    = 15
360:                 .Left      = 272
361:                 .Top       = 116
362:                 .Width     = 154
363:                 .ForeColor = RGB(90, 90, 90)
364:             ENDWITH
365: 
366:             *-- Grid de BINs (RecordSource e ControlSource sao setados em CarregarDados)
367:             loc_oPag.AddObject("grd_4c_Dados", "Grid")
368:             loc_oGrd = loc_oPag.grd_4c_Dados
369:             WITH loc_oGrd
370:                 .Left                = 145
371:                 .Top                 = 135
372:                 .Width               = 432
373:                 .Height              = 244
374:                 .ColumnCount         = 4
375:                 .FontName            = "Tahoma"
376:                 .FontSize            = 8

*-- Linhas 390 a 398:
390:                     .FontName  = "Tahoma"
391:                     .FontSize  = 8
392:                     WITH .Header1
393:                         .Caption   = "B I N"
394:                         .Alignment = 2
395:                         .FontName  = "Tahoma"
396:                         .FontSize  = 8
397:                     ENDWITH
398:                     WITH .Text1

*-- Linhas 410 a 418:
410:                     .FontName  = "Tahoma"
411:                     .FontSize  = 8
412:                     WITH .Header1
413:                         .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
414:                         .Alignment = 2
415:                         .FontName  = "Tahoma"
416:                         .FontSize  = 8
417:                     ENDWITH
418:                     WITH .Text1

*-- Linhas 430 a 438:
430:                     .FontName  = "Tahoma"
431:                     .FontSize  = 8
432:                     WITH .Header1
433:                         .Caption   = "Validade De"
434:                         .Alignment = 2
435:                         .FontName  = "Tahoma"
436:                         .FontSize  = 8
437:                     ENDWITH
438:                     WITH .Text1

*-- Linhas 451 a 459:
451:                     .FontName  = "Tahoma"
452:                     .FontSize  = 8
453:                     WITH .Header1
454:                         .Caption   = "Validade Ate"
455:                         .Alignment = 2
456:                         .FontName  = "Tahoma"
457:                         .FontSize  = 8
458:                     ENDWITH
459:                     WITH .Text1

*-- Linhas 487 a 583:
487:             *-- Cabecalho escuro espelhando Page1
488:             loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
489:             WITH loc_oPag.cnt_4c_Cabecalho
490:                 .Top         = 0 + 29
491:                 .Left        = 0
492:                 .Width       = THIS.Width
493:                 .Height      = 80
494:                 .BorderWidth = 0
495:                 .BackStyle   = 1
496:                 .BackColor   = RGB(100, 100, 100)
497:                 .Visible     = .T.
498:             ENDWITH
499: 
500:             loc_oCab = loc_oPag.cnt_4c_Cabecalho
501: 
502:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
503:             WITH loc_oCab.lbl_4c_Sombra
504:                 .AutoSize  = .F.
505:                 .FontBold  = .T.
506:                 .FontName  = "Tahoma"
507:                 .FontSize  = 18
508:                 .BackStyle = 0
509:                 .Caption   = THIS.Caption
510:                 .Height    = 40
511:                 .Left      = 10
512:                 .Top       = 18
513:                 .Width     = THIS.Width
514:                 .ForeColor = RGB(0, 0, 0)
515:             ENDWITH
516: 
517:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
518:             WITH loc_oCab.lbl_4c_Titulo
519:                 .AutoSize  = .F.
520:                 .FontBold  = .T.
521:                 .FontName  = "Tahoma"
522:                 .FontSize  = 18
523:                 .BackStyle = 0
524:                 .Caption   = THIS.Caption
525:                 .Height    = 46
526:                 .Left      = 10
527:                 .Top       = 17
528:                 .Width     = THIS.Width
529:                 .ForeColor = RGB(255, 255, 255)
530:             ENDWITH
531: 
532:             *-- Botoes Confirmar / Cancelar no container cnt_4c_BotoesAcao
533:             LOCAL loc_oCnt2
534:             loc_oCnt2 = loc_oPag.cnt_4c_BotoesAcao
535: 
536:             loc_oCnt2.AddObject("cmd_4c_Confirmar", "CommandButton")
537:             WITH loc_oCnt2.cmd_4c_Confirmar
538:                 .Left            = 5
539:                 .Top             = 5
540:                 .Width           = 75
541:                 .Height          = 75
542:                 .Caption         = "Confirmar"
543:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
544:                 .FontName        = "Comic Sans MS"
545:                 .FontBold        = .T.
546:                 .FontItalic      = .T.
547:                 .FontSize        = 8
548:                 .ForeColor       = RGB(90, 90, 90)
549:                 .BackColor       = RGB(255, 255, 255)
550:                 .Themes          = .F.
551:                 .SpecialEffect   = 0
552:                 .PicturePosition = 13
553:                 .MousePointer    = 15
554:                 .WordWrap        = .T.
555:             ENDWITH
556:             BINDEVENT(loc_oCnt2.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
557: 
558:             loc_oCnt2.AddObject("cmd_4c_Cancelar", "CommandButton")
559:             WITH loc_oCnt2.cmd_4c_Cancelar
560:                 .Left            = 85
561:                 .Top             = 5
562:                 .Width           = 75
563:                 .Height          = 75
564:                 .Caption         = "Encerrar"
565:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
566:                 .FontName        = "Comic Sans MS"
567:                 .FontBold        = .T.
568:                 .FontItalic      = .T.
569:                 .FontSize        = 8
570:                 .ForeColor       = RGB(90, 90, 90)
571:                 .BackColor       = RGB(255, 255, 255)
572:                 .Themes          = .F.
573:                 .SpecialEffect   = 0
574:                 .PicturePosition = 13
575:                 .MousePointer    = 15
576:                 .WordWrap        = .T.
577:             ENDWITH
578:             BINDEVENT(loc_oCnt2.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
579: 
580:             *-- Vincula BeforeRowColChange para salvar peantvalue (Col2/3/4.Text1.When)
581:             loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
582:             IF VARTYPE(loc_oGrd) = "O"
583:                 BINDEVENT(loc_oGrd, "BeforeRowColChange", THIS, "GrdDadosBeforeRowColChange")

*-- Linhas 653 a 664:
653:                 loc_oGrd.Column4.ControlSource = "cursor_4c_BINs.datafs"
654: 
655:                 *-- Reconfigurar headers (RecordSource os reseta)
656:                 loc_oGrd.Column1.Header1.Caption = "B I N"
657:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
658:                 loc_oGrd.Column3.Header1.Caption = "Validade De"
659:                 loc_oGrd.Column4.Header1.Caption = "Validade Ate"
660: 
661:                 loc_oGrd.Refresh()
662:                 loc_lSucesso = .T.
663:             ENDIF
664:         CATCH TO loc_oErro

*-- Linhas 738 a 747:
738:             loc_oPag = THIS.pgf_4c_Paginas.Page1
739:             loc_oCnt = loc_oPag.cnt_4c_Botoes
740: 
741:             IF VARTYPE(loc_oCnt.cmd_4c_Inserir) = "O" AND ;
742:                loc_oCnt.cmd_4c_Inserir.Visible          AND ;
743:                THIS.GravaDados
744:                 IF !THIS.this_oBusinessObject.SalvarBINs(THIS.this_cFpags, "cursor_4c_BINs")
745:                     loc_lPodeFechar = .F.
746:                 ENDIF
747:             ENDIF

*-- Linhas 973 a 985:
973:         TRY
974:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
975:             IF VARTYPE(loc_oCnt) = "O"
976:                 IF VARTYPE(loc_oCnt.cmd_4c_Inserir) = "O"
977:                     loc_oCnt.cmd_4c_Inserir.Enabled = par_lHabilitar
978:                 ENDIF
979:                 IF VARTYPE(loc_oCnt.cmd_4c_Excluir) = "O"
980:                     loc_oCnt.cmd_4c_Excluir.Enabled = par_lHabilitar
981:                 ENDIF
982:             ENDIF
983:         CATCH TO loc_oErro
984:             MsgErro(loc_oErro.Message + CHR(13) + ;
985:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1022 a 1037:
1022:             loc_lHabilitar = INLIST(THIS.this_cModoAtual, "LISTA", "INCLUIR")
1023: 
1024:             IF VARTYPE(loc_oCnt) = "O"
1025:                 IF VARTYPE(loc_oCnt.cmd_4c_Inserir) = "O"
1026:                     loc_oCnt.cmd_4c_Inserir.Enabled = loc_lHabilitar
1027:                 ENDIF
1028:                 IF VARTYPE(loc_oCnt.cmd_4c_Excluir) = "O"
1029:                     loc_oCnt.cmd_4c_Excluir.Enabled = loc_lHabilitar
1030:                 ENDIF
1031:                 IF VARTYPE(loc_oCnt.cmd_4c_Encerrar) = "O"
1032:                     loc_oCnt.cmd_4c_Encerrar.Enabled = .T.
1033:                 ENDIF
1034:             ENDIF
1035:         CATCH TO loc_oErro
1036:             MsgErro(loc_oErro.Message + CHR(13) + ;
1037:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1079 a 1088:
1079:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1080: 
1081:             IF VARTYPE(loc_oCnt) = "O" AND ;
1082:                VARTYPE(loc_oCnt.cmd_4c_Inserir) = "O" AND ;
1083:                loc_oCnt.cmd_4c_Inserir.Visible
1084:                 IF THIS.GravaDados
1085:                     IF THIS.this_oBusinessObject.SalvarBINs(THIS.this_cFpags, "cursor_4c_BINs")
1086:                         THIS.GravaDados = .F.
1087:                         MsgInfo("BINs salvos com sucesso.", "Salvo")
1088:                     ENDIF


### BO (C:\4c\projeto\app\classes\FpbBO.prg):
*==============================================================================
* FpbBO.prg - Business Object: Cadastro de BIN
* Tabela: SigOpFpb
* PK: cidchaves char(20)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS FpbBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Chave Primaria
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""    && cidchaves char(20) - PK tecnica (auto-gerada)

    *--------------------------------------------------------------------------
    * Propriedades - Campos da tabela SigOpFpb
    *--------------------------------------------------------------------------
    this_cCodBins    = ""    && codbins   char(6)      - codigo BIN
    this_cDescs      = ""    && descs     char(30)     - descricao
    this_dDataIs     = {}    && datais    datetime NULL - validade de
    this_dDataFs     = {}    && datafs    datetime NULL - validade ate
    this_cFpags      = ""    && fpags     char(12)     - FK condicao de pagamento

    *--------------------------------------------------------------------------
    * Propriedades de controle
    *--------------------------------------------------------------------------
    this_lGravaDados = .F.   && indica se houve alteracao nos dados do grid

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpFpb"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCodBins   = TratarNulo(codbins,   "C")
                THIS.this_cDescs     = TratarNulo(descs,     "C")
                THIS.this_dDataIs    = IIF(ISNULL(datais), {}, IIF(VARTYPE(datais) = "T", TTOD(datais), datais))
                THIS.this_dDataFs    = IIF(ISNULL(datafs), {}, IIF(VARTYPE(datafs) = "T", TTOD(datafs), datafs))
                THIS.this_cFpags     = TratarNulo(fpags,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCodBins)
            MsgAviso("C" + CHR(243) + "digo BIN " + CHR(233) + ;
                " " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cFpags)
            MsgAviso("Condi" + CHR(231) + CHR(227) + "o de pagamento " + CHR(233) + ;
                " obrigat" + CHR(243) + "ria.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo BIN no banco de dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarDados()
                THIS.this_cCidChaves = THIS.GerarChavePrimaria()

                loc_cSQL = "INSERT INTO SigOpFpb " + ;
                           "(cidchaves, codbins, descs, datais, datafs, fpags) " + ;
                           "VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves)    + ", " + ;
                           EscaparSQL(THIS.this_cCodBins)      + ", " + ;
                           EscaparSQL(THIS.this_cDescs)        + ", " + ;
                           FormatarDataSQL(THIS.this_dDataIs)  + ", " + ;
                           FormatarDataSQL(THIS.this_dDataFs)  + ", " + ;
                           EscaparSQL(THIS.this_cFpags)        + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir BIN no banco de dados.", "FpbBO.Inserir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza BIN existente no banco de dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigOpFpb SET " + ;
                           "codbins = " + EscaparSQL(THIS.this_cCodBins)     + ", " + ;
                           "descs   = " + EscaparSQL(THIS.this_cDescs)       + ", " + ;
                           "datais  = " + FormatarDataSQL(THIS.this_dDataIs) + ", " + ;
                           "datafs  = " + FormatarDataSQL(THIS.this_dDataFs) + ", " + ;
                           "fpags   = " + EscaparSQL(THIS.this_cFpags)       + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("A")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar BIN no banco de dados.", "FpbBO.Atualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui BIN do banco de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigOpFpb " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir BIN do banco de dados.", "FpbBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBINs - Carrega BINs de uma condicao de pagamento em cursor local
    *--------------------------------------------------------------------------
    FUNCTION CarregarBINs(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BINs")
                USE IN cursor_4c_BINs
            ENDIF
            IF USED("cursor_4c_BINsTemp")
                USE IN cursor_4c_BINsTemp
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_BINs ( ;
                cidchaves C(20) NULL, ;
                codbins   C(6)  NULL, ;
                descs     C(30) NULL, ;
                datais    T     NULL, ;
                datafs    T     NULL, ;
                fpags     C(12) NULL  ;
            )
            SET NULL OFF

            loc_cSQL = "SELECT cidchaves, codbins, descs, datais, datafs, fpags " + ;
                       "FROM SigOpFpb " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + ;
                       " ORDER BY codbins"

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BINsTemp")

            IF USED("cursor_4c_BINsTemp")
                SELECT cursor_4c_BINs
                APPEND FROM DBF("cursor_4c_BINsTemp")
                USE IN cursor_4c_BINsTemp
            ENDIF

            SELECT cursor_4c_BINs
            INDEX ON codbins TAG codbins
            SET ORDER TO
            GOTO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.CarregarBINs")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicidade - Verifica se ha codbins duplicados no cursor
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicidade(par_cCursorBINs)
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.
        TRY
            IF USED(par_cCursorBINs)
                IF USED("cursor_4c_DupBINs")
                    USE IN cursor_4c_DupBINs
                ENDIF

                SELECT codbins, SUM(1) AS nQtd ;
                    FROM (par_cCursorBINs) ;
                    WHERE !EMPTY(codbins) ;
                    GROUP BY codbins ;
                    HAVING SUM(1) > 1 ;
                    INTO CURSOR cursor_4c_DupBINs READWRITE

                IF RECCOUNT("cursor_4c_DupBINs") > 0
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_DupBINs")
                    USE IN cursor_4c_DupBINs
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.ValidarDuplicidade")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarBINs - Exclui BINs antigos e reinsere todos do cursor local
    *--------------------------------------------------------------------------
    FUNCTION SalvarBINs(par_cFpags, par_cCursorBINs)
        LOCAL loc_lSucesso, loc_lErroInsert, loc_cSQL, loc_cChave, loc_oErro
        loc_lSucesso    = .F.
        loc_lErroInsert = .F.
        TRY
            IF THIS.ValidarDuplicidade(par_cCursorBINs)
                loc_cSQL = "DELETE FROM SigOpFpb WHERE fpags = " + EscaparSQL(par_cFpags)
                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    IF USED(par_cCursorBINs)
                        SELECT (par_cCursorBINs)
                        GOTO TOP
                        SCAN WHILE !loc_lErroInsert
                            IF !EMPTY(codbins)
                                loc_cChave = THIS.GerarChavePrimaria()

                                loc_cSQL = "INSERT INTO SigOpFpb " + ;
                                           "(cidchaves, codbins, descs, datais, datafs, fpags) " + ;
                                           "VALUES (" + ;
                                           EscaparSQL(loc_cChave)   + ", " + ;
                                           EscaparSQL(codbins)       + ", " + ;
                                           EscaparSQL(descs)         + ", " + ;
                                           FormatarDataSQL(datais)   + ", " + ;
                                           FormatarDataSQL(datafs)   + ", " + ;
                                           EscaparSQL(par_cFpags)    + ")"

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                    MsgErro("Erro ao salvar BIN: " + ALLTRIM(codbins), ;
                                        "FpbBO.SalvarBINs")
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDSCAN
                        loc_lSucesso = !loc_lErroInsert
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir BINs anteriores da condi" + CHR(231) + CHR(227) + ;
                        "o de pagamento.", "FpbBO.SalvarBINs")
                ENDIF
            ELSE
                MsgAviso("Dados inconsistentes. C" + CHR(243) + "digo BIN em duplicidade!!!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.SalvarBINs")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChavePrimaria - Gera chave unica de 20 chars (substitui fUniqueIds)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChavePrimaria()
        LOCAL loc_cTs, loc_cRand, loc_cChave
        loc_cTs    = TTOC(DATETIME(), 1)
        loc_cRand  = TRANSFORM(INT(RAND() * 999999), "999999")
        loc_cChave = LEFT(loc_cTs + loc_cRand, 20)
        RETURN loc_cChave
    ENDFUNC

ENDDEFINE

