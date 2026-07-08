# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGRECGP): Left original=359 vs migrado 'lbl_4c_Label1' Left=87 (diff=272px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecgp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (850 linhas total):

*-- Linhas 15 a 23:
15: *   * MostrarProgresso() - exibe/oculta indicador durante processamento
16: *   * Destroy() - libera BO e reabilita form pai
17: * FASE 4/8 - Filtros na Page1 (equivalente a ConfigurarPaginaLista para forms REPORT)
18: *   * ConfigurarPaginaFiltros() - Opc_Rel (5 tipos relatorio), Opc_Ordem, lbl_4c_Label1
19: *   * AlternarPagina() - navega entre paginas (compatibilidade pipeline)
20: *   * Habilita Buttons(5) condicionalmente pelo estado do form pai (get_opera??oi)
21: * FASE 5/8 - Acoes e transferencia de filtros (Parte 1)
22: *   * ConfigurarPaginaDados() - stub pipeline compat (form FLAT, sem Page2/Dados)
23: *   * FormParaRelatorio() - transfere Opc_Rel/Opc_Ordem do form para o BO

*-- Linhas 91 a 99:
91:         loc_lSucesso   = .F.
92:         loc_lContinuar = .T.
93:         TRY
94:             THIS.Caption = "Relat" + CHR(243) + "rio de Composi" + ;
95:                            CHR(231) + CHR(227) + "o de Produtos"
96: 
97:             IF TYPE("gc_4c_CaminhoIcones") = "U"
98:                 gc_4c_CaminhoIcones = ""
99:             ENDIF

*-- Linhas 145 a 154:
145:                 THIS.ConfigurarContainerProgresso()
146: 
147:                 *-- Atualiza caption nos labels do cabecalho apos criacao
148:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
149:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
150: 
151:                 *-- BINDEVENTs para todos os botoes de relatorio (Fases 5 e 6)
152:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
153:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
154:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

*-- Linhas 174 a 214:
174:     PROTECTED PROCEDURE ConfigurarCabecalho()
175:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
176:         WITH THIS.cnt_4c_Cabecalho
177:             .Top         = 0
178:             .Left        = 0
179:             .Width       = THIS.Width
180:             .Height      = 80
181:             .BackStyle   = 1
182:             .BackColor   = RGB(100, 100, 100)
183:             .BorderWidth = 0
184:             .Visible     = .T.
185: 
186:             *-- Sombra (deslocada 2px para efeito 3D sobre o fundo escuro)
187:             .AddObject("lbl_4c_Sombra", "Label")
188:             WITH .lbl_4c_Sombra
189:                 .Top       = 22
190:                 .Left      = 22
191:                 .Width     = THIS.Width
192:                 .Height    = 30
193:                 .Caption   = "Relat" + CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o de Produtos"
194:                 .FontName  = "Tahoma"
195:                 .FontSize  = 14
196:                 .FontBold  = .T.
197:                 .ForeColor = RGB(0, 0, 0)
198:                 .BackStyle = 0
199:                 .Visible   = .T.
200:             ENDWITH
201: 
202:             *-- Titulo em branco (visivel sobre a sombra preta)
203:             .AddObject("lbl_4c_Titulo", "Label")
204:             WITH .lbl_4c_Titulo
205:                 .Top       = 20
206:                 .Left      = 20
207:                 .Width     = THIS.Width
208:                 .Height    = 30
209:                 .Caption   = "Relat" + CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o de Produtos"
210:                 .FontName  = "Tahoma"
211:                 .FontSize  = 14
212:                 .FontBold  = .T.
213:                 .ForeColor = RGB(255, 255, 255)
214:                 .BackStyle = 0

*-- Linhas 229 a 254:
229:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
230:         WITH THIS.cmg_4c_Botoes
231:             .ButtonCount   = 4
232:             .Top           = 0
233:             .Left          = 495
234:             .Width         = 310
235:             .Height        = 85
236:             .BackStyle     = 0
237:             .BorderStyle   = 0
238:             .BorderColor   = RGB(136, 189, 188)
239:             .SpecialEffect = 1
240:             .Themes        = .F.
241:             .Visible       = .T.
242: 
243:             *-- Botao 1: Visualizar (preview em tela)
244:             WITH .Buttons(1)
245:                 .Top             = 5
246:                 .Left            = 5
247:                 .Width           = 75
248:                 .Height          = 75
249:                 .Caption         = "Visualizar"
250:                 .FontBold        = .T.
251:                 .FontItalic      = .T.
252:                 .BackColor       = RGB(255, 255, 255)
253:                 .ForeColor       = RGB(90, 90, 90)
254:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 263 a 275:
263: 
264:             *-- Botao 2: Imprimir (enviar para impressora)
265:             WITH .Buttons(2)
266:                 .Top             = 5
267:                 .Left            = 80
268:                 .Width           = 75
269:                 .Height          = 75
270:                 .Caption         = "Imprimir"
271:                 .FontName        = "Tahoma"
272:                 .FontBold        = .T.
273:                 .FontItalic      = .T.
274:                 .FontSize        = 8
275:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 286 a 298:
286: 
287:             *-- Botao 3: Excel (exportar dados)
288:             WITH .Buttons(3)
289:                 .Top             = 5
290:                 .Left            = 155
291:                 .Width           = 75
292:                 .Height          = 75
293:                 .Caption         = "Excel"
294:                 .FontName        = "Tahoma"
295:                 .FontBold        = .T.
296:                 .FontItalic      = .T.
297:                 .FontSize        = 8
298:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 309 a 321:
309: 
310:             *-- Botao 4: Encerrar (fechar dialogo, tecla ESC)
311:             WITH .Buttons(4)
312:                 .Top             = 5
313:                 .Left            = 230
314:                 .Width           = 75
315:                 .Height          = 75
316:                 .Caption         = "Encerrar"
317:                 .Cancel          = .T.
318:                 .FontName        = "Tahoma"
319:                 .FontBold        = .T.
320:                 .FontItalic      = .T.
321:                 .FontSize        = 8

*-- Linhas 351 a 374:
351:         loc_oPgf.PageCount = 2
352: 
353:         *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
354:         loc_oPgf.Top    = 85
355:         loc_oPgf.Left   = -1
356:         loc_oPgf.Width  = THIS.Width + 2
357:         loc_oPgf.Height = THIS.Height - 85
358:         loc_oPgf.Tabs   = .F.
359: 
360:         *-- Page1: Filtros (onde Opc_Rel, Opc_Ordem e Say1 serao adicionados)
361:         loc_oPgf.Page1.Caption   = "Filtros"
362:         loc_oPgf.Page1.FontName  = "Tahoma"
363:         loc_oPgf.Page1.FontSize  = 8
364:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
365:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
366:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
367: 
368:         *-- Page2: vazia (compatibilidade com pipeline BtnIncluirNavegacao)
369:         loc_oPgf.Page2.Caption   = ""
370:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
371: 
372:         loc_oPgf.Visible    = .T.
373:         loc_oPgf.ActivePage = 1
374:     ENDPROC

*-- Linhas 385 a 429:
385:     PROTECTED PROCEDURE ConfigurarContainerProgresso()
386:         THIS.AddObject("cnt_4c_Progresso", "Container")
387:         WITH THIS.cnt_4c_Progresso
388:             .Top           = 113
389:             .Left          = 289
390:             .Width         = 222
391:             .Height        = 66
392:             .SpecialEffect = 0
393:             .BackColor     = RGB(255, 255, 255)
394:             .BorderWidth   = 0
395:             .Visible       = .F.
396:         ENDWITH
397: 
398:         THIS.AddObject("lbl_4c_Aguarde", "Label")
399:         WITH THIS.lbl_4c_Aguarde
400:             .AutoSize  = .T.
401:             .FontBold  = .T.
402:             .FontName  = "Tahoma"
403:             .FontSize  = 11
404:             .BackStyle = 0
405:             .Caption   = "Aguarde !!!"
406:             .Height    = 20
407:             .Left      = 359
408:             .Top       = 126
409:             .Width     = 83
410:             .ForeColor = RGB(90, 90, 90)
411:             .Visible   = .F.
412:         ENDWITH
413: 
414:         THIS.AddObject("lbl_4c_Selecionando", "Label")
415:         WITH THIS.lbl_4c_Selecionando
416:             .AutoSize  = .T.
417:             .FontBold  = .T.
418:             .FontName  = "Tahoma"
419:             .FontSize  = 11
420:             .BackStyle = 0
421:             .Caption   = "Selecionando Registros..."
422:             .Height    = 20
423:             .Left      = 304
424:             .Top       = 144
425:             .Width     = 193
426:             .ForeColor = RGB(90, 90, 90)
427:             .Visible   = .F.
428:         ENDWITH
429:     ENDPROC

*-- Linhas 443 a 463:
443:         IF PEMSTATUS(THIS, "cnt_4c_Progresso", 5)
444:             THIS.cnt_4c_Progresso.Visible   = loc_lVisivel
445:         ENDIF
446:         IF PEMSTATUS(THIS, "lbl_4c_Aguarde", 5)
447:             THIS.lbl_4c_Aguarde.Visible     = loc_lVisivel
448:         ENDIF
449:         IF PEMSTATUS(THIS, "lbl_4c_Selecionando", 5)
450:             THIS.lbl_4c_Selecionando.Visible = loc_lVisivel
451:         ENDIF
452:         DOEVENTS
453:     ENDPROC
454: 
455:     *--------------------------------------------------------------------------
456:     * ConfigurarPaginaFiltros - Adiciona controles de filtro a Page1
457:     *   Equivalentes ao Opc_Rel, Opc_Ordem e Say1 do form original SIGRECGP.
458:     *   Posicoes relativas a Page1 (PageFrame.Top=85 subtraido do original).
459:     *   PILAR 1: captions e posicoes EXATAS do original (corrigido na Fase 6).
460:     *--------------------------------------------------------------------------
461:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
462:         LOCAL loc_oPage1, loc_oGrupo
463:         loc_oPage1 = THIS.pgf_4c_Paginas.Page1

*-- Linhas 469 a 574:
469:         loc_oGrupo = loc_oPage1.obj_4c_Opc_Rel
470:         loc_oGrupo.ButtonCount = 5
471:         WITH loc_oGrupo
472:             .Top       = 8
473:             .Left      = 81
474:             .Width     = 186
475:             .Height    = 102
476:             .Value     = 1
477:             .BackStyle = 0
478:             .Themes    = .F.
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481: 
482:             *-- Option1: Top=5, Left=5, AutoSize=.T. (original)
483:             WITH .Buttons(1)
484:                 .Top       = 5
485:                 .Left      = 5
486:                 .AutoSize  = .T.
487:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
488:                 .FontName  = "Tahoma"
489:                 .FontSize  = 8
490:                 .BackStyle = 0
491:                 .ForeColor = RGB(90, 90, 90)
492:                 .Themes    = .F.
493:                 .Visible   = .T.
494:             ENDWITH
495: 
496:             *-- Option2: Top=24, Left=5, AutoSize=.T. (original)
497:             WITH .Buttons(2)
498:                 .Top       = 24
499:                 .Left      = 5
500:                 .AutoSize  = .T.
501:                 .Caption   = "Custo / Venda"
502:                 .FontName  = "Tahoma"
503:                 .FontSize  = 8
504:                 .BackStyle = 0
505:                 .ForeColor = RGB(90, 90, 90)
506:                 .Themes    = .F.
507:                 .Visible   = .T.
508:             ENDWITH
509: 
510:             *-- Option3: Top=43, Left=5, Width=161, Height=17 (original)
511:             WITH .Buttons(3)
512:                 .Top       = 43
513:                 .Left      = 5
514:                 .Width     = 161
515:                 .Height    = 17
516:                 .Caption   = "Composi" + CHR(231) + CHR(227) + ;
517:                              "o Espec" + CHR(237) + "fica 1"
518:                 .FontName  = "Tahoma"
519:                 .FontSize  = 8
520:                 .BackStyle = 0
521:                 .ForeColor = RGB(90, 90, 90)
522:                 .Themes    = .F.
523:                 .Visible   = .T.
524:             ENDWITH
525: 
526:             *-- Option4: Top=62, Left=5, Width=165, Height=17 (original)
527:             WITH .Buttons(4)
528:                 .Top       = 62
529:                 .Left      = 5
530:                 .Width     = 165
531:                 .Height    = 17
532:                 .Caption   = "Composi" + CHR(231) + CHR(227) + ;
533:                              "o Espec" + CHR(237) + "fica 2"
534:                 .FontName  = "Tahoma"
535:                 .FontSize  = 8
536:                 .BackStyle = 0
537:                 .ForeColor = RGB(90, 90, 90)
538:                 .Themes    = .F.
539:                 .Visible   = .T.
540:             ENDWITH
541: 
542:             *-- Option5: Top=81, Left=5, Width=136, Height=17, Enabled=.F. (original)
543:             WITH .Buttons(5)
544:                 .Top       = 81
545:                 .Left      = 5
546:                 .Width     = 136
547:                 .Height    = 17
548:                 .Caption   = "Custo / Venda 2"
549:                 .FontName  = "Tahoma"
550:                 .FontSize  = 8
551:                 .BackStyle = 0
552:                 .ForeColor = RGB(90, 90, 90)
553:                 .Themes    = .F.
554:                 .Enabled   = .F.
555:                 .Visible   = .T.
556:             ENDWITH
557: 
558:             .Visible = .T.
559:         ENDWITH
560: 
561:         *-- lbl_4c_Label1: "Ordem : " ao lado da selecao de ordenacao
562:         *   Original: Top=200, Left=87 -> Relativo a Page1: Top = 115
563:         loc_oPage1.AddObject("lbl_4c_Label1", "Label")
564:         WITH loc_oPage1.lbl_4c_Label1
565:             .Top       = 115
566:             .Left      = 87
567:             .Width     = 48
568:             .Height    = 17
569:             .Caption   = "Ordem : "
570:             .FontName  = "Tahoma"
571:             .FontSize  = 8
572:             .BackStyle = 0
573:             .ForeColor = RGB(90, 90, 90)
574:             .Visible   = .T.

