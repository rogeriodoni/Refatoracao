# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 493: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDet.prg) - TRECHOS RELEVANTES PARA PASS GRID (1357 linhas total):

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

*-- Linhas 423 a 509:
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
433:         CREATE CURSOR cursor_4c_Itens ;
434:             (cidchaves C(20), empdopnums C(29), cpros C(14), ;
435:              ccars C(20), ctits C(20), resps C(20), ordens N(6,0))
436:     ENDPROC
437: 
438:     *--------------------------------------------------------------------------
439:     * ConfigurarGrade - Grade de Caracteristica/Complemento/Outros (SIGOPDET.
440:     * Grade do legado). Aqui ficam SO as propriedades que nao dependem de
441:     * dado; todo o bind (ColumnCount/RecordSource/ControlSource/Width/
442:     * Header1.Caption/CurrentControl/Sparse/ReadOnly) mora em
443:     * VincularGradeDet, que eh FONTE UNICA compartilhada com CarregarLista
444:     * (regra #44, item 6) - duas copias do bind divergiriam em silencio na
445:     * primeira coluna nova.
446:     *--------------------------------------------------------------------------
447:     PROTECTED PROCEDURE ConfigurarGrade()
448:         LOCAL loc_oGrade
449: 
450:         THIS.AddObject("grd_4c_Dados", "Grid")
451:         loc_oGrade = THIS.grd_4c_Dados
452:         WITH loc_oGrade
453:             .Top           = 88
454:             .Left          = 74
455:             .Width         = 600
456:             .Height        = 405
457:             .FontName      = "Tahoma"
458:             .FontSize      = 8
459:             .DeleteMark    = .F.
460:             .RecordMark    = .F.
461:             .RowHeight     = 16
462:             .ScrollBars    = 2
463:             .GridLineColor = RGB(238, 238, 238)
464:         ENDWITH
465: 
466:         THIS.VincularGradeDet()
467:     ENDPROC
468: 
469:     *--------------------------------------------------------------------------
470:     * VincularGradeDet - Bind COMPLETO da grade a cursor_4c_Itens. FONTE
471:     * UNICA: chamado por ConfigurarGrade (criacao) e por CarregarLista
472:     * (recarga). Precisa ser reaplicado inteiro a cada recarga porque
473:     * RecordSource reseta Column.Width, Header1.Caption, Sparse e
474:     * CurrentControl (regra #48), e porque SigOpDetBO.CarregarItens() FECHA
475:     * e RECRIA o alias - o que zera o ColumnCount e destroi os TextBox das
476:     * Column.
477:     *
478:     * ColumnCount so eh tocado quando esta diferente de 3: reatribui-lo
479:     * DESTROI os objetos Column e com eles os controles postos por
480:     * AddObject (regra do CLAUDE.md sobre ColumnCount em Carregar*).
481:     *--------------------------------------------------------------------------
482:     PROTECTED PROCEDURE VincularGradeDet()
483:         LOCAL loc_oGrade, loc_lSucesso
484:         loc_lSucesso = .F.
485: 
486:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Itens")
487:             loc_oGrade = THIS.grd_4c_Dados
488: 
489:             IF loc_oGrade.ColumnCount != 3
490:                 loc_oGrade.ColumnCount = 3
491:             ENDIF
492: 
493:             loc_oGrade.RecordSource = "cursor_4c_Itens"
494: 
495:             *-- Column1 - Caracteristica | Column2 - Complemento
496:             *-- Column3 - Outros (coluna Resps - observacao livre)
497:             THIS.VincularColunaDet(loc_oGrade.Column1, "txt_4c_Caracteristica", ;
498:                 "TextBoxCaracteristicaDet_4c", "cursor_4c_Itens.ccars", 155, "Caracteristica")
499:             THIS.VincularColunaDet(loc_oGrade.Column2, "txt_4c_Complemento", ;
500:                 "TextBoxComplementoDet_4c", "cursor_4c_Itens.ctits", 155, "Complemento")
501:             THIS.VincularColunaDet(loc_oGrade.Column3, "txt_4c_Outros", ;
502:                 "TextBoxOutrosDet_4c", "cursor_4c_Itens.resps", 255, "Outros")
503: 
504:             *-- Grid.ReadOnly/Column.ReadOnly por ULTIMO e na ordem certa
505:             *-- (regra #18) - o modo de operacao manda, nao um literal
506:             THIS.AjustarBotoesPorModo()
507: 
508:             loc_lSucesso = .T.
509:         ENDIF

*-- Linhas 523 a 587:
523:     * Text1 nativo e o controle nunca aparece (regra #18); e BINDEVENT em
524:     * Valid/When de Column.Text1 nao eh confiavel (regra #46).
525:     *
526:     * Ordem obrigatoria: ControlSource -> Width -> Header1.Caption (regra
527:     * #48 - mexer na fonte do dado reseta largura e cabecalho).
528:     *--------------------------------------------------------------------------
529:     PROTECTED PROCEDURE VincularColunaDet(par_oColuna, par_cNomeControle, ;
530:             par_cClasseControle, par_cControlSource, par_nWidth, par_cCaption)
531: 
532:         IF !PEMSTATUS(par_oColuna, par_cNomeControle, 5)
533:             par_oColuna.AddObject(par_cNomeControle, par_cClasseControle)
534:         ENDIF
535:         par_oColuna.CurrentControl = par_cNomeControle
536:         par_oColuna.Sparse         = .F.
537: 
538:         WITH par_oColuna
539:             .ControlSource     = par_cControlSource
540:             .FontName          = "Tahoma"
541:             .FontSize          = 8
542:             .Width             = par_nWidth
543:             .Movable           = .F.
544:             .Resizable         = .F.
545:             .Header1.Caption   = par_cCaption
546:             .Header1.Alignment = 2
547:             .Header1.FontName  = "Tahoma"
548:             .Header1.FontSize  = 8
549:         ENDWITH
550:     ENDPROC
551: 
552:     *--------------------------------------------------------------------------
553:     * CarregarLista - FUNIL UNICO de carga da grade de detalhes: recarrega
554:     * cursor_4c_Itens, reaplica o bind e repinta. PUBLIC porque o harness
555:     * de teste automatico chama THIS.oForm.CarregarLista() de FORA da
556:     * classe (CLAUDE.md regra #3 - PROTECTED falharia em runtime com
557:     * "Property CARREGARLISTA is not found").
558:     *
559:     * O rebind depois da carga NAO eh zelo: SigOpDetBO.CarregarItens() faz
560:     * USE IN + SELECT ... INTO CURSOR ... READWRITE, isto eh FECHA e RECRIA
561:     * o alias que a grade usa como RecordSource. Com a grade ja bindada
562:     * isso zera o ColumnCount e destroi os TextBox das Column - a grade
563:     * vira um retangulo branco sem erro, sem log e para o RESTO da vida do
564:     * form. Na primeira chamada (ConfigurarPageFrame) a grade ainda nao
565:     * existe e o bloco de rebind eh pulado pela guarda do VincularGradeDet.
566:     *--------------------------------------------------------------------------
567:     PROCEDURE CarregarLista()
568:         LOCAL loc_lSucesso
569: 
570:         loc_lSucesso = THIS.CarregarDadosGrade()
571: 
572:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
573:             THIS.VincularGradeDet()
574:             THIS.RepintarGradeDet()
575:         ENDIF
576: 
577:         RETURN loc_lSucesso
578:     ENDPROC
579: 
580:     *--------------------------------------------------------------------------
581:     * RepintarGradeDet - GO TOP + Refresh da grade (regra #21: popular o
582:     * cursor NAO repinta a grade; sem isto o cursor fica cheio e a tela
583:     * aparece vazia, e o sintoma reportado - "a tela nao traz dados" -
584:     * manda o diagnostico para SQL/cursor/permissao).
585:     *
586:     * Usado SO nos caminhos que (re)populam o cursor. Os handlers de linha
587:     * (BtnInserirDetClick/BtnExcluirDetClick) tem posicionamento PROPRIO

*-- Linhas 593 a 614:
593:         LOCAL loc_lSucesso
594:         loc_lSucesso = .F.
595: 
596:         IF USED("cursor_4c_Itens") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
597:             SELECT cursor_4c_Itens
598:             GO TOP
599:             THIS.grd_4c_Dados.Refresh()
600:             loc_lSucesso = .T.
601:         ENDIF
602: 
603:         RETURN loc_lSucesso
604:     ENDPROC
605: 
606:     *--------------------------------------------------------------------------
607:     * AjustarBotoesPorModo - Aplica o modo de operacao recebido do form
608:     * chamador (pcEscolha do legado) a superficie editavel da tela. PUBLIC
609:     * porque o harness de teste automatico tambem o chama de fora da classe
610:     * (CLAUDE.md regra #3).
611:     *
612:     * O legado trava a edicao pelo When de CADA celula (InList(pcEscolha,
613:     * 'INSERIR','ALTERAR')) - reproduzido nas TextBox subclasses. Aqui a
614:     * mesma regra eh aplicada no nivel da Column, que eh o lugar onde o

*-- Linhas 635 a 659:
635:         LOCAL loc_lEditavel, loc_lSucesso
636:         loc_lSucesso = .F.
637: 
638:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.ColumnCount >= 3
639:             loc_lEditavel = THIS.GradeDetEditavel()
640: 
641:             THIS.grd_4c_Dados.ReadOnly         = .F.
642:             THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lEditavel
643:             THIS.grd_4c_Dados.Column2.ReadOnly = !loc_lEditavel
644:             THIS.grd_4c_Dados.Column3.ReadOnly = !loc_lEditavel
645: 
646:             loc_lSucesso = .T.
647:         ENDIF
648: 
649:         RETURN loc_lSucesso
650:     ENDPROC
651: 
652:     *--------------------------------------------------------------------------
653:     * FormParaBO - Transfere a LINHA CORRENTE da grade (a "ficha" desta
654:     * tela) para as propriedades do BO.
655:     *
656:     * PROTECTED EXPLICITO, e nao por preferencia de estilo: FormBase.prg
657:     * declara "PROTECTED PROCEDURE FormParaBO" (linha 285) e em VFP9 a
658:     * subclasse NAO ALARGA escopo herdado - escrever sem modificador aqui
659:     * nao tornaria o metodo publico, so esconderia de quem le que ele

*-- Linhas 1006 a 1025:
1006:                 loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalCars.ccars)
1007:             ELSE
1008:                 loc_oBusca = CREATEOBJECT("FormBuscaSimples", "cursor_4c_SigOpDetLocalCars", "Caracteristicas")
1009:                 loc_oBusca.mAddColuna("ccars", "", "C" + CHR(243) + "digo")
1010:                 loc_oBusca.mAddColuna("desccars", "", "Descri" + CHR(231) + CHR(227) + "o")
1011:                 loc_oBusca.Show()
1012: 
1013:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigOpDetLocalCars")
1014:                     loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalCars.ccars)
1015:                 ELSE
1016:                     *-- Cancelou: celula VAZIA de proposito, NAO eh o defeito
1017:                     *-- da regra #50. O legado termina o Valid com
1018:                     *-- "This.Value = LocalCars.cCars" INCONDICIONAL: a celula
1019:                     *-- so guarda codigo RELIDO do universo, nunca o texto cru
1020:                     *-- digitado. Devolver o digitado aqui deixaria gravar
1021:                     *-- Caracteristica inexistente em sigmvftc.ccars.
1022:                     loc_cResultado = ""
1023:                 ENDIF
1024:                 loc_oBusca.Release()
1025:             ENDIF

*-- Linhas 1099 a 1118:
1099:                 loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalTits.ctits)
1100:             ELSE
1101:                 loc_oBusca = CREATEOBJECT("FormBuscaSimples", "cursor_4c_SigOpDetLocalTits", "Complementos")
1102:                 loc_oBusca.mAddColuna("ctits", "", "C" + CHR(243) + "digo")
1103:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1104:                 loc_oBusca.Show()
1105: 
1106:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigOpDetLocalTits")
1107:                     loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalTits.ctits)
1108:                 ELSE
1109:                     *-- Cancelou: celula VAZIA de proposito (mesma razao do
1110:                     *-- AbrirLookupCaracteristicaDet acima - o legado fecha o
1111:                     *-- Valid com "This.Value = LocalTits.ctits" incondicional,
1112:                     *-- logo a celula nunca guarda o texto cru digitado). NAO
1113:                     *-- eh o defeito da regra #50.
1114:                     loc_cResultado = ""
1115:                 ENDIF
1116:                 loc_oBusca.Release()
1117:             ENDIF
1118:             USE IN cursor_4c_SigOpDetLocalTits

*-- Linhas 1143 a 1200:
1143:         ENDIF
1144: 
1145:         KEYBOARD "{DNARROW}"
1146:         THIS.grd_4c_Dados.Refresh()
1147:         THIS.grd_4c_Dados.Column1.SetFocus()
1148:     ENDPROC
1149: 
1150:     *--------------------------------------------------------------------------
1151:     * BtnInserirDetClick - cmdInserir.Click do legado (guard de modo +
1152:     * garante linha em branco no fim + foca Column1)
1153:     *--------------------------------------------------------------------------
1154:     PROCEDURE BtnInserirDetClick()
1155:         IF !THIS.GradeDetEditavel()
1156:             RETURN
1157:         ENDIF
1158: 
1159:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1160:             THIS.this_oBusinessObject.InserirLinhaPadrao()
1161:         ENDIF
1162: 
1163:         THIS.grd_4c_Dados.Refresh()
1164:         THIS.grd_4c_Dados.Column1.SetFocus()
1165:     ENDPROC
1166: 
1167:     *--------------------------------------------------------------------------
1168:     * BtnExcluirDetClick - cmdExcluir.Click do legado (guard de modo +
1169:     * remove a linha corrente)
1170:     *--------------------------------------------------------------------------
1171:     PROCEDURE BtnExcluirDetClick()
1172:         IF !THIS.GradeDetEditavel()
1173:             RETURN
1174:         ENDIF
1175: 
1176:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1177:             *-- Carrega a linha no BO ANTES de remove-la: depois do DELETE o
1178:             *-- ponteiro muda e nao ha mais como saber qual cidchaves saiu -
1179:             *-- eh ele que ObterChavePrimaria()/RegistrarAuditoria usam.
1180:             THIS.FormParaBO()
1181:             THIS.this_oBusinessObject.ExcluirLinhaAtual()
1182:         ENDIF
1183: 
1184:         THIS.grd_4c_Dados.SetFocus()
1185:         THIS.grd_4c_Dados.Refresh()
1186:     ENDPROC
1187: 
1188:     *--------------------------------------------------------------------------
1189:     * BtnConfirmarClick / BtnCancelarClick - btnConfirmar.Click e
1190:     * btnSair.Click do legado. O dump tem o MESMO corpo nos dois (Validacao
1191:     * + Release) - os dois handlers delegam para o mesmo metodo. PUBLIC
1192:     * (BINDEVENT - regra #3).
1193:     *--------------------------------------------------------------------------
1194:     PROCEDURE BtnConfirmarClick()
1195:         THIS.ConfirmarSelecaoDetExec()
1196:     ENDPROC
1197: 
1198:     PROCEDURE BtnCancelarClick()
1199:         THIS.ConfirmarSelecaoDetExec()
1200:     ENDPROC

