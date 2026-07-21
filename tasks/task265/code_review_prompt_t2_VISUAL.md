# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (10)
- [FONTNAME-ERRADO] Linha 867: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 886: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 904: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 922: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 940: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 959: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 978: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 997: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1428: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2643 linhas total):

*-- Linhas 103 a 112:
103:                 THIS.ConfigurarContainerProcurar()
104: 
105:                 *-- Propagar titulo din?mico nos labels do cabecalho
106:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
107:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
108: 
109:                 *-- Tornar controles visiveis (exceto containers flutuantes)
110:                 THIS.TornarControlesVisiveis()
111: 
112:                 *-- Configurar eventos BINDEVENT

*-- Linhas 137 a 180:
137:         THIS.AddObject("cnt_4c_Sombra", "Container")
138:         WITH THIS.cnt_4c_Sombra
139:             .Visible     = .T.
140:             .Top         = 0
141:             .Left        = 0
142:             .Width       = THIS.Width
143:             .Height      = 80
144:             .BorderWidth = 0
145:             .BackColor   = RGB(100,100,100)
146:             .AddObject("lbl_4c_Sombra", "Label")
147:             WITH .lbl_4c_Sombra
148:                 .FontBold      = .T.
149:                 .FontName      = "Tahoma"
150:                 .FontSize      = 18
151:                 .FontUnderline = .F.
152:                 .WordWrap      = .T.
153:                 .Alignment     = 0
154:                 .AutoSize      = .F.
155:                 .BackStyle     = 0
156:                 .Caption       = THIS.Caption
157:                 .Height        = 40
158:                 .Left          = 10
159:                 .Top           = 25
160:                 .Width         = THIS.Width
161:                 .ForeColor     = RGB(0,0,0)
162:             ENDWITH
163:             .AddObject("lbl_4c_Titulo", "Label")
164:             WITH .lbl_4c_Titulo
165:                 .FontBold   = .T.
166:                 .FontName   = "Tahoma"
167:                 .FontSize   = 18
168:                 .WordWrap   = .T.
169:                 .Alignment  = 0
170:                 .AutoSize   = .F.
171:                 .BackStyle  = 0
172:                 .Caption    = THIS.Caption
173:                 .Height     = 46
174:                 .Left       = 10
175:                 .Top        = 24
176:                 .Width      = THIS.Width
177:                 .ForeColor  = RGB(255,255,255)
178:             ENDWITH
179:         ENDWITH
180:     ENDPROC

*-- Linhas 191 a 235:
191:         THIS.AddObject("shp_4c_Filtros", "Shape")
192:         WITH THIS.shp_4c_Filtros
193:             .Visible      = .T.
194:             .Top          = 156
195:             .Left         = 18
196:             .Width        = 774
197:             .Height       = 66
198:             .BackStyle    = 0
199:             .BorderStyle  = 6
200:             .SpecialEffect= 1
201:         ENDWITH
202: 
203:         *-- Label Grupo
204:         THIS.AddObject("lbl_4c_Grupo", "Label")
205:         WITH THIS.lbl_4c_Grupo
206:             .Visible    = .T.
207:             .AutoSize   = .T.
208:             .FontName   = "Tahoma"
209:             .FontSize   = 8
210:             .BackStyle  = 0
211:             .Caption    = "Grupo :"
212:             .Height     = 15
213:             .Left       = 34
214:             .Top        = 167
215:             .Width      = 38
216:             .ForeColor  = RGB(90,90,90)
217:         ENDWITH
218: 
219:         *-- TextBox codigo do grupo
220:         THIS.AddObject("txt_4c_CdGrupos", "TextBox")
221:         WITH THIS.txt_4c_CdGrupos
222:             .Visible        = .T.
223:             .FontName       = "Tahoma"
224:             .FontSize       = 8
225:             .Format         = "K"
226:             .Height         = 25
227:             .Left           = 75
228:             .MaxLength      = 10
229:             .SpecialEffect  = 1
230:             .Top            = 163
231:             .Width          = 100
232:             .Themes         = .F.
233:             .Value          = ""
234:         ENDWITH
235: 

*-- Linhas 241 a 285:
241:             .FontSize       = 8
242:             .Format         = "K"
243:             .Height         = 25
244:             .Left           = 177
245:             .MaxLength      = 50
246:             .SpecialEffect  = 1
247:             .Top            = 163
248:             .Width          = 360
249:             .Themes         = .F.
250:             .Value          = ""
251:         ENDWITH
252: 
253:         *-- Label Conta
254:         THIS.AddObject("lbl_4c_Conta", "Label")
255:         WITH THIS.lbl_4c_Conta
256:             .Visible    = .T.
257:             .AutoSize   = .T.
258:             .FontName   = "Tahoma"
259:             .FontSize   = 8
260:             .BackStyle  = 0
261:             .Caption    = "Conta :"
262:             .Height     = 15
263:             .Left       = 34
264:             .Top        = 194
265:             .Width      = 38
266:             .ForeColor  = RGB(90,90,90)
267:         ENDWITH
268: 
269:         *-- TextBox codigo da conta
270:         THIS.AddObject("txt_4c_CdContas", "TextBox")
271:         WITH THIS.txt_4c_CdContas
272:             .Visible        = .T.
273:             .FontName       = "Tahoma"
274:             .FontSize       = 8
275:             .Format         = "K"
276:             .Height         = 25
277:             .Left           = 75
278:             .MaxLength      = 10
279:             .SpecialEffect  = 1
280:             .Top            = 190
281:             .Width          = 100
282:             .Themes         = .F.
283:             .Value          = ""
284:         ENDWITH
285: 

