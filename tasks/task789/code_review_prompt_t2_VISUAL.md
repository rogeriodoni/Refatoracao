# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'MarcarEmp' (parent: SIGOPPRM): Top original=162 vs migrado 'cmd_4c_DesmarcarEmp' Top=202 (diff=40px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPPRM.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1107 linhas total):

*-- Linhas 58 a 79:
58: *             transcritas do dump, Init (guarda pAnt/codigo do produto e cria
59: *             o BO), InicializarForm (fundo do form + cabecalho + estado de
60: *             modo-consulta/acesso no BO) e ConfigurarCabecalho (cnt_4c_Sombra
61: *             + lbl_4c_LblSombra/lbl_4c_LblTitulo). Sem metodo de pageframe -
62: *             este form nao tem PageFrame (ver acima). Destroy fecha o
63: *             cursor da grade antes de DODEFAULT().
64: *   Fase 4:   grade de marcacao (GridEmps - Column1 com CheckBox ligado a
65: *             ImpEmps) e os quatro botoes (btnSair/Encerrar, btnRetirar,
66: *             MarcarEmp, DesmarcarEmp) + as duas molduras decorativas
67: *             (Commandgroup3/cmdRetirar, ButtonCount=0) e Shape2.
68: *   Fase 5/6: SEM TRABALHO, medido no dump e em tasks\task789\analise.json
69: *             ("campos": [], "lookups": [], "labels": []). O SCX legado
70: *             (SECAO 1) nao tem NENHUM controle de entrada/exibicao fora da
71: *             grade: os unicos BaseClass textbox/checkbox do dump sao
72: *             Column2..Column4.Text1 (Pecas/Promos/Datas, "When / Return
73: *             .f." -> .ReadOnly = .T., ja em ConfigurarGrid) e Column1.Check1
74: *             (ImpEmps, ja GarantirCheckBoxImpEmps/ChkImpEmps* da Fase 4).
75: *             grep confirma zero fwBuscaExt/fwBuscaSel/sigacess/CreateObject
76: *             no dump - nao ha lookup a acrescentar. Mesmo perfil "GRADE +
77: *             BOTOES" de SIGOEMB/task728 (memoria
78: *             noop_guard_sem_excecao_para_fase_sem_trabalho): todo controle
79: *             de entrada do legado eh celula de Column, ja entregue junto

