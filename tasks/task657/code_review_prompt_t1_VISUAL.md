# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Ocorrencias' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCCO.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1149 linhas total):

*-- Linhas 12 a 45:
12: *
13: * Fase 3/8 - ESTRUTURA BASE: cria o esqueleto da classe (propriedades,
14: * Init() recebendo os parametros do form chamador, InicializarForm(),
15: * Destroy()) e o cabecalho (cnt_4c_Sombra/lbl_4c_LblSombra/lbl_4c_LblTitulo),
16: * com geometria TRANSCRITA do dump. Grade e botoes (Fase 4), campo Nota
17: * (Fases 5-6), os eventos reais (Confirmar/Cancelar/Valid da Nota - Fase 7)
18: * e a consolidacao (Fase 8) entram nos blocos seguintes deste cabecalho.
19: *
20: * Fase 4/8 - GRADE E BOTOES: este form NAO tem Page1=Lista/Page2=Dados nem
21: * botoes CRUD (Incluir/Alterar/Excluir/Buscar) - e um dialogo OPERACIONAL
22: * unico, e inventar PageFrame/CRUD aqui violaria o PILAR 1. A superficie que
23: * o legado DE FATO tem:
24: *   - grd_4c_Dados        <- SIGOPCCO.Grade (3 colunas: Ocorrencia/Descricao/
25: *                            Retificacao), ligada a cursor_4c_Ocorrencias
26: *                            (equivalente ao "Create Cursor XCorNf" do Load).
27: *                            Column3 usa EditBox (Column3.Edit1 no legado),
28: *                            logo exige AddObject + CurrentControl + Sparse.
29: *   - cmg_4c_Sair         <- SIGOPCCO.Sair (CommandGroup Confirmar/Cancelar)
30: *   - CarregarDados()     <- bloco de carga que o legado repete IDENTICO em
31: *                            PROCEDURE Init e em Get_NotaIni.Valid: monta a
32: *                            lista de ocorrencias (SigCcOco) e casa cada uma
33: *                            com a retificacao gravada (SigNfCor)
34: *   - AtualizarGrade()    <- "Select XCorNf / Go Top / Grade.Refresh", metodo
35: *                            unico de repintura usado por todo caminho que
36: *                            popula o cursor
37: *
38: * Fase 5/8 - CAMPO NOTA (PARTE 1/2 - visual): adiciona ConfigurarCampoNota(),
39: * equivalente a SIGOPCCO.Say1 ("Nota : ") + SIGOPCCO.Get_NotaIni, com
40: * geometria TRANSCRITA do dump (Say1.Left=183/Top=94; Get_NotaIni.Left=220/
41: * Top=91/Width=52/MaxLength=6). O valor inicial (equivalente a
42: * "ThisForm.Get_NotaIni.Value = NFis" no PROCEDURE Init legado) e atribuido
43: * dentro do proprio metodo, com THIS.this_cNfis ja recebido pelo Init.
44: *
45: * Fase 6/8 - CAMPO NOTA (PARTE 2/2 - eventos e lookups):

*-- Linhas 151 a 159:
151:     * antes de delegar ao FormBase
152:     *--------------------------------------------------------------------------
153:     PROCEDURE Init(par_oFormPai, par_cEmps, par_cSeries, par_dEmisDe, par_dEmisAte, par_cNfis)
154:         THIS.Caption = "Carta de Corre" + CHR(231) + CHR(227) + "o"
155: 
156:         THIS.this_oFormPai  = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
157:         THIS.this_cEmps     = IIF(VARTYPE(par_cEmps)   = "C", par_cEmps,   "")
158:         THIS.this_cSeries   = IIF(VARTYPE(par_cSeries) = "C", par_cSeries, "")
159:         THIS.this_dEmisDe   = IIF(INLIST(VARTYPE(par_dEmisDe),  "D", "T"), par_dEmisDe,  {})

*-- Linhas 201 a 210:
201: 
202:                 THIS.ConfigurarPageFrame()
203: 
204:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
205:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
206: 
207:                 THIS.TornarControlesVisiveis(THIS)
208: 
209:                 *-- 1a carga da grade, como o PROCEDURE Init legado faz
210:                 *-- (Requery de CrSigNfCor/CrSigCcOco + montagem de XCorNf)