*-- Linhas 291 a 375:
291:             .FontSize       = 8
292:             .Format         = "K"
293:             .Height         = 25
294:             .Left           = 177
295:             .MaxLength      = 50
296:             .SpecialEffect  = 1
297:             .Top            = 190
298:             .Width          = 360
299:             .Themes         = .F.
300:             .Value          = ""
301:         ENDWITH
302: 
303:         *-- Label Periodo
304:         THIS.AddObject("lbl_4c_Periodo", "Label")
305:         WITH THIS.lbl_4c_Periodo
306:             .Visible    = .T.
307:             .AutoSize   = .T.
308:             .FontName   = "Tahoma"
309:             .FontSize   = 8
310:             .BackStyle  = 0
311:             .Caption    = "Per" + CHR(237) + "odo :"
312:             .Height     = 15
313:             .Left       = 550
314:             .Top        = 167
315:             .Width      = 45
316:             .ForeColor  = RGB(90,90,90)
317:         ENDWITH
318: 
319:         *-- TextBox data inicial
320:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
321:         WITH THIS.txt_4c_DtInicial
322:             .Visible        = .T.
323:             .FontName       = "Tahoma"
324:             .FontSize       = 8
325:             .Alignment      = 3
326:             .SpecialEffect  = 1
327:             .Left           = 598
328:             .Top            = 163
329:             .Value          = DATE()
330:         ENDWITH
331: 
332:         *-- Label separador "a"
333:         THIS.AddObject("lbl_4c_Sep", "Label")
334:         WITH THIS.lbl_4c_Sep
335:             .Visible    = .T.
336:             .FontName   = "Tahoma"
337:             .FontSize   = 8
338:             .BackStyle  = 0
339:             .Caption    = "a"
340:             .Left       = 686
341:             .Top        = 167
342:             .ForeColor  = RGB(90,90,90)
343:         ENDWITH
344: 
345:         *-- TextBox data final
346:         THIS.AddObject("txt_4c_DtFinal", "TextBox")
347:         WITH THIS.txt_4c_DtFinal
348:             .Visible        = .T.
349:             .FontName       = "Tahoma"
350:             .FontSize       = 8
351:             .Alignment      = 3
352:             .SpecialEffect  = 1
353:             .Left           = 701
354:             .Top            = 163
355:             .Value          = DATE()
356:         ENDWITH
357: 
358:         *-- Botao Processar (Command2 original)
359:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
360:         WITH THIS.cmd_4c_Processar
361:             .Visible     = .T.
362:             .Top         = 191
363:             .Left        = 598
364:             .Height      = 24
365:             .Width       = 88
366:             .FontBold    = .T.
367:             .FontItalic  = .T.
368:             .FontName    = "Tahoma"
369:             .FontSize    = 8
370:             .Caption     = "Processar"
371:             .ForeColor   = RGB(90,90,90)
372:             .BackColor   = RGB(255,255,255)
373:             .Themes      = .F.
374:         ENDWITH
375:     ENDPROC

*-- Linhas 385 a 406:
385:         THIS.AddObject("shp_4c_Grade", "Shape")
386:         WITH THIS.shp_4c_Grade
387:             .Visible      = .T.
388:             .Top          = 227
389:             .Left         = 18
390:             .Width        = 774
391:             .Height       = 301
392:             .BackStyle    = 0
393:             .SpecialEffect= 1
394:         ENDWITH
395: 
396:         *-- Grid de cheques
397:         THIS.AddObject("grd_4c_Dados", "Grid")
398:         WITH THIS.grd_4c_Dados
399:             .Visible            = .T.
400:             .Top                = 233
401:             .Left               = 24
402:             .Width              = 710
403:             .Height             = 291
404:             .ColumnCount        = 10
405:             .FontName           = "Tahoma"
406:             .FontSize           = 8

*-- Linhas 425 a 433:
425:                 WITH .Header1
426:                     .FontName   = "Tahoma"
427:                     .Alignment  = 2
428:                     .Caption    = "Data"
429:                     .ForeColor  = RGB(90,90,90)
430:                 ENDWITH
431:                 .AddObject("Text1", "TextBox")
432:                 WITH .Text1
433:                     .FontName       = "Tahoma"

*-- Linhas 454 a 462:
454:                 WITH .Header1
455:                     .FontName   = "Tahoma"
456:                     .Alignment  = 2
457:                     .Caption    = "Conta"
458:                     .ForeColor  = RGB(90,90,90)
459:                 ENDWITH
460:                 .AddObject("Text1", "TextBox")
461:                 WITH .Text1
462:                     .FontName       = "Tahoma"

*-- Linhas 483 a 491:
483:                 WITH .Header1
484:                     .FontName   = "Tahoma"
485:                     .Alignment  = 2
486:                     .Caption    = "C" + CHR(243) + "pia"
487:                     .ForeColor  = RGB(90,90,90)
488:                 ENDWITH
489:                 .AddObject("Text1", "TextBox")
490:                 WITH .Text1
491:                     .FontName       = "Tahoma"

