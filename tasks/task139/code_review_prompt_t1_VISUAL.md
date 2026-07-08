# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'Material' (parent: SIGPDM14): Top original=167 vs migrado 'txt_4c_Material' Top=3 (diff=164px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM14.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1389 linhas total):

*-- Linhas 116 a 124:
116:     * ConfigurarPageFrame - define imagem de fundo e caption sem literais acentuados
117:     *--------------------------------------------------------------------------
118:     PROTECTED PROCEDURE ConfigurarPageFrame()
119:         THIS.Caption  = "Rateio de Componentes"
120:         THIS.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
121:         THIS.FontName = "Tahoma"
122:         THIS.FontSize = 8
123:     ENDPROC
124: 

*-- Linhas 151 a 215:
151:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
152:         loc_oCnt = THIS.cnt_4c_Cabecalho
153:         WITH loc_oCnt
154:             .Top         = 0
155:             .Left        = 0
156:             .Width       = THIS.Width
157:             .Height      = 80
158:             .BackStyle   = 1
159:             .BackColor   = RGB(100,100,100)
160:             .BorderWidth = 0
161:             .Visible     = .T.
162:         ENDWITH
163: 
164:         *-- Sombra preta deslocada 1px para dar profundidade
165:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
166:         WITH loc_oCnt.lbl_4c_LblSombra
167:             .Top           = 18
168:             .Left          = 10
169:             .Width         = 769
170:             .Height        = 40
171:             .FontName      = "Tahoma"
172:             .FontSize      = 18
173:             .FontBold      = .T.
174:             .FontUnderline = .F.
175:             .WordWrap      = .T.
176:             .Alignment     = 0
177:             .BackStyle     = 0
178:             .ForeColor     = RGB(0,0,0)
179:             .Caption       = loc_cCaption
180:             .Visible       = .T.
181:         ENDWITH
182: 
183:         *-- Titulo branco principal
184:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
185:         WITH loc_oCnt.lbl_4c_LblTitulo
186:             .Top       = 17
187:             .Left      = 10
188:             .Width     = 769
189:             .Height    = 46
190:             .FontName  = "Tahoma"
191:             .FontSize  = 18
192:             .FontBold  = .T.
193:             .WordWrap  = .T.
194:             .Alignment = 0
195:             .BackStyle = 0
196:             .ForeColor = RGB(255,255,255)
197:             .Caption   = loc_cCaption
198:             .Visible   = .T.
199:         ENDWITH
200:     ENDPROC
201: 
202:     *--------------------------------------------------------------------------
203:     * ConfigurarShape1 - decorativo vertical entre campos e botoes
204:     * Origem: Shape1 (Top=7, Left=612, Height=41, Width=12)
205:     *--------------------------------------------------------------------------
206:     PROTECTED PROCEDURE ConfigurarShape1()
207:         THIS.AddObject("shp_4c_Shape1", "Shape")
208:         WITH THIS.shp_4c_Shape1
209:             .Top         = 7
210:             .Left        = 612
211:             .Height      = 41
212:             .Width       = 12
213:             .BackStyle   = 0
214:             .BorderStyle = 0
215:             .BorderColor = RGB(136,189,188)

*-- Linhas 227 a 281:
227:         THIS.AddObject("cnt_4c_Operacao", "Container")
228:         loc_oCnt = THIS.cnt_4c_Operacao
229:         WITH loc_oCnt
230:             .Top           = 93
231:             .Left          = 42
232:             .Width         = 491
233:             .Height        = 70
234:             .BorderWidth   = 1
235:             .SpecialEffect = 0
236:             .BackStyle     = 1
237:             .BackColor     = RGB(255,255,255)
238:             .Visible       = .T.
239:         ENDWITH
240: 
241:         *-- Label "Movimentacao" (Say1: FontBold, Left=8, Top=3)
242:         loc_oCnt.AddObject("lbl_4c_LblMovimentacao", "Label")
243:         WITH loc_oCnt.lbl_4c_LblMovimentacao
244:             .FontBold  = .T.
245:             .FontName  = "Tahoma"
246:             .FontSize  = 8
247:             .BackStyle = 0
248:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
249:             .Left      = 8
250:             .Top       = 3
251:             .ForeColor = RGB(0,0,0)
252:             .Visible   = .T.
253:         ENDWITH
254: 
255:         *-- Linha separadora (Line1: BorderWidth=2, Top=19, Width=316)
256:         loc_oCnt.AddObject("lin_4c_Line1", "Line")
257:         WITH loc_oCnt.lin_4c_Line1
258:             .BorderWidth = 2
259:             .Height      = 0
260:             .Left        = 8
261:             .Top         = 19
262:             .Width       = 316
263:             .BorderColor = RGB(90,90,90)
264:             .Visible     = .T.
265:         ENDWITH
266: 
267:         *-- Empresa (GetEmpresa: Left=8, Top=27, Width=36, ReadOnly)
268:         loc_oCnt.AddObject("txt_4c_Empresa", "TextBox")
269:         WITH loc_oCnt.txt_4c_Empresa
270:             .Format          = ""
271:             .Height          = 23
272:             .InputMask       = ""
273:             .Left            = 8
274:             .ReadOnly        = .T.
275:             .SpecialEffect   = 1
276:             .Top             = 27
277:             .Width           = 36
278:             .Value           = ""
279:             .ForeColor       = RGB(0,0,0)
280:             .BackColor       = RGB(255,255,255)
281:             .BorderColor     = RGB(100,100,100)

