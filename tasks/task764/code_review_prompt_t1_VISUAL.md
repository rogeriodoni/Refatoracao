# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Operacoes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1331 linhas total):

*-- Linhas 9 a 35:
9: * O QUE ESTA TELA EH
10: *------------------------------------------------------------------------------
11: * Dialogo de 391x318 sem barra de titulo, com UMA faixa de cabecalho
12: * (cntSombra), UMA grade de duas colunas (CheckBox + Operacao) e UM botao Ok.
13: * Nao executa SQL proprio: a grade esta ligada ao cursor LocalSacOp, que eh
14: * criado e populado por QUEM abre o dialogo (sigatsac.gerarope no legado), e o
15: * CheckBox da Column1 alterna LocalSacOp.Selecionada por codigo. Fechado o
16: * dialogo, o form pai varre o MESMO alias para saber o que foi marcado.
17: *
18: * Por isso DataSession = 1 (sessao COMPARTILHADA), exatamente como o SCX
19: * declara: com datasession privada o alias do pai ficaria invisivel aqui e a
20: * grade abriria vazia.
21: *
22: *------------------------------------------------------------------------------
23: * ESTRUTURA DO LEGADO (arvore de objetos do SCX)
24: *------------------------------------------------------------------------------
25: *   SIGOPLOP (form generico)
26: *     +- cntSombra (container)      -> cnt_4c_Sombra
27: *     |    +- lblSombra (label)     -> lbl_4c_LblSombra
28: *     |    +- lblTitulo (label)     -> lbl_4c_LblTitulo
29: *     +- grdOperacoes (grid)        -> grd_4c_Dados
30: *     +- cmdSair (commandbutton)    -> cmd_4c_Ok
31: *
32: * NAO existe PageFrame no SCX: a raiz eh um "form" GENERICO (nao frmcadastro
33: * nem frmrelatorio), e nenhum objeto da arvore tem BaseClass pageframe. Logo
34: * esta tela nao tem pagina de Lista nem pagina de Dados, e nenhuma Page eh
35: * criada aqui - criar uma significaria inventar superficie que o legado nao

*-- Linhas 59 a 69:
59: *------------------------------------------------------------------------------
60: * FASE 4/8 - GRADE E BOTAO DE ACAO
61: *------------------------------------------------------------------------------
62: * Entrega: grd_4c_Dados (grdOperacoes) com as duas colunas, o CheckBox de
63: * marcacao da Column1 com os quatro handlers de alternancia do legado,
64: * cmd_4c_Ok (o Ok, cmdSair) com o Click real, e os funis MontaGrade /
65: * CarregarLista que ligam e repintam a grade.
66: *
67: * POR QUE NAO HA "ConfigurarPaginaLista" NEM OS 6 BOTOES CRUD
68: * O roteiro generico da Fase 4 pede PageFrame Lista/Dados + cnt_4c_Botoes com
69: * Incluir/Visualizar/Alterar/Excluir/Buscar/Encerrar. Este legado nao tem nada

*-- Linhas 162 a 170:
162: *    "\<Ok" e o icone eh cadastro_salvar_60.jpg: ele eh o OK do dialogo de
163: *    selecao - o usuario marca as Operacoes e confirma, e so depois o form pai
164: *    varre o cursor. Por isso o handler eh BtnOkClick e o controle eh
165: *    cmd_4c_Ok (antes CmdSairClick/cmd_4c_CmdSair, que herdavam o nome do
166: *    objeto legado e ainda duplicavam o prefixo Cmd). Nome do handler segue o
167: *    Caption/corpo do Click, nunca o Name do objeto; o mapeamento.json da task
168: *    foi atualizado no mesmo passo, porque eh dele que o ValidarUIFidelity
169: *    monta o caminho do objeto.
170: *

*-- Linhas 179 a 187:
179: *                               eh gravada na hora, no cursor do form pai.
180: *       Habilitar...Campos ..... nao ha modo (LISTA/INCLUIR/ALTERAR) nem campo
181: *                               a habilitar por modo; a unica entrada eh o
182: *                               CheckBox da grade, cuja editabilidade segue o
183: *                               cursor (this_lGradeEditavel).
184: *       Limpar...Campos ........ nao ha ficha a limpar - zerar a marcacao do
185: *                               cursor do pai seria DESTRUIR a selecao que ele
186: *                               vai ler. Quem zera as properties do BO eh
187: *                               SigOpLopBO.LimparDados, chamado pelo