*-- Linhas 512 a 520:
512:                 WITH .Header1
513:                     .FontName   = "Tahoma"
514:                     .Alignment  = 2
515:                     .Caption    = "Bco"
516:                     .ForeColor  = RGB(90,90,90)
517:                 ENDWITH
518:                 .AddObject("Text1", "TextBox")
519:                 WITH .Text1
520:                     .FontName       = "Tahoma"

*-- Linhas 540 a 548:
540:                 WITH .Header1
541:                     .FontName   = "Tahoma"
542:                     .Alignment  = 2
543:                     .Caption    = "Ag."
544:                     .ForeColor  = RGB(90,90,90)
545:                 ENDWITH
546:                 .AddObject("Text1", "TextBox")
547:                 WITH .Text1
548:                     .FontName       = "Tahoma"

*-- Linhas 568 a 576:
568:                 WITH .Header1
569:                     .FontName   = "Tahoma"
570:                     .Alignment  = 2
571:                     .Caption    = "C.Corrente"
572:                     .ForeColor  = RGB(90,90,90)
573:                 ENDWITH
574:                 .AddObject("Text1", "TextBox")
575:                 WITH .Text1
576:                     .FontName       = "Tahoma"

*-- Linhas 596 a 604:
596:                 WITH .Header1
597:                     .FontName   = "Tahoma"
598:                     .Alignment  = 2
599:                     .Caption    = "Cheque"
600:                     .ForeColor  = RGB(90,90,90)
601:                 ENDWITH
602:                 .AddObject("Text1", "TextBox")
603:                 WITH .Text1
604:                     .FontName       = "Tahoma"

*-- Linhas 624 a 632:
624:                 WITH .Header1
625:                     .FontName   = "Tahoma"
626:                     .Alignment  = 2
627:                     .Caption    = "Situa" + CHR(231) + CHR(227) + "o"
628:                     .ForeColor  = RGB(90,90,90)
629:                 ENDWITH
630:                 .AddObject("Text1", "TextBox")
631:                 WITH .Text1
632:                     .FontName       = "Tahoma"

*-- Linhas 653 a 661:
653:                 WITH .Header1
654:                     .FontName   = "Tahoma"
655:                     .Alignment  = 2
656:                     .Caption    = "Valor"
657:                     .ForeColor  = RGB(90,90,90)
658:                 ENDWITH
659:                 .AddObject("Text1", "TextBox")
660:                 WITH .Text1
661:                     .FontName       = "Tahoma"

*-- Linhas 670 a 724:
670:                 .Sparse         = .T.
671:             ENDWITH
672: 
673:             *-- Coluna 10: Imprime - CheckBox (clnImprime) - ColumnOrder=1 = aparece primeiro
674:             WITH .Column10
675:                 .FontName       = "Tahoma"
676:                 .ColumnOrder    = 1
677:                 .Width          = 55
678:                 .Movable        = .F.
679:                 .Resizable      = .F.
680:                 .ReadOnly       = .F.
681:                 .Sparse         = .F.
682:                 .AddObject("Header1", "Header")
683:                 WITH .Header1
684:                     .FontName   = "Tahoma"
685:                     .Alignment  = 2
686:                     .Caption    = "Imprime"
687:                     .ForeColor  = RGB(90,90,90)
688:                 ENDWITH
689:                 .AddObject("Check1", "CheckBox")
690:                 WITH .Check1
691:                     .Top        = 32
692:                     .Left       = 8
693:                     .Height     = 17
694:                     .Width      = 60
695:                     .FontName   = "Tahoma"
696:                     .Alignment  = 0
697:                     .Caption    = ""
698:                     .ReadOnly   = .F.
699:                     .Value      = 0
700:                 ENDWITH
701:                 .CurrentControl = "Check1"
702:             ENDWITH
703: 
704:             *-- Bind do RecordSource ao cursor de cheques do BO
705:             .RecordSource = THIS.this_oBusinessObject.this_cCursorCheques
706:         ENDWITH
707: 
708:         *-- Label "Favorecido :"
709:         THIS.AddObject("lbl_4c_Favorecido", "Label")
710:         WITH THIS.lbl_4c_Favorecido
711:             .Visible    = .T.
712:             .AutoSize   = .T.
713:             .FontName   = "Tahoma"
714:             .FontSize   = 8
715:             .BackStyle  = 0
716:             .Caption    = "Favorecido :"
717:             .Height     = 15
718:             .Left       = 24
719:             .Top        = 534
720:             .Width      = 62
721:             .ForeColor  = RGB(90,90,90)
722:         ENDWITH
723: 
724:         *-- TextBox favorecido (ReadOnly - preenchido automaticamente ao navegar no grid)

*-- Linhas 730 a 743:
730:             .FontSize       = 8
731:             .Format         = "K"
732:             .Height         = 25
733:             .Left           = 99
734:             .MaxLength      = 40
735:             .ReadOnly       = .T.
736:             .SelectOnEntry  = .T.
737:             .SpecialEffect  = 1
738:             .Top            = 530
739:             .Width          = 286
740:             .Themes         = .F.
741:             .Value          = ""
742:         ENDWITH
743:     ENDPROC