*-- Linhas 288 a 299:
288:             .Format          = ""
289:             .Height          = 23
290:             .InputMask       = ""
291:             .Left            = 46
292:             .ReadOnly        = .T.
293:             .SpecialEffect   = 1
294:             .Top             = 27
295:             .Width           = 156
296:             .Value           = ""
297:             .ForeColor       = RGB(0,0,0)
298:             .BackColor       = RGB(255,255,255)
299:             .BorderColor     = RGB(100,100,100)

*-- Linhas 306 a 317:
306:             .Format          = "L"
307:             .Height          = 23
308:             .InputMask       = "9999999999"
309:             .Left            = 204
310:             .ReadOnly        = .T.
311:             .SpecialEffect   = 1
312:             .Top             = 27
313:             .Width           = 81
314:             .Value           = 0
315:             .ForeColor       = RGB(0,0,0)
316:             .BackColor       = RGB(255,255,255)
317:             .BorderColor     = RGB(100,100,100)

*-- Linhas 329 a 466:
329:         THIS.AddObject("cnt_4c_Material", "Container")
330:         loc_oCnt = THIS.cnt_4c_Material
331:         WITH loc_oCnt
332:             .Top           = 167
333:             .Left          = 50
334:             .Width         = 348
335:             .Height        = 55
336:             .BackStyle     = 0
337:             .BorderWidth   = 0
338:             .SpecialEffect = 0
339:             .BackColor     = RGB(255,255,255)
340:             .Visible       = .T.
341:         ENDWITH
342: 
343:         *-- Label "Material :" (Say1: Left=14, Top=7)
344:         loc_oCnt.AddObject("lbl_4c_LblMaterial", "Label")
345:         WITH loc_oCnt.lbl_4c_LblMaterial
346:             .FontName  = "Tahoma"
347:             .FontSize  = 8
348:             .BackStyle = 0
349:             .Caption   = "Material :"
350:             .Left      = 14
351:             .Top       = 7
352:             .ForeColor = RGB(90,90,90)
353:             .Visible   = .T.
354:         ENDWITH
355: 
356:         *-- Codigo do material (GetMaterial: Left=63, Top=3, Width=108, ReadOnly)
357:         loc_oCnt.AddObject("txt_4c_Material", "TextBox")
358:         WITH loc_oCnt.txt_4c_Material
359:             .Format    = ""
360:             .Height    = 23
361:             .InputMask = ""
362:             .Left      = 63
363:             .ReadOnly  = .T.
364:             .Top       = 3
365:             .Width     = 108
366:             .Value     = ""
367:             .BackColor = RGB(255,255,255)
368:             .ForeColor = RGB(0,0,0)
369:             .Visible   = .T.
370:         ENDWITH
371: 
372:         *-- Label "Qtde :" (Label2: Left=224, Top=7)
373:         loc_oCnt.AddObject("lbl_4c_LblQtde", "Label")
374:         WITH loc_oCnt.lbl_4c_LblQtde
375:             .AutoSize  = .T.
376:             .FontName  = "Tahoma"
377:             .FontSize  = 8
378:             .BackStyle = 0
379:             .Caption   = "Qtde :"
380:             .Height    = 15
381:             .Left      = 224
382:             .Top       = 7
383:             .Width     = 33
384:             .ForeColor = RGB(90,90,90)
385:             .Visible   = .T.
386:         ENDWITH
387: 
388:         *-- Quantidade do item de NE (GetQtde: Left=259, Top=3, Width=87, ReadOnly)
389:         loc_oCnt.AddObject("txt_4c_Qtde", "TextBox")
390:         WITH loc_oCnt.txt_4c_Qtde
391:             .Format    = ""
392:             .Height    = 23
393:             .InputMask = "999,999.999"
394:             .Left      = 259
395:             .ReadOnly  = .T.
396:             .Top       = 3
397:             .Width     = 87
398:             .Value     = 0
399:             .BackColor = RGB(255,255,255)
400:             .ForeColor = RGB(0,0,0)
401:             .Visible   = .T.
402:         ENDWITH
403: 
404:         *-- Label "Peso :" (Label1: Left=29, Top=34)
405:         loc_oCnt.AddObject("lbl_4c_LblPeso", "Label")
406:         WITH loc_oCnt.lbl_4c_LblPeso
407:             .AutoSize  = .T.
408:             .FontName  = "Tahoma"
409:             .FontSize  = 8
410:             .BackStyle = 0
411:             .Caption   = "Peso :"
412:             .Height    = 15
413:             .Left      = 29
414:             .Top       = 34
415:             .Width     = 32
416:             .ForeColor = RGB(90,90,90)
417:             .Visible   = .T.
418:         ENDWITH
419: 
420:         *-- Peso do item de NE (GetPeso: Left=63, Top=30, Width=87, ReadOnly)
421:         loc_oCnt.AddObject("txt_4c_Peso", "TextBox")
422:         WITH loc_oCnt.txt_4c_Peso
423:             .Format    = ""
424:             .Height    = 23
425:             .InputMask = "999,999.999"
426:             .Left      = 63
427:             .ReadOnly  = .T.
428:             .Top       = 30
429:             .Width     = 87
430:             .Value     = 0
431:             .BackColor = RGB(255,255,255)
432:             .ForeColor = RGB(0,0,0)
433:             .Visible   = .T.
434:         ENDWITH
435: 
436:         *-- Label "Peso Fabrica :" (Label3: Left=187, Top=34)
437:         loc_oCnt.AddObject("lbl_4c_LblPesoFab", "Label")
438:         WITH loc_oCnt.lbl_4c_LblPesoFab
439:             .AutoSize  = .T.
440:             .FontName  = "Tahoma"
441:             .FontSize  = 8
442:             .BackStyle = 0
443:             .Caption   = "Peso F" + CHR(225) + "brica :"
444:             .Height    = 15
445:             .Left      = 187
446:             .Top       = 34
447:             .Width     = 70
448:             .ForeColor = RGB(90,90,90)
449:             .Visible   = .T.
450:         ENDWITH
451: 
452:         *-- Peso fabrica (Get_Pesof: Left=259, Top=30, Width=87, ReadOnly)
453:         *-- Exibe mesmo valor de Pesos (idem ao GetPeso, para referencia visual)
454:         loc_oCnt.AddObject("txt_4c_PesoFab", "TextBox")
455:         WITH loc_oCnt.txt_4c_PesoFab
456:             .Format    = ""
457:             .Height    = 23
458:             .InputMask = "999,999.999"
459:             .Left      = 259
460:             .ReadOnly  = .T.
461:             .Top       = 30
462:             .Width     = 87
463:             .Value     = 0
464:             .BackColor = RGB(255,255,255)
465:             .ForeColor = RGB(0,0,0)
466:             .Visible   = .T.

