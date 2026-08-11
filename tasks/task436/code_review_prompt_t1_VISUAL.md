# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 422: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 444: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 471: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormGcp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1409 linhas total):

*-- Linhas 71 a 79:
71: 
72:             IF VARTYPE(par_cDopes) = "C" AND !EMPTY(ALLTRIM(par_cDopes))
73:                 THIS.this_cDopesAtual = ALLTRIM(par_cDopes)
74:                 THIS.Caption = "Grupos / Contas Permitidas " + ;
75:                                PROPER(ALLTRIM(par_cDopes))
76:             ENDIF
77: 
78:             IF VARTYPE(par_cEscolha) = "C"
79:                 THIS.this_cEscolha = ALLTRIM(par_cEscolha)

*-- Linhas 139 a 162:
139:     PROTECTED PROCEDURE ConfigurarPageFrame()
140:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
141:         WITH THIS.pgf_4c_Paginas
142:             .Top       = -29
143:             .Left      = 0
144:             .Width     = THIS.Width
145:             .Height    = THIS.Height + 29
146:             .PageCount = 2
147:             .Tabs      = .F.
148: 
149:             *-- Page1: area principal de trabalho
150:             WITH .Page1
151:                 .Caption   = "Principal"
152:                 .Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
153:             ENDWITH
154: 
155:             *-- Page2: reservada
156:             WITH .Page2
157:                 .Caption   = "Reservada"
158:                 .BackColor = RGB(240, 240, 240)
159:             ENDWITH
160:         ENDWITH
161:         THIS.pgf_4c_Paginas.Visible    = .T.
162:         THIS.pgf_4c_Paginas.ActivePage = 1

*-- Linhas 180 a 222:
180:         *----------------------------------------------------------------------
181:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
182:         WITH loc_oPagina.cnt_4c_Cabecalho
183:             .Top         = 28
184:             .Left        = -2
185:             .Width       = THIS.Width + 4
186:             .Height      = 80
187:             .BackColor   = RGB(100, 100, 100)
188:             .BorderWidth = 0
189:             .Visible     = .T.
190:         ENDWITH
191: 
192:         *----------------------------------------------------------------------
193:         * cnt_4c_Botoes - Botoes de acao: Inserir e Excluir
194:         * Original: cmdInserir.Left=366, cmdExcluir.Left=440 (ambos Top=2)
195:         * Compensacao PageFrame: Top = 2 + 29 = 31 -> container Top = 29
196:         * Posicao: Left=360 (5px antes de Inserir), Width=155 (2 botoes x 75 + margens)
197:         *----------------------------------------------------------------------
198:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
199:         WITH loc_oPagina.cnt_4c_Botoes
200:             .Top         = 29
201:             .Left        =  542
202:             .Width       = 155
203:             .Height      = 85
204:             .BackColor   = RGB(100, 100, 100)
205:             .BorderWidth = 0
206:             .Visible     = .T.
207:         ENDWITH
208: 
209:         *----------------------------------------------------------------------
210:         * cnt_4c_Saida - Container canonico para botao Encerrar
211:         * Original: cmdSair.Left=515, Width~75 (borda direita ~590)
212:         * Canonico: Left = THIS.Width - 90 = 502, Width = 90
213:         *----------------------------------------------------------------------
214:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
215:         WITH loc_oPagina.cnt_4c_Saida
216:             .Top         = 29
217:             .Left        = 917
218:             .Width       = 90
219:             .Height      = 85
220:             .BackStyle   = 0
221:             .BorderWidth = 0
222:             .Visible     = .T.

*-- Linhas 229 a 238:
229:         *----------------------------------------------------------------------
230:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
231:         WITH loc_oPagina.cnt_4c_BotoesAcao
232:             .Top         = 349
233:             .Left        = 0
234:             .Width       = THIS.Width
235:             .Height      = 55
236:             .BackStyle   = 0
237:             .BorderWidth = 0
238:             .Visible     = .T.

*-- Linhas 277 a 287:
277:                         loc_oGrid.Column1.ControlSource = "TmpGcOpe.Grupos"
278:                         loc_oGrid.Column2.ControlSource = "TmpGcOpe.Contas"
279:                         loc_oGrid.Column3.ControlSource = "TmpGcOpe.OriDes"
280:                         loc_oGrid.Column1.Header1.Caption = "Grupo"
281:                         loc_oGrid.Column2.Header1.Caption = "Conta"
282:                         loc_oGrid.Column3.Header1.Caption = "O/D/A"
283:                         *-- DynamicForeColor: azul para Permitidas (BlqCts!=2), rosa para Nao Permitidas (BlqCts=2)
284:                         loc_oGrid.SetAll("DynamicForeColor", ;
285:                             "IIF(TmpGcOpe.BlqCts = 2, RGB(255,0,128), RGB(0,0,128))", "Column")
286:                         loc_oGrid.Refresh()
287:                     ENDIF

*-- Linhas 365 a 397:
365: 
366:         *----------------------------------------------------------------------
367:         * Labels do cabecalho (cnt_4c_Cabecalho)
368:         * Original: lblSombra.Top=18/Left=10 (sombra preta), lblTitulo.Top=17/Left=10 (branco)
369:         *----------------------------------------------------------------------
370:         loc_oCab = par_oPagina.cnt_4c_Cabecalho
371: 
372:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
373:         WITH loc_oCab.lbl_4c_Sombra
374:             .Caption   = THIS.Caption
375:             .Top       = 18
376:             .Left      = 12
377:             .Width     = loc_oCab.Width - 14
378:             .Height    = 40
379:             .FontName  = "Tahoma"
380:             .FontSize  = 16
381:             .FontBold  = .T.
382:             .ForeColor = RGB(0, 0, 0)
383:             .BackStyle = 0
384:             .AutoSize  = .F.
385:             .Visible   = .T.
386:         ENDWITH
387: 
388:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
389:         WITH loc_oCab.lbl_4c_Titulo
390:             .Caption   = THIS.Caption
391:             .Top       = 17
392:             .Left      = 10
393:             .Width     = loc_oCab.Width - 14
394:             .Height    = 46
395:             .FontName  = "Tahoma"
396:             .FontSize  = 16
397:             .FontBold  = .T.

*-- Linhas 403 a 533:
403: 
404:         *----------------------------------------------------------------------
405:         * Botoes em cnt_4c_Botoes: Inserir e Excluir
406:         * Original: cmdInserir.Left=366 Top=2, cmdExcluir.Left=440 Top=2
407:         * Container Left=360 -> Inserir.Left=5 (=366-360-1), Excluir.Left=80 (=440-360)
408:         *----------------------------------------------------------------------
409:         loc_oBotoes = par_oPagina.cnt_4c_Botoes
410: 
411:         loc_oBotoes.AddObject("cmd_4c_Inserir", "CommandButton")
412:         WITH loc_oBotoes.cmd_4c_Inserir
413:             .Caption         = "Inserir"
414:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
415:             .PicturePosition = 13
416:             .Top             = 5
417:             .Left            = 5
418:             .Width           = 75
419:             .Height          = 75
420:             .BackColor       = RGB(255, 255, 255)
421:             .ForeColor       = RGB(90, 90, 90)
422:             .FontName        = "Comic Sans MS"
423:             .FontBold        = .T.
424:             .FontItalic      = .T.
425:             .FontSize        = 8
426:             .Themes          = .F.
427:             .SpecialEffect   = 0
428:             .MousePointer    = 15
429:             .WordWrap        = .T.
430:             .Visible         = .T.
431:         ENDWITH
432: 
433:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
434:         WITH loc_oBotoes.cmd_4c_Excluir
435:             .Caption         = "Excluir"
436:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
437:             .PicturePosition = 13
438:             .Top             = 5
439:             .Left            = 80
440:             .Width           = 75
441:             .Height          = 75
442:             .BackColor       = RGB(255, 255, 255)
443:             .ForeColor       = RGB(90, 90, 90)
444:             .FontName        = "Comic Sans MS"
445:             .FontBold        = .T.
446:             .FontItalic      = .T.
447:             .FontSize        = 8
448:             .Themes          = .F.
449:             .SpecialEffect   = 0
450:             .MousePointer    = 15
451:             .WordWrap        = .T.
452:             .Visible         = .T.
453:         ENDWITH
454: 
455:         *----------------------------------------------------------------------
456:         * Botao Encerrar em cnt_4c_Saida (canonico)
457:         * Original: cmdSair.Left=515, Top=2 -> cnt_4c_Saida.Left=THIS.Width-90
458:         *----------------------------------------------------------------------
459:         loc_oSaida = par_oPagina.cnt_4c_Saida
460:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
461:         WITH loc_oSaida.cmd_4c_Encerrar
462:             .Caption         = "Encerrar"
463:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
464:             .PicturePosition = 13
465:             .Top             = 5
466:             .Left            = 5
467:             .Width           = 75
468:             .Height          = 75
469:             .BackColor       = RGB(255, 255, 255)
470:             .ForeColor       = RGB(90, 90, 90)
471:             .FontName        = "Comic Sans MS"
472:             .FontBold        = .T.
473:             .FontItalic      = .T.
474:             .FontSize        = 8
475:             .Themes          = .F.
476:             .SpecialEffect   = 0
477:             .MousePointer    = 15
478:             .WordWrap        = .T.
479:             .Visible         = .T.
480:         ENDWITH
481: 
482:         *----------------------------------------------------------------------
483:         * BINDEVENTs para botoes (metodos devem ser PUBLIC)
484:         *----------------------------------------------------------------------
485:         BINDEVENT(loc_oBotoes.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")
486:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
487:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
488: 
489:         *----------------------------------------------------------------------
490:         * Labels informativos: O=Origem, D=Destino, A=Ambos (Say1/2/3 do legado)
491:         * Original: Say1.Top=180, Say2.Top=195, Say3.Top=210; Left=386; Width=75
492:         * Com compensacao +29: Top = 209, 224, 239
493:         *----------------------------------------------------------------------
494:         par_oPagina.AddObject("lbl_4c_LegO", "Label")
495:         WITH par_oPagina.lbl_4c_LegO
496:             .Caption   = "O = Origem"
497:             .Top       = 209
498:             .Left      = 386
499:             .Width     = 75
500:             .Height    = 15
501:             .FontName  = "Verdana"
502:             .FontSize  = 8
503:             .FontBold  = .T.
504:             .ForeColor = RGB(216, 39, 70)
505:             .BackStyle = 0
506:             .Visible   = .T.
507:         ENDWITH
508: 
509:         par_oPagina.AddObject("lbl_4c_LegD", "Label")
510:         WITH par_oPagina.lbl_4c_LegD
511:             .Caption   = "D = Destino"
512:             .Top       = 224
513:             .Left      = 386
514:             .Width     = 75
515:             .Height    = 15
516:             .FontName  = "Verdana"
517:             .FontSize  = 8
518:             .FontBold  = .T.
519:             .ForeColor = RGB(216, 39, 70)
520:             .BackStyle = 0
521:             .Visible   = .T.
522:         ENDWITH
523: 
524:         par_oPagina.AddObject("lbl_4c_LegA", "Label")
525:         WITH par_oPagina.lbl_4c_LegA
526:             .Caption   = "A = Ambos"
527:             .Top       = 239
528:             .Left      = 386
529:             .Width     = 75
530:             .Height    = 15
531:             .FontName  = "Verdana"
532:             .FontSize  = 8
533:             .FontBold  = .T.

*-- Linhas 545 a 554:
545:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
546:         loc_oGrid = par_oPagina.grd_4c_Dados
547: 
548:         loc_oGrid.Top         = 120
549:         loc_oGrid.Left        = 141
550:         loc_oGrid.Width       = 237
551:         loc_oGrid.Height      = 221
552:         loc_oGrid.ColumnCount = 3
553: 
554:         WITH loc_oGrid

*-- Linhas 569 a 581:
569:         ENDWITH
570: 
571:         loc_oGrid.Column1.Width          = 60
572:         loc_oGrid.Column1.Header1.Caption = "Grupo"
573:         loc_oGrid.Column2.Width          = 100
574:         loc_oGrid.Column2.Header1.Caption = "Conta"
575:         loc_oGrid.Column3.Width          = 75
576:         loc_oGrid.Column3.Header1.Caption = "O/D/A"
577: 
578:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridDadosAfterRowColChange")
579: 
580:         *----------------------------------------------------------------------
581:         * BINDEVENTs para validacao de celulas do Grid (Column1/2/3 Text1)

*-- Linhas 719 a 735:
719:         loc_oCnt = par_oPagina.cnt_4c_BotoesAcao
720: 
721:         *----------------------------------------------------------------------
722:         * lbl_4c_LblGrupo - Label "Grupo : " (equivale a Label1 do legado)
723:         * Original: Top=323, Left=57, Width=45, Height=17
724:         * No container (Top=349): relative Top = 323+29-349 = 3
725:         *----------------------------------------------------------------------
726:         loc_oCnt.AddObject("lbl_4c_LblGrupo", "Label")
727:         WITH loc_oCnt.lbl_4c_LblGrupo
728:             .Caption   = "Grupo : "
729:             .Top       = 3
730:             .Left      = 57
731:             .Width     = 45
732:             .Height    = 17
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 747 a 756:
747:         *----------------------------------------------------------------------
748:         loc_oCnt.AddObject("txt_4c_Dgru", "TextBox")
749:         WITH loc_oCnt.txt_4c_Dgru
750:             .Top           = 0
751:             .Left          = 104
752:             .Width         = 289
753:             .Height        = 23
754:             .FontName      = "Tahoma"
755:             .FontSize      = 8
756:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 763 a 779:
763:         ENDWITH
764: 
765:         *----------------------------------------------------------------------
766:         * lbl_4c_LblConta - Label "Conta : " (equivale a Label2 do legado)
767:         * Original: Top=346, Left=57, Width=45, Height=17
768:         * No container: relative Top = 346+29-349 = 26
769:         *----------------------------------------------------------------------
770:         loc_oCnt.AddObject("lbl_4c_LblConta", "Label")
771:         WITH loc_oCnt.lbl_4c_LblConta
772:             .Caption   = "Conta : "
773:             .Top       = 26
774:             .Left      = 57
775:             .Width     = 45
776:             .Height    = 17
777:             .FontName  = "Tahoma"
778:             .FontSize  = 8
779:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 791 a 800:
791:         *----------------------------------------------------------------------
792:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
793:         WITH loc_oCnt.txt_4c_DConta
794:             .Top           = 24
795:             .Left          = 104
796:             .Width         = 289
797:             .Height        = 23
798:             .FontName      = "Tahoma"
799:             .FontSize      = 8
800:             .FontBold      = .T.

*-- Linhas 816 a 855:
816:         *----------------------------------------------------------------------
817:         loc_oCnt.AddObject("opt_4c_Permite", "OptionGroup")
818:         WITH loc_oCnt.opt_4c_Permite
819:             .Top         = 1
820:             .Left        = 408
821:             .Width       = 127
822:             .Height      = 46
823:             .ButtonCount = 2
824:             .Value       = 1
825:             .BackStyle   = 0
826:             .BorderStyle = 1
827:             .BorderColor = RGB(100, 100, 100)
828:             .SpecialEffect = 1
829:             .Visible     = .T.
830:         ENDWITH
831: 
832:         WITH loc_oCnt.opt_4c_Permite.Buttons(1)
833:             .Caption   = "Permitidas"
834:             .Value     = 1
835:             .Left      = 5
836:             .Top       = 5
837:             .Width     = 79
838:             .Height    = 15
839:             .AutoSize  = .T.
840:             .FontName  = "Tahoma"
841:             .FontSize  = 8
842:             .FontBold  = .T.
843:             .ForeColor = RGB(90, 90, 90)
844:             .BackStyle = 0
845:         ENDWITH
846: 
847:         WITH loc_oCnt.opt_4c_Permite.Buttons(2)
848:             .Caption   = "N" + CHR(227) + "o Permitidas"
849:             .Left      = 5
850:             .Top       = 24
851:             .Width     = 103
852:             .Height    = 15
853:             .AutoSize  = .T.
854:             .FontName  = "Tahoma"
855:             .FontSize  = 8

*-- Linhas 926 a 934:
926:             loc_cValor = ALLTRIM(loc_oGrd.Column1.Text1.Value)
927:             IF EMPTY(loc_cValor)
928:                 TRY
929:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.cmd_4c_Encerrar.SetFocus
930:                 CATCH
931:                 ENDTRY
932:             ENDIF
933:         ENDIF
934:     ENDPROC

*-- Linhas 1321 a 1334:
1321:         ENDIF
1322: 
1323:         IF VARTYPE(loc_oBotoes) = "O"
1324:             IF VARTYPE(loc_oBotoes.cmd_4c_Inserir) = "O"
1325:                 loc_oBotoes.cmd_4c_Inserir.Enabled = loc_lHabilita AND ;
1326:                     UPPER(ALLTRIM(THIS.this_cEscolha)) != "ALTERAR"
1327:             ENDIF
1328:             IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
1329:                 loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lHabilita AND ;
1330:                     UPPER(ALLTRIM(THIS.this_cEscolha)) != "INSERIR"
1331:             ENDIF
1332:         ENDIF
1333:     ENDPROC
1334: 

*-- Linhas 1366 a 1394:
1366: 
1367:         DO CASE
1368:         CASE loc_cEscolha == "INSERIR"
1369:             IF VARTYPE(loc_oBotoes.cmd_4c_Inserir) = "O"
1370:                 loc_oBotoes.cmd_4c_Inserir.Enabled = .T.
1371:             ENDIF
1372:             IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
1373:                 loc_oBotoes.cmd_4c_Excluir.Enabled = .F.
1374:             ENDIF
1375: 
1376:         CASE loc_cEscolha == "ALTERAR"
1377:             IF VARTYPE(loc_oBotoes.cmd_4c_Inserir) = "O"
1378:                 loc_oBotoes.cmd_4c_Inserir.Enabled = .F.
1379:             ENDIF
1380:             IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
1381:                 loc_oBotoes.cmd_4c_Excluir.Enabled = .T.
1382:             ENDIF
1383: 
1384:         OTHERWISE
1385:             IF VARTYPE(loc_oBotoes.cmd_4c_Inserir) = "O"
1386:                 loc_oBotoes.cmd_4c_Inserir.Enabled = .T.
1387:             ENDIF
1388:             IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
1389:                 loc_oBotoes.cmd_4c_Excluir.Enabled = .T.
1390:             ENDIF
1391:         ENDCASE
1392:     ENDPROC
1393: 
1394:     *==========================================================================


### BO (C:\4c\projeto\app\classes\GcpBO.prg):
*==============================================================================
* GcpBO.prg
* Business Object: Grupos/Contas Permitidas por Operacao (SigCdGcp)
* Herda de: BusinessBase
*
* Tabela principal: SigCdGcp
* Chave primaria  : cidchaves (char 20, gerado via GerarCidChaves)
*
* SigCdGcp schema:
*   cidchaves  char(20) PK
*   contas     char(10) FK SigCdCli.iclis
*   dopes      char(20) FK SigCdOpe.Dopes
*   grupos     char(10) FK SigCdGcr.Codigos
*   orides     char(1)  O=Origem / D=Destino / A=Ambos
*   blqcts     numeric(1,0)  1=Permitidas / 2=Nao Permitidas
*==============================================================================

DEFINE CLASS GcpBO AS BusinessBase

    *-- Identificacao da tabela (exigido pelo BusinessBase)
    this_cTabela     = "SigCdGcp"
    this_cCampoChave = "cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades de dados - mapeamento direto das colunas de SigCdGcp
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && char(20) - chave unica PK
    this_cContas    = ""   && char(10) - codigo da conta/cliente (FK SigCdCli.iclis)
    this_cDopes     = ""   && char(20) - codigo da operacao (FK SigCdOpe.Dopes)
    this_cGrupos    = ""   && char(10) - codigo do grupo contabil (FK SigCdGcr.Codigos)
    this_cOriDes    = ""   && char(1)  - O=Origem / D=Destino / A=Ambos
    this_nBlqCts    = 0    && numeric(1,0) - 1=Permitidas / 2=Nao Permitidas

    *--------------------------------------------------------------------------
    * Propriedades desnormalizadas (preenchidas via JOIN no carregamento)
    *--------------------------------------------------------------------------
    this_cDgrus = ""   && descricao do grupo  (SigCdGcr.Descrs)
    this_cRclis = ""   && nome do cliente/conta (SigCdCli.Rclis)

    *--------------------------------------------------------------------------
    * Propriedades de contexto de colecao
    * Este BO gerencia um CONJUNTO de registros para uma operacao
    *--------------------------------------------------------------------------
    this_cDopesAtual  = ""  && operacao atualmente sendo editada (filtro da colecao)
    this_nBlqCtsAtual = 1   && status da colecao (1=Permitidas / 2=Nao Permitidas)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGcp"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para o sistema de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCidChaves - Gera chave unica de 20 caracteres (substituto de fUniqueIds)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarCidChaves()
        LOCAL loc_cParte1, loc_cParte2
        loc_cParte1 = ALLTRIM(SYS(2015))
        loc_cParte2 = ALLTRIM(SYS(2015))
        RETURN PADR(loc_cParte1 + loc_cParte2, 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cContas    = TratarNulo(contas,    "C")
            THIS.this_cDopes     = TratarNulo(dopes,     "C")
            THIS.this_cGrupos    = TratarNulo(grupos,    "C")
            THIS.this_cOriDes    = TratarNulo(orides,    "C")
            THIS.this_nBlqCts    = TratarNulo(blqcts,    "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigCdGcp com JOIN de descricoes
    * par_cFiltro: filtro adicional WHERE (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF !EMPTY(THIS.this_cDopesAtual)
                loc_cWhere = "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopesAtual)
            ENDIF
            IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = "WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.Contas, a.Dopes, a.Grupos," + ;
                       " a.OriDes, a.BlqCts," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " " + loc_cWhere + ;
                       " ORDER BY a.Grupos, a.Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao buscar grupos/contas:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo CidChaves
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.Contas, a.Dopes, a.Grupos," + ;
                       " a.OriDes, a.BlqCts," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " WHERE a.CidChaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um registro em SigCdGcp (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = THIS.GerarCidChaves()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdGcp" + ;
                       " (CidChaves, Contas, Dopes, Grupos, OriDes, BlqCts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cContas)    + ", " + ;
                       EscaparSQL(THIS.this_cDopes)     + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                       EscaparSQL(THIS.this_cOriDes)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqCts) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro em SigCdGcp (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGcp SET" + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas)         + "," + ;
                       " Dopes  = " + EscaparSQL(THIS.this_cDopes)          + "," + ;
                       " Grupos = " + EscaparSQL(THIS.this_cGrupos)         + "," + ;
                       " OriDes = " + EscaparSQL(THIS.this_cOriDes)         + "," + ;
                       " BlqCts = " + FormatarNumeroSQL(THIS.this_nBlqCts)  + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de um registro (chamado por BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGcp" + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao excluir grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTmpGcOpe - Cria cursor local TmpGcOpe com dados de uma operacao
    * par_cDopes  : codigo da operacao (SigCdOpe.Dopes)
    * par_nBlqCts : BlqCts inicial (1=Permitidas / 2=Nao Permitidas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTmpGcOpe(par_cDopes, par_nBlqCts)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cDopesAtual  = par_cDopes
            THIS.this_nBlqCtsAtual = par_nBlqCts

            IF USED("TmpGcOpe")
                USE IN TmpGcOpe
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpGcOpe ;
                (CidChaves C(20), Dopes C(20), Grupos C(10), Contas C(10), ;
                 Dgrus C(60), Rclis C(80), OriDes C(1), BlqCts N(1))
            SET NULL OFF

            loc_cSQL = "SELECT a.CidChaves, a.Dopes, a.Grupos, a.Contas," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis," + ;
                       " a.OriDes, a.BlqCts" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " WHERE a.Dopes = " + EscaparSQL(par_cDopes) + ;
                       " ORDER BY a.Grupos, a.Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcpTemp")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_GcpTemp") > 0
                    SELECT TmpGcOpe
                    APPEND FROM DBF("cursor_4c_GcpTemp")
                ENDIF
                SELECT TmpGcOpe
                GO TOP
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao carregar grupos/contas da opera" + ;
                            CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_GcpTemp")
                USE IN cursor_4c_GcpTemp
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.CarregarTmpGcOpe")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicatas - Verifica se ha Grupos/Contas duplicados no TmpGcOpe
    * Retorna .T. se NAO ha duplicatas (pode salvar)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicatas()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        TRY
            IF USED("cursor_4c_SecKey")
                USE IN cursor_4c_SecKey
            ENDIF

            SELECT Grupos, Contas, SUM(1) AS Total ;
                FROM TmpGcOpe ;
                GROUP BY Grupos, Contas ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_SecKey NOFILTER

            IF RECCOUNT("cursor_4c_SecKey") > 0
                MostrarErro("Existem Grupos/Contas em duplicidade. Favor acertar!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_SecKey")
                USE IN cursor_4c_SecKey
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarDuplicatas")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarTmpGcOpe - Persiste TmpGcOpe no banco (SigCdGcp) para a operacao
    * Deleta registros antigos da operacao e insere os do TmpGcOpe
    * par_cDopes  : codigo da operacao
    * par_nBlqCts : BlqCts a aplicar em todos os registros
    *--------------------------------------------------------------------------
    PROCEDURE SalvarTmpGcOpe(par_cDopes, par_nBlqCts)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_cChave, loc_cGrupos, loc_cContas, loc_cOriDes, loc_nBlqCts
        loc_lResultado = .F.

        TRY
            IF !USED("TmpGcOpe")
                MostrarErro("Cursor TmpGcOpe n" + CHR(227) + ;
                            "o encontrado!", "Erro")
            ELSE
                *-- Remove linhas em branco do cursor local
                SELECT TmpGcOpe
                DELETE FOR EMPTY(ALLTRIM(Grupos)) OR EMPTY(ALLTRIM(Contas))
                PACK

                *-- Valida duplicatas antes de persistir
                IF !THIS.ValidarDuplicatas()
                    loc_lResultado = .F.
                ELSE
                    *-- Atualiza Dopes e BlqCts em todo o cursor local
                    SELECT TmpGcOpe
                    REPLACE ALL Dopes WITH par_cDopes, BlqCts WITH par_nBlqCts

                    *-- Garante CidChaves em linhas novas
                    GO TOP
                    DO WHILE !EOF()
                        IF EMPTY(ALLTRIM(CidChaves))
                            REPLACE CidChaves WITH THIS.GerarCidChaves()
                        ENDIF
                        SKIP
                    ENDDO

                    *-- Persiste no SQL Server em transacao atomica
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trn")
                    IF USED("cursor_4c_Trn")
                        USE IN cursor_4c_Trn
                    ENDIF

                    *-- Deleta registros antigos da operacao
                    loc_cSQL = "DELETE FROM SigCdGcp WHERE Dopes = " + ;
                               EscaparSQL(par_cDopes)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                    IF USED("cursor_4c_Del")
                        USE IN cursor_4c_Del
                    ENDIF

                    IF loc_nResultado < 0
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
                        IF USED("cursor_4c_Rb")
                            USE IN cursor_4c_Rb
                        ENDIF
                        MostrarErro("Erro ao limpar registros antigos:" + CHR(13) + ;
                                    CapturarErroSQL(), "Erro SQL")
                        loc_lResultado = .F.
                    ELSE
                        *-- Insere linhas do TmpGcOpe
                        SELECT TmpGcOpe
                        GO TOP
                        loc_lResultado = .T.

                        DO WHILE !EOF() AND loc_lResultado
                            loc_cChave  = ALLTRIM(CidChaves)
                            loc_cGrupos = ALLTRIM(Grupos)
                            loc_cContas = ALLTRIM(Contas)
                            loc_cOriDes = ALLTRIM(OriDes)
                            loc_nBlqCts = BlqCts

                            loc_cSQL = "INSERT INTO SigCdGcp" + ;
                                       " (CidChaves, Dopes, Grupos, Contas, OriDes, BlqCts)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cChave)  + ", " + ;
                                       EscaparSQL(par_cDopes)  + ", " + ;
                                       EscaparSQL(loc_cGrupos) + ", " + ;
                                       EscaparSQL(loc_cContas) + ", " + ;
                                       EscaparSQL(loc_cOriDes) + ", " + ;
                                       FormatarNumeroSQL(loc_nBlqCts) + ;
                                       ")"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                            IF USED("cursor_4c_Ins")
                                USE IN cursor_4c_Ins
                            ENDIF

                            IF loc_nResultado < 0
                                MostrarErro("Erro ao inserir linha:" + CHR(13) + ;
                                            CapturarErroSQL(), "Erro SQL")
                                loc_lResultado = .F.
                            ENDIF

                            SKIP
                        ENDDO

                        IF loc_lResultado
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_Cmt")
                            IF USED("cursor_4c_Cmt")
                                USE IN cursor_4c_Cmt
                            ENDIF
                            THIS.RegistrarAuditoria("INSERT")
                        ELSE
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
                            IF USED("cursor_4c_Rb")
                                USE IN cursor_4c_Rb
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
            IF USED("cursor_4c_Rb")
                USE IN cursor_4c_Rb
            ENDIF
            MostrarErro(loException, "GcpBO.SalvarTmpGcOpe")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida Grupo em SigCdGcr e retorna descricao
    * par_cGrupo : codigo a validar
    * par_cDescrs: (BYREF OUTPUT) descricao encontrada
    * Retorna .T. se grupo existe
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_cGrupo, par_cDescrs)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        par_cDescrs    = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cGrupo))
                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF

                loc_cSQL = "SELECT Descrs FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(par_cGrupo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Gcr") > 0
                    SELECT cursor_4c_Gcr
                    par_cDescrs = ALLTRIM(Descrs)
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarGrupo")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida Conta em SigCdCli e retorna Rclis
    * par_cConta : codigo da conta (SigCdCli.Iclis) a validar
    * par_cRclis : (BYREF OUTPUT) nome/razao social do cliente
    * Retorna .T. se conta existe
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta(par_cConta, par_cRclis)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        par_cRclis     = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cConta))
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF

                loc_cSQL = "SELECT Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(par_cConta)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cli") > 0
                    SELECT cursor_4c_Cli
                    par_cRclis = ALLTRIM(Rclis)
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarConta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("TmpGcOpe")
            USE IN TmpGcOpe
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