*-- Linhas 782 a 818:
782:     *==========================================================================
783:     PROTECTED PROCEDURE ConfigurarBotoesSelecao
784:         *-- Botao Marcar Todos (cmdTudo1)
785:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
786:         WITH THIS.cmd_4c_SelTudo
787:             .Visible        = .T.
788:             .Top            = 334
789:             .Left           = 742
790:             .Height         = 40
791:             .Width          = 40
792:             .FontName       = "Verdana"
793:             .FontSize       = 8
794:             .Caption        = ""
795:             .ToolTipText    = "Marca tudo"
796:             .ForeColor      = RGB(36,84,155)
797:             .BackColor      = RGB(255,255,255)
798:             .Themes         = .T.
799:             .Picture        = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
800:             .DisabledPicture= gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
801:         ENDWITH
802: 
803:         *-- Botao Desmarcar Todos (cmdApaga1)
804:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
805:         WITH THIS.cmd_4c_Apaga
806:             .Visible        = .T.
807:             .Top            = 375
808:             .Left           = 742
809:             .Height         = 40
810:             .Width          = 40
811:             .FontName       = "Verdana"
812:             .FontSize       = 8
813:             .Caption        = ""
814:             .ToolTipText    = "Desmarca tudo"
815:             .ForeColor      = RGB(36,84,155)
816:             .BackColor      = RGB(255,255,255)
817:             .Themes         = .T.
818:             .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"

*-- Linhas 834 a 1004:
834:             .BackStyle      = 0
835:             .BorderStyle    = 0
836:             .Height         = 160
837:             .Left           = 11
838:             .SpecialEffect  = 1
839:             .Top            = -3
840:             .Width          = 789
841:             .Themes         = .F.
842: 
843:             *-- Botao 1: Documento (cmdDocumento) - Top=121, Left=473
844:             WITH .Buttons(1)
845:                 .Top            = 121
846:                 .Left           = 473
847:                 .Height         = 37
848:                 .Width          = 120
849:                 .FontBold       = .T.
850:                 .FontItalic     = .T.
851:                 .Caption        = "\<Documento"
852:                 .PicturePosition= 1
853:                 .ForeColor      = RGB(90,90,90)
854:                 .BackColor      = RGB(255,255,255)
855:                 .Themes         = .F.
856:                 .Picture        = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
857:             ENDWITH
858: 
859:             *-- Botao 2: Encerrar/Sair (cmdSair) - Top=6, Left=713
860:             WITH .Buttons(2)
861:                 .Top            = 6
862:                 .Left           = 713
863:                 .Height         = 75
864:                 .Width          = 75
865:                 .FontBold       = .T.
866:                 .FontItalic     = .T.
867:                 .FontName       = "Comic Sans MS"
868:                 .FontSize       = 8
869:                 .Caption        = "Encerrar"
870:                 .Cancel         = .T.
871:                 .ToolTipText    = "[Esc] Encerrar"
872:                 .ForeColor      = RGB(90,90,90)
873:                 .BackColor      = RGB(255,255,255)
874:                 .Themes         = .F.
875:                 .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
876:             ENDWITH
877: 
878:             *-- Botao 3: Imprimir (cmdImprimir) - Top=84, Left=353
879:             WITH .Buttons(3)
880:                 .Top            = 84
881:                 .Left           = 353
882:                 .Height         = 37
883:                 .Width          = 120
884:                 .FontBold       = .T.
885:                 .FontItalic     = .T.
886:                 .FontName       = "Comic Sans MS"
887:                 .FontSize       = 8
888:                 .Caption        = "\<Imprimir"
889:                 .PicturePosition= 1
890:                 .ForeColor      = RGB(90,90,90)
891:                 .BackColor      = RGB(255,255,255)
892:                 .Themes         = .F.
893:                 .Picture        = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
894:             ENDWITH
895: 
896:             *-- Botao 4: Procurar (cmdProcurar) - Top=84, Left=593
897:             WITH .Buttons(4)
898:                 .Top            = 84
899:                 .Left           = 593
900:                 .Height         = 37
901:                 .Width          = 120
902:                 .FontBold       = .T.
903:                 .FontItalic     = .T.
904:                 .FontName       = "Comic Sans MS"
905:                 .FontSize       = 8
906:                 .Caption        = "\<Procurar"
907:                 .PicturePosition= 1
908:                 .ForeColor      = RGB(90,90,90)
909:                 .BackColor      = RGB(255,255,255)
910:                 .Themes         = .F.
911:                 .Picture        = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
912:             ENDWITH
913: 
914:             *-- Botao 5: Recibo (cmdRecibo) - Top=121, Left=593
915:             WITH .Buttons(5)
916:                 .Top            = 121
917:                 .Left           = 593
918:                 .Height         = 37
919:                 .Width          = 120
920:                 .FontBold       = .T.
921:                 .FontItalic     = .T.
922:                 .FontName       = "Comic Sans MS"
923:                 .FontSize       = 8
924:                 .Caption        = "\<Recibo"
925:                 .PicturePosition= 1
926:                 .ForeColor      = RGB(90,90,90)
927:                 .BackColor      = RGB(255,255,255)
928:                 .Themes         = .F.
929:                 .Picture        = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
930:             ENDWITH
931: 
932:             *-- Botao 6: Excluir Documento (cmdExcluiDoc) - Top=84, Left=473
933:             WITH .Buttons(6)
934:                 .Top            = 84
935:                 .Left           = 473
936:                 .Height         = 37
937:                 .Width          = 120
938:                 .FontBold       = .T.
939:                 .FontItalic     = .T.
940:                 .FontName       = "Comic Sans MS"
941:                 .FontSize       = 8
942:                 .Caption        = "E\<xclui Docto."
943:                 .ToolTipText    = "Exclui Documento"
944:                 .PicturePosition= 1
945:                 .ForeColor      = RGB(90,90,90)
946:                 .BackColor      = RGB(255,255,255)
947:                 .Themes         = .F.
948:                 .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
949:             ENDWITH
950: 
951:             *-- Botao 7: Cheque (impressao cheque - cmdImpchq) - Top=121, Left=353
952:             WITH .Buttons(7)
953:                 .Top            = 121
954:                 .Left           = 353
955:                 .Height         = 37
956:                 .Width          = 120
957:                 .FontBold       = .T.
958:                 .FontItalic     = .T.
959:                 .FontName       = "Comic Sans MS"
960:                 .FontSize       = 8
961:                 .Caption        = "Che\<que"
962:                 .ToolTipText    = "Impressora de cheque"
963:                 .PicturePosition= 1
964:                 .ForeColor      = RGB(90,90,90)
965:                 .BackColor      = RGB(255,255,255)
966:                 .Themes         = .F.
967:                 .Picture        = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
968:             ENDWITH
969: 
970:             *-- Botao 8: Cheque Matricial (cmdchmat) - Top=84, Left=233
971:             WITH .Buttons(8)
972:                 .Top            = 84
973:                 .Left           = 233
974:                 .Height         = 37
975:                 .Width          = 120
976:                 .FontBold       = .T.
977:                 .FontItalic     = .T.
978:                 .FontName       = "Comic Sans MS"
979:                 .FontSize       = 8
980:                 .Caption        = "Chq. \<Matric."
981:                 .ToolTipText    = "Impressora matricial"
982:                 .PicturePosition= 1
983:                 .ForeColor      = RGB(90,90,90)
984:                 .BackColor      = RGB(255,255,255)
985:                 .Themes         = .F.
986:                 .Picture        = gc_4c_CaminhoIcones + "cheque.png"
987:             ENDWITH
988: 
989:             *-- Botao 9: Excluir Cheque (btnExcluirChq) - Top=121, Left=233
990:             WITH .Buttons(9)
991:                 .Top            = 121
992:                 .Left           = 233
993:                 .Height         = 37
994:                 .Width          = 120
995:                 .FontBold       = .T.
996:                 .FontItalic     = .T.
997:                 .FontName       = "Comic Sans MS"
998:                 .FontSize       = 8
999:                 .Caption        = "Excluir Chq."
1000:                 .ToolTipText    = "Exclui Cheque"
1001:                 .PicturePosition= 1
1002:                 .ForeColor      = RGB(90,90,90)
1003:                 .BackColor      = RGB(255,255,255)
1004:                 .Themes         = .F.

*-- Linhas 1018 a 1054:
1018:         THIS.AddObject("cnt_4c_Justificativa", "Container")
1019:         WITH THIS.cnt_4c_Justificativa
1020:             .Visible        = .F.
1021:             .Top            = 532
1022:             .Left           = 395
1023:             .Width          = 350
1024:             .Height         = 69
1025:             .BorderWidth    = 0
1026:             .SpecialEffect  = 0
1027:             .BackColor      = RGB(255,255,255)
1028: 
1029:             *-- Label
1030:             .AddObject("lbl_4c_LblJust", "Label")
1031:             WITH .lbl_4c_LblJust
1032:                 .AutoSize   = .T.
1033:                 .FontName   = "Tahoma"
1034:                 .FontSize   = 8
1035:                 .BackStyle  = 0
1036:                 .Caption    = "Justificativa do cancelamento"
1037:                 .Height     = 15
1038:                 .Left       = 6
1039:                 .Top        = 5
1040:                 .Width      = 143
1041:                 .ForeColor  = RGB(90,90,90)
1042:             ENDWITH
1043: 
1044:             *-- EditBox justificativa (get_justificativa original)
1045:             .AddObject("txt_4c_Justificativa", "EditBox")
1046:             WITH .txt_4c_Justificativa
1047:                 .Height             = 44
1048:                 .Left               = 3
1049:                 .Top                = 21
1050:                 .Width              = 238
1051:                 .ForeColor          = RGB(0,0,0)
1052:                 .DisabledBackColor  = RGB(255,255,255)
1053:                 .DisabledForeColor  = RGB(0,0,0)
1054:                 .Value              = ""

*-- Linhas 1060 a 1094:
1060:                 .ButtonCount    = 2
1061:                 .BackStyle      = 0
1062:                 .Height         = 47
1063:                 .Left           = 243
1064:                 .Top            = 18
1065:                 .Width          = 107
1066:                 .Themes         = .F.
1067: 
1068:                 WITH .Buttons(1)
1069:                     .Top            = 4
1070:                     .Left           = 5
1071:                     .Height         = 40
1072:                     .Width          = 48
1073:                     .Caption        = ""
1074:                     .ToolTipText    = "Confirmar"
1075:                     .ForeColor      = RGB(36,84,155)
1076:                     .BackColor      = RGB(255,255,255)
1077:                     .Themes         = .T.
1078:                     .Picture        = gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
1079:                     .DisabledPicture= gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
1080:                 ENDWITH
1081: 
1082:                 WITH .Buttons(2)
1083:                     .Top            = 4
1084:                     .Left           = 53
1085:                     .Height         = 40
1086:                     .Width          = 48
1087:                     .FontName       = "Verdana"
1088:                     .FontSize       = 8
1089:                     .Caption        = ""
1090:                     .Cancel         = .T.
1091:                     .ToolTipText    = "Cancelar"
1092:                     .ForeColor      = RGB(36,84,155)
1093:                     .BackColor      = RGB(255,255,255)
1094:                     .Themes         = .T.

*-- Linhas 1108 a 1240:
1108:         WITH THIS.cnt_4c_Impchmat
1109:             .Visible        = .F.
1110:             .Enabled        = .F.
1111:             .Top            = 284
1112:             .Left           = 240
1113:             .Width          = 314
1114:             .Height         = 218
1115:             .SpecialEffect  = 0
1116:             .BackColor      = RGB(255,255,255)
1117: 
1118:             *-- Label titulo
1119:             .AddObject("lbl_4c_TituloImp", "Label")
1120:             WITH .lbl_4c_TituloImp
1121:                 .AutoSize   = .T.
1122:                 .FontBold   = .T.
1123:                 .FontName   = "Tahoma"
1124:                 .BackStyle  = 0
1125:                 .Caption    = "Impress" + CHR(227) + "o"
1126:                 .Height     = 16
1127:                 .Left       = 12
1128:                 .Top        = 8
1129:                 .Width      = 65
1130:                 .ForeColor  = RGB(90,90,90)
1131:             ENDWITH
1132: 
1133:             *-- Label Banco
1134:             .AddObject("lbl_4c_Banco", "Label")
1135:             WITH .lbl_4c_Banco
1136:                 .Caption    = "Banco :"
1137:                 .Height     = 15
1138:                 .Left       = 66
1139:                 .Top        = 157
1140:                 .Width      = 38
1141:             ENDWITH
1142: 
1143:             *-- TextBox codigo do banco
1144:             .AddObject("txt_4c_Banco", "TextBox")
1145:             WITH .txt_4c_Banco
1146:                 .InputMask  = "999"
1147:                 .Left       = 107
1148:                 .Top        = 153
1149:                 .Width      = 31
1150:                 .ForeColor  = RGB(0,0,0)
1151:                 .Value      = ""
1152:             ENDWITH
1153: 
1154:             *-- Label Cheque Inicial
1155:             .AddObject("lbl_4c_ChqIni", "Label")
1156:             WITH .lbl_4c_ChqIni
1157:                 .Caption    = "Cheque Inicial :"
1158:                 .Height     = 15
1159:                 .Left       = 28
1160:                 .Top        = 185
1161:                 .Width      = 76
1162:             ENDWITH
1163: 
1164:             *-- TextBox cheque inicial
1165:             .AddObject("txt_4c_Chini", "TextBox")
1166:             WITH .txt_4c_Chini
1167:                 .Height     = 23
1168:                 .InputMask  = "999999"
1169:                 .Left       = 107
1170:                 .MaxLength  = 6
1171:                 .Top        = 179
1172:                 .Width      = 52
1173:                 .ForeColor  = RGB(0,0,0)
1174:                 .Value      = ""
1175:             ENDWITH
1176: 
1177:             *-- Label Cheque Final
1178:             .AddObject("lbl_4c_ChqFin", "Label")
1179:             WITH .lbl_4c_ChqFin
1180:                 .Caption    = "Cheque Final :"
1181:                 .Height     = 15
1182:                 .Left       = 172
1183:                 .Top        = 184
1184:                 .Width      = 71
1185:             ENDWITH
1186: 
1187:             *-- TextBox cheque final
1188:             .AddObject("txt_4c_Chfin", "TextBox")
1189:             WITH .txt_4c_Chfin
1190:                 .Height     = 23
1191:                 .InputMask  = "999999"
1192:                 .Left       = 245
1193:                 .MaxLength  = 6
1194:                 .Top        = 180
1195:                 .Width      = 52
1196:                 .ForeColor  = RGB(0,0,0)
1197:                 .Value      = ""
1198:             ENDWITH
1199: 
1200:             *-- CommandGroup: Imprimir + Encerrar (cmdGprocurar: 2 botoes)
1201:             .AddObject("cmg_4c_ImpProc", "CommandGroup")
1202:             WITH .cmg_4c_ImpProc
1203:                 .ButtonCount    = 2
1204:                 .BackStyle      = 0
1205:                 .Height         = 110
1206:                 .Left           = 134
1207:                 .SpecialEffect  = 1
1208:                 .Top            = 7
1209:                 .Width          = 173
1210:                 .Themes         = .F.
1211: 
1212:                 WITH .Buttons(1)
1213:                     .Top            = 1
1214:                     .Left           = 13
1215:                     .Height         = 75
1216:                     .Width          = 75
1217:                     .FontBold       = .T.
1218:                     .FontItalic     = .T.
1219:                     .Caption        = "\<Imprimir"
1220:                     .ForeColor      = RGB(90,90,90)
1221:                     .BackColor      = RGB(255,255,255)
1222:                     .Themes         = .F.
1223:                     .Picture        = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
1224:                 ENDWITH
1225: 
1226:                 WITH .Buttons(2)
1227:                     .Top            = 1
1228:                     .Left           = 95
1229:                     .Height         = 75
1230:                     .Width          = 75
1231:                     .FontBold       = .T.
1232:                     .FontItalic     = .T.
1233:                     .FontName       = "Comic Sans MS"
1234:                     .FontSize       = 8
1235:                     .Caption        = "Encerrar"
1236:                     .Cancel         = .T.
1237:                     .ForeColor      = RGB(90,90,90)
1238:                     .BackColor      = RGB(255,255,255)
1239:                     .Themes         = .F.
1240:                     .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 1252 a 1435:
1252:         THIS.AddObject("cnt_4c_Procurar", "Container")
1253:         WITH THIS.cnt_4c_Procurar
1254:             .Visible        = .F.
1255:             .Top            = 284
1256:             .Left           = 240
1257:             .Width          = 314
1258:             .Height         = 218
1259:             .SpecialEffect  = 0
1260:             .BackColor      = RGB(255,255,255)
1261: 
1262:             *-- Label titulo
1263:             .AddObject("lbl_4c_TituloPrc", "Label")
1264:             WITH .lbl_4c_TituloPrc
1265:                 .AutoSize   = .T.
1266:                 .FontBold   = .T.
1267:                 .FontName   = "Tahoma"
1268:                 .BackStyle  = 0
1269:                 .Caption    = "Procurar"
1270:                 .Height     = 16
1271:                 .Left       = 12
1272:                 .Top        = 8
1273:                 .Width      = 54
1274:                 .ForeColor  = RGB(90,90,90)
1275:             ENDWITH
1276: 
1277:             *-- Label Banco
1278:             .AddObject("lbl_4c_LblBanco", "Label")
1279:             WITH .lbl_4c_LblBanco
1280:                 .Caption    = "Banco :"
1281:                 .Height     = 15
1282:                 .Left       = 36
1283:                 .Top        = 139
1284:                 .Width      = 38
1285:             ENDWITH
1286: 
1287:             *-- TextBox banco
1288:             .AddObject("txt_4c_BancoP", "TextBox")
1289:             WITH .txt_4c_BancoP
1290:                 .Left       = 77
1291:                 .Top        = 135
1292:                 .Width      = 31
1293:                 .Value      = ""
1294:             ENDWITH
1295: 
1296:             *-- Label Agencia
1297:             .AddObject("lbl_4c_LblAgencia", "Label")
1298:             WITH .lbl_4c_LblAgencia
1299:                 .Caption    = "Ag" + CHR(234) + "ncia :"
1300:                 .Height     = 15
1301:                 .Left       = 27
1302:                 .Top        = 163
1303:                 .Width      = 47
1304:             ENDWITH
1305: 
1306:             *-- TextBox agencia
1307:             .AddObject("txt_4c_AgenciaP", "TextBox")
1308:             WITH .txt_4c_AgenciaP
1309:                 .Left       = 77
1310:                 .Top        = 158
1311:                 .Width      = 40
1312:                 .Value      = ""
1313:             ENDWITH
1314: 
1315:             *-- Label Conta
1316:             .AddObject("lbl_4c_LblContaP", "Label")
1317:             WITH .lbl_4c_LblContaP
1318:                 .Caption    = "Conta :"
1319:                 .Height     = 15
1320:                 .Left       = 36
1321:                 .Top        = 187
1322:                 .Width      = 38
1323:             ENDWITH
1324: 
1325:             *-- TextBox conta
1326:             .AddObject("txt_4c_ContaP", "TextBox")
1327:             WITH .txt_4c_ContaP
1328:                 .Height     = 23
1329:                 .Left       = 77
1330:                 .Top        = 181
1331:                 .Width      = 81
1332:                 .Value      = ""
1333:             ENDWITH
1334: 
1335:             *-- Label Cheque
1336:             .AddObject("lbl_4c_LblChequeP", "Label")
1337:             WITH .lbl_4c_LblChequeP
1338:                 .Caption    = "Cheque :"
1339:                 .Height     = 15
1340:                 .Left       = 164
1341:                 .Top        = 139
1342:                 .Width      = 46
1343:             ENDWITH
1344: 
1345:             *-- TextBox cheque
1346:             .AddObject("txt_4c_ChequeP", "TextBox")
1347:             WITH .txt_4c_ChequeP
1348:                 .Height     = 23
1349:                 .Left       = 213
1350:                 .Top        = 135
1351:                 .Width      = 52
1352:                 .Value      = ""
1353:             ENDWITH
1354: 
1355:             *-- Label Emissao
1356:             .AddObject("lbl_4c_LblEmissao", "Label")
1357:             WITH .lbl_4c_LblEmissao
1358:                 .Caption    = "Emiss" + CHR(227) + "o :"
1359:                 .Height     = 15
1360:                 .Left       = 163
1361:                 .Top        = 163
1362:                 .Width      = 47
1363:             ENDWITH
1364: 
1365:             *-- TextBox emissao (data)
1366:             .AddObject("txt_4c_EmissaoP", "TextBox")
1367:             WITH .txt_4c_EmissaoP
1368:                 .Height     = 23
1369:                 .Left       = 213
1370:                 .Top        = 158
1371:                 .Width      = 81
1372:                 .Value      = {}
1373:             ENDWITH
1374: 
1375:             *-- Label Valor
1376:             .AddObject("lbl_4c_LblValorP", "Label")
1377:             WITH .lbl_4c_LblValorP
1378:                 .Caption    = "Valor :"
1379:                 .Height     = 15
1380:                 .Left       = 177
1381:                 .Top        = 187
1382:                 .Width      = 33
1383:             ENDWITH
1384: 
1385:             *-- TextBox valor
1386:             .AddObject("txt_4c_ValorP", "TextBox")
1387:             WITH .txt_4c_ValorP
1388:                 .Height     = 23
1389:                 .Left       = 213
1390:                 .Top        = 181
1391:                 .Width      = 81
1392:                 .Value      = 0
1393:             ENDWITH
1394: 
1395:             *-- CommandGroup: Procurar + Encerrar (cmdgprocurar: 2 botoes)
1396:             .AddObject("cmg_4c_PrcProc", "CommandGroup")
1397:             WITH .cmg_4c_PrcProc
1398:                 .ButtonCount    = 2
1399:                 .BackStyle      = 0
1400:                 .Height         = 110
1401:                 .Left           = 135
1402:                 .SpecialEffect  = 1
1403:                 .Top            = 7
1404:                 .Width          = 173
1405:                 .Themes         = .F.
1406: 
1407:                 WITH .Buttons(1)
1408:                     .Top            = 1
1409:                     .Left           = 13
1410:                     .Height         = 75
1411:                     .Width          = 75
1412:                     .FontBold       = .T.
1413:                     .FontItalic     = .T.
1414:                     .Caption        = "\<Procurar"
1415:                     .ForeColor      = RGB(90,90,90)
1416:                     .BackColor      = RGB(255,255,255)
1417:                     .Themes         = .F.
1418:                     .Picture        = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
1419:                 ENDWITH
1420: 
1421:                 WITH .Buttons(2)
1422:                     .Top            = 1
1423:                     .Left           = 95
1424:                     .Height         = 75
1425:                     .Width          = 75
1426:                     .FontBold       = .T.
1427:                     .FontItalic     = .T.
1428:                     .FontName       = "Comic Sans MS"
1429:                     .FontSize       = 8
1430:                     .Caption        = "Encerrar"
1431:                     .Cancel         = .T.
1432:                     .ForeColor      = RGB(90,90,90)
1433:                     .BackColor      = RGB(255,255,255)
1434:                     .Themes         = .F.
1435:                     .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 1585 a 1614:
1585:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
1586:         ENDIF
1587: 
1588:         *-- Checkbox de selecao (Column10/Check1): KeyPress para toggle via teclado
1589:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1590:             BINDEVENT(THIS.grd_4c_Dados.Column10.Check1, "KeyPress",  THIS, "GrdChkKeyPress")
1591:             BINDEVENT(THIS.grd_4c_Dados.Column10.Check1, "MouseDown", THIS, "GrdChkMouseDown")
1592:         ENDIF
1593: 
1594:         *-- Header clnNcopias: Click para reordenar por NCopias
1595:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1596:             BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "GrdHeaderNCopias")
1597:         ENDIF
1598: 
1599:         *-- Botao Processar
1600:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
1601:             BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
1602:         ENDIF
1603: 
1604:         *-- Botoes de selecao
1605:         IF VARTYPE(THIS.cmd_4c_SelTudo) = "O"
1606:             BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
1607:         ENDIF
1608:         IF VARTYPE(THIS.cmd_4c_Apaga) = "O"
1609:             BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
1610:         ENDIF
1611: 
1612:         *-- Botoes de acao (CommandGroup)
1613:         IF VARTYPE(THIS.cmg_4c_Acoes) = "O"
1614:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(1), "Click", THIS, "BtnDocumentoClick")

