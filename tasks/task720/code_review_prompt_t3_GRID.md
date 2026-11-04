# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 495: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDet.prg) - TRECHOS RELEVANTES PARA PASS GRID (1359 linhas total):

*-- Linhas 144 a 181:
144: *             CarregarDadosGrade: SigOpDetBO.CarregarItens() FECHA e
145: *             RECRIA o alias cursor_4c_Itens (USE IN + SELECT ... INTO
146: *             CURSOR ... READWRITE). Derrubar o alias sob uma grade JA
147: *             bindada zera o ColumnCount e destroi os TextBox que as
148: *             Column receberam por AddObject - a grade viraria um
149: *             retangulo branco, sem erro e sem log. Por isso o funil
150: *             reaplica o bind INTEIRO depois de recarregar
151: *             (VincularGradeDet) e so entao repinta. Na PRIMEIRA carga
152: *             (dentro de ConfigurarPageFrame) a grade ainda nao existe e
153: *             o funil apenas popula o cursor - que eh justamente a ordem
154: *             que a regra #41 exige, porque Column.ControlSource estoura
155: *             se o cursor nao existir.
156: *
157: *             O bind deixou de morar no ConfigurarGrade e passou a
158: *             VincularGradeDet/VincularColunaDet (FONTE UNICA - regra
159: *             #44, item 6): RecordSource reseta Column.Width,
160: *             Header1.Caption, Sparse e CurrentControl (regra #48), entao
161: *             as duas chamadas (criacao e recarga) tem de aplicar o MESMO
162: *             bloco, na ordem ColumnCount -> RecordSource -> ControlSource
163: *             -> Width -> Header1.Caption. ColumnCount so eh tocado quando
164: *             esta diferente de 3, e cada TextBox de celula so eh recriado
165: *             quando a Column o perdeu (guarda PEMSTATUS): reatribuir
166: *             ColumnCount DESTROI os objetos Column e com eles os
167: *             controles postos por AddObject.
168: *
169: *             FormParaBO/BOParaForm sao o par de transferencia da linha, e
170: *             passaram a ser o caminho UNICO pelo qual os dois Valid de
171: *             celula gravam no cursor - no lugar dos REPLACE soltos que a
172: *             Fase 6 tinha espalhado em ValidarCaracteristicaDetExec e
173: *             ValidarComplementoDetExec. O comportamento eh o MESMO do
174: *             legado ("Replace CCars With This.Value in crSigMvFtc",
175: *             "Replace cTits ..." e o "Replace Resps With []" quando o
176: *             Complemento nao fica vazio); o que muda eh haver um lugar so
177: *             que escreve a linha. FormParaBO REAFIRMA o contexto do
178: *             dialogo (empdopnums/cpros) depois do CarregarDoCursor: o
179: *             contexto eh do FORM, nao da linha, e uma linha em branco
180: *             (placeholder) zeraria no BO justamente as duas chaves que
181: *             SigOpDetBO.GravarItens() usa no DELETE/INSERT de SigMvFtc.

*-- Linhas 423 a 511:
423:     *--------------------------------------------------------------------------
424:     * CriarCursorItensPlaceholder - cursor_4c_Itens vazio, com a MESMA ordem
425:     * de campos usada em SigOpDetBO.CarregarItens()/GravarItens() (regra:
426:     * CREATE CURSOR com ordem identica em todos os locais)
427:     *--------------------------------------------------------------------------
428:     PROTECTED PROCEDURE CriarCursorItensPlaceholder()
429:         IF USED("cursor_4c_Itens")
430:             USE IN cursor_4c_Itens
431:         ENDIF
432: 
433:         SET NULL ON
434:         CREATE CURSOR cursor_4c_Itens ;
435:             (cidchaves C(20), empdopnums C(29), cpros C(14), ;
436:              ccars C(20), ctits C(20), resps C(20), ordens N(6,0))
437:         SET NULL OFF
438:     ENDPROC
439: 
440:     *--------------------------------------------------------------------------
441:     * ConfigurarGrade - Grade de Caracteristica/Complemento/Outros (SIGOPDET.
442:     * Grade do legado). Aqui ficam SO as propriedades que nao dependem de
443:     * dado; todo o bind (ColumnCount/RecordSource/ControlSource/Width/
444:     * Header1.Caption/CurrentControl/Sparse/ReadOnly) mora em
445:     * VincularGradeDet, que eh FONTE UNICA compartilhada com CarregarLista
446:     * (regra #44, item 6) - duas copias do bind divergiriam em silencio na
447:     * primeira coluna nova.
448:     *--------------------------------------------------------------------------
449:     PROTECTED PROCEDURE ConfigurarGrade()
450:         LOCAL loc_oGrade
451: 
452:         THIS.AddObject("grd_4c_Dados", "Grid")
453:         loc_oGrade = THIS.grd_4c_Dados
454:         WITH loc_oGrade
455:             .Top           = 88
456:             .Left          = 74
457:             .Width         = 600
458:             .Height        = 405
459:             .FontName      = "Tahoma"
460:             .FontSize      = 8
461:             .DeleteMark    = .F.
462:             .RecordMark    = .F.
463:             .RowHeight     = 16
464:             .ScrollBars    = 2
465:             .GridLineColor = RGB(238, 238, 238)
466:         ENDWITH
467: 
468:         THIS.VincularGradeDet()
469:     ENDPROC
470: 
471:     *--------------------------------------------------------------------------
472:     * VincularGradeDet - Bind COMPLETO da grade a cursor_4c_Itens. FONTE
473:     * UNICA: chamado por ConfigurarGrade (criacao) e por CarregarLista
474:     * (recarga). Precisa ser reaplicado inteiro a cada recarga porque
475:     * RecordSource reseta Column.Width, Header1.Caption, Sparse e
476:     * CurrentControl (regra #48), e porque SigOpDetBO.CarregarItens() FECHA
477:     * e RECRIA o alias - o que zera o ColumnCount e destroi os TextBox das
478:     * Column.
479:     *
480:     * ColumnCount so eh tocado quando esta diferente de 3: reatribui-lo
481:     * DESTROI os objetos Column e com eles os controles postos por
482:     * AddObject (regra do CLAUDE.md sobre ColumnCount em Carregar*).
483:     *--------------------------------------------------------------------------
484:     PROTECTED PROCEDURE VincularGradeDet()
485:         LOCAL loc_oGrade, loc_lSucesso
486:         loc_lSucesso = .F.
487: 
488:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Itens")
489:             loc_oGrade = THIS.grd_4c_Dados
490: 
491:             IF loc_oGrade.ColumnCount != 3
492:                 loc_oGrade.ColumnCount = 3
493:             ENDIF
494: 
495:             loc_oGrade.RecordSource = "cursor_4c_Itens"
496: 
497:             *-- Column1 - Caracteristica | Column2 - Complemento
498:             *-- Column3 - Outros (coluna Resps - observacao livre)
499:             THIS.VincularColunaDet(loc_oGrade.Column1, "txt_4c_Caracteristica", ;
500:                 "TextBoxCaracteristicaDet_4c", "cursor_4c_Itens.ccars", 155, "Caracteristica")
501:             THIS.VincularColunaDet(loc_oGrade.Column2, "txt_4c_Complemento", ;
502:                 "TextBoxComplementoDet_4c", "cursor_4c_Itens.ctits", 155, "Complemento")
503:             THIS.VincularColunaDet(loc_oGrade.Column3, "txt_4c_Outros", ;
504:                 "TextBoxOutrosDet_4c", "cursor_4c_Itens.resps", 255, "Outros")
505: 
506:             *-- Grid.ReadOnly/Column.ReadOnly por ULTIMO e na ordem certa
507:             *-- (regra #18) - o modo de operacao manda, nao um literal
508:             THIS.AjustarBotoesPorModo()
509: 
510:             loc_lSucesso = .T.
511:         ENDIF

*-- Linhas 525 a 589:
525:     * Text1 nativo e o controle nunca aparece (regra #18); e BINDEVENT em
526:     * Valid/When de Column.Text1 nao eh confiavel (regra #46).
527:     *
528:     * Ordem obrigatoria: ControlSource -> Width -> Header1.Caption (regra
529:     * #48 - mexer na fonte do dado reseta largura e cabecalho).
530:     *--------------------------------------------------------------------------
531:     PROTECTED PROCEDURE VincularColunaDet(par_oColuna, par_cNomeControle, ;
532:             par_cClasseControle, par_cControlSource, par_nWidth, par_cCaption)
533: 
534:         IF !PEMSTATUS(par_oColuna, par_cNomeControle, 5)
535:             par_oColuna.AddObject(par_cNomeControle, par_cClasseControle)
536:         ENDIF
537:         par_oColuna.CurrentControl = par_cNomeControle
538:         par_oColuna.Sparse         = .F.
539: 
540:         WITH par_oColuna
541:             .ControlSource     = par_cControlSource
542:             .FontName          = "Tahoma"
543:             .FontSize          = 8
544:             .Width             = par_nWidth
545:             .Movable           = .F.
546:             .Resizable         = .F.
547:             .Header1.Caption   = par_cCaption
548:             .Header1.Alignment = 2
549:             .Header1.FontName  = "Tahoma"
550:             .Header1.FontSize  = 8
551:         ENDWITH
552:     ENDPROC
553: 
554:     *--------------------------------------------------------------------------
555:     * CarregarLista - FUNIL UNICO de carga da grade de detalhes: recarrega
556:     * cursor_4c_Itens, reaplica o bind e repinta. PUBLIC porque o harness
557:     * de teste automatico chama THIS.oForm.CarregarLista() de FORA da
558:     * classe (CLAUDE.md regra #3 - PROTECTED falharia em runtime com
559:     * "Property CARREGARLISTA is not found").
560:     *
561:     * O rebind depois da carga NAO eh zelo: SigOpDetBO.CarregarItens() faz
562:     * USE IN + SELECT ... INTO CURSOR ... READWRITE, isto eh FECHA e RECRIA
563:     * o alias que a grade usa como RecordSource. Com a grade ja bindada
564:     * isso zera o ColumnCount e destroi os TextBox das Column - a grade
565:     * vira um retangulo branco sem erro, sem log e para o RESTO da vida do
566:     * form. Na primeira chamada (ConfigurarPageFrame) a grade ainda nao
567:     * existe e o bloco de rebind eh pulado pela guarda do VincularGradeDet.
568:     *--------------------------------------------------------------------------
569:     PROCEDURE CarregarLista()
570:         LOCAL loc_lSucesso
571: 
572:         loc_lSucesso = THIS.CarregarDadosGrade()
573: 
574:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
575:             THIS.VincularGradeDet()
576:             THIS.RepintarGradeDet()
577:         ENDIF
578: 
579:         RETURN loc_lSucesso
580:     ENDPROC
581: 
582:     *--------------------------------------------------------------------------
583:     * RepintarGradeDet - GO TOP + Refresh da grade (regra #21: popular o
584:     * cursor NAO repinta a grade; sem isto o cursor fica cheio e a tela
585:     * aparece vazia, e o sintoma reportado - "a tela nao traz dados" -
586:     * manda o diagnostico para SQL/cursor/permissao).
587:     *
588:     * Usado SO nos caminhos que (re)populam o cursor. Os handlers de linha
589:     * (BtnInserirDetClick/BtnExcluirDetClick) tem posicionamento PROPRIO

*-- Linhas 595 a 616:
595:         LOCAL loc_lSucesso
596:         loc_lSucesso = .F.
597: 
598:         IF USED("cursor_4c_Itens") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
599:             SELECT cursor_4c_Itens
600:             GO TOP
601:             THIS.grd_4c_Dados.Refresh()
602:             loc_lSucesso = .T.
603:         ENDIF
604: 
605:         RETURN loc_lSucesso
606:     ENDPROC
607: 
608:     *--------------------------------------------------------------------------
609:     * AjustarBotoesPorModo - Aplica o modo de operacao recebido do form
610:     * chamador (pcEscolha do legado) a superficie editavel da tela. PUBLIC
611:     * porque o harness de teste automatico tambem o chama de fora da classe
612:     * (CLAUDE.md regra #3).
613:     *
614:     * O legado trava a edicao pelo When de CADA celula (InList(pcEscolha,
615:     * 'INSERIR','ALTERAR')) - reproduzido nas TextBox subclasses. Aqui a
616:     * mesma regra eh aplicada no nivel da Column, que eh o lugar onde o

*-- Linhas 637 a 661:
637:         LOCAL loc_lEditavel, loc_lSucesso
638:         loc_lSucesso = .F.
639: 
640:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.ColumnCount >= 3
641:             loc_lEditavel = THIS.GradeDetEditavel()
642: 
643:             THIS.grd_4c_Dados.ReadOnly         = .F.
644:             THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lEditavel
645:             THIS.grd_4c_Dados.Column2.ReadOnly = !loc_lEditavel
646:             THIS.grd_4c_Dados.Column3.ReadOnly = !loc_lEditavel
647: 
648:             loc_lSucesso = .T.
649:         ENDIF
650: 
651:         RETURN loc_lSucesso
652:     ENDPROC
653: 
654:     *--------------------------------------------------------------------------
655:     * FormParaBO - Transfere a LINHA CORRENTE da grade (a "ficha" desta
656:     * tela) para as propriedades do BO.
657:     *
658:     * PROTECTED EXPLICITO, e nao por preferencia de estilo: FormBase.prg
659:     * declara "PROTECTED PROCEDURE FormParaBO" (linha 285) e em VFP9 a
660:     * subclasse NAO ALARGA escopo herdado - escrever sem modificador aqui
661:     * nao tornaria o metodo publico, so esconderia de quem le que ele

*-- Linhas 1008 a 1027:
1008:                 loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalCars.ccars)
1009:             ELSE
1010:                 loc_oBusca = CREATEOBJECT("FormBuscaSimples", "cursor_4c_SigOpDetLocalCars", "Caracteristicas")
1011:                 loc_oBusca.mAddColuna("ccars", "", "C" + CHR(243) + "digo")
1012:                 loc_oBusca.mAddColuna("desccars", "", "Descri" + CHR(231) + CHR(227) + "o")
1013:                 loc_oBusca.Show()
1014: 
1015:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigOpDetLocalCars")
1016:                     loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalCars.ccars)
1017:                 ELSE
1018:                     *-- Cancelou: celula VAZIA de proposito, NAO eh o defeito
1019:                     *-- da regra #50. O legado termina o Valid com
1020:                     *-- "This.Value = LocalCars.cCars" INCONDICIONAL: a celula
1021:                     *-- so guarda codigo RELIDO do universo, nunca o texto cru
1022:                     *-- digitado. Devolver o digitado aqui deixaria gravar
1023:                     *-- Caracteristica inexistente em sigmvftc.ccars.
1024:                     loc_cResultado = ""
1025:                 ENDIF
1026:                 loc_oBusca.Release()
1027:             ENDIF

*-- Linhas 1101 a 1120:
1101:                 loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalTits.ctits)
1102:             ELSE
1103:                 loc_oBusca = CREATEOBJECT("FormBuscaSimples", "cursor_4c_SigOpDetLocalTits", "Complementos")
1104:                 loc_oBusca.mAddColuna("ctits", "", "C" + CHR(243) + "digo")
1105:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1106:                 loc_oBusca.Show()
1107: 
1108:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigOpDetLocalTits")
1109:                     loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalTits.ctits)
1110:                 ELSE
1111:                     *-- Cancelou: celula VAZIA de proposito (mesma razao do
1112:                     *-- AbrirLookupCaracteristicaDet acima - o legado fecha o
1113:                     *-- Valid com "This.Value = LocalTits.ctits" incondicional,
1114:                     *-- logo a celula nunca guarda o texto cru digitado). NAO
1115:                     *-- eh o defeito da regra #50.
1116:                     loc_cResultado = ""
1117:                 ENDIF
1118:                 loc_oBusca.Release()
1119:             ENDIF
1120:             USE IN cursor_4c_SigOpDetLocalTits

*-- Linhas 1145 a 1202:
1145:         ENDIF
1146: 
1147:         KEYBOARD "{DNARROW}"
1148:         THIS.grd_4c_Dados.Refresh()
1149:         THIS.grd_4c_Dados.Column1.SetFocus()
1150:     ENDPROC
1151: 
1152:     *--------------------------------------------------------------------------
1153:     * BtnInserirDetClick - cmdInserir.Click do legado (guard de modo +
1154:     * garante linha em branco no fim + foca Column1)
1155:     *--------------------------------------------------------------------------
1156:     PROCEDURE BtnInserirDetClick()
1157:         IF !THIS.GradeDetEditavel()
1158:             RETURN
1159:         ENDIF
1160: 
1161:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1162:             THIS.this_oBusinessObject.InserirLinhaPadrao()
1163:         ENDIF
1164: 
1165:         THIS.grd_4c_Dados.Refresh()
1166:         THIS.grd_4c_Dados.Column1.SetFocus()
1167:     ENDPROC
1168: 
1169:     *--------------------------------------------------------------------------
1170:     * BtnExcluirDetClick - cmdExcluir.Click do legado (guard de modo +
1171:     * remove a linha corrente)
1172:     *--------------------------------------------------------------------------
1173:     PROCEDURE BtnExcluirDetClick()
1174:         IF !THIS.GradeDetEditavel()
1175:             RETURN
1176:         ENDIF
1177: 
1178:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1179:             *-- Carrega a linha no BO ANTES de remove-la: depois do DELETE o
1180:             *-- ponteiro muda e nao ha mais como saber qual cidchaves saiu -
1181:             *-- eh ele que ObterChavePrimaria()/RegistrarAuditoria usam.
1182:             THIS.FormParaBO()
1183:             THIS.this_oBusinessObject.ExcluirLinhaAtual()
1184:         ENDIF
1185: 
1186:         THIS.grd_4c_Dados.SetFocus()
1187:         THIS.grd_4c_Dados.Refresh()
1188:     ENDPROC
1189: 
1190:     *--------------------------------------------------------------------------
1191:     * BtnConfirmarClick / BtnCancelarClick - btnConfirmar.Click e
1192:     * btnSair.Click do legado. O dump tem o MESMO corpo nos dois (Validacao
1193:     * + Release) - os dois handlers delegam para o mesmo metodo. PUBLIC
1194:     * (BINDEVENT - regra #3).
1195:     *--------------------------------------------------------------------------
1196:     PROCEDURE BtnConfirmarClick()
1197:         THIS.ConfirmarSelecaoDetExec()
1198:     ENDPROC
1199: 
1200:     PROCEDURE BtnCancelarClick()
1201:         THIS.ConfirmarSelecaoDetExec()
1202:     ENDPROC