*-- Linhas 193 a 201:
193: * NAO HA AjustarBotoesPorModo (regra #40)
194: * Aquela regra existe para quem DESABILITA botao ao entrar em edicao e precisa
195: * reabilitar no caminho de volta. Aqui ha UM botao que nunca muda de estado:
196: * nenhuma linha deste arquivo atribui cmd_4c_Ok.Enabled, e nao existe
197: * modo (LISTA/INCLUIR/ALTERAR) a ajustar - a tela so marca linhas e fecha.
198: *==============================================================================
199: 
200: DEFINE CLASS FormSigOpLop AS FormBase
201: 

*-- Linhas 239 a 267:
239:     *                       entrar e "= .t." no Ok; aqui a referencia vive numa
240:     *                       property com a nomenclatura do PILAR 3.
241:     * this_cAliasGrade    - alias efetivamente usado pela grade. Eh LocalSacOp
242:     *                       quando o pai o deixou aberto; fora do fluxo real
243:     *                       (validacao de UI / teste) eh o espelho vazio
244:     *                       cursor_4c_Operacoes criado pelo BO.
245:     * this_lGradeEditavel - .T. quando esse alias aceita REPLACE. O CheckBox da
246:     *                       Column1 alterna a coluna Selecionada por REPLACE, e
247:     *                       cursor somente-leitura deixaria o controle inerte.
248:     * this_lConfirmado    - .T. depois do Ok, para o form pai distinguir
249:     *                       confirmacao de fechamento por ESC.
250:     *--------------------------------------------------------------------------
251:     this_oParentForm    = .NULL.
252:     this_cAliasGrade    = ""
253:     this_lGradeEditavel = .F.
254:     this_lConfirmado    = .F.
255: 
256:     *==========================================================================
257:     * Init - recebe o form pai e o desabilita (transcricao do Init legado)
258:     *
259:     * Legado:
260:     *     LParameters pFrm
261:     *     ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
262:     *     ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
263:     *     ThisForm.ParentForm = pFrm
264:     *     ThisForm.ParentForm.Enabled = .f.
265:     *     With ThisForm.grdOperacoes ... EndWith
266:     *
267:     * As duas linhas de Caption viram AtualizarCabecalho(), chamada de dentro

*-- Linhas 374 a 428:
374:             THIS.AddObject("cnt_4c_Sombra", "Container")
375: 
376:             WITH THIS.cnt_4c_Sombra
377:                 .Top           = 0
378:                 .Left          = 0
379:                 .Width         = THIS.Width
380:                 .Height        = 80
381:                 .BackStyle     = 1
382:                 .BackColor     = RGB(100, 100, 100)
383:                 .BorderWidth   = 0
384:                 .SpecialEffect = 0
385:                 .Visible       = .T.
386:             ENDWITH
387: 
388:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
389: 
390:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
391:                 .AutoSize      = .F.
392:                 .WordWrap      = .T.
393:                 .BackStyle     = 0
394:                 .Alignment     = 0
395:                 .Top           = 18
396:                 .Left          = 10
397:                 .Width         = THIS.Width - 20
398:                 .Height        = 40
399:                 .FontName      = "Tahoma"
400:                 .FontSize      = 18
401:                 .FontBold      = .T.
402:                 .FontUnderline = .F.
403:                 .ForeColor     = RGB(0, 0, 0)
404:                 .Caption       = THIS.Caption
405:                 .Visible       = .T.
406:             ENDWITH
407: 
408:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
409: 
410:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
411:                 .AutoSize    = .F.
412:                 .WordWrap    = .T.
413:                 .BackStyle   = 0
414:                 .Alignment   = 0
415:                 .Top         = 17
416:                 .Left        = 10
417:                 .Width       = THIS.Width - 20
418:                 .Height      = 46
419:                 .FontName    = "Tahoma"
420:                 .FontSize    = 18
421:                 .FontBold    = .T.
422:                 .ForeColor   = RGB(255, 255, 255)
423:                 .Caption     = THIS.Caption
424:                 .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
425:                 .Visible     = .T.
426:             ENDWITH
427:         CATCH TO loc_oErro
428:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 435 a 457:
435:     * AtualizarCabecalho - espelha o Caption do form nos dois labels da faixa
436:     *
437:     * Transcricao literal das duas primeiras linhas do Init legado:
438:     *     ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
439:     *     ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
440:     *
441:     * Fica num metodo proprio porque no legado isso roda no Init, quando os
442:     * labels ja existem; aqui eles nascem no ConfigurarCabecalho, e quem quiser
443:     * trocar o Caption em runtime chama este metodo para a faixa acompanhar.
444:     *==========================================================================
445:     PROCEDURE AtualizarCabecalho()
446:         IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
447:             IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblSombra", 5)
448:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
449:             ENDIF
450: 
451:             IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_LblTitulo", 5)
452:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
453:             ENDIF
454:         ENDIF
455:     ENDPROC
456: 
457:     *==========================================================================

*-- Linhas 469 a 477:
469:     * a exibir.
470:     *
471:     * this_lGradeEditavel guarda se esse alias aceita REPLACE: eh o que o
472:     * CheckBox da Column1 precisa para alternar a coluna Selecionada, e eh o
473:     * que permite AVISAR em vez de o clique ficar sem efeito.
474:     *==========================================================================
475:     PROCEDURE PrepararAliasGrade()
476:         LOCAL loc_oErro
477: 

*-- Linhas 561 a 581:
561:     * RestaurarFormPai cobre o caminho em que o dialogo foi fechado por ESC
562:     * (cmdSair tem Cancel = .T. no legado) sem passar pelo Ok.
563:     *
564:     * O cursor LocalSacOp NAO eh fechado aqui: ele pertence ao form pai, que
565:     * volta a varre-lo depois deste dialogo fechar. So o espelho local
566:     * cursor_4c_Operacoes, criado quando o pai nao existe, eh liberado - e isso
567:     * fica a cargo do Destroy do proprio BO.
568:     *
569:     * DODEFAULT() eh obrigatorio na ULTIMA linha: FormBase.Destroy solta o BO e
570:     * reconstroi os popups do menu principal. Sem ele o menu do sistema encolhe
571:     * depois de fechar a tela.
572:     *==========================================================================
573:     PROCEDURE Destroy()
574:         THIS.RestaurarFormPai()
575: 
576:         DODEFAULT()
577:     ENDPROC
578: 
579: 
580:     *==========================================================================
581:     * ConfigurarGrade - cria grd_4c_Dados (grdOperacoes do legado)

*-- Linhas 599 a 610:
599:     *
600:     * ORDEM OBRIGATORIA (medida no VFP9 em 2026-11-08, task758/FormSigOpLcZ):
601:     * ColumnCount -> RecordSource -> ControlSource de TODAS as colunas -> SO
602:     * DEPOIS o AddObject do CheckBox -> Sparse/CurrentControl -> Width/Header.
603:     * Grid cuja RecordSource ainda nao foi atribuida AUTO-BINDA na area de
604:     * trabalho CORRENTE no instante em que o ColumnCount eh definido; se a
605:     * coluna sorteada for CHARACTER, o AddObject de um CheckBox (cujo .Value
606:     * nasce NUMERICO) estoura "Data type mismatch" DENTRO do TRY do
607:     * InicializarForm - CREATEOBJECT devolve o logico .F., o
608:     * IF VARTYPE(loForm) = "O" de quem abre nao entra e A TELA NAO ABRE, sem
609:     * erro na tela e sem nada em log. Por isso a sequencia inteira mora no
610:     * funil MontaGrade(), e aqui so se cria o Grid e se chama o funil - assim a

*-- Linhas 622 a 631:
622:             loc_oGrid = THIS.grd_4c_Dados
623: 
624:             WITH loc_oGrid
625:                 .Top               = 85
626:                 .Left              = 96
627:                 .Width             = 198
628:                 .Height            = 220
629:                 .FontName          = "Tahoma"
630:                 .FontSize          = 8
631:                 .HeaderHeight      = 19

*-- Linhas 644 a 723:
644:             *-- ordem do legado em vez de inventar outra.
645:             loc_oGrid.TabIndex = 2
646: 
647:             *-- Bind + CheckBox + formatacao, na ordem provada acima
648:             THIS.MontaGrade()
649: 
650:             loc_oGrid.Visible = .T.
651:         CATCH TO loc_oErro
652:             MsgErro(loc_oErro.Message + CHR(13) + ;
653:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
654:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrade")
655:         ENDTRY
656:     ENDPROC
657: 
658:     *==========================================================================
659:     * GarantirCheckBoxSelecao - cria (ou RECRIA) o CheckBox da Column1 e
660:     * religa os quatro handlers de alternancia
661:     *
662:     * Equivale ao grdOperacoes.Column1.Check1 do SCX, que la eh um objeto
663:     * DESENHADO na coluna. Aqui ele nasce por AddObject e por isso tem um ciclo
664:     * de vida que o legado nao tem: FECHAR o alias ligado ao Grid DESTROI o
665:     * objeto adicionado na Column - medido no VFP9 (2026-11-08), o
666:     * CurrentControl volta para "Text1" e o CheckBox desaparece, enquanto Width
667:     * e Header1.Caption SOBREVIVEM. Perda PARCIAL, e por isso enganosa: a grade
668:     * continua bonita e so o CheckBox falta, exibindo 0/1 CRU numa caixa de
669:     * texto - sem erro, sem log, e sem como marcar linha nenhuma.
670:     *
671:     * Dai as tres caracteristicas deste metodo:
672:     *   - IDEMPOTENTE (PEMSTATUS antes do AddObject, que estouraria "Object
673:     *     already defined" na segunda vez);
674:     *   - chamado por MontaGrade, ou seja a cada repintura;
675:     *   - os BINDEVENT vao JUNTO, no mesmo lugar - objeto recriado eh OUTRO
676:     *     objeto e as ligacoes do anterior morreram com ele; sem religar, os
677:     *     quatro handlers ficariam MUDOS e o CheckBox apareceria sem alternar.
678:     *
679:     * .Value = 0 NUMERICO eh obrigatorio e bate com o tipo da coluna
680:     * (Selecionada N(1), do literal "0 as Selecionada" do legado). O dump do
681:     * Check1 tambem declara Value = 0.
682:     *
683:     * Geometria transcrita do dump (Top=36 Left=3 Height=17 Width=60) - a
684:     * posicao final dentro da celula eh o Grid que resolve.
685:     *
686:     * AutoSize vai EXPLICITAMENTE .F. embora o Init legado faca
687:     * ".Column1.Check1.AutoSize = .t.": em controle criado por AddObject o
688:     * AutoSize eh NO-OP para a largura, entao confiar nele deixaria o CheckBox
689:     * nos 100x17 do default. As medidas explicitas reproduzem o que o legado de
690:     * fato exibia.
691:     *
692:     * Caption = "" porque na grade o rotulo eh o Header da coluna; o dump
693:     * carrega "Check1" apenas como texto de design do Form Designer.
694:     *==========================================================================
695:     PROTECTED PROCEDURE GarantirCheckBoxSelecao()
696:         LOCAL loc_oCol, loc_lOk
697: 
698:         loc_lOk = .F.
699: 
700:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
701:             loc_oCol = THIS.grd_4c_Dados.Column1
702: 
703:             IF PEMSTATUS(loc_oCol, "chk_4c_Check1", 5)
704:                 *-- Ainda vivo: nada a fazer (AddObject repetido estouraria)
705:                 loc_lOk = .T.
706:             ELSE
707:                 loc_oCol.AddObject("chk_4c_Check1", "CheckBox")
708: 
709:                 WITH loc_oCol.chk_4c_Check1
710:                     .AutoSize  = .F.
711:                     .Top       = 36
712:                     .Left      = 3
713:                     .Height    = 17
714:                     .Width     = 60
715:                     .FontName  = "Tahoma"
716:                     .FontSize  = 8
717:                     .Alignment = 0
718:                     .Caption   = ""
719:                     .Value     = 0
720:                     .ReadOnly  = .F.
721:                     .Visible   = .T.
722:                 ENDWITH
723: 

*-- Linhas 746 a 766:
746:     *     .Column2.ControlSource = [LocalSacOp.Dopes]
747:     *
748:     * O alias eh RE-RESOLVIDO a cada passagem por PrepararAliasGrade(): o
749:     * cursor do pai (LocalSacOp) pode ter sido aberto DEPOIS de esta tela
750:     * montar a estrutura, e nesse caso a grade tem de passar a le-lo em vez de
751:     * continuar no espelho vazio cursor_4c_Operacoes.
752:     *
753:     * Ponto UNICO de proposito: grade ligada a cursor NAO se repinta sozinha
754:     * quando o cursor muda (regra #21), e sem um funil cada caminho esquece uma
755:     * das metades. Os tres passos - bind, CheckBox, formatacao - precisam
756:     * acontecer SEMPRE nessa ordem (ver cabecalho de ConfigurarGrade).
757:     *
758:     * GO TOP IN + Refresh fecham o metodo porque eh isso que faz a grade
759:     * EXIBIR as linhas que o cursor passou a ter. GO TOP **IN** (sem SELECT) de
760:     * proposito: SELECT trocaria a area de trabalho corrente, que eh justamente
761:     * o que dispara o auto-bind medido em ConfigurarGrade.
762:     *
763:     * PUBLIC: eh funil, acionado pelos handlers e pelo harness de teste, que
764:     * chama metodos do form de FORA da classe (regra #3).
765:     *
766:     * par_cFiltro NAO existe no legado e NAO eh usado: esta declarado porque o

*-- Linhas 785 a 796:
785:                 loc_oGrid.Column1.ControlSource = loc_cCursor + ".Selecionada"
786:                 loc_oGrid.Column2.ControlSource = loc_cCursor + ".Dopes"
787: 
788:                 *-- SO AGORA o CheckBox pode entrar/voltar: a Column1 acabou de
789:                 *-- ser ligada a coluna NUMERICA Selecionada, e eh esse bind que
790:                 *-- impede o "Data type mismatch" no AddObject. Idempotente.
791:                 THIS.GarantirCheckBoxSelecao()
792: 
793:                 *-- RecordSource/ControlSource acabaram de resetar Width,
794:                 *-- Header1.Caption e CurrentControl - reaplicar SEMPRE depois
795:                 THIS.FormatarGridOperacoes(loc_oGrid)
796: 

*-- Linhas 832 a 842:
832:     * ControlSource reseta Width e Header1.Caption para o default 90/"Header1"
833:     * (Problema 48) e derruba o CurrentControl da Column1 (regra #18) - a grade
834:     * apareceria com colunas quadradas, cabecalho "Header1" e o valor cru 0/1
835:     * no lugar do CheckBox.
836:     *
837:     * Sparse = .F. eh o que faz o CheckBox aparecer em TODAS as linhas; sem ele
838:     * so a linha ativa o desenha e as outras mostram 0/1 como texto.
839:     *
840:     * Column1.ReadOnly vem DEPOIS do Grid.ReadOnly (regra #18): o do grid
841:     * propaga para as colunas e sobrescreveria este valor. Grid.ReadOnly eh
842:     * atribuido em ConfigurarGrade, que roda antes deste metodo.

*-- Linhas 861 a 874:
861:             .Header1.FontSize  = 8
862:             .Header1.Alignment = 2
863:             .Header1.ForeColor = RGB(36, 84, 155)
864:             .Header1.Caption   = ""
865:         ENDWITH
866: 
867:         *-- Sem o CurrentControl a coluna volta a desenhar o Text1 dela e o
868:         *-- usuario ve o 0/1 cru, sem como marcar nada (regra #18). PEMSTATUS
869:         *-- porque o CheckBox pode nao existir ainda (ou ter sido destruido
870:         *-- pelo fechamento do alias) - apontar para objeto inexistente
871:         *-- deixaria a coluna igualmente vazia.
872:         IF PEMSTATUS(loc_oGrid.Column1, "chk_4c_Check1", 5)
873:             loc_oGrid.Column1.CurrentControl = "chk_4c_Check1"
874:         ENDIF

*-- Linhas 883 a 891:
883:             .Header1.FontSize  = 8
884:             .Header1.Alignment = 2
885:             .Header1.ForeColor = RGB(36, 84, 155)
886:             .Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
887:             .Text1.FontName    = "Tahoma"
888:             .Text1.FontSize    = 8
889:             .Text1.BorderStyle = 0
890:             .Text1.Margin      = 0
891:             .Text1.ReadOnly    = .T.

*-- Linhas 942 a 962:
942:     * sete colunas da linha (Selecionada, Dopes, GerOpServs, cCodServs,
943:     * nVlServs, nAliIss, fPags) para as properties, e AtualizarTotais() reconta
944:     * a selecao e remonta a lista das Operacoes marcadas - que eh exatamente o
945:     * que o form pai consome depois do Ok.
946:     *
947:     * Grade VAZIA nao eh erro: o espelho cursor_4c_Operacoes abre sem linha
948:     * quando nao ha form pai (validacao de UI / teste), e ai nao ha ficha a
949:     * transferir - o BO eh zerado e o retorno eh .F., sem mensagem, porque a
950:     * tela abriu sem dados de proposito.
951:     *
952:     * PROTECTED: FormBase declara os dois hooks PROTECTED e VFP9 nao permite
953:     * ALARGAR o escopo de metodo herdado.
954:     *==========================================================================
955:     PROTECTED PROCEDURE FormParaBO()
956:         LOCAL loc_cAlias, loc_lSucesso, loc_oErro
957: 
958:         loc_lSucesso = .F.
959: 
960:         TRY
961:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
962:                 *-- O alias vem da GRADE (a tela), nao do BO

*-- Linhas 1010 a 1018:
1010:     *      tem de ser o MESMO que o BO carregou. Sem a terceira, um BO parado
1011:     *      na linha A com o ponteiro na linha B gravaria a marcacao de A em B:
1012:     *      corrupcao silenciosa exatamente na coluna que o form pai vai ler.
1013:     *      MEDIDO no probe (2026-11-08): escrever no CheckBox
1014:     *      (chk_4c_Check1.Value) NAO serve. Em grade nao renderizada o valor
1015:     *      atribuido se perde no Refresh seguinte (o probe leu 0 com a linha
1016:     *      marcada em 1), e escrita em controle com ControlSource propaga para
1017:     *      o cursor sem passar por guarda nenhuma. Por isso a gravacao eh
1018:     *      REPLACE explicito no alias, com o tipo da coluna normalizado como o

*-- Linhas 1084 a 1092:
1084:     ENDPROC
1085: 
1086:     *==========================================================================
1087:     * ConfigurarBotoes - cria cmd_4c_Ok (o cmdSair "Ok" do legado)
1088:     *
1089:     * SCX: cmdSair Top=3 Left=315 Class=fwbtng Cancel=.T. Caption="\<Ok"
1090:     *      Picture=..\framework\imagens\cadastro_salvar_60.jpg
1091:     * Classe fwbtng (framework.vcx): Height=100 Width=80 FontName="Comic Sans
1092:     * MS" FontSize=8 FontBold=.T. FontItalic=.T. WordWrap=.T. MousePointer=15

*-- Linhas 1120 a 1135:
1120:         LOCAL loc_oErro
1121: 
1122:         TRY
1123:             THIS.AddObject("cmd_4c_Ok", "CommandButton")
1124: 
1125:             WITH THIS.cmd_4c_Ok
1126:                 .Top           = 3
1127:                 .Left          = 315
1128:                 .Width         = 80
1129:                 .Height        = 100
1130:                 .Caption       = "\<Ok"
1131:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1132:                 .FontName      = "Comic Sans MS"
1133:                 .FontSize      = 8
1134:                 .FontBold      = .T.
1135:                 .FontItalic    = .T.

*-- Linhas 1155 a 1176:
1155:     *==========================================================================
1156:     * ConfigurarEventos - liga o Click do botao Ok
1157:     *
1158:     * Os BINDEVENT do CheckBox da grade NAO ficam aqui: eles vivem em
1159:     * GarantirCheckBoxSelecao, porque o objeto do CheckBox pode ser destruido e
1160:     * recriado quando o alias da grade eh fechado - e ligacao de objeto morto
1161:     * nao se transfere para o objeto novo.
1162:     *
1163:     * BtnOkClick eh PUBLIC: BINDEVENT com metodo PROTECTED falha em SILENCIO
1164:     * (regra #3) e o botao Ok ficaria inerte.
1165:     *==========================================================================
1166:     PROTECTED PROCEDURE ConfigurarEventos()
1167:         LOCAL loc_oErro
1168: 
1169:         TRY
1170:             IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
1171:                 BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
1172:             ENDIF
1173:         CATCH TO loc_oErro
1174:             MsgErro(loc_oErro.Message + CHR(13) + ;
1175:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1176:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventos")

*-- Linhas 1191 a 1199:
1191:     * faz o REPLACE e reconta os totais; o Refresh da grade eh daqui, porque so
1192:     * o form conhece o controle. O BO devolve o valor novo (0/1) ou -1 quando
1193:     * nao foi possivel alternar - eh o que permite AVISAR em vez de ficar
1194:     * inerte: cursor somente-leitura faz o CheckBox aparecer, receber foco e
1195:     * NAO mudar de valor, defeito silencioso que parece bug de Enabled.
1196:     *
1197:     * O legado le a coluna do CURSOR no MouseDown (LocalSacOp.Selecionada) e,
1198:     * no KeyPress, le a variavel LOCAL homonima recem-declarada - que nasce
1199:     * vazia e nunca recebe o valor do registro. Isto eh, o KeyPress legado

*-- Linhas 1251 a 1259:
1251:     *   MouseUp   -> NoDefault
1252:     *   KeyPress  -> If InList(nKeyCode, 13, 32): alterna + Refresh + NoDefault
1253:     *
1254:     * Os NODEFAULT sao o que SUPRIME o toggle nativo do CheckBox: sem eles o
1255:     * controle alternaria por conta propria E o handler alternaria de novo, com
1256:     * a marcacao voltando ao estado anterior a cada clique. O legado desliga o
1257:     * comportamento padrao nos quatro eventos justamente por isso, e a grade so
1258:     * alterna por codigo.
1259:     *


### BO (C:\4c\projeto\app\classes\SigOpLopBO.prg):
*==============================================================================
* SigOpLopBO.prg - Business Object: Sub-Nivel (selecao de Operacoes)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (dialogo modal filho - recebe ParentForm, marca/desmarca
*       as Operacoes no cursor do form pai e devolve o controle a ele)
*
* ORIGEM LEGADO: SigOpLop.SCX (Caption "Sub-Nivel"). O Init recebe pFrm (o form
* que abre o dialogo), desabilita o pai e devolve o Enabled no Ok. O dialogo
* NAO executa SQL nenhum: a grade grdOperacoes esta ligada ao cursor LocalSacOp,
* criado e populado por QUEM abre o dialogo, e o Check1 da Column1 alterna
* LocalSacOp.Selecionada por codigo (Gather Memvar Fields Selecionada), com a
* Column2 (Dopes) em ReadOnly.
*
* QUEM ABRE O DIALOGO (achado no acervo legado, 4install\FortyusMC\Fortyus):
* sigatsac.SCX, metodo gerarope, monta o cursor e so entao chama a tela -
* transcrito aqui LITERALMENTE porque eh o CONTRATO da grade:
*
*   lcQuery = [Select 0 as Selecionada, Dopes, GerOpServs, cCodServs,
*              nVlServs, nAliIss, fPags ] + ;
*             [From SigCdSOp ] + ;
*             [Where Codigos = ] + <crSigCdSOs.CodDeps> + [ And ] + ;
*             [GerOpers = 1]
*   If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSacOp]) < 1) ... Return 0
*   Select LocalSacOp
*   Go Top In LocalSacOp
*   If Eof([LocalSacOp]) ... Else   If (Reccount([LocalSacOp]) > 0)
*       Do Form SigOpLop With ThisForm
*   ...
*   Select LocalSacOp
*   Scan
*       If Not llOks And (LocalSacOp.Selecionada = 1) ... llOks = .t.
*   EndScan
*
* Ou seja: a tabela de origem eh SigCdSOp (Operacoes do Departamento), NAO
* SigCdOpe, e depois de fechado o dialogo o form pai volta a LER o MESMO alias
* LocalSacOp - inclusive as colunas que a grade nao mostra (GerOpServs,
* cCodServs, nVlServs, nAliIss, fPags). Por isso este BO:
*   - mantem o alias legado LocalSacOp (nunca renomeia o cursor do pai);
*   - mapeia as SETE colunas do cursor, nao so as duas visiveis;
*   - trata a camada de dados como CURSOR, nao como INSERT/UPDATE.
*
* GRAVACAO: Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria()
* ficam HERDADOS de BusinessBase - o comportamento padrao da base ja eh o
* correto para esta tela, porque o legado nao tem TABLEUPDATE, nao tem
* .AddCursor e nao tem Insert/Update/Delete sobre tabela nenhuma: a marcacao
* vive no cursor em memoria e quem persiste qualquer coisa eh o form pai,
* depois do Ok. Sobrescrever esses metodos aqui exigiria INVENTAR um comando de
* gravacao que o legado nao possui.
*
* FASE 1/8: declaracao das propriedades + Init().
* FASE 2/8: camada de dados do cursor - CarregarDoCursor() com TODAS as colunas,
*           CarregarOperacoes() (a query do legado), GarantirCursorGrade(),
*           GradeEditavel(), AlternarSelecao(), AtualizarTotais(), TemSelecao(),
*           LimparDados(), ObterChavePrimaria(), Destroy().
*==============================================================================

DEFINE CLASS SigOpLopBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTRATO DE CURSORES
    *
    * this_cCursorPai   - alias EXATO do legado (LocalSacOp). Pertence ao form
    *                     que abre o dialogo; este BO le e alterna a coluna
    *                     Selecionada dele e, quando o pai pede, o POPULA com a
    *                     query do legado - mas nunca o renomeia.
    * this_cCursorGrade - alias local usado como espelho da grade quando o
    *                     dialogo eh instanciado FORA do fluxo real (validacao
    *                     de UI / teste), em que LocalSacOp nao existe.
    *                     Nomenclatura cursor_4c_* do projeto.
    * this_cCursorTemp  - alias temporario do SQLEXEC. O resultado de SQLEXEC
    *                     nasce SOMENTE-LEITURA e a grade tem coluna EDITAVEL
    *                     (o CheckBox da Column1), entao a consulta cai aqui e
    *                     o alias da grade eh montado READWRITE a partir dele.
    *--------------------------------------------------------------------------
    this_cCursorPai   = "LocalSacOp"
    this_cCursorGrade = "cursor_4c_Operacoes"
    this_cCursorTemp  = "cursor_4c_OperacoesTmp"

    *--------------------------------------------------------------------------
    * COLUNAS DA GRADE (LocalSacOp) - uma propriedade por coluna do legado,
    * na MESMA ordem do Select de sigatsac.gerarope.
    *
    * this_nSelecionada - LocalSacOp.Selecionada. No legado a coluna nasce do
    *                     literal "0 as Selecionada", e o toggle eh
    *                     Iif(Selecionada = 0, 1, 0): eh NUMERICA (0/1), nao
    *                     logica. O pai confere com "Selecionada = 1".
    * this_cDopes       - LocalSacOp.Dopes -> SigCdSOp.dopes char(20). Unica
    *                     coluna EXIBIDA na grade (Column2, ReadOnly).
    * this_nGerOpServs  - LocalSacOp.GerOpServs -> geropservs numeric(1,0).
    *                     Lido pelo pai (If LocalSacOp.GerOpServs = 1 abre o
    *                     SigPrIns de servico), portanto NUMERICO.
    * this_cCodServs    - LocalSacOp.cCodServs -> ccodservs char(10).
    * this_nVlServs     - LocalSacOp.nVlServs  -> nvlservs numeric(11,2).
    * this_nAliIss      - LocalSacOp.nAliIss   -> naliiss  numeric(4,2).
    * this_cFPags       - LocalSacOp.fPags     -> fpags    char(12).
    *--------------------------------------------------------------------------
    this_nSelecionada = 0
    this_cDopes       = ""
    this_nGerOpServs  = 0
    this_cCodServs    = ""
    this_nVlServs     = 0
    this_nAliIss      = 0
    this_cFPags       = ""

    *--------------------------------------------------------------------------
    * TOTALIZADORES DA SELECAO (consultados pelo Form no Ok/Encerrar)
    *
    * this_nTotalOperacoes    - quantidade de linhas da grade
    * this_nTotalSelecionadas - quantidade de linhas com Selecionada = 1
    * this_cOperacoesMarcadas - lista das Operacoes marcadas, separadas por
    *                           virgula, para o form pai consumir sem precisar
    *                           varrer o cursor de novo
    *--------------------------------------------------------------------------
    this_nTotalOperacoes    = 0
    this_nTotalSelecionadas = 0
    this_cOperacoesMarcadas = ""

    *--------------------------------------------------------------------------
    * LARGURAS DO SCHEMA (docs\schema.sql, tabela SigCdSOp) - usadas pelo
    * PADR/LEFT das rotinas de carga e pelo MaxLength dos controles, para nunca
    * exibir nem montar valor maior do que a coluna aceita.
    *--------------------------------------------------------------------------
    this_nTamDopes    = 20
    this_nTamCodServs = 10
    this_nTamFPags    = 12
    this_nTamCodigos  = 10

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *
    * A tabela de origem eh SigCdSOp e a coluna que identifica a linha para
    * ESTE dialogo eh dopes (a PK fisica da tabela eh cidchaves, que o Select
    * do legado NAO traz para o cursor, logo nao esta disponivel aqui).
    *
    * As propriedades sao atribuidas ANTES de DODEFAULT() porque
    * BusinessBase.Init() so instancia o DataAccess quando RECEBE o nome da
    * tabela como parametro - aqui a tela nao grava, entao o DataAccess nao eh
    * necessario e nao se passa parametro.
    *
    * O RETURN .T. explicito eh obrigatorio: Init que devolve .F. faz
    * CREATEOBJECT retornar valor nao-objeto e o form nao abre.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdSOp"
        THIS.this_cCampoChave = "dopes"

        DODEFAULT()

        THIS.LimparDados()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterAliasGrade - Resolve QUAL alias a grade deve usar
    *
    * No fluxo real o cursor eh do form pai (LocalSacOp). Fora dele (validacao
    * de UI / teste headless) esse alias nao existe e a grade cai no espelho
    * local. Resolver o alias por aqui evita espalhar IF USED() por todo o Form
    * e garante que Grid.RecordSource, Column.ControlSource e os handlers do
    * CheckBox falem SEMPRE do mesmo cursor.
    *--------------------------------------------------------------------------
    PROCEDURE ObterAliasGrade()
        LOCAL loc_cAlias

        loc_cAlias = THIS.this_cCursorGrade

        IF USED(THIS.this_cCursorPai)
            loc_cAlias = THIS.this_cCursorPai
        ENDIF

        RETURN loc_cAlias
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCursorGrade - Assegura que existe um alias com a estrutura da
    *                       grade ANTES de o Grid ser ligado a ele
    *
    * Column.ControlSource apontando para cursor que ainda nao existe estoura
    * "Alias ... is not found" DENTRO do TRY do InicializarForm: o CREATEOBJECT
    * devolve .F. e a tela simplesmente nao abre. Entao, quando o cursor do pai
    * nao esta aberto, cria-se o espelho VAZIO com as SETE colunas na MESMA
    * ordem do Select do legado - sem inventar nenhuma linha, porque sem o form
    * pai nao ha Operacao nenhuma a exibir.
    *
    * Tipos conforme docs\schema.sql (SigCdSOp) e conforme o literal
    * "0 as Selecionada" do legado. O cursor nasce READWRITE, que eh o que a
    * Column1 precisa para aceitar o REPLACE do CheckBox.
    *--------------------------------------------------------------------------
    PROCEDURE GarantirCursorGrade()
        LOCAL loc_cAlias

        loc_cAlias = THIS.ObterAliasGrade()

        IF !USED(loc_cAlias)
            CREATE CURSOR cursor_4c_Operacoes ( ;
                Selecionada N(1), ;
                Dopes       C(20), ;
                GerOpServs  N(1), ;
                cCodServs   C(10), ;
                nVlServs    N(11,2), ;
                nAliIss     N(4,2), ;
                fPags       C(12))

            loc_cAlias = THIS.this_cCursorGrade
        ENDIF

        THIS.AtualizarTotais(loc_cAlias)

        RETURN loc_cAlias
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeEditavel - .T. quando o alias da grade aceita REPLACE
    *
    * O CheckBox da Column1 alterna a coluna Selecionada por REPLACE, e isso
    * exige cursor READWRITE. Cursor devolvido por SQLEXEC nasce SOMENTE-LEITURA:
    * nesse caso o controle aparece, recebe foco e NAO muda de valor - defeito
    * silencioso que parece bug de Enabled/ReadOnly. Quem monta o cursor
    * (CarregarOperacoes, aqui, ou o form pai) tem de entregar READWRITE; este
    * metodo existe para que o Form possa AVISAR em vez de ficar inerte.
    *--------------------------------------------------------------------------
    PROCEDURE GradeEditavel(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lEditavel

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        loc_lEditavel = .F.

        IF USED(loc_cAlias)
            loc_lEditavel = !ISREADONLY(loc_cAlias)
        ENDIF

        RETURN loc_lEditavel
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula o cursor da grade com a query do legado
    *
    * TRANSCRICAO de sigatsac.gerarope (ver cabecalho). O filtro eh
    * "Codigos = <departamento> And GerOpers = 1" - os dois termos vem do
    * legado e nenhum foi acrescentado.
    *
    * par_cCodigoDepartamento = SigCdSOp.codigos char(10), que no legado vem de
    * crSigCdSOs.CodDeps (a OS selecionada na grade do form pai). Sem esse
    * codigo nao existe consulta possivel: devolve .F. com mensagem, e a grade
    * continua com o espelho vazio criado por GarantirCursorGrade.
    *
    * O SQLEXEC cai em cursor TEMPORARIO e o alias da grade eh montado a partir
    * dele, por dois motivos: (a) o cursor de SQLEXEC eh somente-leitura e a
    * Column1 precisa de REPLACE; (b) SQLEXEC sobre o alias JA ligado a um Grid
    * fecha e recria esse alias, zerando ColumnCount e deixando a grade como um
    * retangulo branco. Com o alias ja aberto e editavel usa-se ZAP + APPEND,
    * que preserva estrutura, RecordSource, ControlSource e CurrentControl.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigoDepartamento)
        LOCAL loc_cSQL, loc_cCodigo, loc_cAlias, loc_nResultado
        LOCAL loc_lSucesso, loc_cSafety, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCodigoDepartamento) != "C" OR EMPTY(par_cCodigoDepartamento)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do Departamento n" + ;
                CHR(227) + "o informado para carregar as Opera" + CHR(231) + ;
                CHR(245) + "es."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        loc_cCodigo = LEFT(ALLTRIM(par_cCodigoDepartamento), THIS.this_nTamCodigos)

        *-- Select transcrito do legado (sigatsac.gerarope): colunas e ordem
        *-- IDENTICAS, porque o form pai le todas elas depois do Ok.
        loc_cSQL = "SELECT 0 AS Selecionada, Dopes, GerOpServs, cCodServs," + ;
                   " nVlServs, nAliIss, fPags" + ;
                   " FROM SigCdSOp" + ;
                   " WHERE Codigos = " + EscaparSQL(loc_cCodigo) + ;
                   " AND GerOpers = 1" + ;
                   " ORDER BY Dopes"

        TRY
            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao carregar as Opera" + CHR(231) + ;
                    CHR(245) + "es do Departamento: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                loc_cAlias = THIS.ObterAliasGrade()

                IF USED(loc_cAlias) AND !ISREADONLY(loc_cAlias)
                    *-- Alias ja aberto e editavel (tipicamente ligado ao Grid):
                    *-- ZAP + APPEND preserva o binding da grade. SET SAFETY eh
                    *-- escopado por data session e volta a ON em form
                    *-- DataSession = 2, onde o ZAP abriria dialogo modal e
                    *-- congelaria a tela.
                    loc_cSafety = SET("SAFETY")
                    SET SAFETY OFF
                    SELECT (loc_cAlias)
                    ZAP
                    APPEND FROM DBF(THIS.this_cCursorTemp)
                    IF loc_cSafety = "ON"
                        SET SAFETY ON
                    ENDIF
                ELSE
                    *-- Primeira carga (ou alias somente-leitura): monta o alias
                    *-- legado LocalSacOp como cursor READWRITE.
                    IF USED(THIS.this_cCursorPai)
                        USE IN (THIS.this_cCursorPai)
                    ENDIF

                    SELECT * ;
                        FROM cursor_4c_OperacoesTmp ;
                        INTO CURSOR LocalSacOp READWRITE

                    loc_cAlias = THIS.this_cCursorPai
                ENDIF

                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF

                *-- Go Top In LocalSacOp - exatamente como o legado faz antes de
                *-- abrir o dialogo.
                SELECT (loc_cAlias)
                GO TOP

                THIS.AtualizarTotais(loc_cAlias)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao carregar as Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA CORRENTE do cursor nas propriedades
    *
    * Mapeia as SETE colunas do cursor do legado, nao apenas as duas que a
    * grade exibe: o form pai consome GerOpServs, cCodServs, nVlServs, nAliIss
    * e fPags depois que o dialogo fecha, e eh este metodo que leva esses
    * valores para o BO.
    *
    * Cuidados:
    *   - SELECT (par_cAliasCursor) ANTES de ler os campos, e restauracao da
    *     area de trabalho anterior no fim (nao roubar o SELECT de quem chamou);
    *   - guarda de EOF: cursor vazio ou posicionado no fim nao pode "carregar"
    *     lixo nas propriedades;
    *   - existencia de cada coluna por TYPE(alias + ".coluna") != "U" -
    *     PEMSTATUS exige OBJETO no 1o argumento e estoura com nome de cursor;
    *   - coluna numeric(1,0) pode chegar como Numerico (numeric) ou como Logico
    *     (bit) conforme o driver: VARTYPE antes de comparar, senao da
    *     type mismatch.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_lSucesso, loc_uValor

        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        loc_cAreaAnterior = ALIAS()
        SELECT (loc_cAlias)

        IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o posicionada no cursor [" + loc_cAlias + "]."
        ELSE
            *-- Selecionada: marcacao numerica 0/1 (literal "0 as Selecionada")
            IF TYPE(loc_cAlias + ".Selecionada") != "U"
                loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
                IF VARTYPE(loc_uValor) = "N"
                    THIS.this_nSelecionada = NVL(loc_uValor, 0)
                ELSE
                    THIS.this_nSelecionada = IIF(NVL(loc_uValor, .F.), 1, 0)
                ENDIF
            ENDIF

            *-- Dopes: a Operacao exibida na Column2 (SigCdSOp.dopes char(20))
            IF TYPE(loc_cAlias + ".Dopes") != "U"
                THIS.this_cDopes = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".Dopes"), ""), ;
                                        THIS.this_nTamDopes)
            ENDIF

            *-- GerOpServs: numeric(1,0); o form pai testa "= 1"
            IF TYPE(loc_cAlias + ".GerOpServs") != "U"
                loc_uValor = EVALUATE(loc_cAlias + ".GerOpServs")
                IF VARTYPE(loc_uValor) = "N"
                    THIS.this_nGerOpServs = NVL(loc_uValor, 0)
                ELSE
                    THIS.this_nGerOpServs = IIF(NVL(loc_uValor, .F.), 1, 0)
                ENDIF
            ENDIF

            *-- cCodServs: char(10)
            IF TYPE(loc_cAlias + ".cCodServs") != "U"
                THIS.this_cCodServs = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".cCodServs"), ""), ;
                                           THIS.this_nTamCodServs)
            ENDIF

            *-- nVlServs: numeric(11,2)
            IF TYPE(loc_cAlias + ".nVlServs") != "U"
                THIS.this_nVlServs = TratarNulo(EVALUATE(loc_cAlias + ".nVlServs"), 0)
                IF VARTYPE(THIS.this_nVlServs) != "N"
                    THIS.this_nVlServs = 0
                ENDIF
            ENDIF

            *-- nAliIss: numeric(4,2) - aliquota de ISS usada pelo pai no calculo
            IF TYPE(loc_cAlias + ".nAliIss") != "U"
                THIS.this_nAliIss = TratarNulo(EVALUATE(loc_cAlias + ".nAliIss"), 0)
                IF VARTYPE(THIS.this_nAliIss) != "N"
                    THIS.this_nAliIss = 0
                ENDIF
            ENDIF

            *-- fPags: char(12) - forma de pagamento que o pai le em SigOpFp
            IF TYPE(loc_cAlias + ".fPags") != "U"
                THIS.this_cFPags = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".fPags"), ""), ;
                                        THIS.this_nTamFPags)
            ENDIF

            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecao - Alterna a marcacao da LINHA CORRENTE
    *
    * Reproduz o que o Check1 da Column1 faz no legado:
    *
    *   m.Selecionada = Iif(LocalSacOp.Selecionada = 0, 1, 0)
    *   Select LocalSacOp
    *   Gather Memvar Fields Selecionada
    *   ThisForm.grdOperacoes.Refresh
    *
    * O Gather Memvar sobre UM campo eh exatamente um REPLACE desse campo; o
    * Refresh da grade fica no Form, que eh quem tem o controle visual.
    *
    * Devolve o valor novo (0 ou 1), ou -1 quando nao foi possivel alternar -
    * assim o Form distingue "desmarcou" de "falhou" em vez de ficar inerte.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecao(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_nAtual, loc_nNovo, loc_uValor
        LOCAL loc_oErro

        loc_nNovo = -1

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN -1
        ENDIF

        IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o posicionada para marcar."
            RETURN -1
        ENDIF

        IF ISREADONLY(loc_cAlias)
            THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] est" + CHR(225) + ;
                " somente-leitura e a marca" + CHR(231) + CHR(227) + "o da Opera" + ;
                CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser gravada."
            RETURN -1
        ENDIF

        IF TYPE(loc_cAlias + ".Selecionada") = "U"
            THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o possui a coluna Selecionada."
            RETURN -1
        ENDIF

        loc_cAreaAnterior = ALIAS()

        TRY
            SELECT (loc_cAlias)

            loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
            IF VARTYPE(loc_uValor) = "N"
                loc_nAtual = NVL(loc_uValor, 0)
            ELSE
                loc_nAtual = IIF(NVL(loc_uValor, .F.), 1, 0)
            ENDIF

            loc_nNovo = IIF(loc_nAtual = 0, 1, 0)

            REPLACE Selecionada WITH loc_nNovo IN (loc_cAlias)

            THIS.this_nSelecionada  = loc_nNovo
            THIS.this_cMensagemErro = ""

            THIS.AtualizarTotais(loc_cAlias)
        CATCH TO loc_oErro
            loc_nNovo = -1
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao marcar a Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN loc_nNovo
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotais - Reconta a selecao e monta a lista das marcadas
    *
    * Equivale ao Scan que o form pai roda DEPOIS do Ok:
    *
    *   Select LocalSacOp
    *   Scan
    *       If Not llOks And (LocalSacOp.Selecionada = 1) ... llOks = .t.
    *   EndScan
    *
    * O RECNO eh salvo e reposto: SCAN move o ponteiro, e a linha corrente eh a
    * que o usuario esta vendo na grade - perde-la faz a grade "pular" sozinha.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTotais(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_nRegistro, loc_nSel, loc_cLista
        LOCAL loc_uValor, loc_nValor, loc_oErro

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        THIS.this_nTotalOperacoes    = 0
        THIS.this_nTotalSelecionadas = 0
        THIS.this_cOperacoesMarcadas = ""

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        loc_cAreaAnterior = ALIAS()
        loc_nSel          = 0
        loc_cLista        = ""

        TRY
            SELECT (loc_cAlias)
            loc_nRegistro = RECNO(loc_cAlias)

            THIS.this_nTotalOperacoes = RECCOUNT(loc_cAlias)

            SCAN
                loc_nValor = 0

                IF TYPE(loc_cAlias + ".Selecionada") != "U"
                    loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
                    IF VARTYPE(loc_uValor) = "N"
                        loc_nValor = NVL(loc_uValor, 0)
                    ELSE
                        loc_nValor = IIF(NVL(loc_uValor, .F.), 1, 0)
                    ENDIF
                ENDIF

                IF loc_nValor = 1
                    loc_nSel = loc_nSel + 1

                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        loc_cLista = loc_cLista + ;
                            IIF(EMPTY(loc_cLista), "", ", ") + ;
                            ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Dopes"), ""))
                    ENDIF
                ENDIF
            ENDSCAN

            THIS.this_nTotalSelecionadas = loc_nSel
            THIS.this_cOperacoesMarcadas = loc_cLista

            *-- Repoe a linha que o usuario estava vendo na grade
            IF loc_nRegistro > 0 AND loc_nRegistro <= RECCOUNT(loc_cAlias)
                GO loc_nRegistro IN (loc_cAlias)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao totalizar a sele" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TemSelecao - .T. quando ha ao menos uma Operacao marcada
    *
    * Eh o llOks do form pai, exposto aqui para que ele nao precise varrer o
    * cursor de novo. CONSULTA apenas: o Ok do legado NAO exige selecao (ele so
    * devolve o Enabled ao pai e libera a tela), portanto o Form nao deve usar
    * este metodo para bloquear o Ok.
    *--------------------------------------------------------------------------
    PROCEDURE TemSelecao(par_cAliasCursor)
        THIS.AtualizarTotais(par_cAliasCursor)

        RETURN (THIS.this_nTotalSelecionadas > 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Zera as propriedades da linha e os totalizadores
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_nSelecionada = 0
        THIS.this_cDopes       = ""
        THIS.this_nGerOpServs  = 0
        THIS.this_cCodServs    = ""
        THIS.this_nVlServs     = 0
        THIS.this_nAliIss      = 0
        THIS.this_cFPags       = ""

        THIS.this_nTotalOperacoes    = 0
        THIS.this_nTotalSelecionadas = 0
        THIS.this_cOperacoesMarcadas = ""

        THIS.this_cMensagemErro = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Identidade da linha corrente
    *
    * SigCdSOp.dopes - a PK fisica da tabela eh cidchaves, que o Select do
    * legado nao traz para o cursor da grade e portanto nao existe aqui.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Fecha apenas o que ESTE BO criou
    *
    * O cursor do pai (LocalSacOp) continua aberto de proposito: o form pai le
    * a selecao depois que o dialogo fecha. Fecha-lo aqui apagaria o resultado
    * da tela inteira.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorTemp)
            USE IN (THIS.this_cCursorTemp)
        ENDIF

        IF USED(THIS.this_cCursorGrade)
            USE IN (THIS.this_cCursorGrade)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