*-- Linhas 1714 a 1722:
1714:         THIS.LockScreen = .F.
1715:     ENDPROC
1716: 
1717:     *-- Grid Checkbox KeyPress: toggle de selecao via ENTER ou SPACE
1718:     PROCEDURE GrdChkKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1719:         LOCAL loc_cCursor, loc_cChave, loc_nRecno
1720:         IF INLIST(par_nKeyCode, 13, 32)
1721:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1722:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)

*-- Linhas 1735 a 1743:
1735:         ENDIF
1736:     ENDPROC
1737: 
1738:     *-- Grid Checkbox MouseDown: delegar para KeyPress com SPACE
1739:     PROCEDURE GrdChkMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1740:         THIS.GrdChkKeyPress(32, 0)
1741:         NODEFAULT
1742:     ENDPROC
1743: 

*-- Linhas 2554 a 2563:
2554:             THIS.txt_4c_DtInicial.Enabled = par_lHabilitar
2555:             THIS.txt_4c_DtFinal.Enabled   = par_lHabilitar
2556:         ENDIF
2557:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
2558:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
2559:         ENDIF
2560:     ENDPROC
2561: 
2562:     *-- BtnIncluirClick: stub N/A - OPERACIONAL nao tem modo INCLUIR
2563:     PROCEDURE BtnIncluirClick()