*-- Linhas 248 a 383:
248:     PROTECTED PROCEDURE ConfigurarCabecalho()
249:         THIS.AddObject("cnt_4c_Sombra", "Container")
250:         WITH THIS.cnt_4c_Sombra
251:             .Top         = 0
252:             .Left        = 0
253:             .Width       = THIS.Width
254:             .Height      = 80
255:             .BackColor   = RGB(100, 100, 100)
256:             .BackStyle   = 1
257:             .BorderWidth = 0
258:             .Visible     = .T.
259:         ENDWITH
260: 
261:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
262:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
263:             .Top           = 18
264:             .Left          = 10
265:             .Width         = 769
266:             .Height        = 40
267:             .AutoSize      = .F.
268:             .BackStyle     = 0
269:             .WordWrap      = .T.
270:             .Alignment     = 0
271:             .FontName      = "Tahoma"
272:             .FontSize      = 18
273:             .FontBold      = .T.
274:             .FontUnderline = .F.
275:             .ForeColor     = RGB(0, 0, 0)
276:             .Caption       = THIS.Caption
277:         ENDWITH
278: 
279:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
280:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
281:             .Top         = 17
282:             .Left        = 10
283:             .Width       = 769
284:             .Height      = 46
285:             .AutoSize    = .F.
286:             .BackStyle   = 0
287:             .WordWrap    = .T.
288:             .Alignment   = 0
289:             .FontName    = "Tahoma"
290:             .FontSize    = 18
291:             .FontBold    = .T.
292:             .ForeColor   = RGB(255, 255, 255)
293:             .Caption     = THIS.Caption
294:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
295:         ENDWITH
296:     ENDPROC
297: 
298:     *--------------------------------------------------------------------------
299:     * CriarCursorOcorrencias - cursor LOCAL (nao SQL) de ocorrencias de
300:     * correcao, equivalente ao "Create Cursor XCorNf (cods n(3),descs c(30),
301:     * retifs m(8) NULL) / Index On cods Tag cods" do PROCEDURE Load legado.
302:     * E repopulado a cada troca de Nota Fiscal (Fase 6, Get_NotaIni.Valid) -
303:     * por isso o reset defensivo no inicio, igual ao padrao de todo form que
304:     * recria cursor local proprio.
305:     *--------------------------------------------------------------------------
306:     PROTECTED PROCEDURE CriarCursorOcorrencias()
307:         IF USED("cursor_4c_Ocorrencias")
308:             USE IN cursor_4c_Ocorrencias
309:         ENDIF
310: 
311:         CREATE CURSOR cursor_4c_Ocorrencias (cods N(3), descs C(30), retifs M NULL)
312:         INDEX ON cods TAG cods
313:     ENDPROC
314: 
315:     *--------------------------------------------------------------------------
316:     * ConfigurarGrade - grd_4c_Dados, equivalente a SIGOPCCO.Grade: 3 colunas
317:     * (Ocorrencia/Descricao/Retificacao), geometria TRANSCRITA do dump.
318:     * Column3 usa EditBox (nao Text1 - o legado tem Column3.Edit1), por isso
319:     * precisa de AddObject + CurrentControl + Sparse=.F. (regra #18 - sem
320:     * isso a coluna continua desenhando o Text1 default e a retificacao
321:     * digitada nunca aparece).
322:     *--------------------------------------------------------------------------
323:     PROTECTED PROCEDURE ConfigurarGrade()
324:         THIS.CriarCursorOcorrencias()
325: 
326:         THIS.AddObject("grd_4c_Dados", "Grid")
327:         WITH THIS.grd_4c_Dados
328:             .Top               = 122
329:             .Left              = 98
330:             .Width             = 604
331:             .Height            = 290
332:             .FontName          = "Tahoma"
333:             .FontSize          = 8
334:             .ForeColor         = RGB(0, 0, 0)
335:             .AllowHeaderSizing = .F.
336:             .AllowRowSizing    = .F.
337:             .DeleteMark        = .F.
338:             .RecordMark        = .F.
339:             .GridLines         = 3
340:             .ReadOnly          = .F.
341:             .RowHeight         = 16
342:             .ScrollBars        = 2
343:             .TabIndex          = 5
344:             .ColumnCount       = 3
345:             .RecordSource      = "cursor_4c_Ocorrencias"
346: 
347:             .Column1.ControlSource     = "cursor_4c_Ocorrencias.cods"
348:             .Column1.Width             = 70
349:             .Column1.FontName          = "Tahoma"
350:             .Column1.FontSize          = 8
351:             .Column1.Movable           = .F.
352:             .Column1.Resizable         = .F.
353:             .Column1.ForeColor         = RGB(0, 0, 0)
354:             .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
355:             .Column1.Header1.Alignment = 2
356:             .Column1.Header1.FontName  = "Tahoma"
357:             .Column1.Header1.FontSize  = 8
358:             .Column1.Text1.BorderStyle = 0
359:             .Column1.Text1.Margin      = 0
360:             .Column1.Text1.ReadOnly    = .F.   && transcrito do dump (default)
361:             .Column1.Text1.ForeColor   = RGB(0, 0, 0)
362:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
363:             *-- legado: Column1.Text1.When -> Return(.F.) (coluna nao digitavel).
364:             *-- POR ULTIMO de proposito: o ReadOnly do Grid propaga para as
365:             *-- colunas e o do Text1 reabriria a celula (regra CLAUDE.md #18/#46)
366:             .Column1.ReadOnly          = .T.
367: 
368:             .Column2.ControlSource     = "cursor_4c_Ocorrencias.descs"
369:             .Column2.Width             = 220
370:             .Column2.FontName          = "Tahoma"
371:             .Column2.FontSize          = 8
372:             .Column2.Movable           = .F.
373:             .Column2.Resizable         = .F.
374:             .Column2.ForeColor         = RGB(0, 0, 0)
375:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
376:             .Column2.Header1.Alignment = 2
377:             .Column2.Header1.FontName  = "Tahoma"
378:             .Column2.Header1.FontSize  = 8
379:             .Column2.Text1.BorderStyle = 0
380:             .Column2.Text1.Margin      = 0
381:             .Column2.Text1.ReadOnly    = .F.   && transcrito do dump (default)
382:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
383:             .Column2.Text1.BackColor   = RGB(255, 255, 255)

*-- Linhas 391 a 479:
391:             .Column3.Movable           = .F.
392:             .Column3.Resizable         = .F.
393:             .Column3.ForeColor         = RGB(0, 0, 0)
394:             .Column3.Header1.Caption   = "Retifica" + CHR(231) + CHR(227) + "o"
395:             .Column3.Header1.Alignment = 2
396:             .Column3.Header1.FontName  = "Tahoma"
397:             .Column3.Header1.FontSize  = 8
398: 
399:             .Column3.AddObject("edt_4c_Retificacao", "EditBox")
400:             .Column3.edt_4c_Retificacao.Top       = 31
401:             .Column3.edt_4c_Retificacao.Left      = 5
402:             .Column3.edt_4c_Retificacao.Width     = 100
403:             .Column3.edt_4c_Retificacao.Height    = 53
404:             .Column3.edt_4c_Retificacao.FontName  = "Tahoma"
405:             .Column3.edt_4c_Retificacao.FontSize  = 8
406:             .Column3.edt_4c_Retificacao.ForeColor = RGB(0, 0, 0)
407:             .Column3.CurrentControl    = "edt_4c_Retificacao"
408:             .Column3.ControlSource     = "cursor_4c_Ocorrencias.retifs"
409:             .Column3.Sparse            = .F.
410:             .Column3.ReadOnly          = .F.
411: 
412:             .Visible = .T.
413:         ENDWITH
414: 
415:         *-- SIGOPCCO.Grade.Column3.Edit1.KeyPress (legado): navegacao por
416:         *-- registro (Enter/Ctrl+X avancam, Ctrl+E volta, Tab vira Ctrl+Tab).
417:         *-- BINDEVENT exige que o metodo alvo ja exista em THIS e seja PUBLIC
418:         *-- (regra CLAUDE.md #3) - por isso vem DEPOIS do WITH acima.
419:         BINDEVENT(THIS.grd_4c_Dados.Column3.edt_4c_Retificacao, "KeyPress", ;
420:                   THIS, "GradeRetificacaoKeyPress")
421:     ENDPROC
422: 
423:     *--------------------------------------------------------------------------
424:     * ConfigurarBotoes - cmg_4c_Sair, equivalente a SIGOPCCO.Sair
425:     * (CommandGroup com Confirmar/Cancelar). Geometria e visual TRANSCRITOS
426:     * do dump; Buttons(N) dentro de CommandGroup mantem Themes=.F. (igual ao
427:     * legado Command1/Command2.Themes=.F.). Os Click handlers (Ok.Click/
428:     * Cancela.Click do legado) sao implementados na Fase 7/8.
429:     *--------------------------------------------------------------------------
430:     PROTECTED PROCEDURE ConfigurarBotoes()
431:         THIS.AddObject("cmg_4c_Sair", "CommandGroup")
432:         WITH THIS.cmg_4c_Sair
433:             .Top           = -2
434:             .Left          = 645
435:             .Width         = 160
436:             .Height        = 85
437:             .ButtonCount   = 2
438:             .BackStyle     = 0
439:             .BorderStyle   = 0
440:             .SpecialEffect = 1
441:             .BorderColor   = RGB(136, 189, 188)
442:             .TabIndex      = 6
443: 
444:             WITH .Buttons(1)
445:                 .Top        = 5
446:                 .Left       = 5
447:                 .Width      = 75
448:                 .Height     = 75
449:                 .FontName   = "Comic Sans MS"
450:                 .FontSize   = 8
451:                 .FontBold   = .T.
452:                 .FontItalic = .T.
453:                 .ForeColor  = RGB(90, 90, 90)
454:                 .BackColor  = RGB(255, 255, 255)
455:                 .Themes     = .F.
456:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
457:                 .Caption    = "\<Confirmar"
458:             ENDWITH
459: 
460:             WITH .Buttons(2)
461:                 .Top        = 5
462:                 .Left       = 80
463:                 .Width      = 75
464:                 .Height     = 75
465:                 .FontName   = "Comic Sans MS"
466:                 .FontSize   = 8
467:                 .FontBold   = .T.
468:                 .FontItalic = .T.
469:                 .ForeColor  = RGB(90, 90, 90)
470:                 .BackColor  = RGB(255, 255, 255)
471:                 .Cancel     = .T.
472:                 .Themes     = .F.
473:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
474:                 .Caption    = "\<Cancelar"
475:             ENDWITH
476: 
477:             .Visible = .T.
478:         ENDWITH
479: 

*-- Linhas 486 a 494:
486:     ENDPROC
487: 
488:     *--------------------------------------------------------------------------
489:     * ConfigurarCampoNota - lbl_4c_Label1 + txt_4c_NotaIni, equivalente a
490:     * SIGOPCCO.Say1 ("Nota : ") + SIGOPCCO.Get_NotaIni. Geometria TRANSCRITA
491:     * do dump:
492:     *   Say1:        Left=183, Top=94,                Caption="Nota : "
493:     *   Get_NotaIni: Left=220, Top=91, Width=52, MaxLength=6, ForeColor preto
494:     *

*-- Linhas 505 a 533:
505:     * "Nota Fiscal Invalida !!") fica para a Fase 6/8.
506:     *--------------------------------------------------------------------------
507:     PROTECTED PROCEDURE ConfigurarCampoNota()
508:         THIS.AddObject("lbl_4c_Label1", "Label")
509:         WITH THIS.lbl_4c_Label1
510:             .Top       = 94
511:             .Left      = 183
512:             .Width     = 34
513:             .Height    = 17
514:             .AutoSize  = .F.
515:             .BackStyle = 0
516:             .WordWrap  = .F.
517:             .Alignment = 0
518:             .FontName  = "Tahoma"
519:             .FontSize  = 8
520:             .ForeColor = RGB(90, 90, 90)
521:             .Caption   = "Nota : "
522:             .TabIndex  = 3
523:         ENDWITH
524: 
525:         THIS.AddObject("txt_4c_NotaIni", "TextBox")
526:         WITH THIS.txt_4c_NotaIni
527:             .Top       = 91
528:             .Left      = 220
529:             .Width     = 52
530:             .MaxLength = 6
531:             .FontName  = "Tahoma"
532:             .FontSize  = 8
533:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 748 a 782:
748:     * CLAUDE.md #3) e DECLARA os parametros do evento (regra CLAUDE.md #3).
749:     *--------------------------------------------------------------------------
750:     PROCEDURE GradeRetificacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
751:         DO CASE
752:             CASE par_nKeyCode = 13 OR par_nKeyCode = 24
753:                 IF USED("cursor_4c_Ocorrencias")
754:                     SELECT cursor_4c_Ocorrencias
755:                     IF !EOF()
756:                         SKIP
757:                     ENDIF
758:                 ENDIF
759:                 THIS.grd_4c_Dados.Refresh()
760:             CASE par_nKeyCode = 5
761:                 IF USED("cursor_4c_Ocorrencias")
762:                     SELECT cursor_4c_Ocorrencias
763:                     IF !BOF()
764:                         SKIP -1
765:                     ENDIF
766:                 ENDIF
767:                 THIS.grd_4c_Dados.Refresh()
768:             CASE par_nKeyCode = 9
769:                 KEYBOARD "{CTRL+TAB}"
770:         ENDCASE
771:     ENDPROC
772: 
773:     *--------------------------------------------------------------------------
774:     * CarregarDados - popula a grade de ocorrencias da Carta de Correcao.
775:     *
776:     * TRANSCRICAO do bloco de carga do legado, que aparece IDENTICO em DOIS
777:     * lugares (PROCEDURE Init e Get_NotaIni.Valid) e aqui vira METODO UNICO:
778:     *
779:     *   Select XCorNf / Zap
780:     *   pcNFisDe = <nota> / ThisForm.poDataMgr.Requery('CrSigNfCor')
781:     *   Select CrSigNfCor / Go Top
782:     *   If !Eof()

*-- Linhas 823 a 863:
823:         TRY
824:             *-- "Select XCorNf / Zap": esvazia a grade SEM derrubar o alias.
825:             *-- USE IN + CREATE CURSOR aqui quebraria RecordSource/
826:             *-- ControlSource/CurrentControl da grade ja criada - por isso
827:             *-- CriarCursorOcorrencias() so roda se o alias nao existir.
828:             IF !USED("cursor_4c_Ocorrencias")
829:                 THIS.CriarCursorOcorrencias()
830:             ENDIF
831:             SELECT cursor_4c_Ocorrencias
832:             ZAP
833: 
834:             IF VARTYPE(loc_oBO) = "O" AND !EMPTY(loc_cNfis)
835: 
836:                 *-- Requery('CrSigNfCor'): retificacoes JA gravadas na nota
837:                 IF loc_oBO.CarregarCorrecoes(THIS.this_cEmps, THIS.this_cSeries, loc_cNfis) ;
838:                    AND USED("cursor_4c_Correcoes") AND RECCOUNT("cursor_4c_Correcoes") > 0
839: 
840:                     loc_lTemCorrecao = .T.
841: 
842:                     *-- 1o Scan do legado: a LISTA COMPLETA de ocorrencias
843:                     *-- (CrSigCcOco) entra na grade com retificacao em branco
844:                     IF loc_oBO.CarregarOcorrencias() AND USED("cursor_4c_TiposOcorrencia")
845:                         SELECT cursor_4c_TiposOcorrencia
846:                         GO TOP
847:                         SCAN
848:                             INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) ;
849:                                  VALUES (cursor_4c_TiposOcorrencia.ncodigos, ;
850:                                          cursor_4c_TiposOcorrencia.cdescrs, ;
851:                                          "")
852:                             *-- INSERT INTO seleciona a tabela de DESTINO:
853:                             *-- reposicionar o alias do SCAN, igual ao
854:                             *-- "Select CrSigNfCor" que o legado faz no 2o Scan
855:                             SELECT cursor_4c_TiposOcorrencia
856:                         ENDSCAN
857:                     ENDIF
858: 
859:                     *-- 2o Scan do legado: casa a retificacao gravada com a
860:                     *-- ocorrencia correspondente (SEEK pelo TAG cods)
861:                     SELECT cursor_4c_Correcoes
862:                     GO TOP
863:                     SCAN

