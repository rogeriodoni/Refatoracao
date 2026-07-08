# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 428: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 447: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 465: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReCmg.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1533 linhas total):

*-- Linhas 81 a 89:
81:             THIS.LockScreen = .T.
82: 
83:             *-- Titulo do form
84:             THIS.Caption = "Gr" + CHR(225) + "fico dos Clientes que Mais Compram"
85: 
86:             *-- Coordena layout do form (form OPERACIONAL sem PageFrame)
87:             THIS.ConfigurarPageFrame()
88: 
89:             *-- Configura "Page1/Lista" (cabecalho + indicador de processamento)

*-- Linhas 200 a 305:
200:         IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
201:             THIS.txt_4c_NumGraficos.ZOrder(0)
202:         ENDIF
203:         IF PEMSTATUS(THIS, "lbl_4c_LabelNumGrf", 5)
204:             THIS.lbl_4c_LabelNumGrf.ZOrder(0)
205:         ENDIF
206:     ENDPROC
207: 
208:     *==========================================================================
209:     * ConfigurarCabecalho - cntSombra com lblSombra e lblTitulo
210:     *==========================================================================
211:     PROTECTED PROCEDURE ConfigurarCabecalho()
212:         THIS.AddObject("cnt_4c_Sombra", "Container")
213:         WITH THIS.cnt_4c_Sombra
214:             .Top         = 0
215:             .Left        = 0
216:             .Width       = THIS.Width
217:             .Height      = 80
218:             .BorderWidth = 0
219:             .BackStyle   = 1
220:             .BackColor   = RGB(100,100,100)
221:             .Visible     = .T.
222: 
223:             .AddObject("lbl_4c_LblSombra", "Label")
224:             WITH .lbl_4c_LblSombra
225:                 .FontBold   = .T.
226:                 .FontName   = "Tahoma"
227:                 .FontSize   = 18
228:                 .WordWrap   = .T.
229:                 .Alignment  = 0
230:                 .BackStyle  = 0
231:                 .Height     = 40
232:                 .Left       = 10
233:                 .Top        = 18
234:                 .Width      = THIS.Width
235:                 .ForeColor  = RGB(0,0,0)
236:                 .Caption    = THIS.Parent.Parent.Caption
237:                 .Visible    = .T.
238:             ENDWITH
239: 
240:             .AddObject("lbl_4c_LblTitulo", "Label")
241:             WITH .lbl_4c_LblTitulo
242:                 .FontBold   = .T.
243:                 .FontName   = "Tahoma"
244:                 .FontSize   = 18
245:                 .WordWrap   = .T.
246:                 .Alignment  = 0
247:                 .BackStyle  = 0
248:                 .Height     = 46
249:                 .Left       = 10
250:                 .Top        = 17
251:                 .Width      = THIS.Width
252:                 .ForeColor  = RGB(255,255,255)
253:                 .Caption    = THIS.Parent.Parent.Caption
254:                 .Visible    = .T.
255:             ENDWITH
256:         ENDWITH
257:     ENDPROC
258: 
259:     *==========================================================================
260:     * ConfigurarContainerAguarde - cntAguarde (visivel durante processamento)
261:     *==========================================================================
262:     PROTECTED PROCEDURE ConfigurarContainerAguarde()
263:         THIS.AddObject("cnt_4c_Aguarde", "Container")
264:         WITH THIS.cnt_4c_Aguarde
265:             .Top          = 314
266:             .Left         = 295
267:             .Width        = 207
268:             .Height       = 49
269:             .SpecialEffect = 0
270:             .BackStyle    = 1
271:             .BackColor    = RGB(255,255,255)
272:             .Visible      = .F.
273: 
274:             .AddObject("lbl_4c_Label1Agu", "Label")
275:             WITH .lbl_4c_Label1Agu
276:                 .FontBold   = .T.
277:                 .FontName   = "Tahoma"
278:                 .FontSize   = 10
279:                 .BackStyle  = 0
280:                 .Caption    = "Aguarde..."
281:                 .Height     = 18
282:                 .Left       = 69
283:                 .Top        = 7
284:                 .Width      = 68
285:                 .ForeColor  = RGB(90,90,90)
286:                 .Visible    = .T.
287:             ENDWITH
288: 
289:             .AddObject("lbl_4c_Label2Agu", "Label")
290:             WITH .lbl_4c_Label2Agu
291:                 .AutoSize   = .T.
292:                 .FontBold   = .T.
293:                 .FontName   = "Tahoma"
294:                 .FontSize   = 10
295:                 .Alignment  = 0
296:                 .BackStyle  = 0
297:                 .Caption    = "Processando Dados..."
298:                 .Height     = 18
299:                 .Left       = 24
300:                 .Top        = 24
301:                 .Width      = 141
302:                 .ForeColor  = RGB(90,90,90)
303:                 .Visible    = .T.
304:             ENDWITH
305:         ENDWITH

