# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'OptConta' (parent: SIGPDMPF.Container1): Top original=114 vs migrado 'obj_4c_OptConta' Top=5 (diff=109px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptConta' (parent: SIGPDMPF.Container1): Left original=100 vs migrado 'obj_4c_OptConta' Left=5 (diff=95px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMpf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1332 linhas total):

*-- Linhas 42 a 50:
42:         ENDIF
43: 
44:         TRY
45:             THIS.Caption = "Movimenta" + CHR(231) + CHR(245) + "es de produ" + ;
46:                            CHR(231) + CHR(227) + "o por funcion" + CHR(225) + "rio"
47:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
48: 
49:             THIS.ConfigurarPageFrame()
50:             THIS.ConfigurarPaginaLista()

*-- Linhas 172 a 217:
172:     PROTECTED PROCEDURE ConfigurarCabecalho()
173:         THIS.AddObject("cnt_4c_Sombra", "Container")
174:         WITH THIS.cnt_4c_Sombra
175:             .Top         = 0
176:             .Left        = 0
177:             .Width       = THIS.Width
178:             .Height      = 80
179:             .BorderWidth = 0
180:             .BackColor   = RGB(100, 100, 100)
181:             .Visible     = .T.
182:         ENDWITH
183: 
184:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
185:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
186:             .FontBold  = .T.
187:             .FontName  = "Tahoma"
188:             .FontSize  = 18
189:             .WordWrap  = .T.
190:             .Alignment = 0
191:             .BackStyle = 0
192:             .Caption   = THIS.Caption
193:             .Height    = 40
194:             .Left      = 10
195:             .Top       = 18
196:             .Width     = 769
197:             .ForeColor = RGB(0, 0, 0)
198:             .Visible   = .T.
199:         ENDWITH
200: 
201:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
202:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
203:             .FontBold  = .T.
204:             .FontName  = "Tahoma"
205:             .FontSize  = 18
206:             .WordWrap  = .T.
207:             .Alignment = 0
208:             .BackStyle = 0
209:             .Caption   = THIS.Caption
210:             .Height    = 46
211:             .Left      = 10
212:             .Top       = 17
213:             .Width     = 769
214:             .ForeColor = RGB(255, 255, 255)
215:             .Visible   = .T.
216:         ENDWITH
217:     ENDPROC

*-- Linhas 226 a 235:
226: 
227:         THIS.AddObject("cnt_4c_Filtros", "Container")
228:         WITH THIS.cnt_4c_Filtros
229:             .Top           = 92
230:             .Left          = 151
231:             .Width         = 498
232:             .Height        = 141
233:             .BackStyle     = 0
234:             .BorderWidth   = 0
235:             .SpecialEffect = 2