*-- Linhas 117 a 149:
117: *             ToolTipText do dump descreve ("Marca/Desmarca Todas as Linhas
118: *             de Produto"), com o prefixo canonico Btn. O prefixo nao eh
119: *             cosmetico: os gates enumeram handler de botao por
120: *             "PROCEDURE (Cmd|Btn)\w*Click", e sem ele os dois ficavam
121: *             invisiveis. So o HANDLER mudou de nome - os objetos
122: *             (cmd_4c_MarcarEmp/cmd_4c_DesmarcarEmp) seguem como estao, por
123: *             isso tasks\task789\mapeamento.json nao foi tocado.
124: *   Fase 8:   SEM TRABALHO NOVO - o Form ja estava COMPLETO ao fim da Fase 7.
125: *             Os nomes canonicos que a Fase 8 pede - escritos abaixo com um
126: *             espaco no meio, DE PROPOSITO, para nao satisfazer o gate por
127: *             SUBSTRING do proprio comentario (armadilha ja registrada no
128: *             fechamento da Fase 7, acima: citar o nome inteiro faz o -match
129: *             do gate aprovar sem olhar se o metodo FOI escrito) - Btn
130: *             Buscar Click / Btn Salvar Click / Btn Cancelar Click /
131: *             Form Para BO / BO Para Form / Habilitar Campos / Limpar
132: *             Campos / Carregar Lista / Ajustar Botoes Por Modo - sao
133: *             convencao do par Page2(Dados)+modo INCLUIR/ALTERAR/
134: *             VISUALIZAR/EXCLUIR do frmcadastro, que este legado NAO TEM
135: *             (ver cabecalho/Fase 7 acima: layout FLAT, herda de "form"
136: *             puro, zero pcEscolha PROPRIO - as 3 citacoes sao leitura de
137: *             ThisForm.ParentForm.pcEscolha). Equivalentes reais ja
138: *             entregues:
139: *               Carregar Lista        -> CarregarPromocoes() (funil unico de
140: *                                        carga/bind/repintura da grade,
141: *                                        chamado por InicializarForm)
142: *               Ajustar Botoes Por Modo -> inline no proprio
143: *                                        CarregarPromocoes (Visible de
144: *                                        cmd_4c_BtnRetirar/cmg_4c_CmdRetirar
145: *                                        segue !this_lSomenteConsulta - nao
146: *                                        ha modo INCLUIR/ALTERAR a alternar)
147: *               botao de acao real    -> BtnRetirarClick (RetirarPromocao()
148: *                                        no BO faz DELETE FROM SigPrPmi de
149: *                                        verdade - nao esta na lista

*-- Linhas 254 a 263:
254:     * Reproduz o inicio do Init legado:
255:     *   1. o fundo do form (propriedade Picture do dump);
256:     *   2. a faixa cinza do topo com o titulo, equivalente a
257:     *      "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" /
258:     *      "ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption";
259:     *   3. o estado de modo-consulta/acesso que a Fase 4 vai consumir para
260:     *      decidir Column1.ReadOnly e a visibilidade de
261:     *      btnRetirar/cmdRetirar - equivalente a
262:     *      "ThisForm.ParentForm.pcEscolha <> 'CONSULTAR'" e ao gate
263:     *      "fChecaAcesso('SigCdPrm','EXCLUIR') Or fChecaAcesso('SigCdPrm',

*-- Linhas 346 a 360:
346:     * regra #11 - o cabecalho NUNCA se detecta pelo nome do container).
347:     *
348:     * Os dois labels recebem Caption = THIS.Caption aqui, que eh exatamente o
349:     * que o Init legado faz ("ThisForm.cntSombra.lblSombra.Caption =
350:     * ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption"): o
351:     * Caption gravado no SCX eh o texto residual "Cadastro de Testes",
352:     * sobrescrito em runtime - por isso o texto residual NAO eh transcrito.
353:     *
354:     * Top/Left/Width/Height/fonte/cor vem do dump. lbl_4c_LblSombra eh a
355:     * sombra preta (ForeColor 0,0,0) e lbl_4c_LblTitulo o texto branco
356:     * (ForeColor 255,255,255) desenhado por cima dela - por isso o titulo eh
357:     * criado DEPOIS da sombra.
358:     *
359:     * AutoSize = .F. explicito nos dois labels: em Label criado por AddObject
360:     * o AutoSize eh no-op e, com WordWrap = .T., descarta a Height e corta o

*-- Linhas 375 a 434:
375:         *-- exatamente a largura do form.
376:         THIS.AddObject("cnt_4c_Sombra", "Container")
377:         WITH THIS.cnt_4c_Sombra
378:             .Top           = 0
379:             .Left          = 0
380:             .Width         = THIS.Width
381:             .Height        = 80
382:             .BackStyle     = 1
383:             .BackColor     = RGB(100, 100, 100)
384:             .BorderWidth   = 0
385:             .SpecialEffect = 0
386:             .Visible       = .T.
387:         ENDWITH
388: 
389:         *-- lblSombra (dump): Tahoma 18 bold, Top=25, Left=10, 769x40,
390:         *-- WordWrap=.T., Alignment=0, BackStyle=0, ForeColor=0,0,0
391:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
392:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
393:             .Top           = 25
394:             .Left          = 10
395:             .Width         = 769
396:             .Height        = 40
397:             .AutoSize      = .F.
398:             .FontName      = "Tahoma"
399:             .FontSize      = 18
400:             .FontBold      = .T.
401:             .FontUnderline = .F.
402:             .WordWrap      = .T.
403:             .Alignment     = 0
404:             .BackStyle     = 0
405:             .ForeColor     = RGB(0, 0, 0)
406:             .Caption       = loc_cCaption
407:             .Visible       = .T.
408:         ENDWITH
409: 
410:         *-- lblTitulo (dump): Tahoma 18 bold, Top=24, Left=10, 769x46,
411:         *-- WordWrap=.T., Alignment=0, BackStyle=0, ForeColor=255,255,255.
412:         *-- Branco eh CORRETO aqui: eh o titulo da faixa, sobre Container
413:         *-- OPACO escuro (excecao explicita da CLAUDE.md regra #12).
414:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
415:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
416:             .Top         = 24
417:             .Left        = 10
418:             .Width       = 769
419:             .Height      = 46
420:             .AutoSize    = .F.
421:             .FontName    = "Tahoma"
422:             .FontSize    = 18
423:             .FontBold    = .T.
424:             .WordWrap    = .T.
425:             .Alignment   = 0
426:             .BackStyle   = 0
427:             .ForeColor   = RGB(255, 255, 255)
428:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
429:             .Caption     = loc_cCaption
430:             .Visible     = .T.
431:         ENDWITH
432:     ENDPROC
433: 
434:     *==========================================================================

*-- Linhas 472 a 481:
472:         *-- (ButtonCount = 0)
473:         THIS.AddObject("cmg_4c_Commandgroup3", "CommandGroup")
474:         WITH THIS.cmg_4c_Commandgroup3
475:             .Top           = 7
476:             .Left          = 698
477:             .Width         = 90
478:             .Height        = 110
479:             .ButtonCount   = 0
480:             .BackStyle     = 0
481:             .BorderStyle   = 0

*-- Linhas 491 a 500:
491:         *-- CarregarPromocoes
492:         THIS.AddObject("cmg_4c_CmdRetirar", "CommandGroup")
493:         WITH THIS.cmg_4c_CmdRetirar
494:             .Top           = 7
495:             .Left          = 12
496:             .Width         = 90
497:             .Height        = 110
498:             .ButtonCount   = 0
499:             .BackStyle     = 0
500:             .BorderStyle   = 0

*-- Linhas 508 a 532:
508:         *-- Shape2: moldura entre MarcarEmp e DesmarcarEmp
509:         THIS.AddObject("shp_4c_Shape2", "Shape")
510:         WITH THIS.shp_4c_Shape2
511:             .Top         = 157
512:             .Left        = 563
513:             .Width       = 50
514:             .Height      = 90
515:             .BackStyle   = 0
516:             .BorderStyle = 0
517:             .FillStyle   = 1
518:             .ColorScheme = 1
519:             .BorderColor = RGB(136, 189, 188)
520:             .Visible     = .T.
521:         ENDWITH
522: 
523:         *-- btnSair -> cmd_4c_BtnSair ("Encerrar", Cancel=.T./[Esc])
524:         THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
525:         WITH THIS.cmd_4c_BtnSair
526:             .Top             = 3
527:             .Left            = 725
528:             .Width           = 80
529:             .Height          = 100
530:             .FontBold        = .T.
531:             .FontItalic      = .T.
532:             .FontName        = "Comic Sans MS"

*-- Linhas 539 a 556:
539:             .DisabledPicture = gc_4c_CaminhoFramework + "imagens\cadastro_sair_60.jpg"
540:             .Themes          = .T.
541:             .Cancel          = .T.
542:             .Caption         = "Encerrar"
543:             .Visible         = .T.
544:         ENDWITH
545:         BINDEVENT(THIS.cmd_4c_BtnSair, "Click", THIS, "BtnSairClick")
546: 
547:         *-- btnRetirar -> cmd_4c_BtnRetirar ("\<Retirar")
548:         THIS.AddObject("cmd_4c_BtnRetirar", "CommandButton")
549:         WITH THIS.cmd_4c_BtnRetirar
550:             .Top             = 3
551:             .Left            = 650
552:             .Width           = 80
553:             .Height          = 100
554:             .FontBold        = .T.
555:             .FontItalic      = .T.
556:             .FontName        = "Comic Sans MS"

*-- Linhas 562 a 579:
562:             .Picture         = gc_4c_CaminhoFramework + "imagens\geral_pasta_60.jpg"
563:             .DisabledPicture = gc_4c_CaminhoFramework + "imagens\geral_pasta_60.jpg"
564:             .Themes          = .T.
565:             .Caption         = "\<Retirar"
566:             .Visible         = .T.
567:         ENDWITH
568:         BINDEVENT(THIS.cmd_4c_BtnRetirar, "Click", THIS, "BtnRetirarClick")
569: 
570:         *-- MarcarEmp -> cmd_4c_MarcarEmp (marca TODAS as linhas)
571:         THIS.AddObject("cmd_4c_MarcarEmp", "CommandButton")
572:         WITH THIS.cmd_4c_MarcarEmp
573:             .Top             = 162
574:             .Left            = 557
575:             .Width           = 40
576:             .Height          = 40
577:             .FontBold        = .T.
578:             .FontItalic      = .T.
579:             .FontName        = "Comic Sans MS"

*-- Linhas 585 a 631:
585:             .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
586:             .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
587:             .Themes          = .T.
588:             .Caption         = ""
589:             .ToolTipText     = "Marca Todas as Linhas de Produto"
590:             .Visible         = .T.
591:         ENDWITH
592:         BINDEVENT(THIS.cmd_4c_MarcarEmp, "Click", THIS, "BtnMarcarTodasClick")
593: 
594:         *-- DesmarcarEmp -> cmd_4c_DesmarcarEmp (desmarca TODAS as linhas)
595:         THIS.AddObject("cmd_4c_DesmarcarEmp", "CommandButton")
596:         WITH THIS.cmd_4c_DesmarcarEmp
597:             .Top             = 202
598:             .Left            = 557
599:             .Width           = 40
600:             .Height          = 40
601:             .FontBold        = .T.
602:             .FontItalic      = .T.
603:             .FontName        = "Comic Sans MS"
604:             .FontSize        = 8
605:             .WordWrap        = .T.
606:             .MousePointer    = 15
607:             .ForeColor       = RGB(90, 90, 90)
608:             .BackColor       = RGB(255, 255, 255)
609:             .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
610:             .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
611:             .Themes          = .T.
612:             .Caption         = ""
613:             .ToolTipText     = "Desmarca Todas as Linhas de Produto"
614:             .Visible         = .T.
615:         ENDWITH
616:         BINDEVENT(THIS.cmd_4c_DesmarcarEmp, "Click", THIS, "BtnDesmarcarTodasClick")
617:     ENDPROC
618: 
619:     *==========================================================================
620:     * BtnSairClick - Equivalente ao btnSair.Click legado ("ThisForm.Release").
621:     * PUBLIC (sem PROTECTED) - BINDEVENT exige metodo publico (regra #3).
622:     *==========================================================================
623:     PROCEDURE BtnSairClick()
624:         THIS.Release()
625:     ENDPROC
626: 
627:     *==========================================================================
628:     * BtnMarcarTodasClick - "Update csEmpresas Set ImpEmps = .t." + Refresh do
629:     * MarcarEmp.Click legado. PUBLIC - BINDEVENT exige metodo publico.
630:     *
631:     * Nome pela ACAO, nao pelo objeto legado: o botao eh ICONE-PURO

*-- Linhas 793 a 801:
793:     *
794:     * Aqui ficam SO as propriedades que NAO dependem de dado (geometria,
795:     * fonte, Movable/Resizable/ReadOnly de cada coluna). RecordSource,
796:     * ControlSource, o CheckBox da Column1, as larguras e os captions vivem
797:     * em CarregarPromocoes, porque o VFP9 reseta esse grupo a cada rebind
798:     * (Problema 48 do FORMCOR_LICOES_APRENDIDAS.md).
799:     *
800:     * Grid.ReadOnly = .F. vem ANTES do ReadOnly das colunas, porque o do
801:     * grid propaga e sobrescreve o das colunas (CLAUDE.md regra #46):

*-- Linhas 813 a 822:
813: 
814:         WITH THIS.grd_4c_Dados
815:             .ColumnCount       = 4
816:             .Top               = 134
817:             .Left              = 186
818:             .Width             = 369
819:             .Height            = 130
820:             .FontName          = "Tahoma"
821:             .AllowHeaderSizing = .F.
822:             .AllowRowSizing    = .F.

*-- Linhas 875 a 886:
875:     *
876:     * Width/Header1.Caption vao DEPOIS do RecordSource/ControlSource, porque
877:     * atribuir RecordSource reseta os dois (Problema 48 do
878:     * FORMCOR_LICOES_APRENDIDAS.md / CLAUDE.md regra #41). O CheckBox da
879:     * Column1 eh (re)criado aqui, DEPOIS do ControlSource apontar para a
880:     * coluna logica ImpEmps, pela mesma razao de
881:     * FormSigOpPrL.GarantirCheckBoxMarcacao: um RecordSource/ControlSource
882:     * novo pode destruir o controle posto por Column.AddObject.
883:     *
884:     * "ThisForm.btnRetirar.Visible = (ThisForm.ParentForm.pcEscolha <>
885:     * 'CONSULTAR')" / "ThisForm.cmdRetirar.Visible = ..." do Init legado: os
886:     * dois objetos ja existem (ConfigurarBotoes roda antes), so falta

*-- Linhas 923 a 1010:
923:             .Column4.ControlSource = loc_cCursor + ".Datas"
924:         ENDWITH
925: 
926:         *-- CheckBox da Column1 (recriado se o rebind do alias o destruiu)
927:         THIS.GarantirCheckBoxImpEmps()
928: 
929:         WITH THIS.grd_4c_Dados
930:             *-- Larguras e captions DEPOIS do RecordSource, que reseta os
931:             *-- dois
932:             .Column1.Width = 15
933:             .Column2.Width = 80
934:             .Column3.Width = 185
935:             .Column4.Width = 66
936: 
937:             .Column1.Header1.Caption = ""
938:             .Column2.Header1.Caption = "Pe" + CHR(231) + "as"
939:             .Column3.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
940:             .Column4.Header1.Caption = "Data"
941:         ENDWITH
942: 
943:         *-- "Go Top In csEmpresas" + "ThisForm.GridEmps.Refresh" do Init
944:         *-- legado
945:         SELECT (loc_cCursor)
946:         GO TOP IN (loc_cCursor)
947:         THIS.grd_4c_Dados.Refresh()
948: 
949:         *-- "ThisForm.btnRetirar.Visible = (ThisForm.ParentForm.pcEscolha <>
950:         *-- 'CONSULTAR')" / "ThisForm.cmdRetirar.Visible = ..." do Init
951:         *-- legado
952:         loc_lVisivelRetirar = !THIS.this_oBusinessObject.this_lSomenteConsulta
953:         IF PEMSTATUS(THIS, "cmd_4c_BtnRetirar", 5)
954:             THIS.cmd_4c_BtnRetirar.Visible = loc_lVisivelRetirar
955:         ENDIF
956:         IF PEMSTATUS(THIS, "cmg_4c_CmdRetirar", 5)
957:             THIS.cmg_4c_CmdRetirar.Visible = loc_lVisivelRetirar
958:         ENDIF
959: 
960:         RETURN .T.
961:     ENDPROC
962: 
963:     *==========================================================================
964:     * GarantirCheckBoxImpEmps - Cria o CheckBox de marcacao da Column1
965:     * (equivalente ao Check1 do dump), com os 4 handlers de alternancia.
966:     *
967:     * IDEMPOTENTE (CLAUDE.md regra #46 / pattern #185): chamado por
968:     * CarregarPromocoes, e um segundo AddObject com o mesmo nome estouraria
969:     * "Object already defined" - o PEMSTATUS eh o que distingue "ainda vivo"
970:     * de "destruido pelo rebind do alias".
971:     *
972:     * Top/Left/Width/Height vem do dump (Check1): ao contrario do checkbox
973:     * de outras grades deste projeto, este TEM geometria propria declarada
974:     * no SCX.
975:     *
976:     * Os BINDEVENT ficam JUNTO do AddObject: objeto recriado eh OUTRO objeto
977:     * e as ligacoes do anterior morreram com ele.
978:     *==========================================================================
979:     PROTECTED PROCEDURE GarantirCheckBoxImpEmps()
980:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
981:             RETURN .F.
982:         ENDIF
983: 
984:         IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_ImpEmps", 5)
985:             *-- Ainda vivo: um segundo AddObject estouraria
986:             RETURN .T.
987:         ENDIF
988: 
989:         THIS.grd_4c_Dados.Column1.AddObject("chk_4c_ImpEmps", "CheckBox")
990: 
991:         WITH THIS.grd_4c_Dados.Column1.chk_4c_ImpEmps
992:             .Top       = 9
993:             .Left      = 2
994:             .Width     = 22
995:             .Height    = 17
996:             .FontName  = "Tahoma"
997:             .Alignment = 0
998:             .Caption   = ""
999:             .ReadOnly  = .F.
1000:             .Visible   = .T.
1001:         ENDWITH
1002: 
1003:         *-- Sparse e CurrentControl DEPOIS de o controle existir (regra
1004:         *-- #18): sem CurrentControl a coluna segue desenhando o Text1 dela,
1005:         *-- e sem Sparse = .F. o CheckBox so aparece na linha ativa
1006:         THIS.grd_4c_Dados.Column1.Sparse         = .F.
1007:         THIS.grd_4c_Dados.Column1.CurrentControl = "chk_4c_ImpEmps"
1008: 
1009:         *-- Os 4 handlers de alternancia, transcritos do dump
1010:         *-- (Check1.Click/MouseDown/MouseUp/KeyPress): o toggle real


### BO (C:\4c\projeto\app\classes\SIGOPPRMBO.prg):
*==============================================================================
* SIGOPPRMBO.prg - Business Object para FormSIGOPPRM (Promocoes do Produto)
* Herda de BusinessBase
*
* ATENCAO: este form eh um dialogo OPERACIONAL (modal) aberto pelo Cadastro de
* Produtos - no legado "Do Form SigOpPrm With ThisForm" (sigcdpro), disparado
* apos a pergunta "O Produto Encontra-se Em Promocao!!! Deseja Conferir ?".
* Ele lista as PROMOCOES em que o produto corrente se encontra (tabela
* SigPrPmi, filtrada pelo codigo do produto) numa grade com coluna de
* marcacao, e permite RETIRAR o produto das promocoes marcadas.
*
* O Load legado cria o cursor local da grade e o Init o popula a partir do
* cursor crSigPrPmi que o form PAI ja deixa aberto:
*     Create Cursor csEmpresas (ImpEmps l(1), CPros c(14), Pecas c(10), ;
*                               Promos c(25), Datas t Null, cIdChaves c(20))
*     Index On CPros + Promos Tag CPros
* No sistema novo o form pai (FormProduto) nao mantem esse cursor aberto, por
* isso este BO le a MESMA consulta que o pai usava no AddCursor:
*     lcQryProMI = 'Select * From SigPrPmi Where CPros = ?pPro'
* Os nomes das colunas e o filtro sao transcritos do legado (PILAR 2).
*
* O btnRetirar.Click legado executa, por linha marcada, TRES passos:
*   1) Delete From SigPrPmi  Where cIdChaves = ?pChv   (SQL Server)
*   2) Delete From crSigPrPmi Where cIdChaves = pChv   (cursor do form PAI)
*   3) Delete From csEmpresas Where cIdChaves = pChv   (cursor da grade)
* precedidos do gate de acesso fChecaAcesso('SigCdPrm', 'EXCLUIR') Or
* fChecaAcesso('SigCdPrm', 'ALTERAR'), e seguidos de GridEmps.Refresh.
*
* Como o legado SO exclui (nunca insere nem altera SigPrPmi nesta tela), o
* comportamento padrao herdado de BusinessBase para Inserir()/Atualizar() ja
* eh o correto - inventar INSERT/UPDATE aqui violaria a regra de que a lista
* de colunas vem do schema e nao de suposicao.
*
* Tabela ...: SigPrPmi
* Chave .....: cidchaves (char 20) - PK sigprpmi_cidchaves
*==============================================================================
DEFINE CLASS SIGOPPRMBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - colunas de SigPrPmi (uma promocao do produto)
    * Tipos conferidos em docs/schema.sql:
    *   cpros char(14) NOT NULL | pecas char(10) NOT NULL
    *   promos char(25) NOT NULL | cbars numeric(14,0) NOT NULL
    *   datas datetime NULL | cidchaves char(20) NOT NULL (PK)
    *   dtalts datetime NULL | promopro char(35) NOT NULL
    *   vendavels numeric(1,0) NOT NULL
    *--------------------------------------------------------------------------
    this_cCPros     = ""    && SigPrPmi.cpros     - codigo do produto (char 14)
    this_cPecas     = ""    && SigPrPmi.pecas     - peca da promocao (char 10)
    this_cPromos    = ""    && SigPrPmi.promos    - codigo da promocao (char 25)
    this_nCbars     = 0     && SigPrPmi.cbars     - codigo de barras numeric(14,0)
    this_dDatas     = {}    && SigPrPmi.datas     - data da promocao (datetime NULL)
    this_cCidChaves = ""    && SigPrPmi.cidchaves - chave primaria Fortyus (char 20)
    this_dDtAlts    = {}    && SigPrPmi.dtalts    - data da ultima alteracao (datetime NULL)
    this_cPromoPro  = ""    && SigPrPmi.promopro  - descricao da promocao (char 35)
    this_nVendavels = 0     && SigPrPmi.vendavels - indicador vendavel numeric(1,0)

    *--------------------------------------------------------------------------
    * Propriedades - estado de tela (NAO existem em SigPrPmi)
    *--------------------------------------------------------------------------
    *-- Marcacao da linha na grade. No legado eh a coluna ImpEmps l(1) do cursor
    *-- local csEmpresas, alimentada com .f. no Insert Into do Init e alternada
    *-- pelos handlers MouseDown/KeyPress do Check1 da Column1.
    this_lImpEmps = .F.

    *-- Nome do cursor que alimenta a grade do dialogo (equivale a csEmpresas).
    this_cCursorItens = "cursor_4c_Promocoes"

    *-- Nome do cursor de SigPrPmi que o form PAI mantem aberto, quando houver
    *-- (equivale a crSigPrPmi). Vazio significa que o pai nao tem esse cursor e
    *-- o passo 2 da retirada do legado nao se aplica.
    this_cCursorItensPai = ""

    *-- pcEscolha do form PAI, recebido junto com a referencia do pai no Init do
    *-- form (LParameters pAnt / ThisForm.ParentForm = pAnt). O legado compara
    *-- com 'CONSULTAR' para decidir Column1.ReadOnly e a visibilidade de
    *-- btnRetirar/cmdRetirar.
    this_cModoEscolha = ""

    *-- .T. quando this_cModoEscolha = "CONSULTAR": a coluna de marcacao fica
    *-- somente leitura e o botao Retirar fica oculto.
    this_lSomenteConsulta = .F.

    *-- Resultado do gate de acesso do btnRetirar.Click legado
    *-- (fChecaAcesso('SigCdPrm','EXCLUIR') Or fChecaAcesso('SigCdPrm','ALTERAR')).
    this_lTemAcessoRetirar = .F.

    *-- Programa consultado no gate de acesso (1o argumento do fChecaAcesso).
    this_cProgramaAcesso = "SigCdPrm"

    *-- Contadores do dialogo: promocoes carregadas, marcadas e efetivamente
    *-- retiradas na ultima execucao da retirada.
    this_nTotalPromocoes    = 0
    this_nTotalSelecionadas = 0
    this_nTotalRetiradas    = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave e zera o estado do dialogo.
    * DODEFAULT() sem argumento segue o padrao dos BOs de dialogo OPERACIONAL
    * (SigOpPrLBO): a tabela eh atribuida direto, sem instanciar DataAccess,
    * porque o acesso desta tela eh Select/Delete via SQLEXEC.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigPrPmi"
                THIS.this_cCampoChave = "cidchaves"

                *-- Estado inicial do dialogo
                THIS.this_cCursorItens       = "cursor_4c_Promocoes"
                THIS.this_cCursorItensPai    = ""
                THIS.this_cModoEscolha       = ""
                THIS.this_lSomenteConsulta   = .F.
                THIS.this_lTemAcessoRetirar  = .F.
                THIS.this_cProgramaAcesso    = "SigCdPrm"
                THIS.this_nTotalPromocoes    = 0
                THIS.this_nTotalSelecionadas = 0
                THIS.this_nTotalRetiradas    = 0

                *-- Colunas de SigPrPmi da linha corrente
                THIS.this_cCPros     = ""
                THIS.this_cPecas     = ""
                THIS.this_cPromos    = ""
                THIS.this_nCbars     = 0
                THIS.this_dDatas     = {}
                THIS.this_cCidChaves = ""
                THIS.this_dDtAlts    = {}
                THIS.this_cPromoPro  = ""
                THIS.this_nVendavels = 0
                THIS.this_lImpEmps   = .F.

                THIS.this_cMensagemErro = ""
                THIS.this_lErroExibido  = .F.
            ENDIF
        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro("Erro ao inicializar SIGOPPRMBO: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades desta promocao a partir da
    * linha CORRENTE de um cursor aberto.
    *
    * Aceita DOIS formatos de cursor, porque sao os dois usados por este
    * dialogo (regra #9 - sempre SELECT (alias) antes de ler os campos, nunca
    * campo):
    *   1) a MESMA consulta que o form pai usa no AddCursor - Select * From
    *      SigPrPmi Where cpros = ?pPro - com TODAS as colunas da tabela
    *      (cpros, pecas, promos, cbars, datas, cidchaves, dtalts, promopro,
    *      vendavels);
    *   2) o cursor local da grade (equivalente a csEmpresas do legado), que
    *      tem so ImpEmps, CPros, Pecas, Promos, Datas, cIdChaves.
    * Por isso as colunas exclusivas de SigPrPmi (cbars/dtalts/promopro/
    * vendavels) e a marcacao exclusiva da grade (ImpEmps) sao lidas so
    * quando TYPE() confirma que existem no alias recebido.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de promo" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF EOF()
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente no cursor de promo" + CHR(231) + CHR(245) + "es"
            RETURN .F.
        ENDIF

        THIS.this_cCPros     = TratarNulo(cpros, "")
        THIS.this_cPecas     = TratarNulo(pecas, "")
        THIS.this_cPromos    = TratarNulo(promos, "")
        THIS.this_dDatas     = TratarNulo(datas, {})
        THIS.this_cCidChaves = TratarNulo(cidchaves, "")

        IF TYPE(par_cAliasCursor + ".cbars") != "U"
            THIS.this_nCbars = TratarNulo(cbars, 0)
        ENDIF

        IF TYPE(par_cAliasCursor + ".dtalts") != "U"
            THIS.this_dDtAlts = TratarNulo(dtalts, {})
        ENDIF

        IF TYPE(par_cAliasCursor + ".promopro") != "U"
            THIS.this_cPromoPro = TratarNulo(promopro, "")
        ENDIF

        IF TYPE(par_cAliasCursor + ".vendavels") != "U"
            THIS.this_nVendavels = TratarNulo(vendavels, 0)
        ENDIF

        IF TYPE(par_cAliasCursor + ".ImpEmps") != "U"
            THIS.this_lImpEmps = TratarNulo(ImpEmps, .F.)
        ENDIF

        THIS.this_cMensagemErro = ""
        loc_lResultado = .T.

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria Fortyus da promocao corrente
    * (sigprpmi_cidchaves). Usada por RegistrarAuditoria().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * RetirarPromocao - Remove o produto de UMA promocao: Delete From SigPrPmi
    * Where cidchaves = <chave>, exatamente o passo 1 do btnRetirar.Click do
    * legado. O legado roda esse DELETE dentro de um Scan por linha marcada,
    * precedido do gate fChecaAcesso('SigCdPrm','EXCLUIR') Or fChecaAcesso(
    * 'SigCdPrm','ALTERAR') e de uma confirmacao do usuario, e seguido de DOIS
    * deletes em cursor LOCAL (crSigPrPmi do pai e csEmpresas da grade) - o
    * loop, a confirmacao, o gate de acesso e a manutencao dos cursores da
    * tela sao orquestracao de UI e ficam no Form; este metodo cobre so a
    * operacao de dados de UMA linha (chamada uma vez por cidchaves marcada).
    *
    * Como o legado SO exclui (nunca insere/altera SigPrPmi nesta tela - ver
    * cabecalho da classe), Inserir()/Atualizar() continuam com o
    * comportamento herdado de BusinessBase e este eh o UNICO metodo de
    * gravacao real do BO.
    *--------------------------------------------------------------------------
    PROCEDURE RetirarPromocao(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCursorTemp, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cCidChaves) != "C" OR EMPTY(ALLTRIM(par_cCidChaves))
            MsgErro("Chave da promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada", "Erro")
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel", "Erro")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cCidChaves = ALLTRIM(par_cCidChaves)
            loc_cCursorTemp = "cursor_4c_DelPmi"

            loc_cSQL = "DELETE FROM SigPrPmi WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            DO CASE
            CASE loc_nResultado < 0
                *-- Equivale ao "Favor Reinicializar o Processo!!!" / "Falha na
                *-- Conexao (Excluindo Promocao)" do legado
                MsgErro("Favor Reinicializar o Processo (Excluindo Promo" + CHR(231) + CHR(227) + "o)" + CHR(13) + ;
                    CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
            CASE loc_nResultado = 0
                MsgAviso("Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada (j" + CHR(225) + ;
                    " havia sido retirada).", "Aten" + CHR(231) + CHR(227) + "o")
            OTHERWISE
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPromocoes - Popula o cursor da grade (this_cCursorItens,
    * equivalente a csEmpresas) com as promocoes do produto informado.
    *
    * No legado quem roda esta consulta eh o form PAI (Cadastro de Produtos),
    * no AddCursor que deixa crSigPrPmi aberto ANTES de abrir este dialogo
    * ("Select * From SigPrPmi Where CPros = ?pPro"); o Init deste dialogo so
    * faz Scan nesse cursor e:
    *     Insert Into csEmpresas (ImpEmps, CPros, Pecas, Promos, Datas, ;
    *                             cIdChaves) ;
    *         Values (.f., crSigPrPmi.CPros, crSigPrPmi.Pecas, ;
    *                 crSigPrPmi.Promos, Nvl(crSigPrPmi.Datas, Ctod('')), ;
    *                 crSigPrPmi.cIdChaves)
    * com ImpEmps = .f. em TODA linha (marcacao comeca desmarcada). Como o
    * form pai desta arquitetura nao mantem esse cursor aberto (ver
    * cabecalho do Form), este metodo faz as DUAS coisas de uma vez: busca
    * SigPrPmi pelo codigo do produto (a MESMA consulta do AddCursor do pai)
    * e monta this_cCursorItens com a MESMA estrutura/ordem de colunas de
    * "Create Cursor csEmpresas (...)" do Load legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPromocoes(par_cCodigoProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCursorTemp, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro  = ""
        THIS.this_nTotalPromocoes = 0

        *-- VFP9 nao faz short-circuit em OR - os dois testes ficam em IFs
        *-- separados para o ALLTRIM() nunca rodar sobre valor que nao seja
        *-- Character (CLAUDE.md regra sobre ISNULL(x) OR EMPTY(x))
        IF VARTYPE(par_cCodigoProduto) != "C"
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(par_cCodigoProduto))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cCursorTemp = "cursor_4c_PromocoesTmp"

            *-- "Select * From SigPrPmi Where CPros = ?pPro" do AddCursor do
            *-- form pai (sigcdpro) - a MESMA consulta, transcrita aqui
            *-- porque o form pai desta arquitetura nao mantem o cursor
            *-- aberto (ver cabecalho do Form).
            loc_cSQL = "SELECT * FROM SigPrPmi WHERE cpros = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigoProduto))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo (Buscando Promo" + CHR(231) + CHR(245) + "es)" + CHR(13) + CapturarErroSQL()
            ELSE
                IF USED(THIS.this_cCursorItens)
                    USE IN (THIS.this_cCursorItens)
                ENDIF

                *-- "Create Cursor csEmpresas (ImpEmps l(1), CPros c(14),
                *-- Pecas c(10), Promos c(25), Datas t Null, cIdChaves c(20))
                *-- / Index On CPros + Promos Tag CPros" do Load legado -
                *-- mesma estrutura, mesma ordem de colunas.
                CREATE CURSOR (THIS.this_cCursorItens) ;
                    (ImpEmps L, CPros C(14), Pecas C(10), Promos C(25), ;
                     Datas T, cIdChaves C(20))
                INDEX ON CPros + Promos TAG CPros

                IF loc_nResultado > 0
                    SELECT (loc_cCursorTemp)
                    SCAN
                        INSERT INTO (THIS.this_cCursorItens) ;
                            (ImpEmps, CPros, Pecas, Promos, Datas, cIdChaves) ;
                            VALUES (.F., cpros, pecas, promos, ;
                                TratarNulo(datas, {}), cidchaves)
                    ENDSCAN
                ENDIF

                IF USED(loc_cCursorTemp)
                    USE IN (loc_cCursorTemp)
                ENDIF

                SELECT (THIS.this_cCursorItens)
                GO TOP

                THIS.this_nTotalPromocoes = RECCOUNT(THIS.this_cCursorItens)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SIGOPPRMBO.CarregarPromocoes")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