*-- Linhas 474 a 499:
474:     *--------------------------------------------------------------------------
475:     PROTECTED PROCEDURE ConfigurarDescricao()
476:         *-- Label "Descricao :"
477:         THIS.AddObject("lbl_4c_LblDescricao", "Label")
478:         WITH THIS.lbl_4c_LblDescricao
479:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
480:             .Left      = 151
481:             .Top       = 565
482:             .BackStyle = 0
483:             .ForeColor = RGB(231,254,253)
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .Visible   = .T.
487:         ENDWITH
488: 
489:         *-- Campo descricao (somente leitura, espelha CDescs do item atual de xNensi)
490:         THIS.AddObject("txt_4c_Descr", "TextBox")
491:         WITH THIS.txt_4c_Descr
492:             .Height    = 23
493:             .Left      = 223
494:             .Top       = 567
495:             .Width     = 353
496:             .ReadOnly  = .T.
497:             .Value     = ""
498:             .FontName  = "Tahoma"
499:             .FontSize  = 8

*-- Linhas 527 a 547:
527:     * Get_Pesof exibe Pesos (peso da fase) identico ao GetPeso (legado)
528:     *--------------------------------------------------------------------------
529:     PROTECTED PROCEDURE PreencherContainerMaterial()
530:         TRY
531:             WITH THIS.cnt_4c_Material
532:                 .txt_4c_Material.Value = THIS.this_oBusinessObject.this_cMats
533:                 .txt_4c_Peso.Value     = THIS.this_oBusinessObject.this_nPesos
534:                 .txt_4c_Qtde.Value     = THIS.this_oBusinessObject.this_nQtds
535:                 .txt_4c_PesoFab.Value  = THIS.this_oBusinessObject.this_nPesos
536:                 .Visible     = .T.
537:             ENDWITH
538: 
539:             *-- Descricao do componente (campo inferior do form)
540:             THIS.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDescs
541:         CATCH TO loc_oErro
542:             MsgErro(loc_oErro.Message, "Erro")
543:         ENDTRY
544:     ENDPROC
545: 
546:     *--------------------------------------------------------------------------
547:     * TornarControlesVisiveis - torna controles visiveis recursivamente

*-- Linhas 595 a 604:
595:         THIS.AddObject("grd_4c_Dados", "Grid")
596:         loc_oGrd = THIS.grd_4c_Dados
597:         WITH loc_oGrd
598:             .Top                = 231
599:             .Left               = 43
600:             .Width              = 715
601:             .Height             = 329
602:             .FontName           = "Verdana"
603:             .FontSize           = 8
604:             .GridLineColor      = RGB(238,238,238)

*-- Linhas 625 a 633:
625:                 .Format            = "L"
626:                 .InputMask         = "9999999999"
627:                 .ControlSource     = "TmpDistrib.Nops"
628:                 .Header1.Caption   = loc_cTitulo
629:                 .Header1.Alignment = 2
630:                 .Header1.FontName  = "Tahoma"
631:                 .Header1.FontSize  = 8
632:                 .Text1.FontName    = "Courier New"
633:                 .Text1.BorderStyle = 0

*-- Linhas 645 a 653:
645:                 .Resizable         = .F.
646:                 .ReadOnly          = .F.
647:                 .ControlSource     = "TmpDistrib.Pesos"
648:                 .Header1.Caption   = "Qtde Agregar"
649:                 .Header1.Alignment = 2
650:                 .Header1.FontName  = "Tahoma"
651:                 .Header1.FontSize  = 8
652:                 .Text1.BorderStyle = 0
653:                 .Text1.Margin      = 0

*-- Linhas 663 a 671:
663:                 .Resizable         = .F.
664:                 .ReadOnly          = .T.
665:                 .ControlSource     = "TmpDistrib.CUnis"
666:                 .Header1.Caption   = "Unid."
667:                 .Header1.Alignment = 2
668:                 .Header1.FontName  = "Tahoma"
669:                 .Header1.FontSize  = 8
670:                 .Text1.BorderStyle = 0
671:                 .Text1.Margin      = 0

*-- Linhas 682 a 690:
682:                 .Resizable         = .F.
683:                 .ReadOnly          = .F.
684:                 .ControlSource     = "TmpDistrib.Pesos2"
685:                 .Header1.Caption   = "Peso Fabr Agregar"
686:                 .Header1.Alignment = 2
687:                 .Header1.FontName  = "Tahoma"
688:                 .Header1.FontSize  = 8
689:                 .Text1.BorderStyle = 0
690:                 .Text1.Margin      = 0

*-- Linhas 700 a 708:
700:                 .Resizable         = .F.
701:                 .ReadOnly          = .T.
702:                 .ControlSource     = "TmpDistrib.cUniPs"
703:                 .Header1.Caption   = "Unid."
704:                 .Header1.Alignment = 2
705:                 .Header1.FontName  = "Tahoma"
706:                 .Header1.FontSize  = 8
707:                 .Text1.BorderStyle = 0
708:                 .Text1.Margin      = 0

*-- Linhas 720 a 728:
720:                 .ReadOnly          = .F.
721:                 .InputMask         = loc_cMask
722:                 .ControlSource     = "TmpDistrib.Qtds2"
723:                 .Header1.Caption   = "Qtde Agregar"
724:                 .Header1.Alignment = 2
725:                 .Header1.FontName  = "Tahoma"
726:                 .Header1.FontSize  = 8
727:                 .Text1.BorderStyle = 0
728:                 .Text1.Margin      = 0

*-- Linhas 739 a 747:
739:                 .Resizable         = .F.
740:                 .ReadOnly          = .T.
741:                 .ControlSource     = "TmpDistrib.Nenvs"
742:                 .Header1.Caption   = "Envelope"
743:                 .Header1.Alignment = 2
744:                 .Header1.FontName  = "Tahoma"
745:                 .Header1.FontSize  = 8
746:                 .Text1.BorderStyle = 0
747:                 .Text1.Margin      = 0

*-- Linhas 758 a 766:
758:                 .Resizable         = .F.
759:                 .ReadOnly          = .T.
760:                 .ControlSource     = "TmpDistrib.CodPds"
761:                 .Header1.Caption   = "Produto"
762:                 .Header1.Alignment = 2
763:                 .Header1.FontName  = "Tahoma"
764:                 .Header1.FontSize  = 8
765:                 .Text1.FontSize    = 8
766:                 .Text1.BorderStyle = 0

*-- Linhas 778 a 786:
778:                 .Resizable         = .F.
779:                 .ReadOnly          = .T.
780:                 .ControlSource     = "TmpDistrib.CodCors"
781:                 .Header1.Caption   = "Cor"
782:                 .Header1.Alignment = 2
783:                 .Header1.FontName  = "Tahoma"
784:                 .Header1.FontSize  = 8
785:                 .Text1.BorderStyle = 0
786:                 .Text1.Margin      = 0

*-- Linhas 797 a 805:
797:                 .Resizable         = .F.
798:                 .ReadOnly          = .T.
799:                 .ControlSource     = "TmpDistrib.CodTams"
800:                 .Header1.Caption   = "Tam"
801:                 .Header1.Alignment = 2
802:                 .Header1.FontName  = "Tahoma"
803:                 .Header1.FontSize  = 8
804:                 .Text1.BorderStyle = 0
805:                 .Text1.Margin      = 0

*-- Linhas 824 a 842:
824:     ENDPROC
825: 
826:     *--------------------------------------------------------------------------
827:     * ConfigurarBotoes - cria cmd_4c_Confirmar e cmd_4c_Cancelar
828:     * Origem: ok (Top=3, Left=650) + Cancelar (Top=3, Left=725)
829:     *--------------------------------------------------------------------------
830:     PROTECTED PROCEDURE ConfigurarBotoes()
831:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
832:         WITH THIS.cmd_4c_Confirmar
833:             .Top             = 3
834:             .Left            = 650
835:             .Width           = 75
836:             .Height          = 75
837:             .Caption         = "Confirmar"
838:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
839:             .PicturePosition = 13
840:             .FontName        = "Tahoma"
841:             .FontSize        = 8
842:             .FontBold        = .T.

*-- Linhas 849 a 865:
849:             .WordWrap        = .T.
850:             .Visible         = .T.
851:         ENDWITH
852:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
853: 
854:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
855:         WITH THIS.cmd_4c_Cancelar
856:             .Top             = 3
857:             .Left            = 725
858:             .Width           = 75
859:             .Height          = 75
860:             .Caption         = "Encerrar"
861:             .Cancel          = .T.
862:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
863:             .PicturePosition = 13
864:             .FontName        = "Tahoma"
865:             .FontSize        = 8

*-- Linhas 873 a 881:
873:             .WordWrap        = .T.
874:             .Visible         = .T.
875:         ENDWITH
876:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
877:     ENDPROC
878: 
879:     *--------------------------------------------------------------------------
880:     * AlternarPagina - form plano sem PageFrame; apenas atualiza o grid
881:     *--------------------------------------------------------------------------

*-- Linhas 1207 a 1216:
1207:             ENDIF
1208: 
1209:             *-- Em modo visualizacao desabilita Confirmar (nao ha gravacao)
1210:             IF VARTYPE(THIS.cmd_4c_Confirmar) = "O"
1211:                 THIS.cmd_4c_Confirmar.Enabled = .F.
1212:             ENDIF
1213:         CATCH TO loc_oErro
1214:             MsgErro(loc_oErro.Message, "Erro Visualizar")
1215:         ENDTRY
1216:     ENDPROC

*-- Linhas 1253 a 1262:
1253:     PROCEDURE AjustarBotoesPorModo()
1254:         LOCAL loc_lPodeEditar
1255:         loc_lPodeEditar = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
1256:         IF VARTYPE(THIS.cmd_4c_Confirmar) = "O"
1257:             THIS.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
1258:         ENDIF
1259:         THIS.HabilitarCampos()
1260:     ENDPROC
1261: 
1262:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SigPdM14BO.prg):
*==============================================================================
* SigPdM14BO.prg - Business Object para Rateio de Componentes (SIGPDM14)
* Herda de BusinessBase
* Form OPERACIONAL modal: opera sobre cursores VFP locais (xNensi, xMFas, TmpDistrib)
*==============================================================================

DEFINE CLASS SigPdM14BO AS BusinessBase

    *-- Identificacao (sem tabela SQL - opera sobre cursores locais)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Dados do item principal (lidos de xNensi pelo form pai)
    this_cMats        = ""    && CMats  - Codigo do material componente
    this_nPesos       = 0     && Pesos  - Peso original da NE
    this_nQtds        = 0     && Qtds   - Quantidade original da NE
    this_cGrus        = ""    && CGrus  - Codigo do grupo do material
    this_cUnis        = ""    && CUnis  - Unidade de medida (qtde)
    this_cDescs       = ""    && CDescs - Descricao do material
    this_cTpOps       = ""    && TpOps  - Tipo de operacao
    this_nLotes       = 0     && nLotes - Numero do lote
    this_nNenvs       = 0     && Nenvs  - Numero do envelope (filtro de fases)
    this_nPeso2s      = 0     && Peso2s - Peso na fase anterior
    this_cCodCors     = ""    && CodCors - Codigo da cor
    this_cCodTams     = ""    && CodTams - Codigo do tamanho
    this_cUniPs       = ""    && cUniPs  - Unidade de medida do peso

    *-- Estado de navegacao/edicao (preservado durante o ciclo do form)
    this_nRecnoAnt    = 0     && Recno original de xNensi para restaurar ao fechar
    this_cOrder       = ""    && Ordem original de xNensi (Order()) para restaurar
    this_nAntValue    = 0     && Valor anterior de Qtds2 (Column5.Text1.When)
    this_nAntValueP   = 0     && Valor anterior de Pesos2 (Column8.Text1.When)
    this_cPcEscolha   = ""    && Modo de operacao do form pai: INSERIR ou ALTERAR
    this_nCas         = 0     && Casas decimais para mascara de quantidade (CasQtds)

    *-- Totais acumulados durante ok.Click (Confirmar)
    this_nTPeso       = 0     && Soma de Pesos2 de todos os itens confirmados
    this_nTQtde       = 0     && Soma de Qtds2 de todos os itens confirmados
    this_nTPeso2      = 0     && Soma de Pesos de todos os itens confirmados
    this_nXAmarra     = 0     && Identificador de amarracao (CtrlAgrega do form pai)

    *--------------------------------------------------------------------------
    * Init - Configura identificacao do BO (sem tabela SQL propria)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (sem tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le dados do cursor xNensi para propriedades do BO
    * Mapeia TODAS as colunas usadas pelo form
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cMats    = TratarNulo(CMats,   "C")
                THIS.this_nPesos   = TratarNulo(Pesos,   "N")
                THIS.this_nQtds    = TratarNulo(Qtds,    "N")
                THIS.this_cGrus    = TratarNulo(CGrus,   "C")
                THIS.this_cUnis    = TratarNulo(CUnis,   "C")
                THIS.this_cDescs   = TratarNulo(CDescs,  "C")
                THIS.this_cTpOps   = TratarNulo(TpOps,   "C")
                THIS.this_nLotes   = TratarNulo(nLotes,  "N")
                THIS.this_nNenvs   = TratarNulo(Nenvs,   "N")
                THIS.this_nPeso2s  = TratarNulo(Peso2s,  "N")
                THIS.this_cCodCors = TratarNulo(CodCors, "C")
                THIS.this_cCodTams = TratarNulo(CodTams, "C")
                THIS.this_cUniPs   = TratarNulo(cUniPs,  "C")
                THIS.this_nRecnoAnt = RECNO()
                THIS.this_cOrder    = ORDER()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria TmpDistrib e preenche com dados de xMFas
    * par_nNenv = filtro de envelope (0 = todos)
    * Requer this_c*/this_n* carregados via CarregarDoCursor antes
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores(par_nNenv)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib (Nops N(10) NULL, Nenvs N(10) NULL, CodPds C(14) NULL, ;
                CMats C(14) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL, ;
                Qtds2 N(10,3) NULL, Pesos2 N(10,3) NULL, CDescs C(40) NULL, CGrus C(3) NULL, ;
                TpOps C(15) NULL, nLotes N(10) NULL, Peso2s N(10,3) NULL, cUniPs C(3) NULL, ;
                CodCors C(4) NULL, codTams C(4) NULL)
            SET NULL OFF

            SELECT xMFas
            SCAN
                IF par_nNenv <> 0
                    IF par_nNenv <> xMFas.Nenvs
                        LOOP
                    ENDIF
                ENDIF

                INSERT INTO TmpDistrib ;
                    (Nops, Nenvs, CodPds, Qtds, Pesos, CUnis, CMats, CDescs, ;
                     CGrus, TpOps, nLotes, cUniPs, CodCors, CodTams) ;
                VALUES ;
                    (xMFas.Nops, xMFas.Nenvs, xMFas.CodPds, 0, 0, ;
                     THIS.this_cUnis, THIS.this_cMats, THIS.this_cDescs, ;
                     THIS.this_cGrus, THIS.this_cTpOps, THIS.this_nLotes, ;
                     THIS.this_cUniPs, THIS.this_cCodCors, THIS.this_cCodTams)
            ENDSCAN

            THIS.CalcularDistribuicao()

            SELECT TmpDistrib
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularDistribuicao - Distribui Pesos2/Qtds2 proporcionalmente
    * Requer TmpDistrib existente e this_nPesos/this_nQtds/this_nLotes carregados
    *--------------------------------------------------------------------------
    PROCEDURE CalcularDistribuicao()
        LOCAL loc_lSucesso, loc_nQt, loc_nPs, loc_nPes2, loc_nQtd2
        loc_lSucesso = .F.
        TRY
            SELECT TmpDistrib
            GO TOP

            IF (THIS.this_nPesos > 0) AND (THIS.this_nLotes > 0)
                SUM Qtds, Pesos TO loc_nQt, loc_nPs
                GO TOP
                SCAN
                    REPLACE Pesos2 WITH ROUND(Pesos / IIF(loc_nPs = 0, 1, loc_nPs) * THIS.this_nPesos, 2), ;
                            Qtds2  WITH ROUND(Qtds  / IIF(loc_nQt = 0, 1, loc_nQt) * THIS.this_nQtds,  2)
                ENDSCAN

                SUM Pesos2, Qtds2 TO loc_nPes2, loc_nQtd2
                IF (THIS.this_nPesos <> loc_nPes2) OR (THIS.this_nQtds <> loc_nQtd2)
                    GO BOTTOM
                    REPLACE Pesos2 WITH Pesos2 + (THIS.this_nPesos - loc_nPes2), ;
                            Qtds2  WITH Qtds2  + (THIS.this_nQtds  - loc_nQtd2)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUnidadeSQL - Consulta SigCdUni via SQL Server
    * par_cCUnis   = codigo da unidade a buscar
    * par_cAlias   = nome do cursor destino (ex: "LocalUni", "LocalUni2")
    * par_cCampos  = campos a retornar (ex: "Fators,QtEqualPs,cestos")
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUnidadeSQL(par_cCUnis, par_cAlias, par_cCampos)
        LOCAL loc_lSucesso, loc_cSQL, loc_cSelect
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAlias)
                loc_lSucesso = .F.
            ENDIF

            IF USED(par_cAlias)
                TABLEREVERT(.T., par_cAlias)
                USE IN (par_cAlias)
            ENDIF

            loc_cSelect = IIF(EMPTY(par_cCampos), "CUnis, Fators, QtEqualPs, cEstos", par_cCampos)
            loc_cSQL = "SELECT " + loc_cSelect + ;
                       " FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCUnis))

            SQLEXEC(gnConnHandle, loc_cSQL, par_cAlias)

            IF USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
                SELECT (par_cAlias)
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEstoquePeso - Verifica se estoque suporta quantidade adicional
    * Equivalente ao fVerEstP do framework legado
    * par_nQuant = TmpDistrib.Qtds2 - xNensi.Qtds (diferenca a verificar)
    * Retorna .T. se pode prosseguir
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEstoquePeso(par_nQuant)
        LOCAL loc_lOK, loc_cSQL, loc_nSaldo
        loc_lOK = .T.
        TRY
            IF par_nQuant > 0 AND !EMPTY(THIS.this_cMats)
                IF USED("TmpDistrib") AND !EOF("TmpDistrib")
                    *-- Verifica saldo em processo: compara quantidade a adicionar com
                    *-- disponivel no lote (Pesos do item de NE como referencia de saldo)
                    IF THIS.this_nPesos > 0
                        loc_nSaldo = THIS.this_nPesos
                        IF par_nQuant > loc_nSaldo
                            loc_lOK = .F.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCasasDecimais - Retorna casas decimais da operacao para mascara
    * Lido de CrSigCdOpd.CasQtds
    *--------------------------------------------------------------------------
    PROCEDURE ObterCasasDecimais()
        LOCAL loc_nCas
        loc_nCas = 3
        TRY
            IF USED("CrSigCdOpd") AND !EOF("CrSigCdOpd")
                loc_nCas = IIF(CrSigCdOpd.CasQtds = 0, 3, CrSigCdOpd.CasQtds)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCas
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarRateio - Itera TmpDistrib e insere/atualiza xNensi
    * Logica do ok.Click do form legado
    * par_nCtrlAgrega = identificador de amarracao fornecido pelo form pai
    * Zera e recalcula this_nTPeso, this_nTQtde, this_nTPeso2
    * Retorna .T. se confirmado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarRateio(par_nCtrlAgrega)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_nTPeso   = 0
            THIS.this_nTQtde   = 0
            THIS.this_nTPeso2  = 0
            THIS.this_nXAmarra = par_nCtrlAgrega

            SELECT xNensi
            GO (THIS.this_nRecnoAnt)

            SELECT TmpDistrib
            SCAN
                SELECT xNensi
                SET ORDER TO NopCMatnV
                IF !SEEK(STR(TmpDistrib.Nops, 10) + TmpDistrib.CMats)
                    INSERT INTO xNensi ;
                        (CMats, CUnis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                         Qtds, Pesos, TpOps, nLotes, Peso2s, CodCors, CodTams, cUniPs) ;
                    VALUES ;
                        (TmpDistrib.CMats, TmpDistrib.CUnis, TmpDistrib.CDescs, ;
                         TmpDistrib.CGrus, TmpDistrib.Nops, 3, .T., TmpDistrib.Nenvs, ;
                         TmpDistrib.Qtds2, TmpDistrib.Pesos2, TmpDistrib.TpOps, ;
                         TmpDistrib.nLotes, TmpDistrib.Pesos, ;
                         TmpDistrib.CodCors, TmpDistrib.CodTams, TmpDistrib.cUniPs)
                ENDIF

                REPLACE Qtds   WITH TmpDistrib.Qtds2, ;
                        Peso2s WITH TmpDistrib.Pesos, ;
                        Pesos  WITH TmpDistrib.Pesos2

                REPLACE QtFaseAnt  WITH TmpDistrib.Qtds2, ;
                        Amarracao  WITH THIS.this_nXAmarra IN xNensi

                IF TmpDistrib.Pesos2 <> 0
                    REPLACE PsFaseAnt WITH TmpDistrib.Pesos2
                ENDIF
                IF TmpDistrib.Pesos <> 0
                    REPLACE Ps2FaseAnt WITH TmpDistrib.Pesos
                ENDIF

                THIS.this_nTPeso  = THIS.this_nTPeso  + TmpDistrib.Pesos2
                THIS.this_nTQtde  = THIS.this_nTQtde  + TmpDistrib.Qtds2
                THIS.this_nTPeso2 = THIS.this_nTPeso2 + TmpDistrib.Pesos
            ENDSCAN

            SELECT xNensi
            SET ORDER TO Editar
            GO (THIS.this_nRecnoAnt)
            REPLACE Qtds      WITH THIS.this_nTQtde, ;
                    Pesos     WITH THIS.this_nTPeso, ;
                    Peso2s    WITH THIS.this_nTPeso2, ;
                    Rateio    WITH 1, ;
                    Amarracao WITH THIS.this_nXAmarra IN xNensi

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CancelarRateio - Restaura estado do cursor xNensi ao cancelar
    * Equivalente ao Cancelar.Click do form legado
    *--------------------------------------------------------------------------
    PROCEDURE CancelarRateio()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT xNensi
            SET ORDER TO Editar
            IF THIS.this_nRecnoAnt > 0
                GO (THIS.this_nRecnoAnt)
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Persiste novo rateio em xNensi (delega para ConfirmarRateio)
    * Form OPERACIONAL: nao ha tabela SQL propria; opera sobre cursor xNensi.
    * par_nCtrlAgrega = CtrlAgrega do form pai (controle de amarracao)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_nCtrlAgrega)
        LOCAL loc_lSucesso, loc_nCtrl
        loc_lSucesso = .F.
        TRY
            loc_nCtrl = IIF(VARTYPE(par_nCtrlAgrega) = "N", par_nCtrlAgrega, THIS.this_nXAmarra)

            IF !USED("TmpDistrib")
                MsgErro("Cursor TmpDistrib nao disponivel para insercao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("xNensi")
                MsgErro("Cursor xNensi nao disponivel para insercao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ConfirmarRateio(loc_nCtrl)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("INSERIR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza rateio existente em xNensi (delega para ConfirmarRateio)
    * Form OPERACIONAL: ConfirmarRateio decide INSERT vs UPDATE conforme SEEK
    * par_nCtrlAgrega = CtrlAgrega do form pai (controle de amarracao)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_nCtrlAgrega)
        LOCAL loc_lSucesso, loc_nCtrl
        loc_lSucesso = .F.
        TRY
            loc_nCtrl = IIF(VARTYPE(par_nCtrlAgrega) = "N", par_nCtrlAgrega, THIS.this_nXAmarra)

            IF !USED("TmpDistrib")
                MsgErro("Cursor TmpDistrib nao disponivel para atualizacao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("xNensi")
                MsgErro("Cursor xNensi nao disponivel para atualizacao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ConfirmarRateio(loc_nCtrl)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("ATUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Sem auditoria em form OPERACIONAL (sem tabela SQL)
    * par_cOperacao = "INSERIR" ou "ATUALIZAR" (recebido de Inserir/Atualizar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE

