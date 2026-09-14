# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 1596: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1623: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1650: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1676: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1703: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1730: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1758: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1784: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigpdmp2.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2993 linhas total):

*-- Linhas 172 a 180:
172:                     THIS.ConfigurarContainerOperacao()
173:                     THIS.ConfigurarContainersAuxiliares()
174:                     THIS.ConfigurarPaginaLista()
175:                     THIS.ConfigurarCheckboxes()
176:                     THIS.ConfigurarContainer2()
177:                     THIS.ConfigurarPaginaDados()
178: 
179:                     *-- Tornar controles visiveis (filtrando containers flutuantes)
180:                     THIS.TornarControlesVisiveis(THIS)

*-- Linhas 204 a 247:
204:             THIS.AddObject("cnt_4c_Sombra", "Container")
205:             loc_oCnt = THIS.cnt_4c_Sombra
206:             WITH loc_oCnt
207:                 .Top         = 0
208:                 .Left        = 0
209:                 .Width       = 1100
210:                 .Height      = 80
211:                 .BackStyle   = 1
212:                 .BackColor   = RGB(100, 100, 100)
213:                 .BorderWidth = 0
214:                 .Visible     = .T.
215:             ENDWITH
216: 
217:             *-- lblSombra: label de sombra (preto) atras do titulo
218:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
219:             WITH loc_oCnt.lbl_4c_LblSombra
220:                 .Top       = 18
221:                 .Left      = 10
222:                 .Width     = 769
223:                 .Height    = 40
224:                 .Caption   = "Componentes"
225:                 .FontName  = "Tahoma"
226:                 .FontSize  = 18
227:                 .FontBold  = .T.
228:                 .ForeColor = RGB(0, 0, 0)
229:                 .BackStyle = 0
230:                 .WordWrap  = .T.
231:                 .Alignment = 0
232:                 .Visible   = .T.
233:             ENDWITH
234: 
235:             *-- lblTitulo: label branco sobre fundo cinza
236:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
237:             WITH loc_oCnt.lbl_4c_LblTitulo
238:                 .Top       = 17
239:                 .Left      = 10
240:                 .Width     = 769
241:                 .Height    = 46
242:                 .Caption   = "Componentes"
243:                 .FontName  = "Tahoma"
244:                 .FontSize  = 18
245:                 .FontBold  = .T.
246:                 .ForeColor = RGB(255, 255, 255)
247:                 .BackStyle = 0

*-- Linhas 267 a 276:
267:         TRY
268:             THIS.AddObject("cnt_4c_Operacao", "Container")
269:             WITH THIS.cnt_4c_Operacao
270:                 .Top           = 158
271:                 .Left          = 15
272:                 .Width         = 382
273:                 .Height        = 34
274:                 .BackStyle     = 0
275:                 .BorderWidth   = 0
276:                 .SpecialEffect = 0

*-- Linhas 299 a 334:
299:             *-- Container1: painel auxiliar oculto
300:             THIS.AddObject("cnt_4c_Container1", "Container")
301:             WITH THIS.cnt_4c_Container1
302:                 .Top         = 501
303:                 .Left        = 13
304:                 .Width       = 389
305:                 .Height      = 97
306:                 .BackStyle   = 0
307:                 .BackColor   = RGB(255, 255, 255)
308:                 .BorderWidth = 0
309:                 .Visible     = .F.
310:             ENDWITH
311: 
312:             *-- Cnt_Servico: painel de servicos (campos do servico da linha)
313:             THIS.AddObject("cnt_4c_Servico", "Container")
314:             WITH THIS.cnt_4c_Servico
315:                 .Top         = 501
316:                 .Left        = 404
317:                 .Width       = 371
318:                 .Height      = 97
319:                 .BackStyle   = 0
320:                 .BackColor   = RGB(255, 255, 255)
321:                 .BorderWidth = 0
322:                 .Visible     = .F.
323:             ENDWITH
324: 
325:             *-- Container2: painel de lotes (grid de lotes + botao OK)
326:             THIS.AddObject("cnt_4c_Container2", "Container")
327:             WITH THIS.cnt_4c_Container2
328:                 .Top         = 207
329:                 .Left        = 287
330:                 .Width       = 432
331:                 .Height      = 264
332:                 .BackStyle   = 1
333:                 .BackColor   = RGB(255, 255, 255)
334:                 .BorderWidth = 1

*-- Linhas 402 a 411:
402:             THIS.AddObject("grd_4c_Dados", "GridBase")
403:             loc_oGrd = THIS.grd_4c_Dados
404:             WITH loc_oGrd
405:                 .Top              = 189
406:                 .Left             = 13
407:                 .Width            = 890
408:                 .Height           = 309
409:                 .RecordSource     = "xNensi"
410:                 .RecordSourceType = 1
411:                 .ColumnCount      = 13

*-- Linhas 424 a 565:
424:             WITH loc_oCol
425:                 .Width           = 35
426:                 .ReadOnly        = .T.
427:                 .Header1.Caption = "OF / Envelope"
428:             ENDWITH
429:             loc_oCol.Controls(1).ControlSource = "xNensi.Seq"
430: 
431:             *-- Coluna 2: SigCdPro - produto (lookup)
432:             loc_oCol = loc_oGrd.Columns(2)
433:             WITH loc_oCol
434:                 .Width           = 70
435:                 .ReadOnly        = .F.
436:                 .Header1.Caption = "Componente"
437:             ENDWITH
438:             loc_oCtrl = loc_oCol.Controls(1)
439:             loc_oCtrl.ControlSource = "xNensi.SigCdPro"
440:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col2GotFocus")
441:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col2ValidarComponente")
442:             BINDEVENT(loc_oCtrl, "KeyPress", THIS, "Col2KeyPress")
443: 
444:             *-- Coluna 3: Descr (somente leitura - derivada do produto)
445:             loc_oCol = loc_oGrd.Columns(3)
446:             WITH loc_oCol
447:                 .Width           = 200
448:                 .ReadOnly        = .T.
449:                 .Header1.Caption = "Envelope"
450:             ENDWITH
451:             loc_oCol.Controls(1).ControlSource = "xNensi.Descr"
452: 
453:             *-- Coluna 4: CUnida - unidade principal (somente leitura)
454:             loc_oCol = loc_oGrd.Columns(4)
455:             WITH loc_oCol
456:                 .Width           = 45
457:                 .ReadOnly        = .T.
458:                 .Header1.Caption = "Uni"
459:             ENDWITH
460:             loc_oCol.Controls(1).ControlSource = "xNensi.CUnida"
461: 
462:             *-- Coluna 5: SigCdRpo - roteiro/processo (lookup com logica CodAcb/Peso)
463:             loc_oCol = loc_oGrd.Columns(5)
464:             WITH loc_oCol
465:                 .Width           = 60
466:                 .ReadOnly        = .F.
467:                 .Header1.Caption = "Peso Fabr."
468:             ENDWITH
469:             loc_oCtrl = loc_oCol.Controls(1)
470:             loc_oCtrl.ControlSource = "xNensi.SigCdRpo"
471:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col5GotFocus")
472:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col5ValidarRoteiro")
473: 
474:             *-- Coluna 6: CUniPs - unidade de pecas (somente leitura)
475:             loc_oCol = loc_oGrd.Columns(6)
476:             WITH loc_oCol
477:                 .Width           = 45
478:                 .ReadOnly        = .T.
479:                 .Header1.Caption = "Lote"
480:             ENDWITH
481:             loc_oCol.Controls(1).ControlSource = "xNensi.CUniPs"
482: 
483:             *-- Coluna 7: Qtde - quantidade principal
484:             loc_oCol = loc_oGrd.Columns(7)
485:             WITH loc_oCol
486:                 .Width           = 65
487:                 .ReadOnly        = .F.
488:                 .Header1.Caption = "Quantidade"
489:             ENDWITH
490:             loc_oCtrl = loc_oCol.Controls(1)
491:             loc_oCtrl.ControlSource = "xNensi.Qtde"
492:             loc_oCtrl.Format = "9999.999"
493:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col7GotFocus")
494:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col7ValidarQuantidade")
495: 
496:             *-- Coluna 8: SigCdSvc - servico (lookup em crSigCdSvc do pai)
497:             loc_oCol = loc_oGrd.Columns(8)
498:             WITH loc_oCol
499:                 .Width           = 60
500:                 .ReadOnly        = .F.
501:                 .Header1.Caption = "Cat."
502:             ENDWITH
503:             loc_oCtrl = loc_oCol.Controls(1)
504:             loc_oCtrl.ControlSource = "xNensi.SigCdSvc"
505:             BINDEVENT(loc_oCtrl, "When",  THIS, "Col8WhenServico")
506:             BINDEVENT(loc_oCtrl, "Valid", THIS, "Col8ValidarServico")
507: 
508:             *-- Coluna 9: Qtps - quantidade em pecas
509:             loc_oCol = loc_oGrd.Columns(9)
510:             WITH loc_oCol
511:                 .Width           = 65
512:                 .ReadOnly        = .F.
513:                 .Header1.Caption = "Saldo"
514:             ENDWITH
515:             loc_oCtrl = loc_oCol.Controls(1)
516:             loc_oCtrl.ControlSource = "xNensi.Qtps"
517:             loc_oCtrl.Format = "9999.999"
518:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col9GotFocus")
519:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col9ValidarQtps")
520: 
521:             *-- Coluna 10: SigCdTma - tipo de material (lookup)
522:             loc_oCol = loc_oGrd.Columns(10)
523:             WITH loc_oCol
524:                 .Width           = 60
525:                 .ReadOnly        = .F.
526:                 .Header1.Caption = "Tipo de Material"
527:             ENDWITH
528:             loc_oCtrl = loc_oCol.Controls(1)
529:             loc_oCtrl.ControlSource = "xNensi.SigCdTma"
530:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col10GotFocus")
531:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col10ValidarTipoMaterial")
532: 
533:             *-- Coluna 11: RepRetrab - sempre oculta (gerenciada via BO legado)
534:             loc_oCol = loc_oGrd.Columns(11)
535:             WITH loc_oCol
536:                 .Width           = 1
537:                 .ReadOnly        = .T.
538:                 .Visible         = .F.
539:                 .Header1.Caption = ""
540:             ENDWITH
541:             loc_oCol.Controls(1).ControlSource = "xNensi.RepRetrab"
542: 
543:             *-- Coluna 12: Cors - cor (dinamica: Width=1 ate grupo ter Cores=.T.)
544:             loc_oCol = loc_oGrd.Columns(12)
545:             WITH loc_oCol
546:                 .Width           = 1
547:                 .ReadOnly        = .F.
548:                 .Header1.Caption = "Cor"
549:             ENDWITH
550:             loc_oCtrl = loc_oCol.Controls(1)
551:             loc_oCtrl.ControlSource = "xNensi.Cors"
552:             BINDEVENT(loc_oCtrl, "When",  THIS, "Col12WhenCor")
553:             BINDEVENT(loc_oCtrl, "Valid", THIS, "Col12ValidarCor")
554: 
555:             *-- Coluna 13: Tams - tamanho (dinamica: Width=1 ate grupo ter Tams=.T.)
556:             loc_oCol = loc_oGrd.Columns(13)
557:             WITH loc_oCol
558:                 .Width           = 1
559:                 .ReadOnly        = .F.
560:                 .Header1.Caption = "Tam"
561:             ENDWITH
562:             loc_oCtrl = loc_oCol.Controls(1)
563:             loc_oCtrl.ControlSource = "xNensi.Tams"
564:             BINDEVENT(loc_oCtrl, "When",  THIS, "Col13WhenTamanho")
565:             BINDEVENT(loc_oCtrl, "Valid", THIS, "Col13ValidarTamanho")

*-- Linhas 581 a 590:
581:         TRY
582:             IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi")
583:                 *-- Atualiza descricao e observacao abaixo do grid
584:                 IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
585:                     THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
586:                 ENDIF
587:                 IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
588:                     THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
589:                     THIS.txt_4c_GetObs.Refresh()
590:                 ENDIF