*-- Linhas 241 a 255:
241:         loc_oCnt = THIS.cnt_4c_Filtros
242: 
243:         *-- Label "Per?odo :" (lbl_periodo)
244:         loc_oCnt.AddObject("lbl_4c_Lbl_periodo", "Label")
245:         WITH loc_oCnt.lbl_4c_Lbl_periodo
246:             .AutoSize  = .T.
247:             .Caption   = "Per" + CHR(237) + "odo :"
248:             .Height    = 15
249:             .Left      = 61
250:             .Top       = 13
251:             .Width     = 45
252:             .FontName  = "Tahoma"
253:             .FontSize  = 8
254:             .BackStyle = 0
255:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 262 a 286:
262:             .FontSize      = 8
263:             .Format        = "K"
264:             .Height        = 25
265:             .Left          = 108
266:             .SpecialEffect = 1
267:             .Top           = 9
268:             .Width         = 80
269:             .ForeColor     = RGB(0, 0, 0)
270:             .BorderColor   = RGB(100, 100, 100)
271:             .Themes        = .F.
272:             .Value         = DATE()
273:         ENDWITH
274: 
275:         *-- Label "?" separador entre datas (lbl_periodo_a)
276:         loc_oCnt.AddObject("lbl_4c_Lbl_periodo_a", "Label")
277:         WITH loc_oCnt.lbl_4c_Lbl_periodo_a
278:             .AutoSize  = .T.
279:             .Caption   = CHR(224)
280:             .Left      = 193
281:             .Top       = 13
282:             .Width     = 8
283:             .FontName  = "Tahoma"
284:             .FontSize  = 8
285:             .BackStyle = 0
286:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 293 a 318:
293:             .FontSize      = 8
294:             .Format        = "K"
295:             .Height        = 25
296:             .Left          = 206
297:             .SpecialEffect = 1
298:             .Top           = 9
299:             .Width         = 80
300:             .ForeColor     = RGB(0, 0, 0)
301:             .BorderColor   = RGB(100, 100, 100)
302:             .Themes        = .F.
303:             .Value         = DATE()
304:         ENDWITH
305: 
306:         *-- Label "Movimenta??o :" (Say1)
307:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
308:         WITH loc_oCnt.lbl_4c_Label1
309:             .AutoSize  = .T.
310:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
311:             .Height    = 15
312:             .Left      = 28
313:             .Top       = 40
314:             .Width     = 78
315:             .FontName  = "Tahoma"
316:             .FontSize  = 8
317:             .BackStyle = 0
318:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 325 a 351:
325:             .FontSize      = 8
326:             .Format        = "K!"
327:             .Height        = 25
328:             .Left          = 108
329:             .MaxLength     = 20
330:             .SpecialEffect = 1
331:             .Top           = 36
332:             .Width         = 150
333:             .ForeColor     = RGB(0, 0, 0)
334:             .BorderColor   = RGB(100, 100, 100)
335:             .Themes        = .F.
336:             .Value         = ""
337:         ENDWITH
338: 
339:         *-- Label "Grupo :" (Say3)
340:         loc_oCnt.AddObject("lbl_4c_Label3", "Label")
341:         WITH loc_oCnt.lbl_4c_Label3
342:             .AutoSize  = .T.
343:             .Caption   = "Grupo :"
344:             .Height    = 15
345:             .Left      = 68
346:             .Top       = 67
347:             .Width     = 38
348:             .FontName  = "Tahoma"
349:             .FontSize  = 8
350:             .BackStyle = 0
351:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 357 a 367:
357:             .FontName      = "Tahoma"
358:             .FontSize      = 8
359:             .Height        = 23
360:             .Left          = 108
361:             .SpecialEffect = 1
362:             .Top           = 63
363:             .Width         = 80
364:             .ForeColor     = RGB(0, 0, 0)
365:             .BorderColor   = RGB(100, 100, 100)
366:             .Themes        = .F.
367:             .Value         = ""

*-- Linhas 374 a 402:
374:             .FontName          = "Tahoma"
375:             .FontSize          = 8
376:             .Height            = 23
377:             .Left              = 189
378:             .MaxLength         = 40
379:             .SpecialEffect     = 1
380:             .Top               = 63
381:             .Width             = 302
382:             .ForeColor         = RGB(0, 0, 0)
383:             .DisabledBackColor = RGB(255, 255, 255)
384:             .DisabledForeColor = RGB(0, 0, 128)
385:             .BorderColor       = RGB(100, 100, 100)
386:             .Themes            = .F.
387:             .Value             = ""
388:         ENDWITH
389: 
390:         *-- Label "Conta :" (Say2)
391:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
392:         WITH loc_oCnt.lbl_4c_Label2
393:             .AutoSize  = .T.
394:             .Caption   = "Conta :"
395:             .Height    = 15
396:             .Left      = 68
397:             .Top       = 93
398:             .Width     = 38
399:             .FontName  = "Tahoma"
400:             .FontSize  = 8
401:             .BackStyle = 0
402:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 408 a 418:
408:             .FontName      = "Tahoma"
409:             .FontSize      = 8
410:             .Height        = 23
411:             .Left          = 108
412:             .SpecialEffect = 1
413:             .Top           = 89
414:             .Width         = 80
415:             .ForeColor     = RGB(0, 0, 0)
416:             .BorderColor   = RGB(100, 100, 100)
417:             .Themes        = .F.
418:             .Value         = ""

*-- Linhas 425 a 450:
425:             .FontName      = "Tahoma"
426:             .FontSize      = 8
427:             .Height        = 23
428:             .Left          = 189
429:             .SpecialEffect = 1
430:             .Top           = 89
431:             .Width         = 303
432:             .ForeColor     = RGB(0, 0, 0)
433:             .BorderColor   = RGB(100, 100, 100)
434:             .Themes        = .F.
435:             .Value         = ""
436:         ENDWITH
437: 
438:         *-- Label "Filtrar por :" (Say4)
439:         loc_oCnt.AddObject("lbl_4c_Label4", "Label")
440:         WITH loc_oCnt.lbl_4c_Label4
441:             .AutoSize  = .T.
442:             .Caption   = "Filtrar por :"
443:             .Height    = 15
444:             .Left      = 50
445:             .Top       = 120
446:             .Width     = 56
447:             .FontName  = "Tahoma"
448:             .FontSize  = 8
449:             .BackStyle = 0
450:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 460 a 502:
460:             .BorderStyle   = 0
461:             .Value         = 3
462:             .Height        = 27
463:             .Left          = 100
464:             .SpecialEffect = 0
465:             .Top           = 114
466:             .Width         = 200
467: 
468:             WITH .Buttons(1)
469:                 .BackStyle = 0
470:                 .Caption   = "Origem"
471:                 .Height    = 15
472:                 .Left      = 5
473:                 .Top       = 5
474:                 .Width     = 52
475:                 .AutoSize  = .T.
476:                 .ForeColor = RGB(90, 90, 90)
477:             ENDWITH
478: 
479:             WITH .Buttons(2)
480:                 .FontName  = "Tahoma"
481:                 .FontSize  = 8
482:                 .BackStyle = 0
483:                 .Caption   = "Destino"
484:                 .Left      = 69
485:                 .Top       = 5
486:                 .AutoSize  = .T.
487:                 .ForeColor = RGB(90, 90, 90)
488:             ENDWITH
489: 
490:             WITH .Buttons(3)
491:                 .FontName  = "Tahoma"
492:                 .FontSize  = 8
493:                 .BackStyle = 0
494:                 .Caption   = "Todos"
495:                 .Height    = 17
496:                 .Left      = 134
497:                 .Top       = 5
498:                 .Width     = 61
499:                 .ForeColor = RGB(90, 90, 90)
500:             ENDWITH
501:         ENDWITH
502: 