*-- Linhas 900 a 926:
900:     * nao traz dados") manda o diagnostico para SQL/cursor/permissao. Por isso
901:     * mora num metodo unico, chamado em TODO caminho que popula o cursor
902:     * (CarregarDados agora; o Valid da Nota e o Ok.Click nas Fases 7-8).
903:     *--------------------------------------------------------------------------
904:     PROCEDURE AtualizarGrade()
905:         IF USED("cursor_4c_Ocorrencias")
906:             SELECT cursor_4c_Ocorrencias
907:             GO TOP IN cursor_4c_Ocorrencias
908:         ENDIF
909: 
910:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
911:             THIS.grd_4c_Dados.Refresh()
912:         ENDIF
913:     ENDPROC
914: 
915:     *--------------------------------------------------------------------------
916:     * CarregarLista - FUNIL de carga da unica lista deste form: a grade de
917:     * ocorrencias da Carta de Correcao (SIGOPCCO.Grade, ligada ao cursor local
918:     * XCorNf no legado). Nao ha Page1=Lista/Page2=Dados aqui - a "lista" desta
919:     * tela e essa grade, e e ela que o PROCEDURE Init legado popula.
920:     *
921:     * Sequencia do funil: FormParaBO (tela -> BO, resolvendo a nota corrente)
922:     * -> CarregarDados (os dois Scan do legado) -> AtualizarGrade (GO TOP +
923:     * Refresh, feito no fim do proprio CarregarDados). Sem aviso de "Nota sem
924:     * Correcao": esse MessageBox existe SO no Get_NotaIni.Valid do legado, e o
925:     * Init abre a grade vazia em silencio - por isso par_lAvisarSemRegistro
926:     * vai .F. aqui.

*-- Linhas 994 a 1017:
994:                     ENDIF
995: 
996:                     *-- Linha corrente da grade (XCorNf.Cods/Retifs do legado).
997:                     *-- Grade vazia ou cursor no fim: zera, para o BO nao
998:                     *-- carregar a ocorrencia da leitura anterior.
999:                     IF USED("cursor_4c_Ocorrencias") AND !EOF("cursor_4c_Ocorrencias") ;
1000:                        AND RECCOUNT("cursor_4c_Ocorrencias") > 0
1001:                         .this_nNoccors = cursor_4c_Ocorrencias.cods
1002:                         .this_cMretifs = TratarNulo(cursor_4c_Ocorrencias.retifs, "")
1003:                     ELSE
1004:                         .this_nNoccors = 0
1005:                         .this_cMretifs = ""
1006:                     ENDIF
1007:                 ENDWITH
1008: 
1009:                 loc_lSucesso = .T.
1010:             ENDIF
1011:         CATCH TO loc_oErro
1012:             MsgErro(loc_oErro.Message + CHR(13) + ;
1013:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1014:                     "Procedure: " + loc_oErro.Procedure, ;
1015:                     "Erro em FormParaBO")
1016:         ENDTRY
1017: 

*-- Linhas 1056 a 1078:
1056: 
1057:                 IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
1058:                     THIS.txt_4c_NotaIni.Value = loc_cNfis
1059:                 ENDIF
1060: 
1061:                 IF loc_nNoccors > 0 AND USED("cursor_4c_Ocorrencias")
1062:                     IF SEEK(loc_nNoccors, "cursor_4c_Ocorrencias", "cods")
1063:                         REPLACE retifs WITH loc_cMretifs IN cursor_4c_Ocorrencias
1064:                     ENDIF
1065:                 ENDIF
1066: 
1067:                 loc_lSucesso = .T.
1068:             ENDIF
1069:         CATCH TO loc_oErro
1070:             MsgErro(loc_oErro.Message + CHR(13) + ;
1071:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1072:                     "Procedure: " + loc_oErro.Procedure, ;
1073:                     "Erro em BOParaForm")
1074:         ENDTRY
1075: 
1076:         RETURN loc_lSucesso
1077:     ENDPROC
1078: 