*-- Linhas 1061 a 1159:
1061: 
1062:         TRY
1063:             *-- Botao Sair (ok): valida todos os componentes e fecha o form
1064:             THIS.AddObject("cmd_4c_Sair", "CommandButton")
1065:             loc_oBtn = THIS.cmd_4c_Sair
1066:             WITH loc_oBtn
1067:                 .Top      = 2
1068:                 .Left     = 921
1069:                 .Width    = 75
1070:                 .Height   = 75
1071:                 .Caption  = "Encerrar"
1072:                 .FontName = "Tahoma"
1073:                 .FontSize = 8
1074:                 .Visible  = .T.
1075:             ENDWITH
1076:             BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
1077: 
1078:             *-- Botao Lotes: toggle do painel de lotes (cnt_4c_Container2)
1079:             THIS.AddObject("cmd_4c_Lotes", "CommandButton")
1080:             loc_oBtn = THIS.cmd_4c_Lotes
1081:             WITH loc_oBtn
1082:                 .Top      = 81
1083:                 .Left     = 846
1084:                 .Width    = 75
1085:                 .Height   = 75
1086:                 .Caption  = "Lotes"
1087:                 .FontName = "Tahoma"
1088:                 .FontSize = 8
1089:                 .Visible  = .T.
1090:             ENDWITH
1091:             BINDEVENT(THIS.cmd_4c_Lotes, "Click", THIS, "BtnLotesClick")
1092: 
1093:             *-- Botao EncerraPCC: oculto ate crSigCdOpd.Pccs = .T.
1094:             THIS.AddObject("cmd_4c_EncerraPCC", "CommandButton")
1095:             loc_oBtn = THIS.cmd_4c_EncerraPCC
1096:             WITH loc_oBtn
1097:                 .Top      = 81
1098:                 .Left     = 771
1099:                 .Width    = 75
1100:                 .Height   = 75
1101:                 .Caption  = "Encerra" + CHR(10) + "PCC"
1102:                 .FontName = "Tahoma"
1103:                 .FontSize = 8
1104:                 .Visible  = .F.
1105:             ENDWITH
1106:             BINDEVENT(THIS.cmd_4c_EncerraPCC, "Click", THIS, "BtnEncerraPCCClick")
1107: 
1108:             *-- Botao Inserir: adiciona nova linha em xNensi
1109:             THIS.AddObject("cmd_4c_Inserir", "CommandButton")
1110:             loc_oBtn = THIS.cmd_4c_Inserir
1111:             WITH loc_oBtn
1112:                 .Top      = 222
1113:                 .Left     = 906
1114:                 .Width    = 75
1115:                 .Height   = 75
1116:                 .Caption  = "Inserir"
1117:                 .FontName = "Tahoma"
1118:                 .FontSize = 8
1119:                 .Visible  = .T.
1120:                 .Enabled  = !THIS.InibeInserir
1121:             ENDWITH
1122:             BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")
1123: 
1124:             *-- Botao Alterar: abre SigPdM14 para edicao detalhada
1125:             THIS.AddObject("cmd_4c_Alterar", "CommandButton")
1126:             loc_oBtn = THIS.cmd_4c_Alterar
1127:             WITH loc_oBtn
1128:                 .Top      = 297
1129:                 .Left     = 906
1130:                 .Width    = 75
1131:                 .Height   = 75
1132:                 .Caption  = "Alterar"
1133:                 .FontName = "Tahoma"
1134:                 .FontSize = 8
1135:                 .Visible  = .T.
1136:                 .Enabled  = !THIS.InibeAlterar
1137:             ENDWITH
1138:             BINDEVENT(THIS.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
1139: 
1140:             *-- Botao Excluir: remove linha corrente de xNensi
1141:             THIS.AddObject("cmd_4c_Excluir", "CommandButton")
1142:             loc_oBtn = THIS.cmd_4c_Excluir
1143:             WITH loc_oBtn
1144:                 .Top      = 372
1145:                 .Left     = 906
1146:                 .Width    = 75
1147:                 .Height   = 75
1148:                 .Caption  = "Excluir"
1149:                 .FontName = "Tahoma"
1150:                 .FontSize = 8
1151:                 .Visible  = .T.
1152:                 .Enabled  = !THIS.InibeExcluir
1153:             ENDWITH
1154:             BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
1155: 
1156:         CATCH TO loc_oErro
1157:             MsgErro(loc_oErro.Message, "Erro ao configurar bot" + CHR(245) + "es principais")
1158:         ENDTRY
1159:     ENDPROC

*-- Linhas 1517 a 1538:
1517:             ENDIF
1518: 
1519:             *-- Desabilita botoes de manipulacao (mantem Sair e Lotes habilitados)
1520:             IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
1521:                 THIS.cmd_4c_Inserir.Enabled = .F.
1522:             ENDIF
1523:             IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
1524:                 THIS.cmd_4c_Alterar.Enabled = .F.
1525:             ENDIF
1526:             IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
1527:                 THIS.cmd_4c_Excluir.Enabled = .F.
1528:             ENDIF
1529:             IF PEMSTATUS(THIS, "cmd_4c_EncerraPCC", 5)
1530:                 THIS.cmd_4c_EncerraPCC.Enabled = .F.
1531:             ENDIF
1532: 
1533:             *-- Desabilita checkboxes que disparam formularios de edicao
1534:             IF PEMSTATUS(THIS, "chk_4c_Retrabalho", 5)
1535:                 THIS.chk_4c_Retrabalho.Enabled = .F.
1536:             ENDIF
1537:             IF PEMSTATUS(THIS, "chk_4c_Pagto", 5)
1538:                 THIS.chk_4c_Pagto.Enabled = .F.

*-- Linhas 1562 a 1801:
1562:     ENDPROC
1563: 
1564:     *==========================================================================
1565:     * ConfigurarCheckboxes - 8 checkboxes de controle (Top=81)
1566:     * Todos: Width=75, Height=75, Style=1(PictureButton), FontName="Comic Sans MS"
1567:     *   chk_4c_Retrabalho (Left=171): abre SigPdM12 (informar retrabalho)
1568:     *   chk_4c_RepeteMat  (Left=246): repete tipo material (flag de estado)
1569:     *   chk_4c_InserirAuto(Left=321): insercao automatica (flag de estado)
1570:     *   chk_4c_Pagto      (Left=396): abre SigPrSer (pagamento)
1571:     *   chk_4c_RetrabAnt  (Left=471): abre SigPdM12 (retrabalho realizado)
1572:     *   chk_4c_Naoconforme(Left=546): abre SigPdMp8 (nao conformidade)
1573:     *   chk_4c_RepRetrab  (Left=621): sempre Visible=.F.
1574:     *   chk_4c_Agregado   (Left=696): abre SigPdMp1 (material agregado)
1575:     *==========================================================================
1576:     PROTECTED PROCEDURE ConfigurarCheckboxes()
1577:         LOCAL loc_oChk, loc_oErro
1578: 
1579:         TRY
1580:             *-- chk_4c_Retrabalho: abre form de retrabalho (SigPdM12)
1581:             THIS.AddObject("chk_4c_Retrabalho", "CheckBox")
1582:             loc_oChk = THIS.chk_4c_Retrabalho
1583:             WITH loc_oChk
1584:                 .Top             = 81
1585:                 .Left            = 171
1586:                 .Width           = 75
1587:                 .Height          = 75
1588:                 .Caption         = "Informar Re\<trabalho"
1589:                 .Value           = 0
1590:                 .Style           = 1
1591:                 .WordWrap        = .T.
1592:                 .Alignment       = 2
1593:                 .PicturePosition = 7
1594:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1595:                 .MousePointer    = 15
1596:                 .FontName        = "Comic Sans MS"
1597:                 .FontBold        = .T.
1598:                 .FontItalic      = .T.
1599:                 .FontSize        = 8
1600:                 .ForeColor       = RGB(90, 90, 90)
1601:                 .BackColor       = RGB(255, 255, 255)
1602:                 .Themes          = .F.
1603:                 .Visible         = .T.
1604:             ENDWITH
1605:             BINDEVENT(THIS.chk_4c_Retrabalho, "Click", THIS, "ChkRetrabalhoClick")
1606: 
1607:             *-- chk_4c_RepeteMat: repete tipo de material da linha anterior
1608:             THIS.AddObject("chk_4c_RepeteMat", "CheckBox")
1609:             loc_oChk = THIS.chk_4c_RepeteMat
1610:             WITH loc_oChk
1611:                 .Top             = 81
1612:                 .Left            = 246
1613:                 .Width           = 75
1614:                 .Height          = 75
1615:                 .Caption         = "\<Repete Tipo Material"
1616:                 .Value           = 0
1617:                 .Style           = 1
1618:                 .WordWrap        = .T.
1619:                 .Alignment       = 2
1620:                 .PicturePosition = 7
1621:                 .Picture         = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
1622:                 .MousePointer    = 15
1623:                 .FontName        = "Comic Sans MS"
1624:                 .FontBold        = .T.
1625:                 .FontItalic      = .T.
1626:                 .FontSize        = 8
1627:                 .ForeColor       = RGB(90, 90, 90)
1628:                 .BackColor       = RGB(255, 255, 255)
1629:                 .Themes          = .F.
1630:                 .Visible         = .T.
1631:             ENDWITH
1632:             BINDEVENT(THIS.chk_4c_RepeteMat, "Click", THIS, "ChkRepeteMatClick")
1633: 
1634:             *-- chk_4c_InserirAuto: insercao automatica apos preencher linha
1635:             THIS.AddObject("chk_4c_InserirAuto", "CheckBox")
1636:             loc_oChk = THIS.chk_4c_InserirAuto
1637:             WITH loc_oChk
1638:                 .Top             = 81
1639:                 .Left            = 321
1640:                 .Width           = 75
1641:                 .Height          = 75
1642:                 .Caption         = "Inserir A\<utom" + CHR(225) + "tico"
1643:                 .Value           = 0
1644:                 .Style           = 1
1645:                 .WordWrap        = .T.
1646:                 .Alignment       = 2
1647:                 .PicturePosition = 7
1648:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1649:                 .MousePointer    = 15
1650:                 .FontName        = "Comic Sans MS"
1651:                 .FontBold        = .T.
1652:                 .FontItalic      = .T.
1653:                 .FontSize        = 8
1654:                 .ForeColor       = RGB(90, 90, 90)
1655:                 .BackColor       = RGB(255, 255, 255)
1656:                 .Themes          = .F.
1657:                 .Visible         = .T.
1658:             ENDWITH
1659: 
1660:             *-- chk_4c_Pagto: pagamento lancado - abre SigPrSer
1661:             THIS.AddObject("chk_4c_Pagto", "CheckBox")
1662:             loc_oChk = THIS.chk_4c_Pagto
1663:             WITH loc_oChk
1664:                 .Top             = 81
1665:                 .Left            = 396
1666:                 .Width           = 75
1667:                 .Height          = 75
1668:                 .Caption         = "\<Pagamento Lan" + CHR(231) + "ado"
1669:                 .Value           = 0
1670:                 .Style           = 1
1671:                 .WordWrap        = .T.
1672:                 .Alignment       = 2
1673:                 .PicturePosition = 7
1674:                 .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
1675:                 .MousePointer    = 15
1676:                 .FontName        = "Comic Sans MS"
1677:                 .FontBold        = .T.
1678:                 .FontItalic      = .T.
1679:                 .FontSize        = 8
1680:                 .ForeColor       = RGB(90, 90, 90)
1681:                 .BackColor       = RGB(255, 255, 255)
1682:                 .Themes          = .F.
1683:                 .Visible         = .T.
1684:             ENDWITH
1685:             BINDEVENT(THIS.chk_4c_Pagto, "Click", THIS, "ChkPagtoClick")
1686: 
1687:             *-- chk_4c_RetrabAnt: retrabalho realizado - abre SigPdM12
1688:             THIS.AddObject("chk_4c_RetrabAnt", "CheckBox")
1689:             loc_oChk = THIS.chk_4c_RetrabAnt
1690:             WITH loc_oChk
1691:                 .Top             = 81
1692:                 .Left            = 471
1693:                 .Width           = 75
1694:                 .Height          = 75
1695:                 .Caption         = "Retrabalho Reali\<zado"
1696:                 .Value           = 0
1697:                 .Style           = 1
1698:                 .WordWrap        = .T.
1699:                 .Alignment       = 2
1700:                 .PicturePosition = 7
1701:                 .Picture         = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
1702:                 .MousePointer    = 15
1703:                 .FontName        = "Comic Sans MS"
1704:                 .FontBold        = .T.
1705:                 .FontItalic      = .T.
1706:                 .FontSize        = 8
1707:                 .ForeColor       = RGB(90, 90, 90)
1708:                 .BackColor       = RGB(255, 255, 255)
1709:                 .Themes          = .F.
1710:                 .Visible         = .T.
1711:             ENDWITH
1712:             BINDEVENT(THIS.chk_4c_RetrabAnt, "Click", THIS, "ChkRetrabAntClick")
1713: 
1714:             *-- chk_4c_Naoconforme: nao conforme - abre SigPdMp8
1715:             THIS.AddObject("chk_4c_Naoconforme", "CheckBox")
1716:             loc_oChk = THIS.chk_4c_Naoconforme
1717:             WITH loc_oChk
1718:                 .Top             = 81
1719:                 .Left            = 546
1720:                 .Width           = 75
1721:                 .Height          = 75
1722:                 .Caption         = "\<N" + CHR(227) + "o Conformes"
1723:                 .Value           = 0
1724:                 .Style           = 1
1725:                 .WordWrap        = .T.
1726:                 .Alignment       = 2
1727:                 .PicturePosition = 7
1728:                 .Picture         = gc_4c_CaminhoIcones + "geral_defrag_60.jpg"
1729:                 .MousePointer    = 15
1730:                 .FontName        = "Comic Sans MS"
1731:                 .FontBold        = .T.
1732:                 .FontItalic      = .T.
1733:                 .FontSize        = 8
1734:                 .ForeColor       = RGB(90, 90, 90)
1735:                 .BackColor       = RGB(255, 255, 255)
1736:                 .Themes          = .F.
1737:                 .Visible         = .T.
1738:             ENDWITH
1739:             BINDEVENT(THIS.chk_4c_Naoconforme, "Click", THIS, "ChkNaoConformeClick")
1740: 
1741:             *-- chk_4c_RepRetrab: repete retrabalho - sempre oculto (Visible=.F.)
1742:             *-- Filtrado em TornarControlesVisiveis - gerenciado pela logica de negocio
1743:             THIS.AddObject("chk_4c_RepRetrab", "CheckBox")
1744:             loc_oChk = THIS.chk_4c_RepRetrab
1745:             WITH loc_oChk
1746:                 .Top             = 81
1747:                 .Left            = 621
1748:                 .Width           = 75
1749:                 .Height          = 75
1750:                 .Caption         = "R\<epete Retrabalho"
1751:                 .Value           = 0
1752:                 .Style           = 1
1753:                 .WordWrap        = .T.
1754:                 .Alignment       = 2
1755:                 .PicturePosition = 7
1756:                 .Picture         = gc_4c_CaminhoIcones + "geral_adicao_60.jpg"
1757:                 .MousePointer    = 15
1758:                 .FontName        = "Comic Sans MS"
1759:                 .FontBold        = .T.
1760:                 .FontItalic      = .T.
1761:                 .FontSize        = 8
1762:                 .ForeColor       = RGB(90, 90, 90)
1763:                 .BackColor       = RGB(255, 255, 255)
1764:                 .Themes          = .F.
1765:                 .Visible         = .F.
1766:             ENDWITH
1767: 
1768:             *-- chk_4c_Agregado: material agregado - abre SigPdMp1
1769:             THIS.AddObject("chk_4c_Agregado", "CheckBox")
1770:             loc_oChk = THIS.chk_4c_Agregado
1771:             WITH loc_oChk
1772:                 .Top             = 81
1773:                 .Left            = 696
1774:                 .Width           = 75
1775:                 .Height          = 75
1776:                 .Caption         = "\<Material Agregado"
1777:                 .Value           = 0
1778:                 .Style           = 1
1779:                 .WordWrap        = .T.
1780:                 .Alignment       = 2
1781:                 .PicturePosition = 7
1782:                 .Picture         = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
1783:                 .MousePointer    = 15
1784:                 .FontName        = "Comic Sans MS"
1785:                 .FontBold        = .T.
1786:                 .FontItalic      = .T.
1787:                 .FontSize        = 8
1788:                 .ForeColor       = RGB(90, 90, 90)
1789:                 .BackColor       = RGB(255, 255, 255)
1790:                 .Themes          = .F.
1791:                 .Visible         = .T.
1792:             ENDWITH
1793:             BINDEVENT(THIS.chk_4c_Agregado, "Click", THIS, "ChkAgregadoClick")
1794: 
1795:         CATCH TO loc_oErro
1796:             MsgErro(loc_oErro.Message, "Erro ao configurar checkboxes")
1797:         ENDTRY
1798:     ENDPROC
1799: 
1800:     *==========================================================================
1801:     * ChkRetrabalhoClick - Abre SigPdM12 para informar retrabalho

*-- Linhas 1911 a 1920:
1911:             loc_oCnt.AddObject("grd_4c_Lotes", "GridBase")
1912:             loc_oGrd = loc_oCnt.grd_4c_Lotes
1913:             WITH loc_oGrd
1914:                 .Top              = 10
1915:                 .Left             = 5
1916:                 .Width            = 420
1917:                 .Height           = 218
1918:                 .RecordSource     = "TmpNens"
1919:                 .RecordSourceType = 1
1920:                 .ColumnCount      = 3

*-- Linhas 1928 a 1964:
1928:             *-- Coluna 1: Lote
1929:             loc_oCol = loc_oGrd.Columns(1)
1930:             loc_oCol.Width           = 160
1931:             loc_oCol.Header1.Caption = "Lote"
1932:             loc_oCol.Controls(1).ControlSource = "TmpNens.Lote"
1933: 
1934:             *-- Coluna 2: Qtde do lote
1935:             loc_oCol = loc_oGrd.Columns(2)
1936:             loc_oCol.Width           = 120
1937:             loc_oCol.Header1.Caption = "Quantidade"
1938:             loc_oCol.Controls(1).ControlSource = "TmpNens.Qtde"
1939: 
1940:             *-- Coluna 3: Prazo/Vencimento
1941:             loc_oCol = loc_oGrd.Columns(3)
1942:             loc_oCol.Width           = 120
1943:             loc_oCol.Header1.Caption = "Saldo"
1944:             loc_oCol.Controls(1).ControlSource = "TmpNens.Prazo"
1945: 
1946:             *-- Botao OK: fecha o painel de lotes
1947:             loc_oCnt.AddObject("cmd_4c_OkLotes", "CommandButton")
1948:             loc_oBtn = loc_oCnt.cmd_4c_OkLotes
1949:             WITH loc_oBtn
1950:                 .Top      = 232
1951:                 .Left     = 170
1952:                 .Width    = 80
1953:                 .Height   = 24
1954:                 .Caption  = "OK"
1955:                 .FontName = "Tahoma"
1956:                 .FontSize = 8
1957:                 .Visible  = .T.
1958:             ENDWITH
1959:             BINDEVENT(loc_oCnt.cmd_4c_OkLotes, "Click", THIS, "BtnOkLotesClick")
1960: 
1961:         CATCH TO loc_oErro
1962:             MsgErro(loc_oErro.Message, "Erro ao configurar painel de lotes")
1963:         ENDTRY
1964:     ENDPROC

*-- Linhas 1988 a 2018:
1988:                 GO TOP IN crSigCdOpd
1989:                 loc_lPccs = (VARTYPE(crSigCdOpd.Pccs) = "L" AND crSigCdOpd.Pccs = .T.)
1990:             ENDIF
1991:             IF PEMSTATUS(THIS, "cmd_4c_EncerraPCC", 5)
1992:                 THIS.cmd_4c_EncerraPCC.Visible = loc_lPccs
1993:             ENDIF
1994: 
1995:             *-- Botoes CRUD: Enabled baseado nas flags Inibe*
1996:             IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
1997:                 THIS.cmd_4c_Inserir.Enabled = !THIS.InibeInserir
1998:             ENDIF
1999:             IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
2000:                 THIS.cmd_4c_Alterar.Enabled = !THIS.InibeAlterar
2001:             ENDIF
2002:             IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
2003:                 THIS.cmd_4c_Excluir.Enabled = !THIS.InibeExcluir
2004:             ENDIF
2005: 
2006:             *-- Grade: posiciona no primeiro registro e atualiza GetDescr/GetObs
2007:             IF USED("xNensi") AND RECCOUNT("xNensi") > 0
2008:                 GO TOP IN xNensi
2009:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2010:                     THIS.grd_4c_Dados.Refresh()
2011:                 ENDIF
2012:                 IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
2013:                     THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
2014:                 ENDIF
2015:                 IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
2016:                     THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
2017:                 ENDIF
2018:             ENDIF

*-- Linhas 2077 a 2103:
2077:             *------------------------------------------------------------------
2078:             loc_oCnt = THIS.cnt_4c_Operacao
2079: 
2080:             loc_oCnt.AddObject("lbl_4c_Say4", "Label")
2081:             WITH loc_oCnt.lbl_4c_Say4
2082:                 .Top       = 9
2083:                 .Left      = 19
2084:                 .Width     = 78
2085:                 .Height    = 15
2086:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
2087:                 .FontName  = "Tahoma"
2088:                 .FontSize  = 8
2089:                 .BackStyle = 0
2090:                 .ForeColor = RGB(0, 0, 0)
2091:                 .Visible   = .T.
2092:             ENDWITH
2093: 
2094:             *-- GetEmpresa: codigo da empresa - preenchido em ConfigurarEstadoInicial
2095:             loc_oCnt.AddObject("txt_4c_Empresa", "TextBox")
2096:             WITH loc_oCnt.txt_4c_Empresa
2097:                 .Top         = 5
2098:                 .Left        = 99
2099:                 .Width       = 36
2100:                 .Height      = 23
2101:                 .ReadOnly    = .T.
2102:                 .FontName    = "Tahoma"
2103:                 .FontSize    = 8

*-- Linhas 2109 a 2118:
2109:             *-- GetOperacao: descricao/numero da OP - preenchido em ConfigurarEstadoInicial
2110:             loc_oCnt.AddObject("txt_4c_OperacaoOp", "TextBox")
2111:             WITH loc_oCnt.txt_4c_OperacaoOp
2112:                 .Top         = 5
2113:                 .Left        = 137
2114:                 .Width       = 156
2115:                 .Height      = 23
2116:                 .ReadOnly    = .T.
2117:                 .FontName    = "Tahoma"
2118:                 .FontSize    = 8

*-- Linhas 2124 a 2133:
2124:             *-- GetCodigo: codigo prog (P+Ndopps) - preenchido em ConfigurarEstadoInicial
2125:             loc_oCnt.AddObject("txt_4c_CodigoOp", "TextBox")
2126:             WITH loc_oCnt.txt_4c_CodigoOp
2127:                 .Top         = 5
2128:                 .Left        = 295
2129:                 .Width       = 81
2130:                 .Height      = 23
2131:                 .ReadOnly    = .T.
2132:                 .FontName    = "Tahoma"
2133:                 .FontSize    = 8

*-- Linhas 2142 a 2151:
2142:             *------------------------------------------------------------------
2143:             THIS.AddObject("shp_4c_Shape2", "Shape")
2144:             WITH THIS.shp_4c_Shape2
2145:                 .Top         = 7
2146:                 .Left        = 10
2147:                 .Width       = 812
2148:                 .Height      = 12
2149:                 .BackStyle   = 1
2150:                 .BackColor   = RGB(53, 53, 53)
2151:                 .BorderStyle = 0

*-- Linhas 2158 a 2183:
2158:             * get_Cor: ligado a xNensi.Cors (Left=108, Width=32, Top=506)
2159:             * get_Tam: ligado a xNensi.Tams (Left=143, Width=32, Top=506)
2160:             *------------------------------------------------------------------
2161:             THIS.AddObject("lbl_4c_Label3", "Label")
2162:             WITH THIS.lbl_4c_Label3
2163:                 .Top       = 510
2164:                 .Left      = 32
2165:                 .Width     = 74
2166:                 .Height    = 15
2167:                 .Caption   = "Cor/Tamanho :"
2168:                 .FontName  = "Tahoma"
2169:                 .FontSize  = 8
2170:                 .BackStyle = 0
2171:                 .ForeColor = RGB(0, 0, 0)
2172:                 .Visible   = .T.
2173:             ENDWITH
2174: 
2175:             THIS.AddObject("txt_4c_GetCor", "TextBox")
2176:             WITH THIS.txt_4c_GetCor
2177:                 .Top           = 506
2178:                 .Left          = 108
2179:                 .Width         = 32
2180:                 .Height        = 23
2181:                 .ReadOnly      = .T.
2182:                 .FontName      = "Tahoma"
2183:                 .FontSize      = 8

*-- Linhas 2189 a 2198:
2189: 
2190:             THIS.AddObject("txt_4c_GetTam", "TextBox")
2191:             WITH THIS.txt_4c_GetTam
2192:                 .Top           = 506
2193:                 .Left          = 143
2194:                 .Width         = 32
2195:                 .Height        = 23
2196:                 .ReadOnly      = .T.
2197:                 .FontName      = "Tahoma"
2198:                 .FontSize      = 8

*-- Linhas 2205 a 2236:
2205:             *------------------------------------------------------------------
2206:             * Area de Descricao - Get_descr/Say2 com posicoes corretas do original
2207:             * Say2 (label): Top=533, Left=51, Caption="Descri??o :"
2208:             * lbl_4c_GetDescr: Top=529, Left=108, Width=490 (exibe xNensi.Descr)
2209:             * Nota: movido de ConfigurarGradePrincipal onde estava em Top=128 (errado)
2210:             *------------------------------------------------------------------
2211:             THIS.AddObject("lbl_4c_Say2", "Label")
2212:             WITH THIS.lbl_4c_Say2
2213:                 .Top       = 533
2214:                 .Left      = 51
2215:                 .Width     = 55
2216:                 .Height    = 15
2217:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
2218:                 .FontName  = "Tahoma"
2219:                 .FontSize  = 8
2220:                 .BackStyle = 0
2221:                 .ForeColor = RGB(0, 0, 0)
2222:                 .Visible   = .T.
2223:             ENDWITH
2224: 
2225:             THIS.AddObject("lbl_4c_GetDescr", "Label")
2226:             WITH THIS.lbl_4c_GetDescr
2227:                 .Top       = 529
2228:                 .Left      = 108
2229:                 .Width     = 490
2230:                 .Height    = 18
2231:                 .Caption   = ""
2232:                 .FontName  = "Tahoma"
2233:                 .FontSize  = 8
2234:                 .BackStyle = 0
2235:                 .ForeColor = RGB(0, 0, 0)
2236:                 .Visible   = .T.

*-- Linhas 2242 a 2267:
2242:             * txt_4c_GetObs: Top=552, Left=108, Width=290
2243:             * Nota: movido de ConfigurarGradePrincipal onde estava em Top=126 (errado)
2244:             *------------------------------------------------------------------
2245:             THIS.AddObject("lbl_4c_Say3", "Label")
2246:             WITH THIS.lbl_4c_Say3
2247:                 .Top       = 556
2248:                 .Left      = 39
2249:                 .Width     = 67
2250:                 .Height    = 15
2251:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
2252:                 .FontName  = "Tahoma"
2253:                 .FontSize  = 8
2254:                 .BackStyle = 0
2255:                 .ForeColor = RGB(0, 0, 0)
2256:                 .Visible   = .T.
2257:             ENDWITH
2258: 
2259:             THIS.AddObject("txt_4c_GetObs", "TextBox")
2260:             WITH THIS.txt_4c_GetObs
2261:                 .Top         = 552
2262:                 .Left        = 108
2263:                 .Width       = 290
2264:                 .Height      = 23
2265:                 .ReadOnly    = .T.
2266:                 .FontName    = "Tahoma"
2267:                 .FontSize    = 8

*-- Linhas 2343 a 2370:
2343:             loc_oCnt = THIS.cnt_4c_Servico
2344: 
2345:             *-- Label2: "Servico :" - rotulo de txt_4c_GetCpro
2346:             loc_oCnt.AddObject("lbl_4c_Label2", "Label")
2347:             WITH loc_oCnt.lbl_4c_Label2
2348:                 .Top       = 5
2349:                 .Left      = 31
2350:                 .Width     = 44
2351:                 .Height    = 15
2352:                 .Caption   = "Servi" + CHR(231) + "o :"
2353:                 .AutoSize  = .T.
2354:                 .FontName  = "Tahoma"
2355:                 .FontSize  = 8
2356:                 .BackStyle = 0
2357:                 .ForeColor = RGB(90, 90, 90)
2358:                 .Visible   = .T.
2359:             ENDWITH
2360: 
2361:             *-- txt_4c_GetCpro: codigo do material do servico (ReadOnly)
2362:             loc_oCnt.AddObject("txt_4c_GetCpro", "TextBox")
2363:             WITH loc_oCnt.txt_4c_GetCpro
2364:                 .Top           = 2
2365:                 .Left          = 77
2366:                 .Width         = 113
2367:                 .Height        = 23
2368:                 .ControlSource = "xNensi.cMats"
2369:                 .ReadOnly      = .T.
2370:                 .MaxLength     = 14

*-- Linhas 2378 a 2419:
2378:             *-- txt_4c_GetDpro: descricao do servico (ReadOnly)
2379:             loc_oCnt.AddObject("txt_4c_GetDpro", "TextBox")
2380:             WITH loc_oCnt.txt_4c_GetDpro
2381:                 .Top           = 25
2382:                 .Left          = 77
2383:                 .Width         = 290
2384:                 .Height        = 23
2385:                 .ControlSource = "xNensi.cdescs"
2386:                 .ReadOnly      = .T.
2387:                 .SpecialEffect = 1
2388:                 .FontName      = "Tahoma"
2389:                 .FontSize      = 8
2390:                 .BorderColor   = RGB(100, 100, 100)
2391:                 .Visible       = .T.
2392:             ENDWITH
2393: 
2394:             *-- Label4: "Valor :" - rotulo de txt_4c_GetValor
2395:             loc_oCnt.AddObject("lbl_4c_Label4", "Label")
2396:             WITH loc_oCnt.lbl_4c_Label4
2397:                 .Top       = 52
2398:                 .Left      = 42
2399:                 .Width     = 33
2400:                 .Height    = 15
2401:                 .Caption   = "Valor :"
2402:                 .AutoSize  = .T.
2403:                 .FontName  = "Tahoma"
2404:                 .FontSize  = 8
2405:                 .BackStyle = 0
2406:                 .ForeColor = RGB(90, 90, 90)
2407:                 .Visible   = .T.
2408:             ENDWITH
2409: 
2410:             *-- txt_4c_GetValor: valor unitario do servico (editavel se AlteraServico)
2411:             loc_oCnt.AddObject("txt_4c_GetValor", "TextBox")
2412:             WITH loc_oCnt.txt_4c_GetValor
2413:                 .Top           = 48
2414:                 .Left          = 77
2415:                 .Width         = 80
2416:                 .Height        = 23
2417:                 .ControlSource = "xNensi.fators"
2418:                 .InputMask     = "999,999.99"
2419:                 .MaxLength     = 12

*-- Linhas 2427 a 2468:
2427:             *-- txt_4c_GetMoeda: codigo da moeda (editavel se AlteraServico, lookup SigCdMoe)
2428:             loc_oCnt.AddObject("txt_4c_GetMoeda", "TextBox")
2429:             WITH loc_oCnt.txt_4c_GetMoeda
2430:                 .Top           = 48
2431:                 .Left          = 157
2432:                 .Width         = 31
2433:                 .Height        = 23
2434:                 .ControlSource = "xNensi.moedas"
2435:                 .MaxLength     = 3
2436:                 .SpecialEffect = 1
2437:                 .FontName      = "Tahoma"
2438:                 .FontSize      = 8
2439:                 .BorderColor   = RGB(100, 100, 100)
2440:                 .Visible       = .T.
2441:             ENDWITH
2442: 
2443:             *-- Label1: "Quantidade :" - rotulo de txt_4c_GetQtde
2444:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
2445:             WITH loc_oCnt.lbl_4c_Label1
2446:                 .Top       = 52
2447:                 .Left      = 220
2448:                 .Width     = 65
2449:                 .Height    = 15
2450:                 .Caption   = "Quantidade :"
2451:                 .AutoSize  = .T.
2452:                 .FontName  = "Tahoma"
2453:                 .FontSize  = 8
2454:                 .BackStyle = 0
2455:                 .ForeColor = RGB(90, 90, 90)
2456:                 .Visible   = .T.
2457:             ENDWITH
2458: 
2459:             *-- txt_4c_GetQtde: quantidade do componente (ReadOnly)
2460:             loc_oCnt.AddObject("txt_4c_GetQtde", "TextBox")
2461:             WITH loc_oCnt.txt_4c_GetQtde
2462:                 .Top           = 48
2463:                 .Left          = 287
2464:                 .Width         = 80
2465:                 .Height        = 23
2466:                 .ControlSource = "xNensi.qtds"
2467:                 .InputMask     = "999,999.999"
2468:                 .MaxLength     = 12

*-- Linhas 2475 a 2503:
2475:             ENDWITH
2476: 
2477:             *-- Label5: "Total :" (negrito) - rotulo de txt_4c_GetTotal
2478:             loc_oCnt.AddObject("lbl_4c_Label5", "Label")
2479:             WITH loc_oCnt.lbl_4c_Label5
2480:                 .Top       = 75
2481:                 .Left      = 248
2482:                 .Width     = 37
2483:                 .Height    = 15
2484:                 .Caption   = "Total :"
2485:                 .AutoSize  = .T.
2486:                 .FontBold  = .T.
2487:                 .FontName  = "Tahoma"
2488:                 .FontSize  = 8
2489:                 .BackStyle = 0
2490:                 .ForeColor = RGB(90, 90, 90)
2491:                 .Visible   = .T.
2492:             ENDWITH
2493: 
2494:             *-- txt_4c_GetTotal: total calculado (ReadOnly, preenchido por LostFocus/AfterRowColChange)
2495:             loc_oCnt.AddObject("txt_4c_GetTotal", "TextBox")
2496:             WITH loc_oCnt.txt_4c_GetTotal
2497:                 .Top           = 71
2498:                 .Left          = 287
2499:                 .Width         = 80
2500:                 .Height        = 23
2501:                 .InputMask     = "999,999.99"
2502:                 .MaxLength     = 12
2503:                 .ReadOnly      = .T.

*-- Linhas 2509 a 2536:
2509:             ENDWITH
2510: 
2511:             *-- Label6: "Retrabalho :" - rotulo de txt_4c_GetRetrab
2512:             loc_oCnt.AddObject("lbl_4c_Label6", "Label")
2513:             WITH loc_oCnt.lbl_4c_Label6
2514:                 .Top       = 75
2515:                 .Left      = 13
2516:                 .Width     = 62
2517:                 .Height    = 15
2518:                 .Caption   = "Retrabalho :"
2519:                 .AutoSize  = .T.
2520:                 .FontName  = "Tahoma"
2521:                 .FontSize  = 8
2522:                 .BackStyle = 0
2523:                 .ForeColor = RGB(90, 90, 90)
2524:                 .Visible   = .T.
2525:             ENDWITH
2526: 
2527:             *-- txt_4c_GetRetrab: coeficiente de retrabalho (editavel se AlteraServico)
2528:             loc_oCnt.AddObject("txt_4c_GetRetrab", "TextBox")
2529:             WITH loc_oCnt.txt_4c_GetRetrab
2530:                 .Top           = 71
2531:                 .Left          = 77
2532:                 .Width         = 80
2533:                 .Height        = 23
2534:                 .ControlSource = "xNensi.Coefs"
2535:                 .InputMask     = "999,999.99"
2536:                 .MaxLength     = 12

*-- Linhas 2772 a 2781:
2772: 
2773:             *-- Atualiza campos de exibicao da linha corrente
2774:             IF USED("xNensi") AND !EOF("xNensi") AND !BOF("xNensi")
2775:                 IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
2776:                     THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
2777:                 ENDIF
2778:                 IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
2779:                     THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
2780:                 ENDIF
2781:                 IF PEMSTATUS(THIS, "txt_4c_Cor", 5)

*-- Linhas 2828 a 2836:
2828:             *-- Botoes de manipulacao
2829:             THIS.AjustarBotoesPorModo()
2830: 
2831:             *-- Checkboxes que abrem forms de edicao
2832:             IF PEMSTATUS(THIS, "chk_4c_Retrabalho", 5)
2833:                 THIS.chk_4c_Retrabalho.Enabled = loc_lEdita
2834:             ENDIF
2835:             IF PEMSTATUS(THIS, "chk_4c_Pagto", 5)
2836:                 THIS.chk_4c_Pagto.Enabled = loc_lEdita

*-- Linhas 2858 a 2867:
2858:         LOCAL loc_oErro
2859: 
2860:         TRY
2861:             IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
2862:                 THIS.lbl_4c_GetDescr.Caption = ""
2863:             ENDIF
2864:             IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
2865:                 THIS.txt_4c_GetObs.Value = ""
2866:             ENDIF
2867:             IF PEMSTATUS(THIS, "txt_4c_Cor", 5)

*-- Linhas 2894 a 2920:
2894:         TRY
2895:             loc_lEdita = INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
2896: 
2897:             IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
2898:                 THIS.cmd_4c_Inserir.Enabled = loc_lEdita AND !THIS.InibeInserir
2899:             ENDIF
2900:             IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
2901:                 THIS.cmd_4c_Alterar.Enabled = loc_lEdita AND !THIS.InibeAlterar
2902:             ENDIF
2903:             IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
2904:                 THIS.cmd_4c_Excluir.Enabled = loc_lEdita AND !THIS.InibeExcluir
2905:             ENDIF
2906:             IF PEMSTATUS(THIS, "cmd_4c_EncerraPCC", 5)
2907:                 THIS.cmd_4c_EncerraPCC.Enabled = loc_lEdita
2908:             ENDIF
2909: 
2910:             *-- Sair e Lotes: sempre habilitados
2911:             IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
2912:                 THIS.cmd_4c_Sair.Enabled = .T.
2913:             ENDIF
2914:             IF PEMSTATUS(THIS, "cmd_4c_Lotes", 5)
2915:                 THIS.cmd_4c_Lotes.Enabled = .T.
2916:             ENDIF
2917: 
2918:         CATCH TO loc_oErro
2919:             MsgErro(loc_oErro.Message, "Erro ao ajustar bot" + CHR(245) + "es por modo")
2920:         ENDTRY

*-- Linhas 2977 a 2986:
2977:                 ENDIF
2978:                 *-- Atualiza campos de exibicao da linha corrente
2979:                 IF !EOF("xNensi")
2980:                     IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
2981:                         THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
2982:                     ENDIF
2983:                     IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
2984:                         THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
2985:                     ENDIF
2986:                 ENDIF

