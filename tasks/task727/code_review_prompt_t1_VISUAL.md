# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_ControleGrupos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopecm.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (949 linhas total):

*-- Linhas 72 a 83:
72: *   3. os BINDEVENT rodam DEPOIS dos AddObject (InicializarForm chama
73: *      ConfigurarPageFrame -> Cabecalho/Botoes/Campos antes de bindar);
74: *   4. os alvos de SetFocus existem com o nome do AddObject
75: *      (cmd_4c_Cancela / cmd_4c_BtnGetArqO), reproduzindo os tres SetFocus do
76: *      legado (ThisForm.Cancela.SetFocus no fim do Processamento e
77: *      ThisForm.btnGetArqO.SetFocus nos dois Return .f. de validacao);
78: *   5. ESC continua saindo pelo Cancel = .T. do cmd_4c_Cancela, transcrito do
79: *      dump - o form nao tem ControlBox nem TitleBar;
80: *   6. Release() (nao Hide()) esta certo aqui: o dialogo nao devolve nada ao
81: *      chamador - o resultado dele eh o arquivo em disco;
82: *   7. as 5 properties do BO que os handlers tocam existem declaradas
83: *      (this_cArquivo, this_lExportarImagens, this_nQtdProdutos,

*-- Linhas 168 a 176:
168:     * this_cUltimoProgresso - ultimo texto de progresso recebido do BO
169:     * (equivalente ao Caption de lblResults no legado). Guardado na classe
170:     * porque o BO reporta progresso desde o inicio do Scan e o label
171:     * lbl_4c_LblResults eh um controle da area de campos: assim o texto nunca
172:     * se perde, e quem exibe eh AtualizarProgresso().
173:     *==========================================================================
174:     this_cUltimoProgresso = ""
175: 
176:     *==========================================================================

*-- Linhas 213 a 221:
213:     * guards de objeto adiante lerem lixo.
214:     *==========================================================================
215:     PROCEDURE Init(par_oFormPai)
216:         THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Arquivo de Exporta" + ;
217:             CHR(231) + CHR(227) + "o Para e-Commerce"
218: 
219:         IF VARTYPE(par_oFormPai) = "O"
220:             THIS.this_oFormPai = par_oFormPai
221:         ENDIF

*-- Linhas 283 a 305:
283:             ELSE
284:                 *-- O BO repinta o progresso durante o Scan chamando
285:                 *-- this_oFormUI.AtualizarProgresso() - equivale ao
286:                 *-- "ThisForm.lblResults.Caption = ..." repetido no legado.
287:                 THIS.this_oBusinessObject.this_oFormUI = THIS
288: 
289:                 THIS.ConfigurarPageFrame()
290: 
291:                 *-- Fase 8: aplica o default de this_lExportarImagens (BO) sobre
292:                 *-- chk_4c_ChkImagens - precisa vir DEPOIS de ConfigurarPageFrame
293:                 *-- (que cria o controle via ConfigurarCampos)
294:                 THIS.BOParaForm()
295: 
296:                 *-- BINDEVENTs: botoes e picker criados em ConfigurarBotoes/
297:                 *-- ConfigurarCampos, acima
298:                 BINDEVENT(THIS.cmd_4c_Processa,   "Click", THIS, "BtnProcessarClick")
299:                 BINDEVENT(THIS.cmd_4c_Cancela,    "Click", THIS, "BtnEncerrarClick")
300:                 BINDEVENT(THIS.cmd_4c_BtnGetArqO, "Click", THIS, "BtnGetArqOClick")
301: 
302:                 THIS.TornarControlesVisiveis(THIS)
303: 
304:                 loc_lSucesso = .T.
305:             ENDIF

*-- Linhas 366 a 387:
366:     * Os tres ultimos sao inertes para a navegacao e estao aqui para fechar a
367:     * faixa 1..8 sem lacuna: Label nao tem TabStop (nao recebe foco) e
368:     * cnt_4c_Sombra so tem os dois Label do titulo dentro, logo o Tab tambem
369:     * nao para nele. Quem de fato para eh cmd_4c_BtnGetArqO -> chk_4c_ChkImagens
370:     * -> cmd_4c_Cancela -> cmd_4c_Processa: txt_4c_ArqTXT fica fora do ciclo
371:     * por TabStop = .F., que com ReadOnly = .T. eh a transcricao do
372:     * "PROCEDURE When / Return .f." que o dump declara nele.
373:     *==========================================================================
374:     PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
375:         THIS.lbl_4c_LblResults.TabIndex = 1    && SCX lblResults : efetivo 1
376:         THIS.lbl_4c_Label1.TabIndex     = 2    && SCX Say1       : efetivo 2
377:         THIS.txt_4c_ArqTXT.TabIndex     = 3    && SCX getArqTXT  : efetivo 3
378:         THIS.cmd_4c_BtnGetArqO.TabIndex = 4    && SCX btnGetArqO : efetivo 4
379:         THIS.chk_4c_ChkImagens.TabIndex = 5    && SCX chkImagens : efetivo 5
380:         THIS.cnt_4c_Sombra.TabIndex     = 6    && SCX cntSombra  : efetivo 6
381:         THIS.cmd_4c_Cancela.TabIndex    = 7    && SCX Cancela    : efetivo 7
382:         THIS.cmd_4c_Processa.TabIndex   = 8    && SCX Processa   : efetivo 8
383:     ENDPROC
384: 
385:     *==========================================================================
386:     * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
387:     * (cntSombra do legado) e os dois labels sobrepostos que produzem o efeito

*-- Linhas 400 a 459:
400:         THIS.AddObject("cnt_4c_Sombra", "Container")
401:         loc_oCab = THIS.cnt_4c_Sombra
402:         WITH loc_oCab
403:             .Top         = 0
404:             .Left        = 0
405:             .Width       = THIS.Width
406:             .Height      = 80
407:             .BackStyle   = 1
408:             .BackColor   = RGB(100, 100, 100)
409:             .BorderWidth = 0
410:             .Visible     = .T.
411:         ENDWITH
412: 
413:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
414:         WITH loc_oCab.lbl_4c_LblSombra
415:             .AutoSize      = .F.
416:             .Top           = 18
417:             .Left          = 10
418:             .Width         = 769
419:             .Height        = 40
420:             .FontName      = "Tahoma"
421:             .FontSize      = 18
422:             .FontBold      = .T.
423:             .FontUnderline = .F.
424:             .WordWrap      = .T.
425:             .Alignment     = 0
426:             .BackStyle     = 0
427:             .ForeColor     = RGB(0, 0, 0)
428:             .Caption       = THIS.Caption
429:             .Visible       = .T.
430:         ENDWITH
431: 
432:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
433:         WITH loc_oCab.lbl_4c_LblTitulo
434:             .AutoSize    = .F.
435:             .Top         = 17
436:             .Left        = 10
437:             .Width       = 769
438:             .Height      = 46
439:             .FontName    = "Tahoma"
440:             .FontSize    = 18
441:             .FontBold    = .T.
442:             .WordWrap    = .T.
443:             .Alignment   = 0
444:             .BackStyle   = 0
445:             .ForeColor   = RGB(255, 255, 255)
446:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
447:             .Caption     = THIS.Caption
448:             .Visible     = .T.
449:         ENDWITH
450:     ENDPROC
451: 
452:     *==========================================================================
453:     * ConfigurarBotoes - Shape1 (moldura decorativa) + os dois botoes de acao
454:     * do legado (Cancela -> cmd_4c_Cancela / Processa -> cmd_4c_Processa),
455:     * ambos classe fwbtng (framework.vcx). O dump so sobrescreve Top/Left/
456:     * Picture/Caption/TabIndex (e Cancel em Cancela) - Height/Width/Font*/
457:     * WordWrap/MousePointer/ForeColor/BackColor/Themes vem do DEFAULT da
458:     * classe fwbtng (docs/FRAMEWORK_class_codigo_fonte.txt, registro 3495):
459:     * Height=100, Width=80, FontBold=.T., FontItalic=.T.,

*-- Linhas 470 a 496:
470:     PROTECTED PROCEDURE ConfigurarBotoes()
471:         THIS.AddObject("shp_4c_Shape1", "Shape")
472:         WITH THIS.shp_4c_Shape1
473:             .Top           = 7
474:             .Left          = 565
475:             .Width         = 173
476:             .Height        = 110
477:             .BackStyle     = 0
478:             .BorderStyle   = 0
479:             .SpecialEffect = 1
480:             .BorderColor   = RGB(136, 189, 188)
481:             .Visible       = .T.
482:         ENDWITH
483: 
484:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
485:         WITH THIS.cmd_4c_Cancela
486:             .Top         = 3
487:             .Left        = 725
488:             .Height      = 100
489:             .Width       = 80
490:             .Cancel      = .T.
491:             .Caption     = "Encerrar"
492:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
493:             .FontBold    = .T.
494:             .FontItalic  = .T.
495:             .FontName    = "Comic Sans MS"
496:             .FontSize    = 8

*-- Linhas 502 a 516:
502:             .Visible     = .T.
503:         ENDWITH
504: 
505:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
506:         WITH THIS.cmd_4c_Processa
507:             .Top         = 3
508:             .Left        = 650
509:             .Height      = 100
510:             .Width       = 80
511:             .Caption     = "\<Processar"
512:             .Picture     = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
513:             .FontBold    = .T.
514:             .FontItalic  = .T.
515:             .FontName    = "Comic Sans MS"
516:             .FontSize    = 8

*-- Linhas 525 a 583:
525: 
526:     *==========================================================================
527:     * ConfigurarCampos - area de parametros do processamento: Say1
528:     * (lbl_4c_Label1), getArqTXT (txt_4c_ArqTXT), btnGetArqO
529:     * (cmd_4c_BtnGetArqO), chkImagens (chk_4c_ChkImagens), Shape2
530:     * (shp_4c_Shape2, moldura do resultado) e lblResults (lbl_4c_LblResults).
531:     *
532:     * txt_4c_ArqTXT.ReadOnly = .T. eh a transcricao de getArqTXT.When
533:     * ("Return .f." no dump) - o campo NAO aceita digitacao, o valor so
534:     * chega pelo picker de btnGetArqO. NAO se faz isso com BINDEVENT "When":
535:     * BINDEVENT descarta o retorno do delegate e o campo continuaria
536:     * digitavel (CLAUDE.md regra #3; precedente: FormSIGOPCCO.prg).
537:     *
538:     * lbl_4c_Label1 eh classe "say" (framework.vcx) sem Width/Alignment no
539:     * dump - AutoSize = .T. herdado da classe eh NO-OP em Label criado por
540:     * AddObject (regra #23), entao aqui AutoSize = .F. + Width explicito
541:     * (que cabe "Arquivo a Ser Gerado" em Tahoma 8 bold) + Alignment = 0,
542:     * com ForeColor = RGB(90,90,90) (default da classe "say", registro 2597
543:     * de docs/FRAMEWORK_class_codigo_fonte.txt).
544:     *
545:     * chk_4c_ChkImagens eh fwcheckbox - mesma armadilha de AutoSize no-op
546:     * (CheckBox, nao so Label): Width explicito para caber "Exportar
547:     * Imagens". Height/FontName/FontSize/Alignment/BackStyle/ForeColor/
548:     * Themes do default da classe (docs/FRAMEWORK_class_codigo_fonte.txt,
549:     * registro 3401). Value = 1 (numerico, nunca .T./.F. - regra de
550:     * CheckBox.Value) reproduz o Value = 1 do dump (caixa marcada).
551:     *
552:     * lbl_4c_LblResults eh "say" tambem, mas o dump JA sobrescreve
553:     * AutoSize = .F. + Width = 573 + Height = 15 - esses numeros sao o
554:     * auto-size calculado pelo Form Designer, reproducao fiel (regra #23).
555:     * FontName/FontSize/ForeColor ficam no default da classe "say".
556:     *==========================================================================
557:     PROTECTED PROCEDURE ConfigurarCampos()
558:         THIS.AddObject("lbl_4c_Label1", "Label")
559:         WITH THIS.lbl_4c_Label1
560:             .Top       = 92
561:             .Left      = 105
562:             .Width     = 170
563:             .Height    = 15
564:             .AutoSize  = .F.
565:             .Alignment = 0
566:             .BackStyle = 0
567:             .FontBold  = .T.
568:             .FontName  = "Tahoma"
569:             .FontSize  = 8
570:             .ForeColor = RGB(90, 90, 90)
571:             .Caption   = "Arquivo a Ser Gerado"
572:             .Visible   = .T.
573:         ENDWITH
574: 
575:         THIS.AddObject("txt_4c_ArqTXT", "TextBox")
576:         WITH THIS.txt_4c_ArqTXT
577:             .Top           = 109
578:             .Left          = 105
579:             .Width         = 560
580:             .Height        = 22
581:             .FontName      = "Tahoma"
582:             .FontSize      = 8
583:             .SpecialEffect = 1

*-- Linhas 590 a 663:
590:             .Visible       = .T.
591:         ENDWITH
592: 
593:         THIS.AddObject("cmd_4c_BtnGetArqO", "CommandButton")
594:         WITH THIS.cmd_4c_BtnGetArqO
595:             .Top           = 107
596:             .Left          = 666
597:             .Height        = 26
598:             .Width         = 26
599:             .FontBold      = .T.
600:             .FontName      = "Verdana"
601:             .FontSize      = 10
602:             .Picture       = gc_4c_CaminhoIcones + "geral_pasta_16.jpg"
603:             .Caption       = ""
604:             .ToolTipText   = "Seleciona o Arquivo Que Ser" + CHR(225) + " Processado"
605:             .SpecialEffect = 2
606:             .ForeColor     = RGB(36, 84, 155)
607:             .BackColor     = RGB(255, 255, 255)
608:             .Themes           = .T.
609:             .Visible       = .T.
610:         ENDWITH
611: 
612:         THIS.AddObject("chk_4c_ChkImagens", "CheckBox")
613:         WITH THIS.chk_4c_ChkImagens
614:             .Top       = 139
615:             .Left      = 105
616:             .Width     = 150
617:             .Height    = 17
618:             .FontBold  = .T.
619:             .FontName  = "Tahoma"
620:             .FontSize  = 8
621:             .Alignment = 0
622:             .BackStyle = 0
623:             .ForeColor = RGB(90, 90, 90)
624:             .Themes    = .F.
625:             .SpecialEffect = 1
626:             .Caption   = "Exportar Imagens"
627:             .Value     = 1
628:             .Visible   = .T.
629:         ENDWITH
630: 
631:         THIS.AddObject("shp_4c_Shape2", "Shape")
632:         WITH THIS.shp_4c_Shape2
633:             .Top         = 163
634:             .Left        = 105
635:             .Width       = 590
636:             .Height      = 36
637:             .BackStyle   = 0
638:             .BorderStyle = 6
639:             .BorderWidth = 1
640:             .Curvature   = 12
641:             .BorderColor = RGB(90, 90, 90)
642:             .Visible     = .T.
643:         ENDWITH
644: 
645:         THIS.AddObject("lbl_4c_LblResults", "Label")
646:         WITH THIS.lbl_4c_LblResults
647:             .Top       = 174
648:             .Left      = 113
649:             .Width     = 573
650:             .Height    = 15
651:             .AutoSize  = .F.
652:             .Alignment = 0
653:             .BackStyle = 0
654:             .FontBold  = .T.
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .ForeColor = RGB(90, 90, 90)
658:             .Caption   = ""
659:             .Visible   = .T.
660:         ENDWITH
661:     ENDPROC
662: 
663:     *==========================================================================

*-- Linhas 702 a 713:
702:     * controle ja existe.
703:     *
704:     * Existe por FONTE UNICA, nao por simetria decorativa: sem este hook o
705:     * "marcado" do checkbox ficaria escrito DUAS vezes - uma em
706:     * sigopecmBO.this_lExportarImagens e outra no .Value = 1 hardcoded de
707:     * ConfigurarCampos. As duas copias divergiriam no primeiro ajuste de
708:     * default - quem mudasse o default no BO veria o checkbox continuar
709:     * abrindo desmarcado, porque ConfigurarCampos nunca consultaria o BO.
710:     *
711:     * PROTECTED EXPLICITO pelo MESMO motivo de FormParaBO, acima.
712:     *==========================================================================
713:     PROTECTED FUNCTION BOParaForm()

*-- Linhas 793 a 806:
793:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemResultado, ;
794:                     "Processamento Finalizado")
795:             ENDIF
796:             THIS.cmd_4c_Cancela.SetFocus()
797:         ELSE
798:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
799:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
800:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
801:                 THIS.cmd_4c_BtnGetArqO.SetFocus()
802:             ENDIF
803:         ENDIF
804:     ENDPROC
805: 
806:     *==========================================================================

*-- Linhas 834 a 842:
834:     *==========================================================================
835:     * AtualizarProgresso - contrato com sigopecmBO.AtualizarProgresso, que
836:     * chama este metodo a cada grupo/produto processado (equivale ao
837:     * "ThisForm.lblResults.Caption = [Processando ] + ..." repetido dentro do
838:     * Scan do legado). PUBLIC porque quem chama eh o BO, de fora da classe.
839:     *
840:     * O texto eh sempre guardado em this_cUltimoProgresso e so entao exibido,
841:     * se o label de resultado da area de campos existir - assim o progresso
842:     * reportado antes de o label entrar em cena nao se perde. O DOEVENTS

*-- Linhas 849 a 859:
849:         loc_cTexto = IIF(VARTYPE(par_cTexto) = "C", par_cTexto, "")
850:         THIS.this_cUltimoProgresso = loc_cTexto
851: 
852:         IF PEMSTATUS(THIS, "lbl_4c_LblResults", 5)
853:             THIS.lbl_4c_LblResults.Caption = loc_cTexto
854:             THIS.lbl_4c_LblResults.Refresh()
855:             DOEVENTS
856:         ENDIF
857:     ENDPROC
858: 
859:     *==========================================================================

*-- Linhas 934 a 949:
934:         THIS.this_oFormPai = .NULL.
935: 
936:         IF USED("cursor_4c_GruposSelec")
937:             USE IN cursor_4c_GruposSelec
938:         ENDIF
939:         IF USED("cursor_4c_ControleGrupos")
940:             USE IN cursor_4c_ControleGrupos
941:         ENDIF
942:         IF USED("cursor_4c_DadosGrupo")
943:             USE IN cursor_4c_DadosGrupo
944:         ENDIF
945: 
946:         DODEFAULT()
947:     ENDPROC
948: 
949: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopecmBO.prg):
*============================================================================
* sigopecmBO.prg - Business Object para Geracao de Arquivo de Exportacao
* Para e-Commerce (SIGOPECM / Formsigopecm)
*
* Form OPERACIONAL (processo em lote, sem tabela propria no banco): gera um
* arquivo de texto de largura fixa (layout "td01"/"td03") a partir dos
* produtos selecionados previamente pelo usuario (cursor crImagens, montado
* pelo form chamador - SIGOPECM.poObjForm) e grava ao lado dele, opcional-
* mente, os JPGs decodificados de SigCdPro.FigJpgs (base64).
*
* crImagens NAO eh criado neste form - quem monta eh SigOpPec.SCT
* (ProximasMigracoes\SigOpPec.SCT, ainda NAO migrado), com pelo menos:
*   Create Cursor CrImagens (Cpros C(14), Cgrus C(3), Cunis C(3), FigJpgs M, ...)
* As duas colunas usadas pelo SIGOPECM sao Cgrus C(3) e Cpros C(14) - usar
* essa estrutura ao criar o cursor placeholder nas proximas fases (nao
* inventar largura diferente).
*
* Fontes de leitura (sem persistencia - o processo so GERA ARQUIVO):
*   - SigCdGrp (CGrus/DGrus/Ids)              -> registro td01 (Grupo)
*   - SigCdPro (CPros/DPros/CUnis/DtIncs/...)  -> registro td03 (Produto)
*   - SigPrCar + SigCrRap (Descrs/Ordens)      -> colecoes/caracteristicas
*     do produto, que tambem geram registros td01 (uma "colecao" por Ordens)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completo em: Fase 2 em diante (metodos de processamento/exportacao)
*============================================================================

DEFINE CLASS sigopecmBO AS BusinessBase

    *==========================================================================
    * Parametros informados na tela (SIGOPECM.getArqTXT/chkImagens)
    *==========================================================================
    this_cArquivo          = ""   && SIGOPECM.getArqTXT.Value - caminho completo do TXT a ser gerado
    *-- SIGOPECM.chkImagens.Value = 1 - espelha o estado da caixa "Exportar
    *-- Imagens" na tela. ATENCAO: o legado NAO CONSULTA esse controle em
    *-- metodo nenhum (conferido no dump inteiro - chkImagens so aparece na
    *-- arvore de objetos e nas propriedades), logo a caixa NAO TEM EFEITO
    *-- no sistema antigo: ele exporta os JPGs sempre que SigCdPro.FigJpgs
    *-- esta preenchido. A property eh mantida porque eh a transcricao fiel
    *-- do controle e deixa a ativacao a um IF de distancia, mas
    *-- GerarArquivoExportacao NAO a usa, de proposito - ativar a caixa eh
    *-- mudar comportamento e exige decisao do cliente (PILAR 1).
    this_lExportarImagens  = .T.

    *==========================================================================
    * Resultado do processamento (SIGOPECM.lblResults / MessageBox final)
    *==========================================================================
    this_nQtdGrupos        = 0    && lnQtd do legado - total de grupos (registros td01) encontrados
    this_nQtdProdutos      = 0    && lnCnt do legado - total de produtos (registros td03) gravados
    this_cMensagemResultado = ""  && espelha o Caption de lblResults durante o Scan

    *==========================================================================
    * Linha corrente lida de cursor por CarregarDoCursor() - equivale as
    * referencias LocalGrupo.<col> / LocalProds.<col> / LocalCaracs.<col> do
    * legado. O tipo de cada property segue o tipo da COLUNA no docs/schema.sql
    * (conferido com Get-Content -Raw, encoding UTF-16 - regra #14), nunca o
    * nome do controle:
    *
    *   SigCdGrp : cgrus char(3)  | dgrus char(20) | ids numeric(10,0)
    *   SigCdPro : cpros char(14) | dpros char(65) | cunis char(3)
    *              dtincs datetime NULL | situas numeric(1,0)
    *              pesoms numeric(8,3) | icms numeric(5,2)
    *              aliqipis numeric(5,2) | clfiscals char(10)
    *              sittricms char(3) | pvens numeric(11,5) | figjpgs text NULL
    *   SigCrRap : descrs char(40) | ordens numeric(6,0)
    *==========================================================================
    this_cCgrus      = ""   && SigCdGrp.cgrus  / crImagens.Cgrus - codigo do grupo
    this_cDgrus      = ""   && SigCdGrp.dgrus  - descricao do grupo (registro td01)
    this_nIds        = 0    && SigCdGrp.ids    - ID do grupo no e-Commerce (registro td01)

    this_cCpros      = ""   && SigCdPro.cpros  / crImagens.Cpros - codigo do produto
    this_cDpros      = ""   && SigCdPro.dpros  - descricao do produto
    this_cCunis      = ""   && SigCdPro.cunis  - unidade
    this_dDtincs     = {}   && SigCdPro.dtincs - data de inclusao (datetime NULL)
    this_nSituas     = 0    && SigCdPro.situas - 2 = inativo ("i"), demais = ativo ("a")
    this_nPesoms     = 0    && SigCdPro.pesoms - peso medio
    this_nIcms       = 0    && SigCdPro.icms   - % de ICMS
    this_nAliqipis   = 0    && SigCdPro.aliqipis - % de IPI
    this_cClfiscals  = ""   && SigCdPro.clfiscals - classificacao fiscal
    this_cSittricms  = ""   && SigCdPro.sittricms - situacao tributaria
    this_nPvens      = 0    && SigCdPro.pvens  - preco de venda
    this_cFigjpgs    = ""   && SigCdPro.figjpgs - imagem em base64 (text NULL)

    this_cDescrs     = ""   && SigCrRap.descrs - descricao da colecao (registro td01)
    this_nOrdens     = 0    && SigCrRap.ordens - ID da colecao (registro td01)

    *==========================================================================
    * Referencia ao form para repintar lblResults.Caption durante o
    * processamento (equivalente ao "ThisForm.lblResults.Caption = ... "
    * repetido dentro do Scan do legado). Fica .NULL. quando o BO eh usado
    * sem interface.
    *==========================================================================
    this_oFormUI = .NULL.

    *==========================================================================
    * Init - Inicializa o Business Object. Sem tabela propria (o processo
    * apenas le SigCdGrp/SigCdPro/SigPrCar/SigCrRap e grava arquivo em disco),
    * entao this_cTabela/this_cCampoChave ficam vazios - igual ao padrao
    * adotado em FAPPBO.prg para forms operacionais sem persistencia.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em sigopecmBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Sem tabela/registro proprio (processo so GERA
    * ARQUIVO), entao nao ha chave primaria para auditar. Explicito aqui (em
    * vez de confiar so no default de BusinessBase) para deixar claro que a
    * ausencia eh decisao, nao esquecimento - mesmo padrao de FAPPBO.prg.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * LimparDados - Zera a linha corrente (as properties alimentadas por
    * CarregarDoCursor). Chamado no inicio de GerarArquivoExportacao e a cada
    * troca de grupo/produto: sem isso, coluna ausente no cursor da vez
    * deixaria o valor do registro ANTERIOR na property e o registro td01/td03
    * sairia com dado de outro produto - divergencia silenciosa, sem erro.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCgrus     = ""
        THIS.this_cDgrus     = ""
        THIS.this_nIds       = 0

        THIS.this_cCpros     = ""
        THIS.this_cDpros     = ""
        THIS.this_cCunis     = ""
        THIS.this_dDtincs    = {}
        THIS.this_nSituas    = 0
        THIS.this_nPesoms    = 0
        THIS.this_nIcms      = 0
        THIS.this_nAliqipis  = 0
        THIS.this_cClfiscals = ""
        THIS.this_cSittricms = ""
        THIS.this_nPvens     = 0
        THIS.this_cFigjpgs   = ""

        THIS.this_cDescrs    = ""
        THIS.this_nOrdens    = 0
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Le a linha CORRENTE de um cursor para as properties
    * deste BO. Equivale as referencias LocalGrupo.<col> / LocalProds.<col> /
    * LocalCaracs.<col> espalhadas pelo Processamento do legado: aqui a leitura
    * acontece em UM lugar so, e o resto do codigo trabalha sobre as
    * properties.
    *
    * Atende os TRES cursores do processo (cada um traz um subconjunto de
    * colunas) e tambem o crImagens montado pelo form chamador:
    *   cursor_4c_DadosGrupo     -> Cgrus, Dgrus, Ids
    *   cursor_4c_DadosProduto   -> Cpros, Dpros, Cunis, Dtincs, Situas,
    *                               Pesoms, Icms, Aliqipis, Clfiscals,
    *                               Sittricms, Pvens, Figjpgs
    *   cursor_4c_Caracteristicas-> Descrs, Ordens
    *   crImagens                -> Cgrus, Cpros
    *
    * Cada coluna eh lida so quando EXISTE no cursor: o teste eh
    * TYPE(alias + ".coluna") != "U", NUNCA PEMSTATUS() - PEMSTATUS exige
    * OBJETO no 1o argumento e com nome de alias dispara o erro 11 do VFP9.
    *
    * O alias corrente eh restaurado no fim: o metodo eh chamado de DENTRO de
    * SCANs (crImagens/grupos/produtos) e nao pode deslocar a area de trabalho
    * de quem chamou.
    *
    * Parametro: par_cAliasCursor - nome do cursor/alias ja aberto e posicionado
    * Retorno: .T. se leu uma linha; .F. se o alias nao existe, nao esta aberto
    *          ou esta em EOF (cursor vazio ou ponteiro no fim).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro, loc_cAlias, loc_cAliasAnterior

        loc_lResultado     = .F.
        loc_cAliasAnterior = ALIAS()
        loc_cAlias         = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- SigCdGrp (grupo) / crImagens
                    IF TYPE(loc_cAlias + ".Cgrus") != "U"
                        THIS.this_cCgrus = ALLTRIM(TratarNulo(Cgrus, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Dgrus") != "U"
                        THIS.this_cDgrus = ALLTRIM(TratarNulo(Dgrus, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Ids") != "U"
                        THIS.this_nIds = TratarNulo(Ids, 0)
                    ENDIF

                    *-- SigCdPro (produto) / crImagens
                    IF TYPE(loc_cAlias + ".Cpros") != "U"
                        THIS.this_cCpros = ALLTRIM(TratarNulo(Cpros, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Dpros") != "U"
                        THIS.this_cDpros = ALLTRIM(TratarNulo(Dpros, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Cunis") != "U"
                        THIS.this_cCunis = ALLTRIM(TratarNulo(Cunis, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Dtincs") != "U"
                        *-- datetime NULL: ConverterParaData normaliza DATE/DATETIME/NULL.
                        *-- TTOD() direto dispara erro 11 quando o valor chega como DATE.
                        THIS.this_dDtincs = ConverterParaData(Dtincs)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Situas") != "U"
                        THIS.this_nSituas = TratarNulo(Situas, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Pesoms") != "U"
                        THIS.this_nPesoms = TratarNulo(Pesoms, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Icms") != "U"
                        THIS.this_nIcms = TratarNulo(Icms, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Aliqipis") != "U"
                        THIS.this_nAliqipis = TratarNulo(Aliqipis, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Clfiscals") != "U"
                        THIS.this_cClfiscals = ALLTRIM(TratarNulo(Clfiscals, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Sittricms") != "U"
                        THIS.this_cSittricms = ALLTRIM(TratarNulo(Sittricms, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Pvens") != "U"
                        THIS.this_nPvens = TratarNulo(Pvens, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Figjpgs") != "U"
                        *-- text NULL - base64 da imagem, lido CRU (sem ALLTRIM)
                        THIS.this_cFigjpgs = TratarNulo(Figjpgs, "")
                    ENDIF

                    *-- SigCrRap (colecoes/caracteristicas do produto)
                    IF TYPE(loc_cAlias + ".Descrs") != "U"
                        THIS.this_cDescrs = ALLTRIM(TratarNulo(Descrs, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Ordens") != "U"
                        THIS.this_nOrdens = TratarNulo(Ordens, 0)
                    ENDIF

                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler o cursor [" + loc_cAlias + "]: " + ;
                loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.

        FINALLY
            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao - este form NUNCA grava em tabela
    * (le SigCdGrp/SigCdPro/SigPrCar/SigCrRap e grava um arquivo em disco);
    * o comportamento padrao herdado de BusinessBase (recusar a operacao) ja
    * eh o correto aqui, entao NAO sao sobrescritos so para preencher metodo.
    * A operacao real do form eh GerarArquivoExportacao(), abaixo.
    *==========================================================================

    *==========================================================================
    * AtualizarProgresso - Repinta o andamento do processamento. Equivale ao
    * "ThisForm.lblResults.Caption = ..." repetido dentro do Scan do legado.
    * Nao sabe o nome do controle: delega para um metodo PUBLIC do form
    * (THIS.this_oFormUI.AtualizarProgresso(cTexto)), que o Form (Fase 3)
    * implementa para repintar o label dele e fazer Refresh().
    *==========================================================================
    PROTECTED PROCEDURE AtualizarProgresso(par_nQtdGrupos, par_nQtdProdutos)
        LOCAL loc_cTexto

        loc_cTexto = "Processando " + ALLTRIM(STR(par_nQtdGrupos, 10)) + " Grupo" + ;
            IIF(par_nQtdGrupos = 1, "", "s") + " / " + ;
            "Produtos Gerados : " + ALLTRIM(STR(par_nQtdProdutos, 10))

        THIS.this_cMensagemResultado = loc_cTexto

        IF VARTYPE(THIS.this_oFormUI) = "O" AND PEMSTATUS(THIS.this_oFormUI, "AtualizarProgresso", 5)
            THIS.this_oFormUI.AtualizarProgresso(loc_cTexto)
        ENDIF
    ENDPROC

    *==========================================================================
    * GerarArquivoExportacao - Equivalente a SIGOPECM.Processamento do legado.
    *
    * Le o cursor crImagens (montado pelo form chamador - ver cabecalho do
    * arquivo) e, para cada Cgrus/Cpros distinto nele, consulta SigCdGrp/
    * SigCdPro/SigPrCar+SigCrRap e grava registros de largura fixa ("td01"
    * para grupos/colecoes, "td03" para produtos) no arquivo THIS.this_cArquivo,
    * alem dos JPGs decodificados de SigCdPro.FigJpgs sempre que a coluna
    * estiver preenchida (o legado nao condiciona isso a nada mais - ver a
    * nota no bloco de exportacao de imagens, adiante).
    *
    * Pre-requisitos (devem ser setados pelo Form ANTES de chamar):
    *   THIS.this_cArquivo         - caminho completo do TXT a ser gerado
    *   THIS.this_oFormUI          - opcional, para repintar o progresso
    * (this_lExportarImagens NAO entra aqui: este metodo nao a le, porque o
    * legado tambem nao - ver a nota na declaracao da property.)
    *
    * Retorno: .T. se o processamento rodou do inicio ao fim (mesmo que
    * nenhum produto tenha sido gerado - igual ao legado, que so muda a
    * mensagem final, nunca o retorno); .F. em falha de validacao ou de SQL.
    *
    * Contrato de erro (mesmo do Inserir()/Atualizar() de BusinessBase):
    *   - falha de SQL exibe o proprio MsgErro aqui e deixa
    *     this_cMensagemErro VAZIO (ja mostrado, Form nao repete);
    *   - falha de validacao (arquivo vazio/nao-gravavel/sem imagens
    *     selecionadas) NAO mostra MsgErro - so preenche this_cMensagemErro,
    *     para o Form decidir a mensagem e o SetFocus.
    *==========================================================================
    PROCEDURE GerarArquivoExportacao()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cChr, loc_cSQL, loc_nResultado
        LOCAL loc_nQtdGrupos, loc_nQtdProdutos
        LOCAL loc_cGru, loc_cDes, loc_cUni, loc_cStr
        LOCAL loc_cRef, loc_cDat, loc_cSit, loc_cPes, loc_cIpi, loc_cIcm, loc_cClf, loc_cTri, loc_cVal, loc_cPre
        LOCAL loc_cGvd, loc_cGr1, loc_cDe1, loc_cUn1
        LOCAL loc_cImg, loc_cFoto

        loc_lResultado = .F.

        *-- Zera a linha corrente (LimparDados tambem limpa this_cMensagemErro
        *-- via DODEFAULT) para o processamento nunca herdar o produto/grupo de
        *-- uma geracao anterior - o form fica aberto entre um Processar e outro
        THIS.LimparDados()

        THIS.this_nQtdGrupos         = 0
        THIS.this_nQtdProdutos       = 0
        THIS.this_cMensagemResultado = ""

        loc_cArquivo = ALLTRIM(NVL(THIS.this_cArquivo, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "O Arquivo a Ser Gerado N" + CHR(227) + "o Foi Informado!!!"
            ELSE
                *-- Testa se o arquivo pode ser criado (igual ao legado)
                STRTOFILE("", loc_cArquivo, 0)

                IF !FILE(loc_cArquivo)
                    THIS.this_cMensagemErro = "O Arquivo N" + CHR(227) + "o Pode Ser Criado!!!"
                ELSE
                    IF !USED("crImagens")
                        THIS.this_cMensagemErro = "Nenhuma imagem selecionada para exportar."
                    ELSE
                        loc_cChr = CHR(13) + CHR(10)

                        IF USED("cursor_4c_GruposSelec")
                            USE IN cursor_4c_GruposSelec
                        ENDIF
                        SELECT DISTINCT Cgrus FROM crImagens ;
                            INTO CURSOR cursor_4c_GruposSelec ;
                            ORDER BY Cgrus

                        IF USED("cursor_4c_ControleGrupos")
                            USE IN cursor_4c_ControleGrupos
                        ENDIF
                        CREATE CURSOR cursor_4c_ControleGrupos (Grupo N(8))
                        INDEX ON Grupo TAG Grupo

                        loc_nQtdGrupos   = RECCOUNT("cursor_4c_GruposSelec")
                        loc_nQtdProdutos = 0

                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                        loc_lResultado = .T.

                        SELECT cursor_4c_GruposSelec
                        SCAN
                            IF !loc_lResultado
                                EXIT
                            ENDIF

                            loc_cSQL = "SELECT Cgrus, Dgrus, Ids" + ;
                                " FROM SigCdGrp" + ;
                                " WHERE Cgrus = " + EscaparSQL(cursor_4c_GruposSelec.Cgrus) + ;
                                "   AND Ids > 0"

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosGrupo")

                            IF loc_nResultado < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalGrupo)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            SELECT cursor_4c_DadosGrupo
                            GO TOP

                            *-- CarregarDoCursor devolve .F. em EOF, o que equivale ao
                            *-- "If Not Eof([LocalGrupo])" do legado
                            IF THIS.CarregarDoCursor("cursor_4c_DadosGrupo")
                                loc_cGru = PADL(THIS.this_nIds, 8, "0")
                                loc_cDes = PADR(THIS.this_cDgrus, 40)
                                loc_cUni = PADR("", 4)

                                *-- td01 - Tabela de Grupos
                                loc_cStr = "td01" + ;           && Tipo - "td01" - Constante - Caracter(4)
                                    loc_cGru + ;                && ID - Numerico(8)
                                    loc_cDes + ;                && Descricao - Caracter(40)
                                    loc_cUni + loc_cChr         && Unidade - Caracter(4)

                                STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                IF !SEEK(THIS.this_nIds, "cursor_4c_ControleGrupos", "Grupo")
                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (THIS.this_nIds)
                                ENDIF

                                *-- Produtos distintos do grupo (crPros do legado)
                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                                SELECT DISTINCT Cpros FROM crImagens ;
                                    WHERE Cgrus = cursor_4c_GruposSelec.Cgrus ;
                                    INTO CURSOR cursor_4c_ProdutosGrupo ;
                                    ORDER BY Cpros

                                SELECT cursor_4c_ProdutosGrupo
                                SCAN
                                    loc_cSQL = "SELECT Cpros, Dpros, Cunis, Dtincs, Situas, Pesoms, Icms," + ;
                                        " Aliqipis, Clfiscals, Sittricms, Pvens, Figjpgs" + ;
                                        " FROM SigCdPro" + ;
                                        " WHERE Cpros = " + EscaparSQL(cursor_4c_ProdutosGrupo.Cpros)

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosProduto")

                                    IF loc_nResultado < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalProds)")
                                        loc_lResultado = .F.
                                        EXIT
                                    ENDIF

                                    SELECT cursor_4c_DadosProduto
                                    GO TOP

                                    IF THIS.CarregarDoCursor("cursor_4c_DadosProduto")
                                        loc_cRef = PADR(CHRTRAN(THIS.this_cCpros, [ */\:?"'<>|], []), 25)
                                        loc_cDes = PADR(THIS.this_cDpros, 60)
                                        loc_cUni = PADR(THIS.this_cCunis, 3)
                                        loc_cDat = DTOC(THIS.this_dDtincs)
                                        loc_cSit = IIF(THIS.this_nSituas = 2, "i", "a")
                                        *-- Pesoms/Pvens: PADL de COLUNA converte o numero com as
                                        *-- decimais DECLARADAS (pesoms numeric(8,3), pvens
                                        *-- numeric(11,5)); de VARIAVEL converteria com SET DECIMALS
                                        *-- (2 por default) e o campo de largura fixa sairia com
                                        *-- outro conteudo. O STR explicito reproduz a coluna.
                                        loc_cPes = STRTRAN(PADL(ALLTRIM(STR(THIS.this_nPesoms, 12, 3)), 8, "0"), ".", ",")
                                        loc_cIpi = PADL(INT(THIS.this_nAliqipis), 2, "0")
                                        loc_cIcm = PADL(INT(THIS.this_nIcms), 2, "0")
                                        loc_cClf = PADR(CHRTRAN(THIS.this_cClfiscals, [ .], []), 8)
                                        loc_cTri = PADR(THIS.this_cSittricms, 3)
                                        loc_cVal = STRTRAN(PADL(ALLTRIM(STR(THIS.this_nPvens, 18, 5)), 8, "0"), ".", ",")
                                        loc_cPre = PADR("00000000" + loc_cVal + "0000^", 400)

                                        loc_cGvd = ""

                                        *-- Colecoes/caracteristicas do produto (SigPrCar + SigCrRap)
                                        loc_cSQL = "SELECT b.Descrs, b.Ordens" + ;
                                            " FROM SigPrCar a, SigCrRap b" + ;
                                            " WHERE a.Cpros = " + EscaparSQL(THIS.this_cCpros) + ;
                                            "   AND a.Codigos = b.Codigos"

                                        IF USED("cursor_4c_Caracteristicas")
                                            USE IN cursor_4c_Caracteristicas
                                        ENDIF
                                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Caracteristicas")

                                        IF loc_nResultado < 1
                                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalCaracs)")
                                            loc_lResultado = .F.
                                            EXIT
                                        ENDIF

                                        SELECT cursor_4c_Caracteristicas
                                        SCAN
                                            *-- Le a linha corrente (Descrs/Ordens) para as
                                            *-- properties; Cpros/Figjpgs do produto NAO sao
                                            *-- tocados (este cursor nao tem essas colunas)
                                            THIS.CarregarDoCursor("cursor_4c_Caracteristicas")

                                            IF !EMPTY(THIS.this_nOrdens)
                                                IF !SEEK(THIS.this_nOrdens, "cursor_4c_ControleGrupos", "Grupo")
                                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (THIS.this_nOrdens)

                                                    loc_cGr1 = PADL(THIS.this_nOrdens, 8, "0")
                                                    loc_cDe1 = PADR(THIS.this_cDescrs, 40)
                                                    loc_cUn1 = PADR("", 4)

                                                    *-- td01 - Tabela de Grupos (colecao)
                                                    loc_cStr = "td01" + loc_cGr1 + loc_cDe1 + loc_cUn1 + loc_cChr

                                                    STRTOFILE(loc_cStr, loc_cArquivo, .T.)
                                                ENDIF
                                                loc_cGvd = loc_cGvd + ALLTRIM(STR(THIS.this_nOrdens, 8)) + "^"
                                            ENDIF
                                        ENDSCAN
                                        loc_cGvd = PADR(ALLTRIM(loc_cGvd), 60)

                                        *-- td03 - Tabela de Produtos
                                        loc_cStr = "td03" + ;               && Tipo - "td03" - Constante - Caracter(4)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            loc_cRef + ;                    && Referencia - Caracter(25)
                                            loc_cDes + ;                    && Descricao - Caracter(60)
                                            loc_cUni + ;                    && Unidade - Caracter(3)
                                            loc_cGru + ;                    && ID Grupo - Numerico(8)
                                            "00000000" + ;                  && ID Subgrupo - Numerico(8)
                                            loc_cDat + ;                    && Data do produto - Data(10)
                                            " " + ;                         && Alternativo - Caracter(1)
                                            "001" + ;                       && Multiplicador - Numerico(3)
                                            PADR(loc_cRef, 20) + ;          && Nome Foto Sem Extensao - Caracter(20)
                                            loc_cSit + ;                    && Status Produto a=ativo/i=inativo - Caracter(1)
                                            "00000000" + ;                  && Desconto Maximo em % - Numerico(8)
                                            "00" + ;                        && Tabela - Caracter(2)
                                            loc_cPes + ;                    && Peso - Numerico(8)
                                            " " + ;                         && Status Foto - Caracter(1)
                                            " " + ;                         && Lancamento - Caracter(1)
                                            loc_cIpi + ;                    && % do IPI - Numerico(2)
                                            "00000000" + ;                  && Valor IPI - Numerico(8)
                                            loc_cIcm + ;                    && % ICMS - Numerico(2)
                                            "00000000" + ;                  && Valor ICMS - Numerico(8)
                                            loc_cClf + ;                    && Classificacao Fiscal - Caracter(8)
                                            loc_cTri + ;                    && Situacao Tributaria - Caracter(3)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            "00000000" + ;                  && Estoque - Numerico(8)
                                            loc_cPre + ;                    && Lista(8)+Preco(8)+QtdeMinima(4)+^ - Caracter(400)
                                            SPACE(20) + ;                   && Codigo de Barras - Caracter(20)
                                            SPACE(64) + ;                   && RESERVADO - Caracter(64)
                                            SPACE(400) + ;                  && Caracteristicas (separador CHR(13)) - Caracter(400)
                                            loc_cGvd + loc_cChr             && Material/Complemento - Caracter(60)

                                        STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                        loc_nQtdProdutos = loc_nQtdProdutos + 1
                                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                                        *-- Exportando as imagens
                                        *-- this_cFigjpgs ja vem sem NULL (TratarNulo em
                                        *-- CarregarDoCursor), por isso o ISNULL do legado
                                        *-- fica coberto pelo EMPTY.
                                        *--
                                        *-- A condicao eh SO esta: o legado NAO consulta
                                        *-- chkImagens em lugar nenhum - no dump do SCX esse
                                        *-- controle aparece apenas na arvore de objetos e no
                                        *-- bloco de propriedades, e o Processamento guarda a
                                        *-- exportacao so com "If Not Empty(LocalProds.FigJpgs)
                                        *-- And Not IsNull(LocalProds.FigJpgs)". Acrescentar
                                        *-- AND this_lExportarImagens aqui seria INVENTAR uma
                                        *-- restricao que o legado nao tem (PILAR 1 / regra
                                        *-- #49): quem desmarcasse "Exportar Imagens" deixaria
                                        *-- de receber os JPGs que o sistema antigo gera.
                                        *-- Ver a nota de this_lExportarImagens: ligar a
                                        *-- caixa eh mudanca de comportamento e precisa de
                                        *-- decisao do cliente, nao de decisao do migrador.
                                        IF !EMPTY(THIS.this_cFigjpgs)
                                            loc_cImg = ALLTRIM(JUSTPATH(loc_cArquivo)) + "\" + ALLTRIM(loc_cRef) + ".Jpg"
                                            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(THIS.this_cFigjpgs, ;
                                                "data:image/png;base64,", ""), ;
                                                "data:image/jpeg;base64,", ""), ;
                                                "data:image/jpg;base64,", ""), 14)
                                            STRTOFILE(loc_cFoto, loc_cImg)
                                        ENDIF
                                    ENDIF

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    IF USED("cursor_4c_Caracteristicas")
                                        USE IN cursor_4c_Caracteristicas
                                    ENDIF
                                ENDSCAN

                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                            ENDIF

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                        ENDSCAN

                        THIS.this_nQtdGrupos   = loc_nQtdGrupos
                        THIS.this_nQtdProdutos = loc_nQtdProdutos

                        IF loc_lResultado
                            IF loc_nQtdProdutos > 0
                                THIS.this_cMensagemResultado = "Arquivo de Produtos Gerado Com Sucesso!!!"
                            ELSE
                                THIS.this_cMensagemResultado = "Aten" + CHR(231) + CHR(227) + "o!!! Arquivo Gerado Sem Produtos!!!"
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo de exporta" + CHR(231) + CHR(227) + "o: " + ;
                loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.

        FINALLY
            IF USED("cursor_4c_GruposSelec")
                USE IN cursor_4c_GruposSelec
            ENDIF
            IF USED("cursor_4c_ProdutosGrupo")
                USE IN cursor_4c_ProdutosGrupo
            ENDIF
            IF USED("cursor_4c_ControleGrupos")
                USE IN cursor_4c_ControleGrupos
            ENDIF
            IF USED("cursor_4c_DadosGrupo")
                USE IN cursor_4c_DadosGrupo
            ENDIF
            IF USED("cursor_4c_DadosProduto")
                USE IN cursor_4c_DadosProduto
            ENDIF
            IF USED("cursor_4c_Caracteristicas")
                USE IN cursor_4c_Caracteristicas
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