*-- Linhas 1099 a 1138:
1099:         IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
1100:             THIS.txt_4c_NotaIni.Value = ""
1101:             THIS.txt_4c_NotaIni.Refresh()
1102:         ENDIF
1103: 
1104:         IF USED("cursor_4c_Ocorrencias")
1105:             SELECT cursor_4c_Ocorrencias
1106:             ZAP
1107:         ENDIF
1108: 
1109:         THIS.AtualizarGrade()
1110:     ENDPROC
1111: 
1112:     *--------------------------------------------------------------------------
1113:     * Destroy - equivalente ao "PROCEDURE Release" implicito do legado.
1114:     * Fecha o cursor local de ocorrencias (cursor_4c_Ocorrencias, criado em
1115:     * CriarCursorOcorrencias/ConfigurarGrade) para nao vazar work area entre
1116:     * aberturas sucessivas do dialogo.
1117:     * DODEFAULT() e a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz o
1118:     * SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que repoe
1119:     * os pads do menu principal depois de uma tela modal fechar.
1120:     *--------------------------------------------------------------------------
1121:     PROCEDURE Destroy()
1122:         IF USED("cursor_4c_Ocorrencias")
1123:             USE IN cursor_4c_Ocorrencias
1124:         ENDIF
1125: 
1126:         DODEFAULT()
1127:     ENDPROC
1128: 
1129:     *--------------------------------------------------------------------------
1130:     * TornarControlesVisiveis - torna todos os controles visiveis
1131:     * recursivamente. FILTRO: nenhum container flutuante neste form.
1132:     *--------------------------------------------------------------------------
1133:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1134:         LOCAL loc_i, loc_oControl
1135: 
1136:         FOR loc_i = 1 TO par_oContainer.ControlCount
1137:             loc_oControl = par_oContainer.Controls(loc_i)
1138:             IF VARTYPE(loc_oControl) = "O"


### BO (C:\4c\projeto\app\classes\SIGOPCCOBO.prg):
*====================================================================
* SIGOPCCOBO.prg
*
* Business Object para Carta de Correcao de Nota Fiscal
* Tabela: SigNfCor
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGOPCCOBO AS BusinessBase

    *-- Propriedades da entidade (tabela SigNfCor - Carta de Correcao de NF)
    this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica Fortyus)
    this_cEmps       = ""   && cemps char(3) - empresa
    this_cSeries     = ""   && cseries char(3) - serie da nota fiscal
    this_cNfis       = ""   && cnfis char(6) - numero da nota fiscal
    this_nNoccors    = 0    && noccors numeric(3,0) - numero da ocorrencia (FK SigCcOco.ncodigos)
    this_cMretifs    = ""   && mretifs text - texto da retificacao/correcao

    *-- Propriedades de contexto (parametros recebidos do form chamador)
    this_dEmisDe     = {}   && data de emissao inicial (filtro repassado na impressao)
    this_dEmisAte    = {}   && data de emissao final (filtro repassado na impressao)

    *-- Propriedade auxiliar (tabela SigCdEmp - razao social da empresa)
    this_cRazas      = ""   && SigCdEmp.razas char(40) - razao social da empresa

    *-- Resultado de ConfirmarCorrecao(): .T. quando o lote gravou pelo
    *-- menos 1 retificacao (equivalente ao buffer crSigNfCor nao vazio do
    *-- Ok.Click legado); .F. quando nenhuma linha da grade tinha retifs
    *-- preenchido (ramo "Confirma Impressao da Correcao ?")
    this_lTemCorrecoesGravadas = .F.

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigNfCor"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia todas as colunas de SigNfCor (CrSigNfCor)
    * para as propriedades this_* do BO.
    *
    * TratarNulo(valor, PADRAO): o 2o argumento e o VALOR de fallback usado
    * quando a coluna vem NULL - NAO o tipo. Por isso "" para char/text e 0
    * para numeric (mretifs e text NULL no schema, logo o caso NULL e real).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                THIS.this_cEmps      = TratarNulo(cemps,     "")
                THIS.this_cSeries    = TratarNulo(cseries,   "")
                THIS.this_cNfis      = TratarNulo(cnfis,     "")
                THIS.this_nNoccors   = TratarNulo(noccors,   0)
                THIS.this_cMretifs   = TratarNulo(mretifs,   "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGOPCCOBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Grava nova ocorrencia de Carta de Correcao em SigNfCor
    * Gera cidchaves (PK Fortyus) quando o registro ainda nao tem uma
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigNfCor (cemps, cseries, cnfis, noccors, mretifs, cidchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cSeries)>>,
                    <<EscaparSQL(THIS.this_cNfis)>>,
                    <<FormatarNumeroSQL(THIS.this_nNoccors, 0)>>,
                    <<EscaparSQL(THIS.this_cMretifs)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao inserir Carta de Corre" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message, "SIGOPCCOBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza o texto de retificacao de uma ocorrencia
    * existente em SigNfCor (chave primaria cidchaves)
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigNfCor
                SET cemps    = <<EscaparSQL(THIS.this_cEmps)>>,
                    cseries  = <<EscaparSQL(THIS.this_cSeries)>>,
                    cnfis    = <<EscaparSQL(THIS.this_cNfis)>>,
                    noccors  = <<FormatarNumeroSQL(THIS.this_nNoccors, 0)>>,
                    mretifs  = <<EscaparSQL(THIS.this_cMretifs)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao atualizar Carta de Corre" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message, "SIGOPCCOBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarOcorrencias - popula cursor_4c_TiposOcorrencia com a LISTA
    * COMPLETA de ocorrencias de correcao (tabela SigCcOco).
    *
    * Equivalente ao cursor CrSigCcOco do legado:
    *   .AddCursor('SigCcOco','ncodigos','CrSigCcOco','','')
    *   ThisForm.poDataMgr.Requery('CrSigCcOco')
    *
    * O legado nao filtra nada - traz a tabela inteira - e ordena por
    * ncodigos (chave do AddCursor), que e a ordem em que as ocorrencias
    * aparecem na grade.
    *
    * Colunas conferidas em docs/schema.sql: SigCcOco.ncodigos numeric(3,0),
    * SigCcOco.cdescrs char(30).
    *====================================================================
    PROCEDURE CarregarOcorrencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                       "  FROM SigCcOco" + ;
                       " ORDER BY ncodigos"

            IF USED("cursor_4c_TiposOcorrencia")
                USE IN cursor_4c_TiposOcorrencia
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposOcorrencia")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao carregar ocorr" + CHR(234) + "ncias de corre" + CHR(231) + CHR(227) + "o:" + ;
                            CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCCOBO.CarregarOcorrencias")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarCorrecoes - popula cursor_4c_Correcoes com as retificacoes
    * JA GRAVADAS para uma nota fiscal (tabela SigNfCor).
    *
    * Equivalente ao cursor CrSigNfCor do legado, com a MESMA query:
    *   lcQryCorNf = [Select * From SigNfCor ]+
    *                [Where cemps = ?pcEmps And cseries = ?pcSeries
    *                       And cnfis = ?pcNFis ]+
    *                [Order By cemps,cseries,cnfis,noccors ]
    *
    * O legado passa os 3 filtros SEMPRE (inclusive vazios, via parametro do
    * fSqlConector) e re-executa a mesma query em Get_NotaIni.Valid trocando
    * so pcNFisDe - aqui isso vira o parametro par_cNfis.
    *
    * PADR nas larguras do schema (cemps/cseries char(3), cnfis char(6)) -
    * igual ao Padr(...,3)/Padr(...,6) que o proprio legado usa nos Delete/
    * Update do Ok.Click.
    *====================================================================
    PROCEDURE CarregarCorrecoes(par_cEmps, par_cSeries, par_cNfis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_cEmps, loc_cSeries, loc_cNfis
        loc_lSucesso = .F.

        loc_cEmps   = PADR(IIF(VARTYPE(par_cEmps)   = "C", ALLTRIM(par_cEmps),   ""), 3)
        loc_cSeries = PADR(IIF(VARTYPE(par_cSeries) = "C", ALLTRIM(par_cSeries), ""), 3)
        loc_cNfis   = PADR(IIF(VARTYPE(par_cNfis)   = "C", ALLTRIM(par_cNfis),   ""), 6)

        TRY
            loc_cSQL = "SELECT cemps, cseries, cnfis, noccors, mretifs, cidchaves" + ;
                       "  FROM SigNfCor" + ;
                       " WHERE cemps   = " + EscaparSQL(loc_cEmps) + ;
                       "   AND cseries = " + EscaparSQL(loc_cSeries) + ;
                       "   AND cnfis   = " + EscaparSQL(loc_cNfis) + ;
                       " ORDER BY cemps, cseries, cnfis, noccors"

            IF USED("cursor_4c_Correcoes")
                USE IN cursor_4c_Correcoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Correcoes")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao carregar as corre" + CHR(231) + CHR(245) + "es da nota fiscal:" + ;
                            CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCCOBO.CarregarCorrecoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfirmarCorrecao - grava a Carta de Correcao da nota fiscal como UM
    * LOTE SQL atomico: apaga as retificacoes anteriores (SigNfCor) e grava
    * so as linhas de cursor_4c_Ocorrencias (a grade do form) com texto de
    * retificacao preenchido, atualizando a flag SigMvNfi.Correcs.
    *
    * Equivalente ao Ok.Click do legado:
    *   Delete From SigNfCor Where CEmps=... And CSeries=... And CNfis=...
    *   Update SigMvNfi Set Correcs = .F. Where ...   (commit)
    *   Zap In crSigNfCor
    *   <para cada linha de XCorNf com Retifs preenchido:
    *        Insert Into crSigNfCor (cEmps,cSeries,cNfis,nOccors,mRetifs,cIdChaves)>
    *   Update(crSigNfCor)
    *   Se crSigNfCor nao ficou vazio:
    *       Update SigMvNfi Set Correcs = .T. Where ...   (commit)
    *
    * BEGIN/COMMIT via SQLEXEC separados NAO protegem (a conexao
    * SQLSTRINGCONNECT ja nasce com @@TRANCOUNT=1 - um par BEGIN/COMMIT so
    * aninha o contador e um ROLLBACK depois nao desfaz nada). A
    * atomicidade pretendida pelo legado (tudo ou nada) vai num SQLEXEC
    * UNICO com SAVE TRANSACTION/TRY/CATCH/THROW em T-SQL, no mesmo padrao
    * de ProdutoBO.CopiarProduto.
    *
    * fUniqueIds() gera a PK (cidchaves) de cada linha nova - igual ao
    * Insert Into do legado. this_lTemCorrecoesGravadas fica .T. quando
    * pelo menos 1 linha foi incluida no lote.
    *====================================================================
    PROCEDURE ConfirmarCorrecao(par_cEmps, par_cSeries, par_cNfis)
        LOCAL loc_cEmps, loc_cSeries, loc_cNfis, loc_cLote, loc_cInserts
        LOCAL loc_nResultado, loc_lSucesso, loc_oErro

        *-- Argumento ausente cai na PROPRIA property, que o FormParaBO do
        *-- form acabou de preencher - assim o form nao precisa repassar como
        *-- argumento o que ja esta no BO (fonte unica). PADR nas larguras do
        *-- schema (cemps/cseries char(3), cnfis char(6)), igual ao
        *-- Padr(...,3)/Padr(...,6) do Ok.Click legado.
        loc_cEmps   = PADR(ALLTRIM(IIF(VARTYPE(par_cEmps)   = "C", par_cEmps,   THIS.this_cEmps)),   3)
        loc_cSeries = PADR(ALLTRIM(IIF(VARTYPE(par_cSeries) = "C", par_cSeries, THIS.this_cSeries)), 3)
        loc_cNfis   = PADR(ALLTRIM(IIF(VARTYPE(par_cNfis)   = "C", par_cNfis,   THIS.this_cNfis)),   6)

        THIS.this_cMensagemErro         = ""
        THIS.this_lErroExibido          = .F.
        THIS.this_lTemCorrecoesGravadas = .F.
        loc_lSucesso = .F.
        loc_cInserts = ""

        TRY
            IF !USED("cursor_4c_Ocorrencias")
                THIS.this_cMensagemErro = "Grade de ocorr" + CHR(234) + "ncias n" + CHR(227) + "o carregada."
                THIS.ExibirFalha("Confirmar")
            ELSE
                *-- "Zap In crSigNfCor" + 1o Scan (so as linhas com Retifs
                *-- preenchido entram no buffer)
                SELECT cursor_4c_Ocorrencias
                GO TOP
                SCAN
                    IF !EMPTY(cursor_4c_Ocorrencias.retifs)
                        *-- ALLTRIM tira espacos sobrando que o EditBox pode
                        *-- deixar no texto digitado antes de gravar
                        loc_cInserts = loc_cInserts + ;
                            "INSERT INTO SigNfCor (cemps, cseries, cnfis, noccors, mretifs, cidchaves) VALUES (" + ;
                            EscaparSQL(loc_cEmps) + ", " + ;
                            EscaparSQL(loc_cSeries) + ", " + ;
                            EscaparSQL(loc_cNfis) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_Ocorrencias.cods, 0) + ", " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_Ocorrencias.retifs)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ");" + CHR(13) + CHR(10)
                        SELECT cursor_4c_Ocorrencias
                    ENDIF
                ENDSCAN

                THIS.this_lTemCorrecoesGravadas = !EMPTY(loc_cInserts)

                loc_cLote = "SET NOCOUNT ON;" + CHR(13) + CHR(10) + ;
                    "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 BEGIN TRANSACTION" + CHR(13) + CHR(10) + ;
                    "ELSE SAVE TRANSACTION Cco4c;" + CHR(13) + CHR(10) + ;
                    "BEGIN TRY" + CHR(13) + CHR(10) + ;
                    "DELETE FROM SigNfCor WHERE cemps = " + EscaparSQL(loc_cEmps) + ;
                        " AND cseries = " + EscaparSQL(loc_cSeries) + ;
                        " AND cnfis = " + EscaparSQL(loc_cNfis) + ";" + CHR(13) + CHR(10) + ;
                    loc_cInserts + ;
                    "UPDATE SigMvNfi SET correcs = " + IIF(THIS.this_lTemCorrecoesGravadas, "1", "0") + ;
                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                        " AND series = " + EscaparSQL(loc_cSeries) + ;
                        " AND nfis = " + EscaparSQL(loc_cNfis) + ";" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + CHR(10) + ;
                    "END TRY" + CHR(13) + CHR(10) + ;
                    "BEGIN CATCH" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + CHR(10) + ;
                    "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Cco4c; END;" + CHR(13) + CHR(10) + ;
                    "THROW;" + CHR(13) + CHR(10) + ;
                    "END CATCH"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    THIS.ExibirFalha("Confirmar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.ExibirFalha("Confirmar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterEmpDopNums - devolve SigMvNfi.empdopnums (coluna ja
    * materializada = Emps char(3) + Dopes char(20) + Str(Numes,6), total
    * char(29) - regra #42) da nota fiscal atual.
    *
    * Equivalente a "CrSigMvNfi.Emps + CrSigMvNfi.Dopes +
    * Str(CrSigMvNfi.Numes,6)" do Ok.Click legado, que monta a chave a
    * partir do cursor global do FORM CHAMADOR (CrSigMvNfi). Sem form
    * chamador nesta migracao (SIGOPCCO abre direto do menu), a mesma linha
    * e localizada pela chave natural Emps/Series/Nfis que os Updates de
    * ConfirmarCorrecao() ja usam.
    *====================================================================
    PROCEDURE ObterEmpDopNums(par_cEmps, par_cSeries, par_cNfis)
        LOCAL loc_cSQL, loc_nResultado, loc_cRetorno, loc_oErro

        loc_cRetorno = ""

        TRY
            *-- Argumento ausente cai na PROPRIA property (preenchida pelo
            *-- FormParaBO do form), mesmo criterio de ConfirmarCorrecao
            loc_cSQL = "SELECT empdopnums" + ;
                       "  FROM SigMvNfi" + ;
                       " WHERE emps   = " + EscaparSQL(PADR(ALLTRIM(IIF(VARTYPE(par_cEmps)   = "C", par_cEmps,   THIS.this_cEmps)),   3)) + ;
                       "   AND series = " + EscaparSQL(PADR(ALLTRIM(IIF(VARTYPE(par_cSeries) = "C", par_cSeries, THIS.this_cSeries)), 3)) + ;
                       "   AND nfis   = " + EscaparSQL(PADR(ALLTRIM(IIF(VARTYPE(par_cNfis)   = "C", par_cNfis,   THIS.this_cNfis)),   6))

            IF USED("cursor_4c_EmpDopNums")
                USE IN cursor_4c_EmpDopNums
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDopNums")

            IF loc_nResultado >= 0 AND USED("cursor_4c_EmpDopNums") AND RECCOUNT("cursor_4c_EmpDopNums") > 0
                loc_cRetorno = cursor_4c_EmpDopNums.empdopnums
            ENDIF

            IF USED("cursor_4c_EmpDopNums")
                USE IN cursor_4c_EmpDopNums
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCCOBO.ObterEmpDopNums")
        ENDTRY

        RETURN loc_cRetorno
    ENDPROC


ENDDEFINE