*-- Linhas 520 a 598:
520:         *-- (reproduz SpecialEffect=1 + BorderColor do CommandGroup sair do legado)
521:         THIS.AddObject("shp_4c_Saida", "Shape")
522:         WITH THIS.shp_4c_Saida
523:             .Top         = -2
524:             .Left        = 718
525:             .Width       = 87
526:             .Height      = 87
527:             .BackStyle   = 0
528:             .BorderStyle = 0
529:             .BorderColor = RGB(136, 189, 188)
530:             .Visible     = .T.
531:         ENDWITH
532: 
533:         *-- Botao Pesquisar (consulta no legado): Top=3, Left=650
534:         THIS.AddObject("cmd_4c_Pesquisar", "CommandButton")
535:         WITH THIS.cmd_4c_Pesquisar
536:             .Top             = 5
537:             .Left            = 650
538:             .Height          = 75
539:             .Width           = 75
540:             .FontBold        = .T.
541:             .FontItalic      = .T.
542:             .FontName        = "Tahoma"
543:             .FontSize        = 8
544:             .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
545:             .Caption         = "Pesquisar"
546:             .ForeColor       = RGB(90, 90, 90)
547:             .BackColor       = RGB(255, 255, 255)
548:             .SpecialEffect   = 0
549:             .PicturePosition = 13
550:             .Themes          = .F.
551:             .MousePointer    = 15
552:             .WordWrap        = .T.
553:             .AutoSize        = .F.
554:             .Visible         = .T.
555:         ENDWITH
556:         BINDEVENT(THIS.cmd_4c_Pesquisar, "Click", THIS, "CmdPesquisarClick")
557: 
558:         *-- Container Encerrar (sair CommandGroup no legado): Top=-2, Left=720
559:         THIS.AddObject("cnt_4c_Saida", "Container")
560:         WITH THIS.cnt_4c_Saida
561:             .Top         = -2
562:             .Left        = 917
563:             .Width       = 90
564:             .Height      = 85
565:             .BackStyle   = 0
566:             .BorderWidth = 0
567:             .Visible     = .T.
568:         ENDWITH
569: 
570:         THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
571:         WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
572:             .Top             = 5
573:             .Left            = 5
574:             .Height          = 75
575:             .Width           = 75
576:             .FontBold        = .T.
577:             .FontItalic      = .T.
578:             .FontName        = "Tahoma"
579:             .FontSize        = 8
580:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
581:             .Caption         = "Encerrar"
582:             .Cancel          = .T.
583:             .ForeColor       = RGB(90, 90, 90)
584:             .BackColor       = RGB(255, 255, 255)
585:             .SpecialEffect   = 0
586:             .PicturePosition = 13
587:             .Themes          = .F.
588:             .MousePointer    = 15
589:             .WordWrap        = .T.
590:             .AutoSize        = .F.
591:             .Visible         = .T.
592:         ENDWITH
593:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
594:     ENDPROC
595: 
596:     *==========================================================================
597:     * InicializarFiltros - Define valores default dos filtros no BO
598:     * Espelho do bloco With .Container1 do Init() original

*-- Linhas 1281 a 1295:
1281:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1282:         THIS.Enabled = .T.
1283: 
1284:         IF VARTYPE(THIS.cmd_4c_Pesquisar) = "O"
1285:             THIS.cmd_4c_Pesquisar.Enabled = .T.
1286:         ENDIF
1287: 
1288:         IF VARTYPE(THIS.cnt_4c_Saida) = "O" AND ;
1289:            VARTYPE(THIS.cnt_4c_Saida.cmd_4c_Encerrar) = "O"
1290:             THIS.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = .T.
1291:         ENDIF
1292: 
1293:         THIS.HabilitarCampos(.T.)
1294:     ENDPROC
1295: 


### BO (C:\4c\projeto\app\classes\SigPdMpfBO.prg):
*==============================================================================
* SigPdMpfBO.prg - Business Object: Movimentacoes de producao por funcionario
*==============================================================================
* Tabela principal : SigCdNec (movimentacoes)
* Tabela join      : SigCdOpd (operacoes de producao)
* Lookups          : SigCdGcr (grupos), SigCdCli (contas)
* Tipo             : OPERACIONAL (consulta + CRUD em SigCdNec)
*==============================================================================

DEFINE CLASS SigPdMpfBO AS BusinessBase

    *-- Filtros de consulta - Periodo
    this_dDtInicial  = {}
    this_dDtFinal    = {}

    *-- Filtro - Operacao (dopps em SigCdOpd, char(20))
    this_cNmOperacao = ""

    *-- Filtro - Grupo contabil (SigCdGcr.codigos, char(10))
    this_cGrupo      = ""

    *-- Descricao do grupo (SigCdGcr.descrs, char(40))
    this_cDGrupo     = ""

    *-- Filtro - Conta (SigCdCli.IClis, char(10))
    this_cConta      = ""

    *-- Descricao da conta (SigCdCli.RClis)
    this_cDConta     = ""

    *-- Tipo de filtro por conta: 1=Origem, 2=Destino, 3=Todos
    this_nOptConta   = 3

    *-- Propriedades adicionais para CRUD em SigCdNec
    this_cCidChaves  = ""    && PK char(20)
    this_dDatas      = {}    && Data movimentacao
    this_cDopps      = ""    && Operacao char(20)
    this_cEmps       = ""    && Empresa char(3)
    this_cContaOs    = ""    && Conta origem char(10)
    this_cContaDs    = ""    && Conta destino char(10)
    this_cGrupoOs    = ""    && Grupo origem char(10)
    this_cGrupoDs    = ""    && Grupo destino char(10)
    this_nNumps      = 0     && Numero processo numeric(10,0)
    this_nNops       = 0     && Numero operacao numeric(10,0)
    this_cUsuars     = ""    && Usuario char(10)
    this_nTotPesos   = 0     && Total pesos numeric(11,3)
    this_cDocus      = ""    && Documento char(10)
    this_cLocals     = ""    && Local char(10)
    this_cEmpDnps    = ""    && char(33) - empresa+doc+nump
    this_cJobs       = ""    && Job char(10)

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdNec"
        THIS.this_cCampoChave = "cidchaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCampoChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor SigCdNec para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Chave primaria
                IF TYPE(par_cAliasCursor + ".cidchaves") != "U"
                    THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                ENDIF

                *-- Data movimentacao
                IF TYPE(par_cAliasCursor + ".datas") != "U"
                    THIS.this_dDatas = TratarNulo(datas, "D")
                ENDIF

                *-- Operacao
                IF TYPE(par_cAliasCursor + ".dopps") != "U"
                    THIS.this_cDopps = TratarNulo(dopps, "C")
                ENDIF

                *-- Empresa
                IF TYPE(par_cAliasCursor + ".emps") != "U"
                    THIS.this_cEmps = TratarNulo(emps, "C")
                ENDIF

                *-- Contas
                IF TYPE(par_cAliasCursor + ".contaos") != "U"
                    THIS.this_cContaOs = TratarNulo(contaos, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".contads") != "U"
                    THIS.this_cContaDs = TratarNulo(contads, "C")
                ENDIF

                *-- Grupos
                IF TYPE(par_cAliasCursor + ".grupoos") != "U"
                    THIS.this_cGrupoOs = TratarNulo(grupoos, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".grupods") != "U"
                    THIS.this_cGrupoDs = TratarNulo(grupods, "C")
                ENDIF

                *-- Numericos
                IF TYPE(par_cAliasCursor + ".numps") != "U"
                    THIS.this_nNumps = TratarNulo(numps, "N")
                ENDIF
                IF TYPE(par_cAliasCursor + ".nops") != "U"
                    THIS.this_nNops = TratarNulo(nops, "N")
                ENDIF
                IF TYPE(par_cAliasCursor + ".totpesos") != "U"
                    THIS.this_nTotPesos = TratarNulo(totpesos, "N")
                ENDIF

                *-- Outros
                IF TYPE(par_cAliasCursor + ".usuars") != "U"
                    THIS.this_cUsuars = TratarNulo(usuars, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".docus") != "U"
                    THIS.this_cDocus = TratarNulo(docus, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".locals") != "U"
                    THIS.this_cLocals = TratarNulo(locals, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".empdnps") != "U"
                    THIS.this_cEmpDnps = TratarNulo(empdnps, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".jobs") != "U"
                    THIS.this_cJobs = TratarNulo(jobs, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar (SigCdNec)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_dDatas)
            MsgAviso("Informe a data da movimenta" + CHR(231) + CHR(227) + "o.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDopps))
            MsgAviso("Informe a opera" + CHR(231) + CHR(227) + "o.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
            MsgAviso("Chave da movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova movimentacao em SigCdNec
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = gc_4c_UsuarioLogado
            ENDIF

            *-- Monta empdnps (emps + docus + numps) caso nao informado
            IF EMPTY(ALLTRIM(THIS.this_cEmpDnps))
                THIS.this_cEmpDnps = PADR(ALLTRIM(THIS.this_cEmps),  3) + ;
                                     PADR(ALLTRIM(THIS.this_cDocus), 10) + ;
                                     PADL(ALLTRIM(TRANSFORM(THIS.this_nNumps)), 10, "0")
            ENDIF

            loc_cSQL = "INSERT INTO SigCdNec (" + ;
                       "cidchaves, datas, dopps, emps, " + ;
                       "contaos, contads, grupoos, grupods, " + ;
                       "numps, nops, usuars, totpesos, " + ;
                       "docus, locals, empdnps, jobs, " + ;
                       "chksubn, imprs, lccs, procbals, procdbal, " + ;
                       "retrabs, autos, nconforms, " + ;
                       "grvends, vends, ntrans, naceites, " + ;
                       "libprods, codnconfs, numbalds, numbals, " + ;
                       "codobs, empds, nlotes, pesolancs, " + ;
                       "usulibs, chkbaixa, usuconfs) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(THIS.this_cDopps) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cContaOs) + ", " + ;
                       EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoOs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotPesos) + ", " + ;
                       EscaparSQL(THIS.this_cDocus) + ", " + ;
                       EscaparSQL(THIS.this_cLocals) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDnps) + ", " + ;
                       EscaparSQL(THIS.this_cJobs) + ", " + ;
                       "0, 0, 0, 0, 0, " + ;
                       "0, 0, 0, " + ;
                       "'', '', 0, 0, " + ;
                       "'', '', 0, 0, " + ;
                       "0, '', 0, 0, " + ;
                       "'', 0, '')"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 1
                MsgErro("Falha ao inserir movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("INSERIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza movimentacao em SigCdNec
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdNec SET " + ;
                       "datas = "    + FormatarDataSQL(THIS.this_dDatas)   + ", " + ;
                       "dopps = "    + EscaparSQL(THIS.this_cDopps)        + ", " + ;
                       "emps = "     + EscaparSQL(THIS.this_cEmps)         + ", " + ;
                       "contaos = "  + EscaparSQL(THIS.this_cContaOs)      + ", " + ;
                       "contads = "  + EscaparSQL(THIS.this_cContaDs)      + ", " + ;
                       "grupoos = "  + EscaparSQL(THIS.this_cGrupoOs)      + ", " + ;
                       "grupods = "  + EscaparSQL(THIS.this_cGrupoDs)      + ", " + ;
                       "numps = "    + FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       "nops = "     + FormatarNumeroSQL(THIS.this_nNops)  + ", " + ;
                       "usuars = "   + EscaparSQL(THIS.this_cUsuars)       + ", " + ;
                       "totpesos = " + FormatarNumeroSQL(THIS.this_nTotPesos) + ", " + ;
                       "docus = "    + EscaparSQL(THIS.this_cDocus)        + ", " + ;
                       "locals = "   + EscaparSQL(THIS.this_cLocals)       + ", " + ;
                       "empdnps = "  + EscaparSQL(THIS.this_cEmpDnps)      + ", " + ;
                       "jobs = "     + EscaparSQL(THIS.this_cJobs)         + " "  + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 1
                MsgErro("Falha ao atualizar movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("ATUALIZAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui movimentacao de SigCdNec pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Chave da movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCdNec WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 1
                MsgErro("Falha ao excluir movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("EXCLUIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de executar a consulta
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarFiltros()
        IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
            MsgAviso("Informe o per" + CHR(237) + "odo de consulta.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            MsgAviso("Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! Data Final Menor Que a Data Inicial!!!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConstruirSQL - Monta a query de consulta de movimentacoes por funcionario
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConstruirSQL()
        LOCAL loc_cSQL, loc_cWhere, loc_cGrupo, loc_cConta, loc_cOper
        LOCAL loc_cDtIni, loc_cDtFim

        loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
        loc_cConta = ALLTRIM(THIS.this_cConta)
        loc_cOper  = ALLTRIM(THIS.this_cNmOperacao)

        *-- Formata datas: inicio com hora 00:00:00, fim com 23:59:59
        loc_cDtIni = "'" + ;
            PADL(YEAR(THIS.this_dDtInicial),  4, "0") + "-" + ;
            PADL(MONTH(THIS.this_dDtInicial), 2, "0") + "-" + ;
            PADL(DAY(THIS.this_dDtInicial),   2, "0") + " 00:00:00'"

        loc_cDtFim = "'" + ;
            PADL(YEAR(THIS.this_dDtFinal),  4, "0") + "-" + ;
            PADL(MONTH(THIS.this_dDtFinal), 2, "0") + "-" + ;
            PADL(DAY(THIS.this_dDtFinal),   2, "0") + " 23:59:59'"

        *-- Monta clausula WHERE para filtro de conta/grupo conforme optConta
        DO CASE
            CASE THIS.this_nOptConta = 1   && Origem
                loc_cWhere = "(a.grupoos = " + EscaparSQL(loc_cGrupo) + ;
                             " AND a.contaos = " + EscaparSQL(loc_cConta) + ")"
            CASE THIS.this_nOptConta = 2   && Destino
                loc_cWhere = "(a.grupods = " + EscaparSQL(loc_cGrupo) + ;
                             " AND a.contads = " + EscaparSQL(loc_cConta) + ")"
            OTHERWISE                       && Todos
                loc_cWhere = "((a.grupoos = " + EscaparSQL(loc_cGrupo) + ;
                             " OR a.grupods = " + EscaparSQL(loc_cGrupo) + ") AND " + ;
                             "(a.contaos = " + EscaparSQL(loc_cConta) + ;
                             " OR a.contads = " + EscaparSQL(loc_cConta) + "))"
        ENDCASE

        *-- Filtro de operacao: sem operacao busca apenas grcomps=1, com operacao filtra por dopps
        LOCAL loc_cFiltroOper
        IF EMPTY(loc_cOper)
            loc_cFiltroOper = "o.grcomps = 1"
        ELSE
            loc_cFiltroOper = "a.dopps = " + EscaparSQL(loc_cOper)
        ENDIF

        *-- Monta SQL completo (equivalente ao legado: SELECT a.*)
        loc_cSQL = "SELECT a.* " + ;
                   "FROM SigCdNec a, SigCdOpd o " + ;
                   "WHERE a.datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " " + ;
                   "AND a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " " + ;
                   "AND a.dopps = o.dopps " + ;
                   "AND " + loc_cFiltroOper + " " + ;
                   "AND " + loc_cWhere

        RETURN loc_cSQL
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarConsulta - Executa a consulta e retorna a SQL string se houver
    *                    registros (vazia em caso de erro ou sem resultados)
    *--------------------------------------------------------------------------
    FUNCTION ExecutarConsulta()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.
        loc_cSQL     = ""

        TRY
            IF !THIS.ValidarFiltros()
                loc_lSucesso = ""
            ENDIF

            loc_cSQL = THIS.ConstruirSQL()

            *-- Fecha cursor temporario anterior se existir
            IF USED("cursor_4c_TmpConsulta")
                USE IN cursor_4c_TmpConsulta
            ENDIF

            *-- Executa para verificar se ha registros
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpConsulta")

            IF loc_nResult < 1
                MsgErro("Falha ao executar consulta de movimenta" + CHR(231) + CHR(245) + "es.", "Erro")
                loc_lSucesso = ""
            ENDIF

            SELECT cursor_4c_TmpConsulta
            IF RECCOUNT() = 0
                IF USED("cursor_4c_TmpConsulta")
                    USE IN cursor_4c_TmpConsulta
                ENDIF
                MsgAviso("Nenhum Registro Selecionado!!!", "Consulta")
                loc_lSucesso = ""
            ENDIF

            IF USED("cursor_4c_TmpConsulta")
                USE IN cursor_4c_TmpConsulta
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF loc_lSucesso
            RETURN loc_cSQL
        ENDIF
        RETURN ""
    ENDFUNC

ENDDEFINE

