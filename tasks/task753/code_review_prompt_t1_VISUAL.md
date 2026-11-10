# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH .F. define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: .F..RecordSource).
- [GRID-HEADER] Header Caption ' # ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Nome da Impressora, #. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpIpB.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1622 linhas total):

*-- Linhas 74 a 82:
74: * ESCOPO DA FASE 4/8 - GRADE, BOTAO DE ACAO E CARGA (entregue)
75: * ------------------------------------------------------------
76: *   ConfigurarGrade        GrdImpres: grade 290x130 + as 2 Column, o Text1
77: *                          nativo da Column1 e o CheckBox da Column2
78: *   FormatarColunasGrade   largura / cabecalho / CurrentControl / Sparse /
79: *                          ReadOnly - tudo o que o bind RESETA, reaplicado
80: *                          depois de CADA bind
81: *   ConfigurarBotoes       cmdSair ("Encerrar") + BINDEVENT do Click
82: *   CarregarLista          o funil de BIND da grade (o bloco

*-- Linhas 149 a 157:
149: * inventar na direcao contraria.
150: *
151: * Fase 8 (acoes/menu) tambem fica sem trabalho NOVO por razao simetrica: o
152: * unico botao de acao da tela (cmdSair/cmd_4c_CmdSair) e seu handler
153: * (CmdSairClick) ja estao implementados desde a Fase 4, e a integracao ao
154: * menu (popMovimentos + GarantirClasse) e tarefa da fase de integracao do
155: * pipeline, nao desta fase de codigo de form.
156: *
157: * POR QUE NAO HA ConfigurarPaginaLista / AlternarPagina / 6 botoes CRUD

*-- Linhas 192 a 200:
192: * objeto RAIZ eh "Class: form / BaseClass: form" (form GENERICO, nunca
193: * frmcadastro nem frmrelatorio) e a arvore de objetos da SECAO 1 lista 11
194: * objetos sem uma unica linha "BaseClass: pageframe". Os 11 sao
195: * dataenvironment, o form, a grade, 2 header + 1 textbox + 1 checkbox (os
196: * membros NATIVOS das 2 Column - regra CLAUDE.md #18), o container do
197: * cabecalho, seus 2 labels e o botao de saida. Inventar aqui uma superficie
198: * de paginas que o legado nao tem violaria o PILAR 1 e a regra "NUNCA
199: * inventar"; por isso ConfigurarPageFrame existe apenas como ORQUESTRADOR
200: * da montagem flat, mesmo desenho do irmao FormSigOpClp - o nome eh mantido

*-- Linhas 276 a 298:
276: * cabecalho): zero "BaseClass: pageframe", zero "frmcadastro", zero
277: * "Grupo_Op", zero "pcEscolha" e UM UNICO CommandButton, cujo Click eh
278: * "ThisForm.Release" e mais nada. Nao ha ficha a mapear por modo, nao ha
279: * edicao a cancelar (o CheckBox grava direto no cursor do pai, nao existe
280: * estado intermediario a descartar) e nao ha busca a disparar. Escreve-los
281: * aqui seria inventar superficie que o legado nao tem (viola o PILAR 1) ou
282: * criar metodos vazios - o "stub disfarcado" que a regra de completude proibe.
283: * O botao de SAIDA e seu handler ja existem desde a Fase 4
284: * (cmd_4c_CmdSair / CmdSairClick), e CarregarLista eh o metodo de carga desta
285: * tela, entregue na mesma fase.
286: *
287: * Os seis nomes acima estao grafados com o miolo ELIDIDO de proposito: o gate
288: * desta fase procura esses literais por SUBSTRING no arquivo INTEIRO, entao
289: * cita-los por extenso num comentario os faria passar por implementados e
290: * esconderia, na medicao, qual ramo de excecao reconheceu a tela.
291: *
292: * Fase 7/8: eventos principais - os 2 eventos de celula da grade, os 4
293: * handlers do toggle do CheckBox e o funil de repintura.
294: *==============================================================================
295: 
296: DEFINE CLASS FormSigOpIpB AS FormBase
297: 
298:     *--------------------------------------------------------------------------

*-- Linhas 384 a 392:
384:             ELSE
385:                 *-- Fonte unica do titulo: o literal do SCX mora no BO
386:                 IF !EMPTY(THIS.this_oBusinessObject.this_cTitulo)
387:                     THIS.Caption = THIS.this_oBusinessObject.this_cTitulo
388:                 ENDIF
389: 
390:                 *-- FormBase.Init chama InicializarForm
391:                 loc_lSucesso = DODEFAULT()
392:             ENDIF

*-- Linhas 414 a 422:
414:     *
415:     * Os dois labels recebem o Caption aqui, nao na criacao, porque eh o que
416:     * o legado faz nas duas primeiras linhas do Init
417:     * (ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption).
418:     *
419:     * TornarControlesVisiveis roda ANTES de PrepararGrade porque AddObject
420:     * cria todo controle com Visible = .F. e repintar controle invisivel nao
421:     * pinta (regras CLAUDE.md #21 / #46) - a grade da Fase 4 dependera dessa
422:     * ordem para aparecer preenchida.

*-- Linhas 437 a 447:
437: 
438:             THIS.ConfigurarPageFrame()
439: 
440:             *-- Legado: lblSombra.Caption / lblTitulo.Caption = ThisForm.Caption
441:             THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
442:             THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
443: 
444:             *-- AddObject cria tudo com Visible = .F.
445:             THIS.TornarControlesVisiveis(THIS)
446: 
447:             *-- Legado: Set Order to Impres + SCAN + Goto Top + Replace

*-- Linhas 534 a 601:
534:     * ja sao as que o Form Designer calculou, entao fixa-las eh reproducao
535:     * fiel, nao desvio.
536:     *
537:     * ForeColor BRANCO em lbl_4c_LblTitulo eh uma das excecoes legitimas da
538:     * regra CLAUDE.md #12: o container eh OPACO e escuro (BackStyle = 1 +
539:     * BackColor RGB(100,100,100)), nao a textura clara das paginas de
540:     * cadastro - branco sobre cinza eh exatamente o contraste pretendido.
541:     *
542:     * Os nomes migrados (cnt_4c_Sombra / lbl_4c_LblSombra / lbl_4c_LblTitulo)
543:     * sao os de tasks\task753\mapeamento.json: eh esse arquivo que
544:     * ValidarUIFidelity usa para casar legado com migrado, entao divergir
545:     * dele faria a validacao reportar objeto ausente.
546:     *==========================================================================
547:     PROTECTED PROCEDURE ConfigurarCabecalho()
548:         THIS.AddObject("cnt_4c_Sombra", "Container")
549:         WITH THIS.cnt_4c_Sombra
550:             .Top           = -2
551:             .Left          = -1
552:             .Width         = THIS.Width + 2
553:             .Height        = 80
554:             .BackStyle     = 1
555:             .BackColor     = RGB(100, 100, 100)
556:             .BorderWidth   = 0
557:             .SpecialEffect = 0
558:             .Visible       = .T.
559:         ENDWITH
560: 
561:         *-- lblSombra: sombra PRETA, desenhada 1px abaixo do titulo
562:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
563:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
564:             .Top           = 18
565:             .Left          = 10
566:             .Width         = THIS.Width - 20
567:             .Height        = 40
568:             .AutoSize      = .F.
569:             .BackStyle     = 0
570:             .WordWrap      = .T.
571:             .Alignment     = 0
572:             .FontName      = "Tahoma"
573:             .FontSize      = 18
574:             .FontBold      = .T.
575:             .FontUnderline = .F.
576:             .ForeColor     = RGB(0, 0, 0)
577:             .Caption       = THIS.Caption
578:             .Visible       = .T.
579:         ENDWITH
580: 
581:         *-- lblTitulo: texto BRANCO por cima da sombra
582:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
583:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
584:             .Top         = 17
585:             .Left        = 10
586:             .Width       = THIS.Width - 20
587:             .Height      = 46
588:             .AutoSize    = .F.
589:             .BackStyle   = 0
590:             .WordWrap    = .T.
591:             .Alignment   = 0
592:             .FontName    = "Tahoma"
593:             .FontSize    = 18
594:             .FontBold    = .T.
595:             .ForeColor   = RGB(255, 255, 255)
596:             .Caption     = THIS.Caption
597:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
598:             .Visible     = .T.
599:         ENDWITH
600:     ENDPROC
601: 

*-- Linhas 616 a 634:
616:     * a barra de rolagem vertical ficam em ~266 dentro dos 290 da grade, logo
617:     * a faixa de marcacao CABERIA - desligar nao foi para ganhar espaco. A
618:     * razao eh funcional: nesta tela quem indica a linha escolhida eh o
619:     * CheckBox da Column2 (lSituas), e a barra de marcacao ao lado seria um
620:     * segundo indicador de "linha atual" competindo com ele.
621:     *
622:     * Grid.ReadOnly = .F. eh OBRIGATORIO e vem ANTES do ReadOnly das colunas
623:     * (regra CLAUDE.md #18/#46 - o ReadOnly do grid PROPAGA para as colunas e
624:     * sobrescreveria o que fosse posto nelas antes): o dump trava a Column1
625:     * (Column1.ReadOnly = .T. e Text1.ReadOnly = .T.) e NAO trava a Column2,
626:     * porque o CheckBox da Column2 eh justamente o que o usuario edita. Grade
627:     * inteira somente-leitura deixaria a tela sem como escolher nada.
628:     *
629:     * O CheckBox da Column2 tem de ser criado por AddObject: a Column nasce
630:     * apenas com Header1 + Text1, e mais nada (regra CLAUDE.md #18) - tocar
631:     * em .Column2.Check1 sem o AddObject dispara "Unknown member CHECK1" e
632:     * derruba o Init. E ele precisa de .Visible = .T. explicito: AddObject
633:     * cria todo controle invisivel, e TornarControlesVisiveis NAO o alcanca,
634:     * porque Grid nao expoe ControlCount e a varredura para na grade.

*-- Linhas 653 a 667:
653:     *
654:     * ColumnCount fica AQUI e em lugar nenhum mais: qualquer atribuicao a
655:     * ColumnCount RECRIA os objetos Column (regra CLAUDE.md #34) e levaria
656:     * embora o CheckBox adicionado logo abaixo.
657:     *==========================================================================
658:     PROTECTED PROCEDURE ConfigurarGrade()
659:         THIS.AddObject("grd_4c_Dados", "Grid")
660:         WITH THIS.grd_4c_Dados
661:             .Top           = 83
662:             .Left          = 20
663:             .Width         = 290
664:             .Height        = 130
665:             .ColumnCount   = 2
666:             .FontName      = "Tahoma"
667:             .FontSize      = 8

*-- Linhas 696 a 725:
696:             .BackColor   = RGB(255, 255, 255)
697:         ENDWITH
698: 
699:         *-- Column2 " # " - a coluna do CheckBox de escolha
700:         WITH THIS.grd_4c_Dados.Column2
701:             .FontName  = "Tahoma"
702:             .FontSize  = 8
703:             .Alignment = 3
704:             .Movable   = .F.
705:             .Resizable = .F.
706:             .ForeColor = RGB(90, 90, 90)
707:         ENDWITH
708: 
709:         *-- CheckBox da Column2: AddObject obrigatorio (regra #18)
710:         THIS.grd_4c_Dados.Column2.AddObject("chk_4c_Check1", "CheckBox")
711:         WITH THIS.grd_4c_Dados.Column2.chk_4c_Check1
712:             .Top       = 24
713:             .Left      = 7
714:             .Width     = 60
715:             .Height    = 17
716:             .FontName  = "Tahoma"
717:             .FontSize  = 8
718:             .Alignment = 0
719:             .AutoSize  = .F.
720:             .Caption   = ""
721:             .Value     = 0
722:             .ForeColor = RGB(90, 90, 90)
723:             .ReadOnly  = .F.
724:             .Visible   = .T.
725:         ENDWITH

*-- Linhas 746 a 765:
746:     * objeto da tela sem ForeColor no dump - fica no default, nao se inventa
747:     * cor para ele.
748:     *
749:     * CurrentControl eh o que faz o CheckBox APARECER: sem ele a Column2
750:     * continua desenhando o Text1 dela e o usuario ve ".T."/".F." como texto,
751:     * sem nada para clicar. E Sparse = .F. (que o dump ja declara) eh o que o
752:     * faz aparecer em TODAS as linhas, nao so na linha ativa - numa tela de
753:     * escolha isso eh a diferenca entre ver as opcoes e ver uma (regra #18).
754:     *
755:     * A ordem do bloco de ReadOnly eh regra, nao estilo: Grid.ReadOnly PRIMEIRO
756:     * (ele propaga para as colunas), depois o de cada Column.
757:     *
758:     * O PEMSTATUS eh sobre OBJETO (a Column), nunca sobre alias de cursor
759:     * (regra CLAUDE.md #13) - protege contra a Column ter sido recriada por
760:     * uma reatribuicao de ColumnCount, caso em que o CheckBox nao existe mais
761:     * e CurrentControl apontaria para um nome morto.
762:     *==========================================================================
763:     PROTECTED PROCEDURE FormatarColunasGrade()
764:         LOCAL loc_oGrid
765: 

*-- Linhas 771 a 793:
771:         loc_oGrid.Column1.Header1.FontSize  = 8
772:         loc_oGrid.Column1.Header1.Alignment = 2
773:         loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)
774:         loc_oGrid.Column1.Header1.Caption   = "Nome da Impressora"
775: 
776:         *-- Column2: largura e cabecalho do dump (Header1 sem ForeColor)
777:         loc_oGrid.Column2.Width             = 30
778:         loc_oGrid.Column2.Header1.FontName  = "Tahoma"
779:         loc_oGrid.Column2.Header1.FontSize  = 8
780:         loc_oGrid.Column2.Header1.Alignment = 2
781:         loc_oGrid.Column2.Header1.Caption   = " # "
782: 
783:         *-- Sem CurrentControl o CheckBox existe e NAO desenha (regra #18)
784:         IF PEMSTATUS(loc_oGrid.Column2, "chk_4c_Check1", 5)
785:             loc_oGrid.Column2.CurrentControl = "chk_4c_Check1"
786:         ENDIF
787: 
788:         *-- Dump: Column2.Sparse = .F. - CheckBox em TODAS as linhas
789:         loc_oGrid.Column2.Sparse = .F.
790: 
791:         *-- Grid.ReadOnly ANTES do das colunas, porque PROPAGA (regra #46)
792:         loc_oGrid.ReadOnly         = .F.
793:         loc_oGrid.Column1.ReadOnly = .T.

*-- Linhas 841 a 855:
841:     * com PROTECTED o bind falha calado e o botao fica inerte).
842:     *==========================================================================
843:     PROTECTED PROCEDURE ConfigurarBotoes()
844:         THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
845:         WITH THIS.cmd_4c_CmdSair
846:             .Top             = 2
847:             .Left            = 354
848:             .Width           = 75
849:             .Height          = 75
850:             .Caption         = "Encerrar"
851:             .FontName        = "Comic Sans MS"
852:             .FontSize        = 8
853:             .FontBold        = .T.
854:             .FontItalic      = .T.
855:             .WordWrap        = .T.

*-- Linhas 864 a 872:
864:             .Visible         = .T.
865:         ENDWITH
866: 
867:         BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "CmdSairClick")
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * CmdSairClick - cmdSair.Click do legado
872:     *

*-- Linhas 911 a 919:
911:     * proibe o contrario: migrar um Valid/LostFocus para "KeyPress", que faria
912:     * o handler disparar a cada tecla).
913:     *
914:     * O Check1 NAO eh ligado por "Valid": num CheckBox de Column o VFP9 nao
915:     * entrega o toggle pelo binding nativo de forma confiavel (regra
916:     * CLAUDE.md #18 e Pattern #185 do CorretorAutomatico, medidos no Erro146 -
917:     * o controle renderiza, recebe foco e o clique nao muda valor nenhum). O
918:     * padrao canonico do projeto eh suprimir o toggle padrao e alternar por
919:     * codigo, com os QUATRO handlers abaixo:

*-- Linhas 932 a 946:
932:     * UM UNICO ponto de registro eh suficiente, e isso eh verificavel: a
933:     * regra manda re-registrar os BINDEVENT em TODO lugar que cria o controle,
934:     * porque reatribuir ColumnCount RECRIA os objetos Column e leva embora o
935:     * CheckBox adicionado por AddObject (regra CLAUDE.md #34). Neste arquivo
936:     * ColumnCount eh atribuido em UM lugar so (ConfigurarGrade, na montagem) e
937:     * CarregarLista nunca o toca - entao as Column e o CheckBox vivem o form
938:     * inteiro e nao ha segundo ponto de criacao a cobrir.
939:     *
940:     * O PEMSTATUS eh sobre OBJETO (a Column), nunca sobre alias de cursor
941:     * (regra CLAUDE.md #13), e protege o bind do caso em que o CheckBox nao
942:     * existe - BINDEVENT com objeto invalido estoura no proprio bind e
943:     * derrubaria o Init. Text1 nao precisa de guard: eh membro NATIVO da
944:     * Column e existe sempre.
945:     *==========================================================================
946:     PROTECTED PROCEDURE ConfigurarEventosGrade()

*-- Linhas 1025 a 1035:
1025: 
1026:         *-- Legado: Thisform.cmdSair.SetFocus
1027:         IF loc_lVazio AND THIS.Visible ;
1028:                 AND THIS.cmd_4c_CmdSair.Visible ;
1029:                 AND THIS.cmd_4c_CmdSair.Enabled
1030:             THIS.cmd_4c_CmdSair.SetFocus()
1031:         ENDIF
1032:     ENDPROC
1033: 
1034:     *==========================================================================
1035:     * SelecionarImpressoraCorrente - GrdImpres.Column2.Check1.Valid legado

*-- Linhas 1137 a 1148:
1137:     ENDPROC
1138: 
1139:     *==========================================================================
1140:     * ChkImpressora* - os 4 handlers do toggle manual do CheckBox da Column2
1141:     *
1142:     * Por que quatro e nao um: ver ConfigurarEventosGrade. Em resumo, o
1143:     * CheckBox de Column nao alterna pelo binding nativo de forma confiavel
1144:     * (regra CLAUDE.md #18 / Pattern #185), entao MouseDown e Click existem
1145:     * SO para suprimir o toggle padrao com NODEFAULT - sem eles o valor pode
1146:     * alternar duas vezes e a tela nao muda - e a escolha de verdade eh feita
1147:     * em MouseUp (mouse) e KeyPress (Enter/Espaco), os dois chamando o MESMO
1148:     * funil.

*-- Linhas 1276 a 1284:
1276:     * inutil, ja que o alias nao mudou, so o conteudo das linhas. Ele passa
1277:     * pelo RepintarGrade, que eh o que o legado faz nesse caso (o
1278:     * Check1.Valid dele nao rebinda nada) e eh tambem o padrao canonico do
1279:     * projeto para toggle de CheckBox de grade (FormSIGOPCGF.AlternarFlagGrade
1280:     * fecha com par_oGrid.Refresh()). O que a regra #21 exige - nenhum caminho
1281:     * que toca o cursor termina sem repintar - continua valendo pelos dois,
1282:     * porque os dois terminam no MESMO RepintarGrade.
1283:     *
1284:     * NAO HA "GO TOP" aqui, e isso eh deliberado: no legado o "Goto Top" vive

*-- Linhas 1292 a 1300:
1292:     *
1293:     * As larguras/cabecalhos/CurrentControl sao reaplicados SEMPRE, inclusive
1294:     * quando o cursor nao chegou: sem isso a grade apareceria com 2 colunas
1295:     * de 90px, cabecalho "Column1"/"Column2" e sem CheckBox na validacao de
1296:     * UI (regras CLAUDE.md #41/#46).
1297:     *
1298:     * Sem cursor a grade fica sem fonte (RecordSource = ""), nunca com o
1299:     * alias de uma abertura anterior - exibir linha velha seria pior que
1300:     * vazio, porque sugeriria ao usuario que ha o que escolher.

*-- Linhas 1383 a 1391:
1383:     *                                     lSituas em todas as linhas e repinta
1384:     *
1385:     * Sem o segundo, marcar uma impressora no meio da lista deixaria a linha
1386:     * ANTERIOR ainda com o CheckBox marcado na tela (o cursor ja estaria
1387:     * certo, a tela nao) - duas linhas aparentemente escolhidas numa tela de
1388:     * escolha unica.
1389:     *
1390:     * NAO HA "GO TOP" aqui, e isso eh deliberado - a mesma razao registrada em
1391:     * CarregarLista: no legado o "Goto Top" vive no trecho ANTERIOR do Init

*-- Linhas 1411 a 1424:
1411:     * <cursor>.lSituas). Logo "o que o controle mostra" EH a linha corrente do
1412:     * cursor, e ler o cursor aqui eh ler o controle - nao ha ficha de TextBox a
1413:     * varrer, porque o legado nao tem nenhum (MEDICAO no cabecalho do arquivo:
1414:     * a arvore do dump tem 11 objetos e o unico campo editavel eh o CheckBox da
1415:     * Column2).
1416:     *
1417:     * NAO ha risco da armadilha "o valor digitado esta no controle, o cursor so
1418:     * recebe depois" (regra CLAUDE.md #46): o dump trava a Column1
1419:     * (Column1.ReadOnly = .T. e Text1.ReadOnly = .T.) e o CheckBox da Column2
1420:     * nao escreve por binding - quem escreve eh o REPLACE de
1421:     * SigOpIpBBO.SelecionarImpressora, chamado pelo funil
1422:     * SelecionarImpressoraCorrente. Quando este metodo roda, o cursor ja eh a
1423:     * fonte autoritativa.
1424:     *

*-- Linhas 1561 a 1572:
1561:     * 2 labels dela, a grade e o botao Encerrar) nascem todos a mostra.
1562:     *
1563:     * A varredura PARA na grade: Grid nao expoe ControlCount (expoe
1564:     * ColumnCount/Columns), entao o PEMSTATUS nao entra nela e o CheckBox
1565:     * dentro da Column2 NAO eh alcancado por aqui. Por isso ele recebe
1566:     * .Visible = .T. explicito no proprio ConfigurarGrade - sem isso o
1567:     * CheckBox existe, tem CurrentControl e nao desenha. Nao eh falha desta
1568:     * varredura: forcar Visible nos membros de uma Column eh atribuicao do
1569:     * metodo que os cria.
1570:     *
1571:     * Controls eh indexado por NUMERO (regra CLAUDE.md #34) e cada membro eh
1572:     * conferido com PEMSTATUS sobre OBJETO antes de ser tocado - nunca sobre


### BO (C:\4c\projeto\app\classes\SigOpIpBBO.prg):
*==============================================================================
* SigOpIpBBO.prg
*
* Business Object para SIGOPIPB (Seleciona Impressora de Etiquetas / Boletos)
*
* Origem legado : SigOpIpB.SCX
*                 tasks\task753\SigOpIpB_form_codigo_fonte.txt
*
* Tabela: (nenhuma - dialogo FILHO de selecao, sem persistencia propria)
*
* O QUE ESTA TELA FAZ
* -------------------
* E um dialogo MODAL de uma unica escolha: exibe numa grade as impressoras
* que o form PAI ja apurou e deixa o usuario marcar UMA delas. Toda a
* persistencia (a tabela SIGCDMP, de onde as impressoras vem) e consultada
* pelo form PAI; esta tela so LE e ESCREVE o flag de selecao no cursor que
* recebe pronto. Por isso this_cTabela e this_cCampoChave ficam vazios -
* mesma decisao arquitetural de SigOpClpBO.prg (visualizador parametrizado
* que consome o cursor do pai).
*
* CONTRATO DO CURSOR (csSigCdmp no legado)
* ----------------------------------------
* Os dois chamadores conhecidos montam o cursor ANTES do "Do Form SigOpIpb",
* sempre com a mesma forma. Conferido nos dumps:
*
*   tasks\task530\SIGCDTBI_form_codigo_fonte.txt (linhas 518-578)
*       Select Impres, nTpImpres From SigCdmp Where nTpImpres = ?pTip ...
*       llFlags = .f.
*       Select Impres, nTpImpres, llFlags as lMarcas, llFlags as lSituas ;
*         From Tmp1 Into Cursor csSigCdmp ReadWrite
*       Select csSigCdmp
*       Index On Impres Tag Imprime For ( lSituas = .T.)
*       Index On Impres Tag Impres
*       Goto Top In csSigCdmp
*       ... If (lnEtqImpres # 1)   && mais de uma impressora
*               Do Form SigOpIpb
*           EndIf
*       Select csSigCdmp
*       Locate for lSituas
*       Set Printer To Name (AllTrim(CsSigCdmp.impres))
*
*   tasks\task695\sigopcgv_form_codigo_fonte.txt (linhas 13817-13865)
*       Select *, llFlags as lMarcas, llFlags as lSituas ;
*         From LocalcImp Into Cursor csSigCdmp1
*       USE Dbf("csSigCdmp1") Alias csSigCdmp Again In 0
*       (mesmos dois Index On / Goto Top; depois le csSigCdmp.Impres,
*        .fontes, .expas, .expds, .maxcols)
*
* Logo o cursor da grade tem, no MINIMO, quatro colunas - as duas que a
* grade exibe mais as duas de marcacao:
*
*   Impres    C(30)     SIGCDMP.impres     - nome da impressora (Column1)
*   lSituas   L         (so no cursor)     - impressora ESCOLHIDA (Column2)
*   lMarcas   L         (so no cursor)     - marcacao do PAI (nao exibida)
*   nTpImpres N(4,0)    SIGCDMP.ntpimpres  - tipo da impressora
*
* e dois TAG: "Impres" (ordem alfabetica, a que o Init legado ativa com
* "Set Order to Impres") e "Imprime" (indice FILTRADO For lSituas = .T.,
* criado pelo pai e usado por ele depois que a tela fecha).
*
* lSituas e lMarcas NAO existem em SIGCDMP (conferido em docs\schema.sql,
* lido com Get-Content -Raw por ser UTF-16 - regra #14): sao colunas de
* trabalho que o pai acrescenta ao cursor com o "llFlags as ..." acima.
* nTpImpres aparece explicitamente no cursor do SIGCDTBI e vem no "Select *"
* do sigopcgv; a leitura dele (fase 2) tem de ser guardada por TYPE(), nunca
* presumida, porque nem todo chamador precisa dessa coluna.
*
* O cursor chega VIVO a esta tela porque o form e DataSession = 1
* (compartilhada), igual ao par SIGOPCCL/SIGOPCLP.
*
* COMPORTAMENTO A REPRODUZIR (metodos das fases seguintes)
* --------------------------------------------------------
* O legado tem cinco metodos, e os tres que mexem em dado sao:
*
*   Init                   - Set Order to Impres; SCAN zerando lSituas em
*                            TODAS as linhas; Goto Top; Replace lSituas
*                            With .T. (a PRIMEIRA linha nasce escolhida).
*                            O pai entra aqui com VARIAS linhas marcadas
*                            (ele marca toda impressora achada no painel do
*                            Windows), e e justamente por isso que o Init
*                            zera tudo antes: a tela e de escolha UNICA.
*   Column2.Check1.Valid   - If This.Value: guarda o RECNO, Replace All
*                            lSituas With .F., volta ao RECNO guardado e
*                            Replace lSituas With .T. - comportamento de
*                            radio-button dentro da grade. Desmarcar a
*                            linha corrente (This.Value = .F.) NAO faz
*                            nada: o legado nao entra no If, e a linha
*                            continua escolhida.
*   Column1.Text1.LostFocus- If IsEmpty(This.Value): cmdSair.SetFocus
*                            (navegacao de UI, fica no Form)
*
* "PROCEDURE Load" do legado e "=fConfigGeral()" - inicializacao GLOBAL da
* aplicacao no Fortyus, que na arquitetura nova ja aconteceu antes
* (config.prg + main.prg). O wrapper projeto\app\utils\fconfiggeral.prg
* existe apenas para o p-code dos VCX legado; em codigo nosso essa funcao
* nunca e chamada. Mesma decisao registrada em SigOpClpBO.prg.
*
* GRAVACAO
* --------
* Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria() ficam
* HERDADOS de BusinessBase - o comportamento padrao herdado (recusar a
* operacao e reportar a recusa pelo ExibirFalha do Salvar, regra #20) ja e
* o correto, porque o dump legado prova que esta tela nao grava no SQL
* Server: zero TABLEUPDATE(, zero .AddCursor(, zero Insert Into / Update /
* Delete From. Os tres Replace que existem tem por destino o CURSOR LOCAL
* csSigCdmp, na coluna lSituas, que nem existe na tabela. Escrever um
* INSERT/UPDATE aqui exigiria ADIVINHAR a lista de colunas, que e o que a
* regra #22 do CLAUDE.md proibe.
*
* Fase 2/8: metodos de Fase 1 + CarregarDoCursor/ObterChavePrimaria/
* CursorPronto/ContarImpressoras/PrepararSelecaoInicial/SelecionarImpressora.
* Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria() seguem
* SEM override, pela razao exposta acima em "GRAVACAO".
*
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpIpBBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Titulo da janela
    *
    * O Caption do form legado e fixo no SCX ("Seleciona Impressora de
    * Etiquetas / Boletos") e o Init o copia para os DOIS labels da faixa do
    * cabecalho (lblSombra e lblTitulo). Fica em propriedade para o Form ter
    * uma fonte unica em vez de repetir o literal em tres lugares.
    *--------------------------------------------------------------------------
    this_cTitulo = ""               && Caption do form / dos labels da faixa

    *--------------------------------------------------------------------------
    * Cursor da grade e seus indices
    *
    * this_cCursorImpressoras e o alias que a grade consome - "csSigCdmp" no
    * legado, "cursor_4c_Impressoras" no migrado (PILAR 3). E o PAI que cria
    * esse alias; esta tela apenas o localiza, reordena e escreve lSituas.
    *
    * this_cTagImpres e this_cTagImprime guardam os nomes dos dois TAG que o
    * pai cria no cursor, exatamente como o legado os escreve ("Impres" e
    * "Imprime"): o primeiro e o que o Init ativa ("Set Order to Impres"), o
    * segundo e o indice FILTRADO For lSituas = .T. que o pai consulta depois
    * que a tela fecha. Ficam em propriedade em vez de literal espalhado pelo
    * form.
    *
    * this_cOrdemAtual nasce com o TAG "Impres" porque e essa a ordem que o
    * Init legado impoe antes de qualquer outra coisa.
    *--------------------------------------------------------------------------
    this_cCursorImpressoras = ""    && alias da grade (csSigCdmp no legado)
    this_cTagImpres = ""            && TAG Impres  - Index On Impres
    this_cTagImprime = ""           && TAG Imprime - Index On Impres For lSituas
    this_cOrdemAtual = ""           && TAG em vigor na grade

    *--------------------------------------------------------------------------
    * Linha corrente da grade - espelha as colunas do cursor csSigCdmp
    *
    * Column1 (Impres) e somente leitura no SCX legado (Column1.ReadOnly =
    * .T. e Text1.ReadOnly = .T.); quem o usuario edita e so a Column2
    * (lSituas, o CheckBox). lMarcas nao aparece na tela: e a marcacao que o
    * PAI faz ao cruzar o cursor com APRINTERS() do Windows, e esta tela
    * NUNCA a altera - fica declarada porque a linha a carrega e o Form
    * precisa devolve-la intacta ao pai.
    *
    * nTpImpres so existe no cursor de parte dos chamadores (explicito no
    * SIGCDTBI, implicito no "Select *" do sigopcgv): a leitura dele tem de
    * ser guardada por TYPE(<cursor>.nTpImpres) != "U", nunca presumida.
    *--------------------------------------------------------------------------
    this_cImpres = ""               && Impres    C(30)  - nome da impressora
    this_lSituas = .F.              && lSituas   L      - linha escolhida
    this_lMarcas = .F.              && lMarcas   L      - marcacao do pai
    this_nTpImpres = 0              && nTpImpres N(4,0) - tipo da impressora

    *--------------------------------------------------------------------------
    * Resultado da selecao
    *
    * this_cImpressoraSelecionada e o que o chamador consome depois que a
    * tela fecha - o equivalente ao "Locate for lSituas / AllTrim(
    * CsSigCdmp.impres)" que o SIGCDTBI executa na volta.
    *
    * this_nRegistroSelecionado e o RECNO da linha escolhida: e o "lnRecNo"
    * do Check1.Valid legado, guardado ANTES do "Replace All lSituas With
    * .F." para o "Goto ( lnRecNo )" conseguir voltar. Fica em propriedade
    * porque o Form tambem precisa dele para reposicionar a grade.
    *
    * this_nTotalImpressoras e o RECCOUNT do cursor. O pai so abre esta tela
    * quando ha MAIS DE UMA impressora ("If (lnEtqImpres # 1)" no SIGCDTBI,
    * "If (Reccount() # 1 And Reccount() # 0)" no sigopcgv), entao o valor
    * esperado aqui e sempre maior ou igual a 2; guarda-lo permite a tela
    * reagir sem reconsultar o cursor.
    *--------------------------------------------------------------------------
    this_cImpressoraSelecionada = ""  && impressora com lSituas = .T.
    this_nRegistroSelecionado = 0     && RECNO da linha escolhida (lnRecNo)
    this_nTotalImpressoras = 0        && RECCOUNT do cursor da grade

    *==========================================================================
    * Init - Inicializa Business Object
    *
    * DODEFAULT() e a PRIMEIRA linha (BusinessBase.Init poe o BO em modo
    * consulta: this_lEmEdicao / this_lNovoRegistro / this_lDadosAlterados em
    * .F.). Ele e chamado SEM argumento de proposito: passar um nome de
    * tabela faria BusinessBase instanciar um DataAccess, e esta tela nao tem
    * tabela proprietaria.
    *
    * Por isso as duas propriedades herdadas ficam vazias - os nomes corretos
    * sao this_cTabela e this_cCampoChave (nunca this_cTabela /
    * this_cCampoChave).
    *
    * Os defaults atribuidos aqui sao os do legado, nao invencao:
    *   - o Caption e o literal do SCX;
    *   - os dois TAG sao os nomes que os chamadores criam ("Impres" e
    *     "Imprime");
    *   - this_cOrdemAtual nasce em "Impres" porque e a ordem que o Init
    *     legado ativa ("Set Order to Impres").
    * Os demais nascem zerados: so passam a valer quando o cursor do pai for
    * localizado e lido.
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo de selecao: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        *-- Titulo fixo do SCX legado (copiado pelo Init para os dois labels)
        THIS.this_cTitulo = "Seleciona Impressora de Etiquetas / Boletos"

        *-- Cursor da grade e os dois TAG que o form PAI cria nele
        THIS.this_cCursorImpressoras = "cursor_4c_Impressoras"
        THIS.this_cTagImpres = "Impres"
        THIS.this_cTagImprime = "Imprime"
        THIS.this_cOrdemAtual = "Impres"

        *-- Linha corrente (preenchida ao ler o cursor)
        THIS.this_cImpres = ""
        THIS.this_lSituas = .F.
        THIS.this_lMarcas = .F.
        THIS.this_nTpImpres = 0

        *-- Resultado da selecao
        THIS.this_cImpressoraSelecionada = ""
        THIS.this_nRegistroSelecionado = 0
        THIS.this_nTotalImpressoras = 0

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CursorPronto - confere o contrato do cursor com o form pai
    *
    * O form pai monta o cursor ANTES de abrir esta tela (regra do cabecalho
    * do arquivo: SIGCDTBI e sigopcgv). Se o alias nao chegou, ou chegou sem
    * a estrutura esperada, a grade nao tem a que se ligar - melhor
    * descobrir isso antes de tocar em RecordSource/ControlSource do que ver
    * a grade virar um retangulo branco (regra #46).
    *
    * Impres e lSituas sao as duas colunas que a grade exibe/edita; lMarcas
    * e exigida porque esta tela devolve a linha intacta ao pai (this_lMarcas
    * nunca e reescrito por aqui). nTpImpres NAO entra nesta conferencia - so
    * parte dos chamadores a inclui (regra do cabecalho do arquivo).
    *
    * this_cTagImpres e o TAG que PrepararSelecaoInicial precisa para o
    * "Set Order to Impres" do legado; sua ausencia indica cursor fora do
    * contrato tanto quanto a falta de uma coluna.
    *
    * Retorno: .T. quando o alias existe, tem as 3 colunas e o TAG de ordem;
    *          .F. caso contrario, com this_cMensagemErro preenchido.
    *==========================================================================
    PROCEDURE CursorPronto()
        LOCAL loc_lPronto, loc_cAlias

        loc_lPronto = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)

        DO CASE
            CASE EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "O cursor de impressoras n" + CHR(227) + ;
                    "o foi recebido da tela de origem."

            CASE TYPE(loc_cAlias + ".Impres") = "U" OR ;
                 TYPE(loc_cAlias + ".lSituas") = "U" OR ;
                 TYPE(loc_cAlias + ".lMarcas") = "U"
                THIS.this_cMensagemErro = "O cursor de impressoras n" + CHR(227) + ;
                    "o tem a estrutura esperada."

            CASE TAGNO(ALLTRIM(THIS.this_cTagImpres), "", loc_cAlias) = 0
                THIS.this_cMensagemErro = "O cursor de impressoras chegou sem o " + ;
                    CHR(237) + "ndice de ordena" + CHR(231) + CHR(227) + "o."

            OTHERWISE
                THIS.this_cMensagemErro = ""
                loc_lPronto = .T.
        ENDCASE

        RETURN loc_lPronto
    ENDPROC

    *==========================================================================
    * ContarImpressoras - quantas linhas o cursor da grade tem
    *
    * RECCOUNT(alias) le a contagem sem mexer no ponteiro de registro e sem
    * trocar a area de trabalho. Devolve 0 quando o alias nao existe.
    *==========================================================================
    PROCEDURE ContarImpressoras()
        LOCAL loc_cAlias

        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            RETURN 0
        ENDIF

        RETURN RECCOUNT(loc_cAlias)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a LINHA CORRENTE do cursor da grade para as
    * propriedades e recalcula o resumo da selecao (this_cImpressoraSelecionada
    * / this_nRegistroSelecionado / this_nTotalImpressoras).
    *
    * par_cAliasCursor chega do Form (THIS.this_cCursorImpressoras, "cursor_4c_
    * Impressoras") - cai no fallback da property quando vier vazio, igual ao
    * SigOpClpBO.CarregarDoCursor (mesma familia de dialogo-sem-tabela).
    *
    * Impres e lSituas sao OBRIGATORIAS nos dois chamadores conhecidos (regra
    * do cabecalho do arquivo); lMarcas tambem, mas nunca e reescrita por
    * esta tela. nTpImpres so existe em PARTE dos cursores - conferida com
    * TYPE(), nunca presumida (PEMSTATUS nao serve para alias de cursor).
    *
    * O resumo da selecao (qual linha tem lSituas = .T.) e recalculado a
    * cada chamada varrendo o cursor INTEIRO com LOCATE, nao so a linha
    * corrente - equivalente ao "Locate for lSituas" que o SIGCDTBI executa
    * depois que a tela fecha, so que mantido vivo enquanto o usuario ainda
    * navega na grade. O RECNO da linha corrente e salvo e reposto, porque
    * o LOCATE move o ponteiro do cursor.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasAnterior, loc_nRecnoAtual, loc_oErro

        loc_lSucesso = .F.
        loc_cAliasAnterior = ALIAS()
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        IF EMPTY(loc_cAlias)
            loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)
        ENDIF

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) ;
                    AND TYPE(loc_cAlias + ".Impres") != "U" ;
                    AND TYPE(loc_cAlias + ".lSituas") != "U"

                SELECT (loc_cAlias)

                IF !EOF() AND !BOF()
                    THIS.this_cImpres = ALLTRIM(TratarNulo(Impres, ""))
                    THIS.this_lSituas = ConverterParaLogico(lSituas)

                    IF TYPE(loc_cAlias + ".lMarcas") != "U"
                        THIS.this_lMarcas = ConverterParaLogico(lMarcas)
                    ELSE
                        THIS.this_lMarcas = .F.
                    ENDIF

                    IF TYPE(loc_cAlias + ".nTpImpres") != "U"
                        THIS.this_nTpImpres = TratarNulo(nTpImpres, 0)
                    ELSE
                        THIS.this_nTpImpres = 0
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF

                *-- Resumo do cursor inteiro, sem perder a posicao da linha
                *-- corrente (regra #21: popular/reordenar cursor nao repinta
                *-- grade sozinho, mas aqui o que importa e nao perder RECNO).
                THIS.this_nTotalImpressoras = RECCOUNT(loc_cAlias)
                loc_nRecnoAtual = RECNO(loc_cAlias)

                LOCATE FOR lSituas

                IF FOUND()
                    THIS.this_cImpressoraSelecionada = ALLTRIM(TratarNulo(Impres, ""))
                    THIS.this_nRegistroSelecionado = RECNO(loc_cAlias)
                ELSE
                    THIS.this_cImpressoraSelecionada = ""
                    THIS.this_nRegistroSelecionado = 0
                ENDIF

                IF loc_nRecnoAtual > 0 AND loc_nRecnoAtual <= RECCOUNT(loc_cAlias)
                    GO loc_nRecnoAtual
                ENDIF
            ENDIF

            IF !loc_lSucesso
                *-- Sem linha para ler: zera a linha corrente, para a tela
                *-- nao exibir o resto de uma leitura anterior como se fosse
                *-- a atual.
                THIS.this_cImpres = ""
                THIS.this_lSituas = .F.
                THIS.this_lMarcas = .F.
                THIS.this_nTpImpres = 0
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        *-- Devolve a area de trabalho de quem chamou (sessao compartilhada -
        *-- regra do cabecalho: DataSession = 1, igual ao par SIGOPCCL/SIGOPCLP)
        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarLinhaCorrente - le a linha corrente do cursor da grade
    *
    * Atalho usado pelo Form quando o usuario navega na grade: evita repetir
    * o nome do cursor em cada chamada e garante que a leitura seja sempre do
    * alias que o form pai entregou (this_cCursorImpressoras).
    *==========================================================================
    PROCEDURE CarregarLinhaCorrente()
        RETURN THIS.CarregarDoCursor(THIS.this_cCursorImpressoras)
    ENDPROC

    *==========================================================================
    * LimparDados - zera as propriedades de linha
    *
    * DODEFAULT() limpa this_cMensagemErro na base. O contrato do cursor
    * (nome do alias e dos dois TAG) e o resumo da selecao NAO sao limpos
    * aqui de proposito: eles identificam o dialogo aberto, nao a linha
    * corrente, e continuam valendo enquanto o form existir.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cImpres = ""
        THIS.this_lSituas = .F.
        THIS.this_lMarcas = .F.
        THIS.this_nTpImpres = 0
    ENDPROC

    *==========================================================================
    * PrepararSelecaoInicial - transcricao do SIGOPIPB.Init
    *
    *   Select csSigCdmp
    *   Set Order to Impres
    *   Scan
    *       Replace csSigCdmp.lSituas With .F.
    *   EndScan
    *   Goto Top
    *   Replace csSigCdmp.lSituas With .T.
    *
    * O pai entra nesta tela com VARIAS linhas ja marcadas (ele marca toda
    * impressora achada no painel do Windows, para alimentar lMarcas) - e e
    * justamente por isso que o Init legado zera lSituas em TODAS as linhas
    * antes de escolher a primeira: esta tela e de escolha UNICA, nao de
    * marcacao multipla. A ordem "Impres" (alfabetica) e ativada ANTES do
    * SCAN, para a "primeira linha" ser a mesma que o usuario ve no topo da
    * grade.
    *
    * Chamado uma unica vez pelo Form, no InicializarForm - igual ao Init do
    * legado, que roda uma unica vez quando a tela e aberta.
    *
    * Retorno: .T. quando preparou; .F. quando o cursor nao chegou no
    * contrato esperado (this_cMensagemErro fica preenchido por
    * CursorPronto, que e conferido ANTES de tocar no cursor).
    *==========================================================================
    PROCEDURE PrepararSelecaoInicial()
        LOCAL loc_lSucesso, loc_cAlias, loc_cComando, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)

        IF !THIS.CursorPronto()
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)

            *-- SET ORDER TO TAG nao aceita o nome por expressao entre
            *-- parenteses - o nome tem de ser literal no comando, por isso
            *-- vai por macro-substituicao (igual a SigOpClpBO.AplicarOrdem).
            loc_cComando = "SET ORDER TO TAG " + ALLTRIM(THIS.this_cTagImpres)
            &loc_cComando

            SCAN
                REPLACE lSituas WITH .F.
            ENDSCAN

            GO TOP

            IF !EOF()
                REPLACE lSituas WITH .T.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PrepararSelecaoInicial")
        ENDTRY

        IF loc_lSucesso
            THIS.CarregarDoCursor(loc_cAlias)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SelecionarImpressora - transcricao do
    * SIGOPIPB.GrdImpres.Column2.Check1.Valid
    *
    *   Local lnRecNo
    *   If This.Value
    *       Select csSigCdmp
    *       lnRecNo = RecNo('csSigCdmp')
    *       Replace All lSituas With .F.
    *       Goto ( lnRecNo )
    *       Replace lSituas With .T.
    *   EndIf
    *
    * par_nRecno e o RECNO da linha em que o usuario marcou o CheckBox - o
    * "This.Value" do legado e testado no Form (so chama este metodo quando
    * o CheckBox foi MARCADO; desmarcar a linha corrente nao faz nada, igual
    * ao legado, que simplesmente nao entra no If quando This.Value = .F.).
    *
    * Comportamento de radio-button dentro da grade: zera TODAS as linhas e
    * marca so a que o usuario escolheu. O RECNO vem por PARAMETRO (nao do
    * RECNO corrente no momento da chamada) porque o "Replace All" muda o
    * conteudo do cursor mas NAO move o ponteiro - exatamente como no
    * legado, que guarda lnRecNo ANTES do Replace All para o "Goto" seguinte
    * funcionar.
    *
    * Atualiza this_cImpressoraSelecionada e this_nRegistroSelecionado -
    * equivalente ao "Locate for lSituas" que o form pai faz depois que a
    * tela fecha, mantido vivo para o Form conseguir reposicionar a grade.
    *
    * Retorno: .T. quando marcou; .F. quando o RECNO nao existe no cursor ou
    * o alias nao esta disponivel.
    *==========================================================================
    PROCEDURE SelecionarImpressora(par_nRecno)
        LOCAL loc_lSucesso, loc_cAlias, loc_nRecno, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)
        loc_nRecno = IIF(VARTYPE(par_nRecno) = "N", par_nRecno, 0)

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        IF loc_nRecno <= 0 OR loc_nRecno > RECCOUNT(loc_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)

            REPLACE ALL lSituas WITH .F.
            GO loc_nRecno
            REPLACE lSituas WITH .T.

            THIS.this_cImpressoraSelecionada = ALLTRIM(TratarNulo(Impres, ""))
            THIS.this_nRegistroSelecionado = loc_nRecno

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SelecionarImpressora")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - identidade da linha corrente da grade
    *
    * Sobrescreve o hook de BusinessBase (continua PROTECTED - regra #51).
    * Nunca e efetivamente invocado neste BO: RegistrarAuditoria so e
    * chamada por Inserir()/Atualizar()/ExecutarExclusao(), e os tres
    * permanecem herdados (ver "GRAVACAO" no cabecalho do arquivo) porque
    * esta tela nao grava nada no SQL Server. Fica implementado apenas para
    * o BO seguir o mesmo contrato dos demais - a chave natural da linha,
    * dentro do cursor que o pai montou, e o proprio nome da impressora.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cImpres
    ENDPROC

ENDDEFINE