*-- Linhas 311 a 331:
311:     PROTECTED PROCEDURE ConfigurarContainerGrafico()
312:         THIS.AddObject("cnt_4c_Grf1", "Container")
313:         WITH THIS.cnt_4c_Grf1
314:             .Top          = 202
315:             .Left         = 14
316:             .Width        = 770
317:             .Height       = 400
318:             .BackStyle    = 1
319:             .SpecialEffect = 0
320:             .BackColor    = RGB(255,255,255)
321:             .Visible      = .F.
322: 
323:             .AddObject("obj_4c_OleGrafico1", "OleBoundControl")
324:             WITH .obj_4c_OleGrafico1
325:                 .Top     = 5
326:                 .Left    = 5
327:                 .Height  = 390
328:                 .Width   = 760
329:                 .Visible = .T.
330:             ENDWITH
331:         ENDWITH

*-- Linhas 337 a 363:
337:     PROTECTED PROCEDURE ConfigurarContainerControles()
338:         THIS.AddObject("cnt_4c_Grf2", "Container")
339:         WITH THIS.cnt_4c_Grf2
340:             .Top          = 94
341:             .Left         = 128
342:             .Width        = 200
343:             .Height       = 35
344:             .SpecialEffect = 0
345:             .BackStyle    = 1
346:             .BackColor    = RGB(255,255,255)
347:             .Visible      = .F.
348: 
349:             .AddObject("lbl_4c_LblChave1", "Label")
350:             WITH .lbl_4c_LblChave1
351:                 .AutoSize  = .T.
352:                 .FontName  = "Tahoma"
353:                 .FontSize  = 8
354:                 .BackStyle = 0
355:                 .Caption   = "Cliente :"
356:                 .Height    = 15
357:                 .Left      = 32
358:                 .Top       = 8
359:                 .Width     = 42
360:                 .ForeColor = RGB(90,90,90)
361:                 .Visible   = .T.
362:             ENDWITH
363: 

*-- Linhas 374 a 383:
374:                 .Sorted          = .F.
375:                 .SpecialEffect   = 0
376:                 .Height          = 25
377:                 .Left            = 81
378:                 .Top             = 4
379:                 .Width           = 86
380:                 .Visible         = .T.
381:             ENDWITH
382:         ENDWITH
383:     ENDPROC

*-- Linhas 392 a 474:
392:             .BackStyle     = 0
393:             .BorderStyle   = 0
394:             .Height        = 85
395:             .Left          = 491
396:             .SpecialEffect = 1
397:             .Top           = -2
398:             .Width         = 313
399:             .Themes        = .F.
400:             .Visible       = .F.
401: 
402:             *-- Botao 1: Anterior
403:             WITH .Buttons(1)
404:                 .Top        = 5
405:                 .Left       = 5
406:                 .Height     = 75
407:                 .Width      = 75
408:                 .FontBold   = .T.
409:                 .FontItalic = .T.
410:                 .WordWrap   = .T.
411:                 .Picture    = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
412:                 .Caption    = "\<Anterior"
413:                 .ForeColor  = RGB(90,90,90)
414:                 .BackColor  = RGB(255,255,255)
415:                 .Themes     = .F.
416:                 .Enabled    = .F.
417:             ENDWITH
418: 
419:             *-- Botao 2: Proximo
420:             WITH .Buttons(2)
421:                 .Top        = 5
422:                 .Left       = 81
423:                 .Height     = 75
424:                 .Width      = 75
425:                 .FontBold   = .T.
426:                 .FontItalic = .T.
427:                 .FontName   = "Comic Sans MS"
428:                 .FontSize   = 8
429:                 .WordWrap   = .T.
430:                 .Picture    = gc_4c_CaminhoIcones + "geral_seta_dir_60.jpg"
431:                 .Caption    = "Pr" + CHR(243) + "ximo"
432:                 .ForeColor  = RGB(90,90,90)
433:                 .BackColor  = RGB(255,255,255)
434:                 .Themes     = .F.
435:                 .Enabled    = .F.
436:             ENDWITH
437: 
438:             *-- Botao 3: Imprimir (grafico pizza)
439:             WITH .Buttons(3)
440:                 .Top        = 5
441:                 .Left       = 157
442:                 .Height     = 75
443:                 .Width      = 75
444:                 .FontBold   = .T.
445:                 .FontItalic = .T.
446:                 .FontName   = "Comic Sans MS"
447:                 .FontSize   = 8
448:                 .WordWrap   = .T.
449:                 .Picture    = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
450:                 .Caption    = "Gr" + CHR(225) + "fico"
451:                 .ForeColor  = RGB(90,90,90)
452:                 .BackColor  = RGB(255,255,255)
453:                 .Themes     = .F.
454:             ENDWITH
455: 
456:             *-- Botao 4: Encerrar/Sair
457:             WITH .Buttons(4)
458:                 .Top        = 5
459:                 .Left       = 233
460:                 .Height     = 75
461:                 .Width      = 75
462:                 .FontBold   = .T.
463:                 .FontItalic = .T.
464:                 .FontName   = "Comic Sans MS"
465:                 .FontSize   = 8
466:                 .WordWrap   = .T.
467:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
468:                 .Cancel     = .T.
469:                 .Caption    = "Encerrar"
470:                 .ForeColor  = RGB(90,90,90)
471:                 .BackColor  = RGB(255,255,255)
472:                 .Themes     = .F.
473:             ENDWITH
474:         ENDWITH

*-- Linhas 484 a 504:
484:     * ConfigurarControlesAdicionais - chkGraficos, NumGraficos, Label1
485:     *==========================================================================
486:     PROTECTED PROCEDURE ConfigurarControlesAdicionais()
487:         *-- CheckBox: Todos os Graficos
488:         THIS.AddObject("chk_4c_ChkGraficos", "CheckBox")
489:         WITH THIS.chk_4c_ChkGraficos
490:             .Top          = 133
491:             .Left         = 146
492:             .Height       = 17
493:             .Width        = 122
494:             .FontName     = "Tahoma"
495:             .FontSize     = 8
496:             .AutoSize     = .F.
497:             .Alignment    = 0
498:             .BackStyle    = 0
499:             .Caption      = "Todos os Gr" + CHR(225) + "ficos"
500:             .SpecialEffect = 0
501:             .Style        = 0
502:             .ForeColor    = RGB(90,90,90)
503:             .Value        = 0
504:             .Visible      = .F.

*-- Linhas 511 a 536:
511:             .Value      = 1
512:             .Height     = 23
513:             .InputMask  = "9999"
514:             .Left       = 267
515:             .MaxLength  = 4
516:             .Top        = 157
517:             .Width      = 38
518:             .Visible    = .T.
519:         ENDWITH
520: 
521:         *-- Label: "A partir do Grafico"
522:         THIS.AddObject("lbl_4c_LabelNumGrf", "Label")
523:         WITH THIS.lbl_4c_LabelNumGrf
524:             .AutoSize   = .F.
525:             .FontName   = "Tahoma"
526:             .FontSize   = 8
527:             .BackStyle  = 0
528:             .Caption    = "A partir do Gr" + CHR(225) + "fico : "
529:             .Height     = 17
530:             .Left       = 166
531:             .Top        = 161
532:             .Width      = 117
533:             .ForeColor  = RGB(90,90,90)
534:             .Visible    = .T.
535:         ENDWITH
536:     ENDPROC

*-- Linhas 605 a 627:
605:                         .SpecialEffect     = 0
606:                         .Width             = (loc_nTmStr1 * 7 + 9) + 20
607:                         .Height            = 25
608:                         .Top               = 5
609:                         .Left              = 5 + THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width
610: 
611:                         FOR loc_nConta1 = 1 TO loc_nTotal
612:                             .AddItem(PADR(STR(loc_aClientes(loc_nConta1,1),5) + CHR(170) + ;
613:                                          loc_aClientes(loc_nConta1,2), loc_nTmStr1))
614:                         ENDFOR
615:                     ENDWITH
616: 
617:                     WITH THIS.cnt_4c_Grf2
618:                         .Height = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Height + 10
619:                         .Width  = THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width + ;
620:                                   THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Width + 10
621:                         .Top    = THIS.obj_4c_CmdGgrafico.Top - .Height
622:                         .Left   = THIS.Width - .Width - 5
623:                         .Visible     = .T.
624:                     ENDWITH
625:                 ENDIF
626:             ENDIF
627: 

*-- Linhas 802 a 811:
802:                                                     loc_nVlGrf1 = 0
803:                                                 ENDIF
804:                                             ENDIF
805:                                             .Top          = .Top - IIF(loc_nVlGrf1 < 0, -10, 10)
806:                                             .Caption      = ALLTRIM(STR(loc_nVlGrf1, 20, 2))
807:                                             .NumberFormat = "###,###,###,##0.00"
808:                                             .Font.Name    = "Arial"
809:                                             .Font.Size    = 8
810:                                             .Font.Bold    = .T.
811:                                             .Font.Shadow  = .F.

*-- Linhas 1244 a 1252:
1244: 
1245:     *==========================================================================
1246:     * LimparCampos - Reseta controles do form para estado inicial
1247:     * Limpa o ControlSource do grafico OLE, reseta combo e checkbox.
1248:     * Chamado ao fechar ou reabrir o form com novos dados.
1249:     *==========================================================================
1250:     PROTECTED PROCEDURE LimparCampos()
1251:         IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
1252:            PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)

*-- Linhas 1297 a 1305:
1297:             ENDIF
1298:         ENDIF
1299: 
1300:         *-- Checkbox e textbox de impressao dependem da disponibilidade do combo
1301:         IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5) AND ;
1302:            PEMSTATUS(THIS, "cnt_4c_Grf2", 5)
1303:             THIS.chk_4c_ChkGraficos.Enabled = ;
1304:                 (THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0)
1305:         ENDIF


### BO (C:\4c\projeto\app\classes\SigReCmgBO.prg):
*==============================================================================
* SigReCmgBO.prg
* Business Object: Grafico Clientes que Mais Compram (SIGRECMG)
* Herda de: BusinessBase
* Tipo: OPERACIONAL - subformulario de exibicao de grafico
* Sem tabela direta (dados vem de TmpResult do formulario pai)
*==============================================================================

DEFINE CLASS SigReCmgBO AS BusinessBase

    *-- Identificacao
    this_cTabela          = ""
    this_cCampoChave      = ""

    *-- Estado do grafico
    this_nNumGrafico      = 0      && Posicao atual do grafico exibido (1-3)
    this_lTodosGraficos   = .F.    && Imprimir todos os graficos em sequencia
    this_nInicioGrafico   = 1      && Grafico inicial para impressao em lote
    this_cChaveAtual      = ""     && Chave selecionada no combo (ordem + nome cliente)

    *-- Titulos do grafico (lidos de TmpResult ao gerar cada grafico)
    this_cTitulo1         = ""
    this_cTitulo2         = ""
    this_cTitulo3         = ""
    this_cTitulo4         = ""
    this_cEmpresaGrafico  = ""

    *==========================================================================
    * Init - Inicializa o BO sem tabela direta (form operacional)
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Obrigatorio para sistema de auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaveAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Atualizar - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * InicializarCursorGrafico - Cria cursor CrGrafico1 se nao existe
    * Estrutura IDENTICA ao original (BeforeOpenTables/mGeraGrafico)
    *==========================================================================
    PROCEDURE InicializarCursorGrafico()
        IF !USED("CrGrafico1")
            SET NULL ON
            CREATE CURSOR CrGrafico1 (;
                gGrafico1s G(4),;
                cChave1s   C(100),;
                cEmpresas  C(128),;
                cTitulo1s  C(64),;
                cTitulo2s  C(64),;
                cTitulo3s  C(64),;
                cTitulo4s  C(64))
            SET NULL OFF
            INDEX ON cChave1s TAG pkchave1
        ENDIF
    ENDPROC

    *==========================================================================
    * ZerarCursorGrafico - Limpa CrGrafico1 para regerar graficos
    *==========================================================================
    PROCEDURE ZerarCursorGrafico()
        IF USED("CrGrafico1")
            SELECT CrGrafico1
            ZAP
        ENDIF
    ENDPROC

    *==========================================================================
    * FecharCursores - Fecha cursores locais do grafico
    *==========================================================================
    PROCEDURE FecharCursores()
        IF USED("CrGrafico1")
            USE IN CrGrafico1
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarClientesTmpResult - Busca clientes distintos de TmpResult
    * Popula par_aClientes com [Ordem, Crclis] ordenado por Ordem
    * Retorna numero de clientes encontrados (0 se TmpResult nao existe)
    *==========================================================================
    PROCEDURE BuscarClientesTmpResult(par_aClientes)
        LOCAL loc_nTotal, loc_oErro
        loc_nTotal = 0

        TRY
            IF USED("TmpResult")
                SELECT DISTINCT Ordem, Crclis ;
                  FROM TmpResult ;
                 ORDER BY Ordem ;
                  INTO ARRAY par_aClientes

                loc_nTotal = ALEN(par_aClientes, 1)
                THIS.this_cChaveAtual = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * ObterTitulosGrafico - Le titulos e empresa de TmpResult pela chave
    * par_cChave1 = item do combo (5 chars ordem + separador + nome cliente)
    * Popula this_cTitulo1..4 e this_cEmpresaGrafico
    *==========================================================================
    PROCEDURE ObterTitulosGrafico(par_cChave1)
        LOCAL loc_nOrdem, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_nOrdem = VAL(LEFT(par_cChave1, 5))

            IF USED("TmpResult")
                SELECT TmpResult
                SET ORDER TO ""
                LOCATE FOR TmpResult.ordem = loc_nOrdem

                IF !EOF()
                    THIS.this_cTitulo1        = ALLTRIM(TmpResult.cTitulo1s)
                    THIS.this_cTitulo2        = ALLTRIM(TmpResult.cTitulo2s)
                    THIS.this_cTitulo3        = ALLTRIM(TmpResult.cTitulo3s)
                    THIS.this_cTitulo4        = ALLTRIM(TmpResult.cTitulo4s)
                    THIS.this_cEmpresaGrafico = ALLTRIM(TmpResult.cEmpresas)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PrepararDadosGrafico - Prepara e insere dados no CrGrafico1
    * par_cChave2     = chave composta (chave1 + nome do eixo para o grafico N)
    * par_nContaGrafico = 1, 2 ou 3
    * par_nQtVal      = 1=Valor, 2=Quantidade (do OptionGroup Opt_SelRel do pai)
    * par_cStrgeixoY  = string do eixo Y com 3 nomes de 10 chars cada
    * Retorna .T. se CrGrafico1 preparado (novo ou ja existente)
    *==========================================================================
    PROCEDURE PrepararDadosGrafico(par_cChave2, par_nContaGrafico, par_nQtVal, par_cStrgeixoY)
        LOCAL loc_lResultado, loc_cStrg1, loc_cStrg2, loc_nVlGrf1
        LOCAL loc_cStrgeixoX, loc_nNlegenda1, loc_nConta2, loc_oErro
        LOCAL loc_cCampValComp, loc_cCampValAno
        loc_lResultado = .F.

        TRY
            THIS.InicializarCursorGrafico()

            *-- Verifica se o grafico ja foi gerado para esta chave
            SELECT CrGrafico1
            LOCATE FOR CrGrafico1.cChave1s = PADR(par_cChave2, 100)

            IF !EOF()
                loc_lResultado = .T.
            ELSE
                IF USED("TmpResult")
                    *-- Titulo do eixo X (nome do tipo de grafico)
                    loc_cStrg1 = CHR(9) + PROPER(ALLTRIM(SUBSTR(par_cStrgeixoY, (par_nContaGrafico * 10 - 9), 10)))

                    *-- Campos conforme tipo Valor/Quantidade
                    loc_cCampValComp = ALLTRIM(SUBSTR("ncomprasordem   " + IIF(par_nQtVal = 1, "nvalcomp", "nqtde   "), (par_nContaGrafico * 8 - 7), 8))
                    loc_cCampValAno  = ALLTRIM(SUBSTR("ncompra ordem   " + IIF(par_nQtVal = 1, "nvalano ", "nqtdano "), (par_nContaGrafico * 8 - 7), 8))

                    *-- Linha geral (total do ranking)
                    loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValComp)
                    loc_cStrg2  = "Geral" + CHR(9) + ;
                                  ALLTRIM(TRANSFORM(IIF(par_nContaGrafico = 2, TmpResult.MaxOrdem - loc_nVlGrf1 + 1, loc_nVlGrf1), "999,999,999,999")) + ;
                                  CHR(13) + CHR(10)

                    *-- Linhas por ano (ate 7 anos)
                    loc_cStrgeixoX = TmpResult.cStrAno1s
                    loc_nNlegenda1 = 7

                    FOR loc_nConta2 = 1 TO loc_nNlegenda1
                        IF !EMPTY(SUBSTR(loc_cStrgeixoX, (loc_nConta2 * 4 - 3), 4))
                            loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValAno + ALLTRIM(STR(loc_nConta2, 20, 0)))
                            loc_cStrg2  = loc_cStrg2 + ;
                                          PROPER(ALLTRIM(SUBSTR(loc_cStrgeixoX, (loc_nConta2 * 4 - 3), 4))) + ;
                                          CHR(9) + ;
                                          ALLTRIM(TRANSFORM(IIF(par_nContaGrafico = 2, TmpResult.MaxOrdem - loc_nVlGrf1 + 1, loc_nVlGrf1), "999,999,999,999")) + ;
                                          CHR(13) + CHR(10)
                        ENDIF
                    ENDFOR

                    *-- Insere estrutura no CrGrafico1 com titulos e dados OLE
                    SELECT CrGrafico1
                    INSERT INTO CrGrafico1 (cChave1s, cTitulo1s, cTitulo2s, cTitulo3s, cTitulo4s, cEmpresas) ;
                        VALUES (par_cChave2, THIS.this_cTitulo1, THIS.this_cTitulo2, ;
                                THIS.this_cTitulo3, THIS.this_cTitulo4, THIS.this_cEmpresaGrafico)
                    APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" DATA (loc_cStrg1 + CHR(13) + CHR(10) + loc_cStrg2)

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * NavGraficoAnterior - Decrementa posicao do grafico (minimo 1)
    * Retorna o numero atual apos decremento
    *==========================================================================
    PROCEDURE NavGraficoAnterior()
        THIS.this_nNumGrafico = MAX(1, THIS.this_nNumGrafico - 1)
        RETURN THIS.this_nNumGrafico
    ENDPROC

    *==========================================================================
    * NavGraficoProximo - Incrementa posicao do grafico (maximo 3)
    * Retorna o numero atual apos incremento
    *==========================================================================
    PROCEDURE NavGraficoProximo()
        THIS.this_nNumGrafico = MIN(3, THIS.this_nNumGrafico + 1)
        RETURN THIS.this_nNumGrafico
    ENDPROC

    *==========================================================================
    * ObterChaveGrafico - Monta chave composta para lookup em CrGrafico1
    * par_cChave1 = item do combo (ordem + separador + cliente)
    * par_nContaGrafico = 1, 2 ou 3
    * par_cStrgeixoY = string do eixo Y (30 chars = 3 nomes de 10)
    *==========================================================================
    PROCEDURE ObterChaveGrafico(par_cChave1, par_nContaGrafico, par_cStrgeixoY)
        RETURN par_cChave1 + SUBSTR(par_cStrgeixoY, (par_nContaGrafico * 10 - 9), 10)
    ENDPROC

ENDDEFINE