*-- Linhas 582 a 612:
582:         loc_oGrupo = loc_oPage1.obj_4c_Opc_Ordem
583:         WITH loc_oGrupo
584:             .ButtonCount = 2
585:             .Top       = 110
586:             .Left      = 135
587:             .Width     = 190
588:             .Height    = 27
589:             .Value     = 1
590:             .BackStyle = 0
591:             .Themes    = .F.
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594: 
595:             WITH .Buttons(1)
596:                 .Top      = 5
597:                 .Left     = 5
598:                 .AutoSize = .T.
599:                 .Caption  = "Produto"
600:                 .Visible  = .T.
601:             ENDWITH
602: 
603:             WITH .Buttons(2)
604:                 .Top      = 5
605:                 .Left     = 80
606:                 .AutoSize = .T.
607:                 .Caption  = "Ref.Fornecedor"
608:                 .Visible  = .T.
609:             ENDWITH
610: 
611:             .Visible = .T.
612:         ENDWITH


### BO (C:\4c\projeto\app\classes\sigrecgpBO.prg):
*==============================================================================
* SIGRECGPBO.PRG
* BO do Relatorio de Composicao de Produtos (SIGRECGP)
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrecgpBO AS RelatorioBase

    *-- Opcoes selecionadas pelo usuario no form
    this_nOpcRel      = 1    && 1=Comp, 2=Custo/Venda, 3=CompEsp1, 4=CompEsp2, 5=Custo/Venda2
    this_nOpcOrdem    = 1    && 1=Produto, 2=Ref.Fornecedor
    this_nVal         = 0    && Derivado: INLIST(tipo,2) -> 1, else 0

    *-- Referencia ao form pai e filtros
    this_oParentForm  = .NULL.
    this_cEmpEDN      = ""   && Chave empresa+operacao+operacaoid (tipo 5)

    *--------------------------------------------------------------------------
    * Init - Configura identificadores base
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Sem chave para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursor Relatorio com dados de composicao
    * Equivalente ao metodo processamento do legado
    * REQUER que CrProdutos esteja populado pelo form chamador
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nOrdem, loc_nTpRel, loc_lOK
        LOCAL loc_cEmpresa, loc_cTitulo, loc_nResult, loc_cSQL
        LOCAL loc_cGrupo, loc_cProdt, loc_nCnt
        LOCAL loc_cCodPro, loc_lFoundMov, loc_cFotoRel
        LOCAL loc_cFotoBranco, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_nOrdem = THIS.this_nOpcOrdem
            loc_nTpRel = THIS.this_nOpcRel

            THIS.this_nVal = IIF(INLIST(loc_nTpRel, 2) = .T., 1, 0)

            *-- Tipos 3 e 4: processamento especial de composicao especifica
            IF INLIST(loc_nTpRel, 3, 4)
                loc_lSucesso = THIS.PrepararDadosCompEsp1()
            ELSE
                *-- Tipos 1, 2, 5: processamento padrao

                *-- Obter nome da empresa para cabecalho
                loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpHdr")

                IF loc_nResult > 0
                    SELECT cursor_4c_EmpHdr
                    GO TOP
                    loc_cEmpresa = go_4c_Sistema.cCodEmpresa + " - " + ;
                                   IIF(!EMPTY(cursor_4c_EmpHdr.Razas), ;
                                       ALLTRIM(cursor_4c_EmpHdr.Razas), "")
                    USE IN cursor_4c_EmpHdr
                ELSE
                    loc_cEmpresa = go_4c_Sistema.cCodEmpresa
                ENDIF

                loc_cTitulo = "RELAT" + CHR(211) + "RIO DE COMPOSI" + ;
                              CHR(199) + CHR(195) + "O DE PRODUTOS"

                *-- Cursor de cabecalho para o relatorio
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF
                CREATE CURSOR csCabecalho (NomeEmpresa c(80), Titulo c(200), ImpImagem l(1))
                INSERT INTO csCabecalho (NomeEmpresa, Titulo, ImpImagem) ;
                    VALUES (loc_cEmpresa, loc_cTitulo, .T.)

                *-- Imagem em branco para produtos sem foto
                IF USED("CrBranco")
                    USE IN CrBranco
                ENDIF
                CREATE CURSOR CrBranco (Branco M)
                SELECT CrBranco
                APPEND BLANK

                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 carqicones, marqicones FROM SigSyIco", ;
                    "cursor_4c_BrJpg")

                IF loc_nResult > 0
                    SELECT cursor_4c_BrJpg
                    GO TOP
                    IF !EOF() AND !EMPTY(cursor_4c_BrJpg.marqicones)
                        SELECT CrBranco
                        REPLACE Branco WITH cursor_4c_BrJpg.marqicones IN CrBranco
                    ENDIF
                    USE IN cursor_4c_BrJpg
                ENDIF

                IF !EMPTY(CrBranco.Branco)
                    loc_cFotoBranco = STRCONV(STRTRAN(STRTRAN(STRTRAN(CrBranco.Branco, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFotoBranco, SYS(2023) + "\FBRANCOS.JPG")
                ENDIF

                *-- Cursores temporarios de dados
                IF USED("Tmp_Memos")
                    USE IN Tmp_Memos
                ENDIF
                CREATE CURSOR Tmp_Memos (Cids c(1), Imagem m, ValTot m, MoeTot m)

                IF USED("Tmp_Compos")
                    USE IN Tmp_Compos
                ENDIF

                *-- Popula Tmp_Compos conforme tipo de relatorio
                loc_lOK = .T.

                IF INLIST(loc_nTpRel, 5)
                    *-- Tipo 5: dados de composicao filtrados pela operacao
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros,a.mats,a.dcompos,a.cats," + ;
                        "a.qtscons*b.qtds as qtscons,a.unicompos," + ;
                        "a.moeds,a.cgrus,a.obscompos,a.etiqs," + ;
                        "a.vlrcvs,a.qtdcvs*b.qtds as qtdcvs," + ;
                        "a.qtds,a.pcompos,b.totas,b.moedas " + ;
                        "FROM SigPrCpo a, SigMvItN b " + ;
                        "WHERE b.cpros = a.cpros" + ;
                        " AND empdopnums = " + EscaparSQL(THIS.this_cEmpEDN), ;
                        "TmpAux")

                    IF loc_nResult > 0
                        *-- Acumula por material
                        SELECT cpros, mats, MAX(dcompos) as dcompos, ;
                               MAX(cats) as cats, ;
                               SUM(ROUND(qtscons,3)) as qtscons, ;
                               MAX(unicompos) as unicompos, ;
                               MAX(moeds) as moeds, ;
                               MAX(cgrus) as cgrus, ;
                               MAX(obscompos) as obscompos, ;
                               MAX(etiqs) as etiqs, ;
                               SUM(vlrcvs) as vlrcvs, ;
                               SUM(ROUND(qtdcvs,3)) as qtdcvs, ;
                               SUM(qtds) as qtds, ;
                               SUM(pcompos) as pcompos, ;
                               00000000.00 as valtotmoe, ;
                               0 as ps ;
                            FROM TmpAux GROUP BY cpros, mats ;
                            INTO CURSOR AuxCompos READWRITE

                        *-- Totais de consumo por produto
                        SELECT cpros, 'xxxxxxxxxxxxxx' as mats, ;
                               SUM(qtscons) as qtscons ;
                            FROM AuxCompos GROUP BY cpros ;
                            INTO CURSOR AuxCons

                        *-- Totais de qtdcvs por unidade/produto
                        SELECT cpros, 'xxxxxxxxxxxxxx' as mats, ;
                               unicompos, SUM(qtdcvs) as qtdcvs ;
                            FROM AuxCompos GROUP BY cpros, unicompos ;
                            INTO CURSOR AuxMat

                        *-- Totais de valor por moeda/produto
                        SELECT cpros, 'xxxxxxxxxxxxxx' as mats, ;
                               moeds, SUM(vlrcvs*qtdcvs) as valtotmoe ;
                            FROM AuxCompos GROUP BY cpros, moeds ;
                            INTO CURSOR AuxMoe

                        *-- Totais gerais por material
                        SELECT mats, dcompos, unicompos, ;
                               MAX(moeds) as moeds, ;
                               SUM(qtscons) as qtscons, ;
                               SUM(qtdcvs) as qtdcvs, ;
                               SUM(vlrcvs*qtdcvs) as valtotmoe ;
                            FROM AuxCompos GROUP BY mats, dcompos, unicompos ;
                            INTO CURSOR AuxG

                        *-- Consolida qtscons no AuxCompos
                        SELECT AuxCons
                        GO TOP
                        SCAN
                            SELECT AuxCompos
                            LOCATE FOR cpros = AuxCons.cpros AND ;
                                        mats = 'xxxxxxxxxxxxxx' AND qtscons = 0
                            IF !FOUND()
                                APPEND BLANK
                                REPLACE ps WITH 1
                            ENDIF
                            REPLACE mats WITH 'xxxxxxxxxxxxxx', ;
                                    cgrus WITH 'xxx', ;
                                    cpros WITH AuxCons.cpros, ;
                                    qtscons WITH AuxCons.qtscons
                            SELECT AuxCons
                        ENDSCAN

                        *-- Consolida qtdcvs no AuxCompos
                        SELECT AuxMat
                        GO TOP
                        SCAN
                            SELECT AuxCompos
                            LOCATE FOR cpros = AuxMat.cpros AND ;
                                        mats = 'xxxxxxxxxxxxxx' AND ;
                                        unicompos = '   '
                            IF !FOUND()
                                APPEND BLANK
                            ENDIF
                            REPLACE mats WITH 'xxxxxxxxxxxxxx', ;
                                    cgrus WITH 'xxx', ;
                                    cpros WITH AuxMat.cpros, ;
                                    unicompos WITH AuxMat.unicompos, ;
                                    qtdcvs WITH AuxMat.qtdcvs
                            SELECT AuxMat
                        ENDSCAN

                        *-- Consolida valtotmoe no AuxCompos
                        SELECT AuxMoe
                        GO TOP
                        SCAN
                            SELECT AuxCompos
                            LOCATE FOR cpros = AuxMoe.cpros AND ;
                                        mats = 'xxxxxxxxxxxxxx' AND ;
                                        moeds = '   '
                            IF !FOUND()
                                APPEND BLANK
                            ENDIF
                            REPLACE mats WITH 'xxxxxxxxxxxxxx', ;
                                    cgrus WITH 'xxx', ;
                                    cpros WITH AuxMoe.cpros, ;
                                    moeds WITH AuxMoe.moeds, ;
                                    valtotmoe WITH AuxMoe.valtotmoe
                            SELECT AuxMoe
                        ENDSCAN

                        SELECT * FROM AuxCompos ORDER BY cpros, mats ;
                            INTO CURSOR Tmp_Compos READWRITE

                        SELECT cpros, MAX(totas) as totas, MAX(moedas) as moedas ;
                            FROM TmpAux GROUP BY cpros ;
                            INTO CURSOR TmpMov READWRITE

                        *-- Totais por material (variavel publica lida pelo relatorio)
                        PUBLIC pcTotais
                        pcTotais = "TOTAIS POR MATERIAL" + CHR(10)
                        pcTotais = pcTotais + ;
                            "Material      Descricao                       " + ;
                            "           Consumo      Qtde Un      Total" + CHR(10)
                        pcTotais = pcTotais + ;
                            "________________________________________________" + ;
                            "_________________________________________" + CHR(10)
                        SELECT AuxG
                        GO TOP
                        SCAN
                            pcTotais = pcTotais + AuxG.mats + dcompos + ;
                                       TRANSFORM(qtscons, "@R 999999.999") + ;
                                       TRANSFORM(qtdcvs, "@R 999999.999") + ;
                                       " " + unicompos + ;
                                       TRANSFORM(valtotmoe, "@R 9999999.99") + ;
                                       " " + moeds + CHR(10)
                        ENDSCAN
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao buscar dados da opera" + ;
                            CHR(231) + CHR(227) + "o"
                        loc_lOK = .F.
                    ENDIF
                ELSE
                    *-- Tipos 1 e 2: todos os dados de composicao
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros,a.mats,a.dcompos,a.cats," + ;
                        "a.qtscons,a.unicompos,a.moeds,a.cgrus," + ;
                        "a.obscompos,a.etiqs,a.vlrcvs,a.qtdcvs," + ;
                        "a.qtds,a.pcompos," + ;
                        "CAST(0 AS NUMERIC(8,2)) as valtotmoe," + ;
                        "0 as ps " + ;
                        "FROM SigPrCpo a", ;
                        "Tmp_Compos")

                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao buscar composicao dos produtos"
                        loc_lOK = .F.
                    ENDIF
                ENDIF

                IF loc_lOK
                    *-- CsRels: join CrProdutos x Tmp_Compos
                    SELECT a.cpros      AS Codigo, ;
                           a.dpros      AS Descricao, ;
                           SPACE(10)    AS Linha, ;
                           SPACE(3)     AS Unidade, ;
                           000000.00    AS Peso, ;
                           00000000.00  AS PreCusto, ;
                           SPACE(3)     AS MoeCusto, ;
                           00000000.00  AS PreVenda, ;
                           SPACE(3)     AS MoeVenda, ;
                           000000000.00 AS PreIdeal, ;
                           SPACE(3)     AS MoeIdeal, ;
                           c.mats       AS CodMateria, ;
                           c.dcompos    AS DesMateria, ;
                           c.cats       AS Categoria, ;
                           c.qtscons    AS Consumo, ;
                           IIF(loc_nTpRel = 1, c.qtds, c.qtdcvs) AS Quantidade, ;
                           c.unicompos  AS UniMateria, ;
                           IIF(loc_nTpRel = 1, c.pcompos, c.vlrcvs) AS ValMateria, ;
                           c.moeds      AS MoeMateria, ;
                           c.cpros + c.cgrus AS Grupos, ;
                           999999       AS Quadro, ;
                           SPACE(8)     AS OrdImg, ;
                           SPACE(15)    AS RefFor, ;
                           c.obscompos  AS Observa, ;
                           SPACE(6)     AS SubGrupo, ;
                           c.etiqs      AS Imprime, ;
                           c.cgrus      AS GruProd, ;
                           SPACE(20)    AS DesGrupo, ;
                           c.valtotmoe  AS valtotmoe, ;
                           c.ps         AS Ps ;
                        FROM CrProdutos a, Tmp_Compos c ;
                        WHERE a.cpros = c.cpros ;
                            AND IIF(INLIST(loc_nTpRel, 2), c.vlrcvs # 0, .T.) ;
                        ORDER BY a.cpros + c.cgrus ;
                        INTO CURSOR CsRels

                    *-- CsRelatorio: adiciona colunas de memo (imagem, totais)
                    SELECT a.*, b.Imagem, b.ValTot, b.MoeTot ;
                        FROM CsRels a ;
                        FULL JOIN Tmp_Memos b ON b.cids = ' ' ;
                        INTO CURSOR CsRelatorio

                    IF USED("CsRels")
                        USE IN CsRels
                    ENDIF

                    IF USED("Relatorio")
                        USE IN Relatorio
                    ENDIF

                    *-- Abre segunda referencia para permitir sub-SELECTs durante SCAN
                    USE DBF("CsRelatorio") ALIAS Relatorio IN 0 AGAIN

                    *-- Enriquece cada produto com dados detalhados do SQL
                    SELECT Relatorio
                    GO TOP
                    SCAN
                        loc_cCodPro   = Relatorio.Codigo
                        loc_lFoundMov = .F.

                        IF USED("TmpProds")
                            USE IN TmpProds
                        ENDIF

                        IF INLIST(loc_nTpRel, 5) AND USED("TmpMov")
                            SELECT TmpMov
                            LOCATE FOR cpros = loc_cCodPro
                            loc_lFoundMov = FOUND()
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT a.cpros,a.linhas,a.cunis,a.pesoms," + ;
                            "a.custofs,a.moecusfs,a.moecs," + ;
                            "a.pvens,a.moevs,a.pvideals," + ;
                            "a.moedas,a.reffs,a.figjpgs," + ;
                            "a.sgrus,s.descricaos " + ;
                            "FROM SigCdPro a " + ;
                            "LEFT JOIN SigCdPsg s ON a.sgrus = s.codigos " + ;
                            "WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
                            "TmpProds")

                        SELECT TmpProds
                        GO TOP
                        IF !EOF()
                            SELECT Relatorio
                            REPLACE Relatorio.Linha    WITH TmpProds.linhas, ;
                                    Relatorio.Unidade  WITH TmpProds.cunis, ;
                                    Relatorio.Peso     WITH TmpProds.pesoms, ;
                                    Relatorio.PreCusto WITH TmpProds.custofs, ;
                                    Relatorio.MoeCusto WITH ;
                                        IIF(loc_nTpRel = 1, ;
                                            TmpProds.moecusfs, TmpProds.moecs), ;
                                    Relatorio.PreIdeal WITH TmpProds.pvideals, ;
                                    Relatorio.MoeIdeal WITH TmpProds.moedas, ;
                                    Relatorio.Imagem   WITH ;
                                        STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                            TmpProds.figjpgs, ;
                                            "data:image/png;base64,",""), ;
                                            "data:image/jpeg;base64,",""), ;
                                            "data:image/jpg;base64,",""),14), ;
                                    Relatorio.RefFor   WITH TmpProds.reffs, ;
                                    Relatorio.SubGrupo WITH TmpProds.sgrus, ;
                                    Relatorio.DesGrupo WITH TmpProds.descricaos

                            *-- Preco de venda: tipo 5 usa preco da movimentacao
                            IF loc_lFoundMov = .T.
                                REPLACE Relatorio.PreVenda WITH TmpMov.totas, ;
                                        Relatorio.MoeVenda WITH TmpMov.moedas
                            ELSE
                                REPLACE Relatorio.PreVenda WITH TmpProds.pvens, ;
                                        Relatorio.MoeVenda WITH TmpProds.moevs
                            ENDIF
                        ENDIF
                        SELECT Relatorio
                    ENDSCAN

                    *-- Indexa por referencia + grupo + quadro
                    INDEX ON RefFor + Grupos + STR(Quadro, 6) TAG Ordem
                    SET ORDER TO Ordem

                    loc_nCnt   = 0
                    loc_cGrupo = Relatorio.RefFor + Relatorio.Grupos
                    loc_cProdt = SUBSTR(Relatorio.Grupos, 1, 10)

                    *-- Processa imagens, totais por grupo e ordenacao de quadros
                    SELECT Relatorio
                    GO TOP
                    SCAN
                        REPLACE Relatorio.ValTot WITH "", ;
                                Relatorio.MoeTot WITH ""

                        IF EMPTY(Imagem) OR ISNULL(Imagem)
                            REPLACE Relatorio.OrdImg WITH "FBRANCOS"
                        ELSE
                            REPLACE Relatorio.OrdImg WITH "F" + PADL(RECNO(), 7, "0")
                            loc_cFotoRel = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                Relatorio.Imagem, ;
                                "data:image/png;base64,",""), ;
                                "data:image/jpeg;base64,",""), ;
                                "data:image/jpg;base64,",""), 14)
                            STRTOFILE(loc_cFotoRel, SYS(2023) + "\F" + ;
                                      PADL(RECNO(), 7, "0") + ".Jpg")
                        ENDIF

                        IF Relatorio.Imprime = "S" AND loc_nTpRel = 2
                            IF !EMPTY(Relatorio.Observa) AND !ISNULL(Relatorio.Observa)
                                REPLACE Relatorio.DesMateria WITH Relatorio.Observa
                            ELSE
                                IF !EMPTY(Relatorio.DesGrupo) AND !ISNULL(Relatorio.DesGrupo)
                                    REPLACE Relatorio.DesMateria WITH Relatorio.DesGrupo
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Ao mudar de grupo: calcula totais do grupo anterior
                        IF loc_cGrupo # Relatorio.RefFor + Relatorio.Grupos
                            SKIP -1

                            SELECT a.Grupos, a.MoeCusto, ;
                                   SUM(a.Quantidade * a.ValMateria) AS Valor ;
                                FROM CsRelatorio a ;
                                WHERE a.RefFor + a.Grupos = loc_cGrupo ;
                                GROUP BY a.Grupos, a.MoeCusto ;
                                INTO CURSOR csMoedas

                            SELECT csMoedas
                            SCAN
                                SELECT Relatorio
                                REPLACE Relatorio.ValTot WITH ;
                                    IIF(EMPTY(ValTot), ;
                                        TRANSFORM(csMoedas.Valor, "999,999.99"), ;
                                        ValTot + CHR(13) + ;
                                        TRANSFORM(csMoedas.Valor, "999,999.99")), ;
                                    Relatorio.MoeTot WITH ;
                                    IIF(EMPTY(MoeTot), ;
                                        csMoedas.MoeCusto, ;
                                        MoeTot + CHR(13) + csMoedas.MoeCusto)
                                SELECT csMoedas
                            ENDSCAN

                            SELECT Relatorio
                            SKIP
                            loc_cGrupo = Relatorio.RefFor + Relatorio.Grupos
                        ENDIF

                        IF loc_cProdt # SUBSTR(Relatorio.Grupos, 1, 10)
                            loc_cProdt = SUBSTR(Relatorio.Grupos, 1, 10)
                            loc_nCnt = 0
                        ENDIF

                        REPLACE Relatorio.Quadro WITH loc_nCnt
                        SELECT Relatorio
                        loc_nCnt = loc_nCnt + 1
                    ENDSCAN

                    *-- Calcula totais do ultimo grupo
                    SELECT Relatorio
                    GO BOTTOM

                    SELECT a.Grupos, a.MoeCusto, ;
                           SUM(a.Quantidade * a.ValMateria) AS Valor ;
                        FROM CsRelatorio a ;
                        WHERE a.RefFor + a.Grupos = loc_cGrupo ;
                        GROUP BY a.Grupos, a.MoeCusto ;
                        INTO CURSOR CsMoedas

                    SELECT CsMoedas
                    SCAN
                        SELECT Relatorio
                        REPLACE Relatorio.ValTot WITH ;
                            IIF(EMPTY(ValTot), ;
                                TRANSFORM(CsMoedas.Valor, "999,999.99"), ;
                                ValTot + CHR(13) + TRANSFORM(CsMoedas.Valor, "999,999.99")), ;
                            Relatorio.MoeTot WITH ;
                            IIF(EMPTY(MoeTot), ;
                                CsMoedas.MoeCusto, ;
                                MoeTot + CHR(13) + CsMoedas.MoeCusto)
                        SELECT CsMoedas
                    ENDSCAN

                    *-- Ordenacao final
                    SELECT Relatorio
                    IF loc_nOrdem = 1
                        INDEX ON Grupos + STR(Quadro, 6) TAG Ordem
                    ENDIF
                    SET ORDER TO Ordem
                    GO TOP

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosCompEsp1 - Prepara cursor crProCompos para tipos 3 e 4
    * Equivalente ao metodo proccompesp1 do legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosCompEsp1()
        LOCAL loc_lSucesso, loc_lOK, loc_cEmp, loc_nResult
        LOCAL loc_lcImgJpg, loc_oErro
        LOCAL loc_cCodPro, loc_lcCompos, loc_cMaoObraPro, loc_cMaoObraGarra
        LOCAL loc_lcArquivo, loc_xImg, loc_lcFoto

        loc_lSucesso = .F.

        TRY
            *-- Nome da empresa para o cabecalho
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Razas FROM SigCdEmp", ;
                "cursor_4c_TmpEmp")

            IF loc_nResult > 0
                SELECT cursor_4c_TmpEmp
                GO TOP
                loc_cEmp = IIF(!EOF(), ALLTRIM(cursor_4c_TmpEmp.Razas), "")
                USE IN cursor_4c_TmpEmp
            ELSE
                loc_cEmp = go_4c_Sistema.cCodEmpresa
            ENDIF

            *-- Cursor de cabecalho
            IF USED("Cabecalho")
                USE IN Cabecalho
            ENDIF
            CREATE CURSOR Cabecalho (Empresa c(50), Titulos c(50), lImpTit l)
            INSERT INTO Cabecalho (Empresa, Titulos, lImpTit) ;
                VALUES (loc_cEmp, ;
                    "Composi" + CHR(231) + CHR(227) + "o Espec" + CHR(237) + "fica 1", ;
                    .F.)

            *-- Cursor de resultado da composicao especifica
            IF USED("crProCompos")
                USE IN crProCompos
            ENDIF
            CREATE CURSOR crProCompos ( ;
                cPros c(14), dPros c(40), PesoMs n(12,2), PVens n(12,2), ;
                Compos m, DtIncs d, DataAlts d, CodGarras c(10), ;
                cProdPai c(14), MoeVs c(3), PrecoGarra n(12,2), ;
                PesoGarra n(12,2), MoeGarra c(3), ;
                cMObraPro c(50), cMObraGarra c(50), Colecoes c(10))

            *-- Imagem em branco via SigSyIco
            loc_lcImgJpg = ""
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 carqicones, marqicones FROM SigSyIco", ;
                "cursor_4c_Icone1")

            IF loc_nResult > 0
                SELECT cursor_4c_Icone1
                GO TOP
                IF !EOF()
                    loc_lcImgJpg = NVL(cursor_4c_Icone1.marqicones, "")
                ENDIF
                USE IN cursor_4c_Icone1
            ENDIF

            IF USED("CrBranco")
                USE IN CrBranco
            ENDIF
            CREATE CURSOR CrBranco (branco m)
            SELECT CrBranco
            APPEND BLANK
            IF !EMPTY(loc_lcImgJpg)
                REPLACE Branco WITH loc_lcImgJpg IN CrBranco
            ENDIF

            *-- Verifica cursor de produtos do form chamador
            IF !USED("CrProdutos")
                THIS.this_cMensagemErro = "Cursor CrProdutos n" + CHR(227) + ;
                    "o encontrado. O form chamador deve popular este cursor antes de chamar PrepararDados."
                loc_lSucesso = .F.
                loc_lOK = .F.
            ELSE
                loc_lOK = .T.
            ENDIF

            IF loc_lOK
                *-- Percorre cada produto e monta o cursor de composicao especifica
                SELECT CrProdutos
                GO TOP IN CrProdutos
                SCAN WHILE loc_lOK
                    loc_cCodPro       = CrProdutos.cPros
                    loc_lcCompos      = ""
                    loc_cMaoObraPro   = ""
                    loc_cMaoObraGarra = ""

                    *-- Dados principais do produto e garra
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT b.CPros, MAX(b.dpros) as dpros," + ;
                        " b.PVens, b.PesoMs, b.DtIncs," + ;
                        " MAX(c.DataAlts) as DataAlts, b.Colecoes," + ;
                        " b.CodGarras, b.cProEqs, b.MoeVs," + ;
                        " d.PVens as PrecoGarra," + ;
                        " d.PesoMs as PesoGarra," + ;
                        " d.MoeVs as MoeGarra" + ;
                        " FROM SigCdPro b" + ;
                        " LEFT JOIN SigCdPro d ON d.cPros = b.CodGarras" + ;
                        " LEFT JOIN SigCdPrc c ON c.cPros = b.cPros" + ;
                        " WHERE b.cPros = " + EscaparSQL(loc_cCodPro) + ;
                        " GROUP BY b.cPros, b.PVens, b.PesoMs, b.DtIncs," + ;
                        " b.Colecoes, b.CodGarras, b.cProEqs," + ;
                        " b.MoeVs, d.PVens, d.PesoMs, d.MoeVs" + ;
                        " ORDER BY b.CPros", ;
                        "crTmpPro")

                    IF loc_nResult < 1
                        MsgErro("Falha na conex" + CHR(227) + ;
                            "o ao buscar produto " + loc_cCodPro, ;
                            "PrepararDadosCompEsp1")
                        loc_lOK = .F.
                    ENDIF

                    IF loc_lOK
                        *-- Composicao do produto
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT a.cGrus, a.Mats, a.dCompos, a.Qtds," + ;
                            " a.UniCompos, a.Pesos, a.cUniPs," + ;
                            " b.CustoFs, c.nTipoJoals" + ;
                            " FROM SigPrCpo a" + ;
                            " INNER JOIN SigCdPro b ON b.cPros = a.Mats" + ;
                            " INNER JOIN SigCdGrp c ON c.cGrus = a.cGrus" + ;
                            " WHERE a.cPros = " + EscaparSQL(loc_cCodPro), ;
                            "crTmpCompo")

                        IF loc_nResult < 1
                            MsgErro("Falha na conex" + CHR(227) + ;
                                "o ao buscar composi" + CHR(231) + CHR(227) + ;
                                "o de " + loc_cCodPro, ;
                                "PrepararDadosCompEsp1")
                            loc_lOK = .F.
                        ENDIF
                    ENDIF

                    IF loc_lOK
                        *-- Monta string de composicao e identifica mao de obra
                        SELECT crTmpCompo
                        SCAN
                            IF crTmpCompo.nTipoJoals = 4
                                loc_cMaoObraPro = loc_cMaoObraPro + ;
                                    IIF(!EMPTY(loc_cMaoObraPro), "/", "") + ;
                                    ALLTRIM(crTmpCompo.Mats)
                            ENDIF
                            loc_lcCompos = loc_lcCompos + ;
                                IIF(!EMPTY(loc_lcCompos), CHR(13) + CHR(10), "")
                            loc_lcCompos = loc_lcCompos + crTmpCompo.Mats + "  " + ;
                                LEFT(crTmpCompo.dCompos, 34) + " " + ;
                                TRANSFORM(crTmpCompo.Qtds, "9999.999") + " " + ;
                                crTmpCompo.UniCompos + " " + ;
                                TRANSFORM(crTmpCompo.Pesos, "9999.999") + " " + ;
                                crTmpCompo.cUniPs
                        ENDSCAN

                        *-- Mao de obra da garra (acessorio do produto)
                        SELECT crTmpPro
                        GO TOP
                        IF !EMPTY(crTmpPro.CodGarras)
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT a.Mats" + ;
                                " FROM SigPrCpo a" + ;
                                " INNER JOIN SigCdPro b ON b.cPros = a.Mats" + ;
                                " INNER JOIN SigCdGrp c ON c.cGrus = a.cGrus" + ;
                                " WHERE a.cPros = " + EscaparSQL(crTmpPro.CodGarras) + ;
                                " AND c.nTipoJoals = 4", ;
                                "crMaoObra")

                            IF loc_nResult < 1
                                MsgErro("Falha na conex" + CHR(227) + ;
                                    "o ao buscar m" + CHR(227) + ;
                                    "o de obra da garra", ;
                                    "PrepararDadosCompEsp1")
                                loc_lOK = .F.
                            ELSE
                                SELECT crMaoObra
                                SCAN
                                    loc_cMaoObraGarra = loc_cMaoObraGarra + ;
                                        IIF(!EMPTY(loc_cMaoObraGarra), "/", "") + ;
                                        ALLTRIM(crMaoObra.Mats)
                                ENDSCAN
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lOK
                        *-- Imagem do produto
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT FigJpgs FROM SigCdPro" + ;
                            " WHERE cPros = " + EscaparSQL(loc_cCodPro), ;
                            "cursor_4c_LocPro")

                        *-- Limpa codigo do produto para uso como nome de arquivo
                        SELECT crTmpPro
                        GO TOP
                        loc_xImg = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(STRTRAN( ;
                            crTmpPro.cPros, "/", ""), " ", ""), ".", ""), "\", ""))
                        loc_lcArquivo = SYS(2023) + "\T" + loc_xImg + ".jpg"

                        CLEAR RESOURCES
                        IF loc_nResult > 0
                            SELECT cursor_4c_LocPro
                            GO TOP
                            IF !EOF() AND !EMPTY(cursor_4c_LocPro.FigJpgs)
                                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    cursor_4c_LocPro.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                            ELSE
                                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    CrBranco.Branco, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                            ENDIF
                            USE IN cursor_4c_LocPro
                        ELSE
                            loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                CrBranco.Branco, ;
                                "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                                "data:image/jpg;base64,", ""), 14)
                        ENDIF

                        STRTOFILE(loc_lcFoto, loc_lcArquivo)

                        *-- Insere registro no cursor de resultado
                        SELECT crTmpPro
                        GO TOP
                        INSERT INTO crProCompos ( ;
                            cPros, dPros, PesoMs, PVens, Compos, ;
                            DtIncs, DataAlts, CodGarras, cProdPai, ;
                            MoeVs, PrecoGarra, PesoGarra, MoeGarra, ;
                            cMObraPro, cMObraGarra, Colecoes) ;
                            VALUES ( ;
                            crTmpPro.cPros, crTmpPro.dpros, ;
                            crTmpPro.PesoMs, crTmpPro.PVens, ;
                            loc_lcCompos, ;
                            NVL(crTmpPro.DtIncs, {}), ;
                            NVL(crTmpPro.DataAlts, {}), ;
                            crTmpPro.CodGarras, crTmpPro.cProEqs, ;
                            crTmpPro.MoeVs, ;
                            NVL(crTmpPro.PrecoGarra, 0), ;
                            NVL(crTmpPro.PesoGarra, 0), ;
                            NVL(crTmpPro.MoeGarra, ""), ;
                            loc_cMaoObraPro, loc_cMaoObraGarra, ;
                            crTmpPro.Colecoes)

                        SELECT CrProdutos
                    ENDIF
                ENDSCAN

                IF loc_lOK
                    SELECT crProCompos
                    GO TOP IN crProCompos
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDadosCompEsp1")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime o relatorio em impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_nTpRel, loc_lcApagar, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_nTpRel = THIS.this_nOpcRel

            IF loc_nTpRel = 1
                REPORT FORM SigReCgp TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 2)
                REPORT FORM SigReCg1 TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 5)
                REPORT FORM SigReCg2 TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF loc_nTpRel = 3
                REPORT FORM SigPrCpr TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF loc_nTpRel = 4
                REPORT FORM SigPrCp2 TO PRINT PROMPT NOCONSOLE
            ENDIF

            loc_lcApagar = SYS(2023) + "\F*.Jpg"
            DELETE FILE &loc_lcApagar.

            THIS.LimparCursores()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_nTpRel, loc_lcApagar, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_nTpRel = THIS.this_nOpcRel

            IF loc_nTpRel = 1
                REPORT FORM SigReCgp PREVIEW NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 2)
                REPORT FORM SigReCg1 PREVIEW NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 5)
                REPORT FORM SigReCg2 PREVIEW NOCONSOLE
            ENDIF
            IF loc_nTpRel = 3
                REPORT FORM SigPrCpr PREVIEW NOCONSOLE
            ENDIF
            IF loc_nTpRel = 4
                REPORT FORM SigPrCp2 PREVIEW NOCONSOLE
            ENDIF

            loc_lcApagar = SYS(2023) + "\F*.Jpg"
            DELETE FILE &loc_lcApagar.

            THIS.LimparCursores()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Libera cursores temporarios e arquivos de imagem
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        LOCAL loc_lcArquivo, loc_xImg

        *-- Remove arquivos de imagem temporarios da CompEsp1 (prefixo T)
        IF USED("crProCompos")
            SELECT crProCompos
            GO TOP
            SCAN
                loc_xImg = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(STRTRAN( ;
                    crProCompos.cPros, "/", ""), " ", ""), ".", ""), "\", ""))
                loc_lcArquivo = SYS(2023) + "\T" + loc_xImg + ".jpg"
                IF FILE(loc_lcArquivo)
                    DELETE FILE (loc_lcArquivo)
                ENDIF
            ENDSCAN
        ENDIF

        *-- Fecha cursores de relatorio
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("Relatorio")
            USE IN Relatorio
        ENDIF
        IF USED("csRelatorio")
            USE IN csRelatorio
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("csMoedas")
            USE IN csMoedas
        ENDIF
        IF USED("CsMoedas")
            USE IN CsMoedas
        ENDIF
        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF
        IF USED("crProCompos")
            USE IN crProCompos
        ENDIF
        IF USED("Tmp_Memos")
            USE IN Tmp_Memos
        ENDIF
        IF USED("Tmp_Compos")
            USE IN Tmp_Compos
        ENDIF
        IF USED("CrBranco")
            USE IN CrBranco
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor de preset
    * Para BO de relatorio, o cursor pode armazenar parametros previamente usados
    * par_cAliasCursor: nome do cursor com colunas de parametros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    *-- SCATTER MEMVAR para acessar colunas dinamicamente
                    SCATTER MEMVAR

                    IF TYPE("m.nOpcRel") = "N"
                        THIS.this_nOpcRel = m.nOpcRel
                    ENDIF
                    IF TYPE("m.nOpcOrdem") = "N"
                        THIS.this_nOpcOrdem = m.nOpcOrdem
                    ENDIF
                    IF TYPE("m.cEmpEDN") = "C"
                        THIS.this_cEmpEDN = ALLTRIM(m.cEmpEDN)
                    ENDIF
                    IF TYPE("m.nVal") = "N"
                        THIS.this_nVal = m.nVal
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o relatorio enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Prepara dados, dispara impressao e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !INLIST(THIS.this_nOpcRel, 1, 2, 3, 4, 5)
                THIS.this_cMensagemErro = "Tipo de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido: " + ;
                    TRANSFORM(THIS.this_nOpcRel)
            ELSE
                IF !THIS.PrepararDados()
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.Imprimir()
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("IMPRESSAO")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o relatorio em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Prepara dados, dispara preview e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !INLIST(THIS.this_nOpcRel, 1, 2, 3, 4, 5)
                THIS.this_cMensagemErro = "Tipo de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido: " + ;
                    TRANSFORM(THIS.this_nOpcRel)
            ELSE
                IF !THIS.PrepararDados()
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.Visualizar()
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("VISUALIZACAO")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        LOCAL loc_cUsuario, loc_cEmpresa, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cEmpresa = ""
            IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF

            loc_cChave = "EMP=" + loc_cEmpresa + ;
                         ";TIPO=" + ALLTRIM(STR(THIS.this_nOpcRel, 1)) + ;
                         ";ORDEM=" + ALLTRIM(STR(THIS.this_nOpcOrdem, 1)) + ;
                         ";EDN=" + ALLTRIM(THIS.this_cEmpEDN)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCgp") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE

